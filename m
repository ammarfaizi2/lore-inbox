Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263340AbTDCKaD>; Thu, 3 Apr 2003 05:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263341AbTDCKaD>; Thu, 3 Apr 2003 05:30:03 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:20450 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id <S263340AbTDCKaB>; Thu, 3 Apr 2003 05:30:01 -0500
Date: Thu, 3 Apr 2003 20:42:54 +1000
From: CaT <cat@zip.com.au>
To: Christoph Rohland <cr@sap.com>
Cc: Hugh Dickins <hugh@veritas.com>, tomlins@cam.org,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
Message-ID: <20030403104254.GA437@zip.com.au>
References: <Pine.LNX.4.44.0304011734370.1503-100000@localhost.localdomain> <ovd6k5l60d.fsf@sap.com> <20030402144432.GB536@zip.com.au> <ovadf8ls8e.fsf@sap.com> <20030403053543.GK2107@zip.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <20030403053543.GK2107@zip.com.au>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 03, 2003 at 03:35:43PM +1000, CaT wrote:
> > And I have set it to 400MB on a 256MB box just fine ;-) How could you
> 
> :)
> 
> > do these two setup generally without knowing your hardware. 20MB tmpfs
> 
> If you want to take swap into account you still can't but then this
> patch changes nothing for you in either case. You'd still specify 400MB
> or (now) 156%.

Well, I got bored.

size=<ram>%+<swap>%

So size=100%+50% will set the tmpfs size at 100% the size of your ram
+ 50% the size of your swap.

It's just an idea. It's still simple and gives you what you seem to want
(in part... there's no dynamic changes on swapon/off) and what I want
(the ability to set the size off just real ram).

It seems like a decent compromise so I'm sure someone'll hate it. :)

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="add-percentile-ram+swap-size-tmpfs-2.5.66.patch"

--- mm/shmem.c.old	Sun Mar 30 00:51:39 2003
+++ mm/shmem.c	Thu Apr  3 20:33:04 2003
@@ -34,6 +34,7 @@
 #include <linux/writeback.h>
 #include <linux/vfs.h>
 #include <asm/uaccess.h>
+#include <asm/div64.h>
 
 /* This magic number is used in glibc for posix shared memory */
 #define TMPFS_MAGIC	0x01021994
@@ -1630,6 +1631,25 @@
 		if (!strcmp(this_char,"size")) {
 			unsigned long long size;
 			size = memparse(value,&rest);
+			if (*rest == '%') {
+				size <<= PAGE_SHIFT;
+				size *= totalram_pages;
+				do_div(size, 100);
+				rest++;
+				if(*rest == '+') {
+					unsigned long long swpsize;
+					rest++;
+					value = rest;
+					swpsize = memparse(value,&rest);
+					if (*rest == '%') {
+						swpsize <<= PAGE_SHIFT;
+						swpsize *= nr_swap_pages;
+						do_div(swpsize, 100);
+						rest++;
+					}
+					size+=swpsize;
+				}
+			}
 			if (*rest)
 				goto bad_val;
 			*blocks = size >> PAGE_CACHE_SHIFT;
@@ -1695,7 +1715,6 @@
 	uid_t uid = current->fsuid;
 	gid_t gid = current->fsgid;
 	struct shmem_sb_info *sbinfo;
-	struct sysinfo si;
 	int err = -ENOMEM;
 
 	sbinfo = kmalloc(sizeof(struct shmem_sb_info), GFP_KERNEL);
@@ -1708,8 +1727,7 @@
 	 * Per default we only allow half of the physical ram per
 	 * tmpfs instance
 	 */
-	si_meminfo(&si);
-	blocks = inodes = si.totalram / 2;
+	blocks = inodes = totalram_pages / 2;
 
 #ifdef CONFIG_TMPFS
 	if (shmem_parse_options(data, &mode, &uid, &gid, &blocks, &inodes)) {

--y0ulUmNC+osPPQO6--
