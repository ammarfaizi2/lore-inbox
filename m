Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423554AbWJaTVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423554AbWJaTVX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 14:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423729AbWJaTVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 14:21:23 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:46503 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1423554AbWJaTVW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 14:21:22 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: Suspend to disk:  do we HAVE to use swap?
Date: Tue, 31 Oct 2006 20:19:37 +0100
User-Agent: KMail/1.9.1
Cc: Luca Tettamanti <kronos.it@gmail.com>, linux-kernel@vger.kernel.org,
       John Richard Moser <nigelenki@comcast.net>
References: <20061031174006.GA31555@dreamland.darkstar.lan> <200610311905.33667.s0348365@sms.ed.ac.uk>
In-Reply-To: <200610311905.33667.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_KH6RFbKEp+wR4Zz"
Message-Id: <200610312019.38368.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_KH6RFbKEp+wR4Zz
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday, 31 October 2006 20:05, Alistair John Strachan wrote:
> On Tuesday 31 October 2006 17:40, Luca Tettamanti wrote:
> > Alistair John Strachan <s0348365@sms.ed.ac.uk> ha scritto:
> > > On Tuesday 31 October 2006 06:16, Rafael J. Wysocki wrote:
> > > [snip]
> > >
> > >> However, we already have code that allows us to use swap files for the
> > >> suspend and turning a regular file into a swap file is as easy as
> > >> running 'mkswap' and 'swapon' on it.
> > >
> > > How is this feature enabled? I don't see it in 2.6.19-rc4.
> >
> > Swap files have been supported for ages. suspend-to-swapfile is very
> > new, you need a -mm kernel and userspace suspend from CVS:
> > http://suspend.sf.net
> 
> I know, I use swap files, and not a partition. This has prevented me from 
> using suspend to disk "for ages". ;-)
> 
> Is userspace suspend REQUIRED for this feature?

No, but unfortunately one piece is still missing: You'll need to figure out
where your swap file's header is located.

However, if you apply the attached patch the kernel will tell you where it is
(after you do 'swapon' grep dmesg for 'swap' and use the value in the
'offset' field).

Please read Documentation/power/swsusp-and-swap-files.txt before you begin. 

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller

--Boundary-00=_KH6RFbKEp+wR4Zz
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="mm-print-offset-for-swap-files.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mm-print-offset-for-swap-files.patch"

---
 mm/swapfile.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

Index: linux-2.6.18-rc6-mm2/mm/swapfile.c
===================================================================
--- linux-2.6.18-rc6-mm2.orig/mm/swapfile.c
+++ linux-2.6.18-rc6-mm2/mm/swapfile.c
@@ -1047,7 +1047,8 @@ add_swap_extent(struct swap_info_struct 
  * This is extremely effective.  The average number of iterations in
  * map_swap_page() has been measured at about 0.3 per page.  - akpm.
  */
-static int setup_swap_extents(struct swap_info_struct *sis, sector_t *span)
+static int setup_swap_extents(struct swap_info_struct *sis, sector_t *span,
+                              sector_t *start)
 {
 	struct inode *inode;
 	unsigned blocks_per_page;
@@ -1060,6 +1061,7 @@ static int setup_swap_extents(struct swa
 	int nr_extents = 0;
 	int ret;
 
+	*start = 0;
 	inode = sis->swap_file->f_mapping->host;
 	if (S_ISBLK(inode->i_mode)) {
 		ret = add_swap_extent(sis, 0, sis->max, 0);
@@ -1114,6 +1116,8 @@ static int setup_swap_extents(struct swa
 				lowest_block = first_block;
 			if (first_block > highest_block)
 				highest_block = first_block;
+		} else {
+			*start = first_block;
 		}
 
 		/*
@@ -1407,7 +1411,7 @@ asmlinkage long sys_swapon(const char __
 	int swap_header_version;
 	unsigned int nr_good_pages = 0;
 	int nr_extents = 0;
-	sector_t span;
+	sector_t span, start;
 	unsigned long maxpages = 1;
 	int swapfilesize;
 	unsigned short *swap_map;
@@ -1608,7 +1612,7 @@ asmlinkage long sys_swapon(const char __
 		p->swap_map[0] = SWAP_MAP_BAD;
 		p->max = maxpages;
 		p->pages = nr_good_pages;
-		nr_extents = setup_swap_extents(p, &span);
+		nr_extents = setup_swap_extents(p, &span, &start);
 		if (nr_extents < 0) {
 			error = nr_extents;
 			goto bad_swap;
@@ -1628,9 +1632,10 @@ asmlinkage long sys_swapon(const char __
 	total_swap_pages += nr_good_pages;
 
 	printk(KERN_INFO "Adding %uk swap on %s.  "
-			"Priority:%d extents:%d across:%lluk\n",
+			"Priority:%d extents:%d across:%lluk offset:%llu\n",
 		nr_good_pages<<(PAGE_SHIFT-10), name, p->prio,
-		nr_extents, (unsigned long long)span<<(PAGE_SHIFT-10));
+		nr_extents, (unsigned long long)span<<(PAGE_SHIFT-10),
+		(unsigned long long)start);
 
 	/* insert swap space into swap_list: */
 	prev = -1;

--Boundary-00=_KH6RFbKEp+wR4Zz--
