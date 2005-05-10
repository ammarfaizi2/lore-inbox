Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbVEJVaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbVEJVaA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 17:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbVEJV37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 17:29:59 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:22211 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261798AbVEJV1Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 17:27:24 -0400
Date: Tue, 10 May 2005 14:27:21 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: chas@cmf.nrl.navy.mil
Cc: linux-atm-general@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix ATM build with O=
Message-ID: <20050510212721.GC2772@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.12-rc3-mm2 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chas,

I noticed today, while trying to build with the O= make option (which
allows the objects to be in a different directory than the source), that
ATM throws a warning. Turns out there is an explicit dependency on where
include is. But, with O=, include only contains asm-offsets.s and
include2 contains the appropriate files.

Here is a first attempt at a fix... Ideally, I could just check
KBUILD_OUTPUT's value (which should be set with O= or the
environmental variable KBUILD_OUTPUT). But I couldn't get that to work
(can try again with some guidance, though). Instead, I just check if the
source and object trees are different -- which I think can only be the
case if you use O= or KBUILD_OUTPUT. I think the change from $(src) to
$(obj) is also correct...

Description: Fix the build process for ATM when the make command-line
option O= is used. The current code assumes the files will be availabled
in the src directory (not the case with O=) and that include is the
directory to look in (not the case with O=). I would prefer to use
KBUILD_OUTPUT, but was unable to get it working.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.12-rc4/drivers/atm/Makefile.orig	2005-05-10 14:24:35.000000000 -0700
+++ 2.6.12-rc4/drivers/atm/Makefile	2005-05-10 14:19:43.000000000 -0700
@@ -39,7 +39,11 @@ ifeq ($(CONFIG_ATM_FORE200E_PCA),y)
   fore_200e-objs		+= fore200e_pca_fw.o
   # guess the target endianess to choose the right PCA-200E firmware image
   ifeq ($(CONFIG_ATM_FORE200E_PCA_DEFAULT_FW),y)
-    CONFIG_ATM_FORE200E_PCA_FW = $(shell if test -n "`$(CC) -E -dM $(src)/../../include/asm/byteorder.h | grep ' __LITTLE_ENDIAN '`"; then echo $(obj)/pca200e.bin; else echo $(obj)/pca200e_ecd.bin2; fi)
+    ifneq ($(srctree),$(objtree))
+      CONFIG_ATM_FORE200E_PCA_FW = $(shell if test -n "`$(CC) -E -dM $(obj)/../../include2/asm/byteorder.h | grep ' __LITTLE_ENDIAN '`"; then echo $(obj)/pca200e.bin; else echo $(obj)/pca200e_ecd.bin2; fi)
+    else
+      CONFIG_ATM_FORE200E_PCA_FW = $(shell if test -n "`$(CC) -E -dM $(obj)/../../include/asm/byteorder.h | grep ' __LITTLE_ENDIAN '`"; then echo $(obj)/pca200e.bin; else echo $(obj)/pca200e_ecd.bin2; fi)
+    endif
   endif
 endif
 
