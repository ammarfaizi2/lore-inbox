Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267486AbUHTHuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267486AbUHTHuQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 03:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUHTHuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 03:50:16 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:42666 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267620AbUHTHuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 03:50:03 -0400
Message-ID: <4125AD23.4000705@yahoo.com.au>
Date: Fri, 20 Aug 2004 17:49:55 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
CC: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: Possible dcache BUG
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>	<20040808113930.24ae0273.akpm@osdl.org>	<200408100012.08945.gene.heskett@verizon.net>	<200408102342.12792.gene.heskett@verizon.net>	<Pine.LNX.4.58.0408102044220.1839@ppc970.osdl.org>	<20040810211849.0d556af4@laptop.delusion.de>	<Pine.LNX.4.58.0408102201510.1839@ppc970.osdl.org>	<Pine.LNX.4.58.0408102213250.1839@ppc970.osdl.org>	<20040812180033.62b389db@laptop.delusion.de>	<Pine.LNX.4.58.0408121813190.1839@ppc970.osdl.org>	<20040820000238.55e22081@laptop.delusion.de>	<20040820001154.0a5cf331.akpm@osdl.org> <20040820001905.27a9ff8f@laptop.delusion.de>
In-Reply-To: <20040820001905.27a9ff8f@laptop.delusion.de>
Content-Type: multipart/mixed;
 boundary="------------080305040709020600010403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080305040709020600010403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Udo A. Steinberg wrote:
> On Fri, 20 Aug 2004 00:11:54 -0700 Andrew Morton (AM) wrote:
> 
> AM> "Udo A. Steinberg" <us15@os.inf.tu-dresden.de> wrote:
> AM> >
> AM> > I've tried to download 700 MB of data from a digital camera via USB using
> AM> >  "gphoto2 --get-all-files" and I can repeatedly run my 128 MB box out of
> AM> >  memory using either Linux 2.4.26 or 2.6.8.1 for that.
> AM> 
> AM> whee.  How much swap is online?
> 
> Something close to 512 MB.
> 
> Adding 506512k swap on /dev/hda2.  Priority:-1 extents:1
> 
> AM> Not that it matters - you seem to have a bunch of reclaimable pagecache
> AM> just sitting there.  Very odd.
> AM> 
> AM> Could gphoto2 be using mlock?  Does it run as root?
> 
> No, gphoto2 was not running as root.
> 
> -Udo.

Can you reproduce the OOM with the following patch please? Then
send the output.

Thanks


--------------080305040709020600010403
Content-Type: text/x-patch;
 name="vm-unreclaimable-debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-unreclaimable-debug.patch"




---

 linux-2.6-npiggin/mm/page_alloc.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

diff -puN mm/page_alloc.c~vm-unreclaimable-debug mm/page_alloc.c
--- linux-2.6/mm/page_alloc.c~vm-unreclaimable-debug	2004-08-20 17:44:45.000000000 +1000
+++ linux-2.6-npiggin/mm/page_alloc.c	2004-08-20 17:48:26.000000000 +1000
@@ -1182,6 +1182,8 @@ void show_free_areas(void)
 			" active:%lukB"
 			" inactive:%lukB"
 			" present:%lukB"
+			" pages_scanned:%lu"
+			" all_unreclaimable? %s"
 			"\n",
 			zone->name,
 			K(zone->free_pages),
@@ -1190,7 +1192,9 @@ void show_free_areas(void)
 			K(zone->pages_high),
 			K(zone->nr_active),
 			K(zone->nr_inactive),
-			K(zone->present_pages)
+			K(zone->present_pages),
+			zone->pages_scanned,
+			(zone->all_unreclaimable ? "yes" : "no")
 			);
 		printk("protections[]:");
 		for (i = 0; i < MAX_NR_ZONES; i++)

_

--------------080305040709020600010403--
