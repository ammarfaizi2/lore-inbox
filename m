Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272974AbTHFAuk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 20:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272983AbTHFAuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 20:50:40 -0400
Received: from out004pub.verizon.net ([206.46.170.142]:10932 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S272974AbTHFAuK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 20:50:10 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: 2.4 vs 2.6 versions of include/linux/ioport.h
Date: Tue, 5 Aug 2003 20:50:07 -0400
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200308051041.08078.gene.heskett@verizon.net> <20030805075758.31f51879.rddunlap@osdl.org>
In-Reply-To: <20030805075758.31f51879.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/CFM/ARbOSBd4oT"
Message-Id: <200308052050.07841.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.12.168] at Tue, 5 Aug 2003 19:50:08 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_/CFM/ARbOSBd4oT
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 05 August 2003 10:57, Randy.Dunlap wrote:
>On Tue, 5 Aug 2003 10:41:08 -0400 Gene Heskett 
<gene.heskett@verizon.net> wrote:
>| Greetings;
>|
>| In the 2.4 includes, find this in ioport.h
>| ----
>| /* Compatibility cruft */
>| #define check_region(start,n)   __check_region(&ioport_resource,
>| (start), (n))
>| [snip]
>| extern int __check_region(struct resource *, unsigned long,
>| unsigned long);
>| ----
>| But in the 2.6 version, find this:
>| ----
>| /* Compatibility cruft */
>| [snip]
>| extern int __check_region(struct resource *, unsigned long,
>| unsigned long);
>| [snip]
>| static inline int __deprecated check_region(unsigned long s,
>| unsigned long n)
>| {
>|         return __check_region(&ioport_resource, s, n);
>| }
>| ----
>| First, the define itself is missing in the 2.6 version.
>|
>| Many drivers seem to use this call, and in that which I'm trying
>| to build, the nforce and advansys modules use it.  And while the
>| modules seem to build, they do not run properly.
>|
>| I cannot run 2.6.x for extended tests because of the advansys
>| breakage this causes.  I also haven't even tried to run X because
>| of the nforce error reported when its built, the same error as
>| attacks the advansys code.
>|
>| Can I ask why this change was made, and is there a suitable
>| replacement call available that these drivers could use instead of
>| check_region(), as shown here in a snip from advansys.c?
>| ----
>| if (check_region(iop, ASC_IOADR_GAP) != 0) {
>| ...
>| if (check_region(iop_base, ASC_IOADR_GAP) != 0) {
>| ...
>|
>| Hopeing for some hints here.
>
>check_region() was racy.  Use request_region() instead.
>
>   if (!request_region(iop, ASC_IOADR_GAP, "advansys")) {
>   ...
>
>   if (!request_region(iop_base, ASC_IOADR, "advansys")) {
>   ...
>
>Of course, if successful, this assigns the region to the driver,
>while check_region() didn't do this, so release_region() should be
>used as needed to return the resources.

Randy, look the attached patch over & see if its suitable.  Its 
against the driver in the 2.6.0-test2 archive, and was done from 
within the drivers/scsi directory.  Its working fine here, booting 
and accessing my tape drive just fine with the advansys driver 
incorporated into the kernel, or as a module.  I didn't see any 
memory leakage, but my test method isn't definitive.

If its suitable, pass it on to Linus.  It will add one more card to 
the NOT broken by 2.6 list.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

--Boundary-00=_/CFM/ARbOSBd4oT
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-advansys.c-for-2.6"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-advansys.c-for-2.6"

--- advansys.c-orig	2003-07-27 12:59:39.000000000 -0400
+++ advansys.c	2003-08-05 20:28:37.000000000 -0400
@@ -1,5 +1,5 @@
-#define ASC_VERSION "3.3GJ"    /* AdvanSys Driver Version */
+#define ASC_VERSION "3.4MGH"    /* AdvanSys Driver Version */
 
 /*
  * advansys.c - Linux Host Driver for AdvanSys SCSI Adapters
  *
@@ -24,8 +24,15 @@
  *  ftp://ftp.connectcom.net/pub/linux/linux.tgz
  *
  * Please send questions, comments, bug reports to:
  *  support@connectcom.net
+ *  
+ *  Unforch, connectcom seems to have been bankrupt, and a new
+ *  company has bought some, but not all, of the advansys line.
+ *  What they, Initio I think it is, bought, did not include
+ *  the ABP-930 family, so this hardware is officially in the
+ *  orphaned state now.  This per a message Initio returned to me
+ *  Gene Heskett on about 08/03/2003.
  */
 
 /*
 
@@ -676,8 +683,12 @@
      3.3GJD (10/14/02):
          1. change select_queue_depths to slave_configure
 	 2. make cmd_per_lun be sane again
 
+     3.4MGH (08/05/2003)
+	 1. change check_region calls to request_region in an attempt
+	 to 2.6-ify this driver.  I'm 100% hacking in the dark here folks.
+
   I. Known Problems/Fix List (XXX)
 
      1. Need to add memory mapping workaround. Test the memory mapping.
         If it doesn't work revert to I/O port access. Can a test be done
@@ -741,8 +752,14 @@
 
      Andy Kellner <AKellner@connectcom.net> continues the Advansys SCSI
      driver development for ConnectCom (Version > 3.3F).
 
+     But he has now denied any interest in further support for obsolete
+     cards.  They'd be glad to sell me a new card, but I could
+     not find a scsi-2 FAST, 20mhz/sec card in their lineup.  I've
+     changed the version string to append MEH to the 3.4, and will
+     attempt to keep it going for a while yet.
+     
   K. ConnectCom (AdvanSys) Contact Information
 
      Mail:                   ConnectCom Solutions, Inc.
                              1150 Ringwood Court
@@ -753,8 +770,13 @@
      Tech Support E-Mail:    linux@connectcom.net
      FTP Site:               ftp.connectcom.net (login: anonymous)
      Web Site:               http://www.connectcom.net
 
+     I'll leave the above in just in case someone wants to follow
+     the trail.
+
+     I can usually be reached at <gene.heskett@verizon.net>
+
 */
 
 
 /*
@@ -775,9 +797,9 @@
     (LINUX_VERSION_CODE > ASC_LINUX_VERSION(2,3,0) && \
      LINUX_VERSION_CODE < ASC_LINUX_VERSION(2,4,0))
 #error "AdvanSys driver supported only in 2.2 and 2.4 or greater kernels."
 #endif
-
+ 
 /*
  * --- Linux Include Files
  */
 
@@ -4618,9 +4640,9 @@
                     if (iop) {
                         ASC_DBG1(1,
                                 "advansys_detect: probing I/O port 0x%x...\n",
                             iop);
-                        if (check_region(iop, ASC_IOADR_GAP) != 0) {
+                        if (!request_region(iop, ASC_IOADR_GAP, "advansys")) {
                             printk(
 "AdvanSys SCSI: specified I/O Port 0x%X is busy\n", iop);
                             /* Don't try this I/O port twice. */
                             asc_ioport[ioport] = 0;
@@ -10000,11 +10022,11 @@
         }
     }
     for (; i < ASC_IOADR_TABLE_MAX_IX; i++) {
         iop_base = _asc_def_iop_base[i];
-        if (check_region(iop_base, ASC_IOADR_GAP) != 0) {
+        if (!request_region(iop_base, ASC_IOADR_GAP, "advansys")) {
             ASC_DBG1(1,
-               "AscSearchIOPortAddr11: check_region() failed I/O port 0x%x\n",
+               "AscSearchIOPortAddr11: request_region() failed I/O port 0x%x\n",
                      iop_base);
             continue;
         }
         ASC_DBG1(1, "AscSearchIOPortAddr11: probing I/O port 0x%x\n", iop_base);

--Boundary-00=_/CFM/ARbOSBd4oT--

