Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266876AbSLUKkh>; Sat, 21 Dec 2002 05:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266886AbSLUKkh>; Sat, 21 Dec 2002 05:40:37 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:6339 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266876AbSLUKkf>; Sat, 21 Dec 2002 05:40:35 -0500
Message-ID: <3E044709.5050302@slit.de>
Date: Sat, 21 Dec 2002 11:48:41 +0100
From: achen@t-online.de (Alexander Achenbach)
Reply-To: xela@slit.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
X-Accept-Language: en
MIME-Version: 1.0
To: hpa@zytor.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zero-size E820 memory (kernel start-up failure)
References: <3E02F8E1.70509@slit.de> <20021220125400.GB28068@suse.de>
Content-Type: multipart/mixed;
 boundary="------------010201070305070901080206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010201070305070901080206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi again.

Dave Jones wrote:
 >
 >  > The patch adds code to remove empty entries before sorting regions. It
 >  > was generated for a 2.4.20 kernel.
 >
 > Looks good to me. Care to do a similar patch for 2.5 ?

This is it, to be applied against 2.5.52.
I've tested the kernel on an EPOX 4BEA-R and it boots as it should.

Cheers,
Alex

--------------010201070305070901080206
Content-Type: text/plain;
 name="nullmem-2.5.52.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nullmem-2.5.52.diff"

diff -ru linux-2.5.52/arch/i386/kernel/setup.c linux-2.5.52-nullmem/arch/i386/kernel/setup.c
--- linux-2.5.52/arch/i386/kernel/setup.c	Mon Dec 16 03:07:56 2002
+++ linux-2.5.52-nullmem/arch/i386/kernel/setup.c	Fri Dec 20 15:48:35 2002
@@ -14,6 +14,9 @@
  * Moved CPU detection code to cpu/${cpu}.c
  *    Patrick Mochel <mochel@osdl.org>, March 2002
  *
+ *  Provisions for empty E820 memory regions (reported by certain BIOSes).
+ *  Alex Achenbach <xela@slit.de>, December 2002.
+ *
  */
 
 /*
@@ -275,7 +278,7 @@
 	int chgidx, still_changing;
 	int overlap_entries;
 	int new_bios_entry;
-	int old_nr, new_nr;
+	int old_nr, new_nr, chg_nr;
 	int i;
 
 	/*
@@ -329,20 +332,24 @@
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
@@ -365,7 +372,7 @@
 	last_type = 0;		 /* start with undefined memory type */
 	last_addr = 0;		 /* start with 0 as last starting address */
 	/* loop through change-points, determining affect on the new bios map */
-	for (chgidx=0; chgidx < 2*old_nr; chgidx++)
+	for (chgidx=0; chgidx < chg_nr; chgidx++)
 	{
 		/* keep track of all overlapping bios entries */
 		if (change_point[chgidx]->addr == change_point[chgidx]->pbios->addr)

--------------010201070305070901080206--

