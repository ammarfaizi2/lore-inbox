Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261969AbVDVPMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbVDVPMi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 11:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbVDVPLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 11:11:08 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:42408 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S261971AbVDVPDL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 11:03:11 -0400
Date: Fri, 22 Apr 2005 17:02:38 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 10/12] s390: remove ioctl32 from dasdcmb.
Message-ID: <20050422150238.GJ17508@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 10/12] s390: remove ioctl32 from dasdcmb.

From: Cornelia Huck <cohuck@de.ibm.com>

The ioctl32_conversion routines will be deprecated: Remove them from
dasd_cmb and handle the three cmb ioctls like all other dasd ioctls.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/compat_ioctl.c |    7 ++++++-
 drivers/s390/block/dasd_cmb.c   |   19 ++-----------------
 include/asm-s390/cmb.h          |    2 +-
 3 files changed, 9 insertions(+), 19 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/compat_ioctl.c linux-2.6-patched/arch/s390/kernel/compat_ioctl.c
--- linux-2.6/arch/s390/kernel/compat_ioctl.c	2005-04-22 15:44:44.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/compat_ioctl.c	2005-04-22 15:45:06.000000000 +0200
@@ -16,6 +16,7 @@
 #define CODE
 #include "../../../fs/compat_ioctl.c"
 #include <asm/dasd.h>
+#include <asm/cmb.h>
 #include <asm/tape390.h>
 
 static int do_ioctl32_pointer(unsigned int fd, unsigned int cmd,
@@ -58,7 +59,11 @@ COMPATIBLE_IOCTL(BIODASDPRRD)
 COMPATIBLE_IOCTL(BIODASDPSRD)
 COMPATIBLE_IOCTL(BIODASDGATTR)
 COMPATIBLE_IOCTL(BIODASDSATTR)
-
+#if defined(CONFIG_DASD_CMB) || defined(CONFIG_DASD_CMB_MODULE)
+COMPATIBLE_IOCTL(BIODASDCMFENABLE)
+COMPATIBLE_IOCTL(BIODASDCMFDISABLE)
+COMPATIBLE_IOCTL(BIODASDREADALLCMB)
+#endif
 #endif
 
 #if defined(CONFIG_S390_TAPE) || defined(CONFIG_S390_TAPE_MODULE)
diff -urpN linux-2.6/drivers/s390/block/dasd_cmb.c linux-2.6-patched/drivers/s390/block/dasd_cmb.c
--- linux-2.6/drivers/s390/block/dasd_cmb.c	2005-03-02 08:38:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_cmb.c	2005-04-22 15:45:06.000000000 +0200
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/s390/block/dasd_cmb.c ($Revision: 1.6 $)
+ * linux/drivers/s390/block/dasd_cmb.c ($Revision: 1.9 $)
  *
  * Linux on zSeries Channel Measurement Facility support
  *  (dasd device driver interface)
@@ -23,7 +23,6 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 #include <linux/init.h>
-#include <linux/ioctl32.h>
 #include <linux/module.h>
 #include <asm/ccwdev.h>
 #include <asm/cmb.h>
@@ -84,27 +83,13 @@ dasd_ioctl_readall_cmb(struct block_devi
 static inline int
 ioctl_reg(unsigned int no, dasd_ioctl_fn_t handler)
 {
-	int ret;
-	ret = dasd_ioctl_no_register(THIS_MODULE, no, handler);
-#ifdef CONFIG_COMPAT
-	if (ret)
-		return ret;
-
-	ret = register_ioctl32_conversion(no, NULL);
-	if (ret)
-		dasd_ioctl_no_unregister(THIS_MODULE, no, handler);
-#endif
-	return ret;
+	return dasd_ioctl_no_register(THIS_MODULE, no, handler);
 }
 
 static inline void
 ioctl_unreg(unsigned int no, dasd_ioctl_fn_t handler)
 {
 	dasd_ioctl_no_unregister(THIS_MODULE, no, handler);
-#ifdef CONFIG_COMPAT
-	unregister_ioctl32_conversion(no);
-#endif
-
 }
 
 static void
diff -urpN linux-2.6/include/asm-s390/cmb.h linux-2.6-patched/include/asm-s390/cmb.h
--- linux-2.6/include/asm-s390/cmb.h	2005-03-02 08:38:37.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/cmb.h	2005-04-22 15:45:06.000000000 +0200
@@ -52,7 +52,7 @@ struct cmbdata {
 #define BIODASDREADALLCMB	_IOWR(DASD_IOCTL_LETTER,33,struct cmbdata)
 
 #ifdef __KERNEL__
-
+struct ccw_device;
 /**
  * enable_cmf() - switch on the channel measurement for a specific device
  *  @cdev:	The ccw device to be enabled
