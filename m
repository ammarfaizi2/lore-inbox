Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbSLTKzQ>; Fri, 20 Dec 2002 05:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261305AbSLTKzQ>; Fri, 20 Dec 2002 05:55:16 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:14804 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261302AbSLTKzO>; Fri, 20 Dec 2002 05:55:14 -0500
Message-ID: <3E02F8E1.70509@slit.de>
Date: Fri, 20 Dec 2002 12:02:57 +0100
From: achen@t-online.de (Alexander Achenbach)
Reply-To: xela@slit.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
X-Accept-Language: en
MIME-Version: 1.0
To: davej@suse.de, hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: [PATCH] zero-size E820 memory (kernel start-up failure)
Content-Type: multipart/mixed;
 boundary="------------080909030608050905050101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080909030608050905050101
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi everybody.

This patch fixes the

     Ok, booting the kernel.         [hangs]

problem with BIOSes that report E820 memory maps with zero-size entries.
Among the mainboards affected are

     EPOX 4G4A+ (presumably)
     EPOX 4BEA[-R]
     Chaintech 9EJL  .

In the past (kernels up to 2.4.20), these mainboards could only boot Linux
with explicit 'mem=' boot parameters.

Up to 2.4.20, a zero-size E820 memory region (eg 0xa0000 - 0xa0000)
reported by the BIOS causes 'sanitize_e820_map' to take the end of this
region as the start of another region, producing two overlapping regions
extending to the end of addressable memory. If the zero-size region is of
a higher type than 'usable RAM' (eg 'reserved'), this causes all memory
above the zero-size region to be marked unusable (leaving 640k as of the
above example -- the kernel fails to start at all).

The patch adds code to remove empty entries before sorting regions. It
was generated for a 2.4.20 kernel.

Best regards,
Alex

[ Please send answers to my Reply-To address.
   I'm not subscribed to the kernel mailing list. ]

--------------080909030608050905050101
Content-Type: text/plain;
 name="nullmem.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nullmem.diff"

diff -ur linux-2.4.20/arch/i386/kernel/setup.c linux-2.4.20-nullmem/arch/i386/kernel/setup.c
--- linux-2.4.20/arch/i386/kernel/setup.c	Fri Nov 29 00:53:09 2002
+++ linux-2.4.20-nullmem/arch/i386/kernel/setup.c	Mon Dec 16 14:52:21 2002
@@ -71,6 +71,9 @@
  *  CacheSize bug workaround updates for AMD, Intel & VIA Cyrix.
  *  Dave Jones <davej@suse.de>, September, October 2001.
  *
+ *  Provisions for empty E820 memory regions (reported by certain BIOSes).
+ *  Alex Achenbach <xela@slit.de>, December 2002.
+ *
  */
 
 /*
@@ -501,7 +504,7 @@
 	int chgidx, still_changing;
 	int overlap_entries;
 	int new_bios_entry;
-	int old_nr, new_nr;
+	int old_nr, new_nr, chg_nr;
 	int i;
 
 	/*
@@ -555,20 +558,24 @@
 	for (i=0; i < 2*old_nr; i++)
 		change_point[i] = &change_point_list[i];
 
-	/* record all known change-points (starting and ending addresses) */
+	/* record all known change-points (starting and ending addresses),
+	   omitting those that are for empty memory regions */
 	chgidx = 0;
 	for (i=0; i < old_nr; i++)	{
-		change_point[chgidx]->addr = biosmap[i].addr;
-		change_point[chgidx++]->pbios = &biosmap[i];
-		change_point[chgidx]->addr = biosmap[i].addr + biosmap[i].size;
-		change_point[chgidx++]->pbios = &biosmap[i];
+		if (biosmap[i].size != 0) {
+			change_point[chgidx]->addr = biosmap[i].addr;
+			change_point[chgidx++]->pbios = &biosmap[i];
+			change_point[chgidx]->addr = biosmap[i].addr + biosmap[i].size;
+			change_point[chgidx++]->pbios = &biosmap[i];
+		}
 	}
+	chg_nr = chgidx;    	/* true number of change-points */
 
 	/* sort change-point list by memory addresses (low -> high) */
 	still_changing = 1;
 	while (still_changing)	{
 		still_changing = 0;
-		for (i=1; i < 2*old_nr; i++)  {
+		for (i=1; i < chg_nr; i++)  {
 			/* if <current_addr> > <last_addr>, swap */
 			/* or, if current=<start_addr> & last=<end_addr>, swap */
 			if ((change_point[i]->addr < change_point[i-1]->addr) ||
@@ -591,7 +598,7 @@
 	last_type = 0;		 /* start with undefined memory type */
 	last_addr = 0;		 /* start with 0 as last starting address */
 	/* loop through change-points, determining affect on the new bios map */
-	for (chgidx=0; chgidx < 2*old_nr; chgidx++)
+	for (chgidx=0; chgidx < chg_nr; chgidx++)
 	{
 		/* keep track of all overlapping bios entries */
 		if (change_point[chgidx]->addr == change_point[chgidx]->pbios->addr)

--------------080909030608050905050101--

