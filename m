Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262161AbUKDLOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbUKDLOt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 06:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262167AbUKDLOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 06:14:49 -0500
Received: from sd291.sivit.org ([194.146.225.122]:6873 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262161AbUKDLNH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 06:13:07 -0500
Date: Thu, 4 Nov 2004 12:13:22 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/12] meye: module related fixes
Message-ID: <20041104111322.GG3472@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <20041104111231.GF3472@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104111231.GF3472@crusoe.alcove-fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================

ChangeSet@1.2340, 2004-11-02 15:03:36+01:00, stelian@popies.net
  meye: module related fixes
          * use module_param() instead of MODULE_PARM() and __setup()
          * use MODULE_VERSION()
  
  Signed-off-by: Stelian Pop <stelian@popies.net>

===================================================================

 meye.c |   61 ++++++++++++++++++++++---------------------------------------
 meye.h |    3 +++
 2 files changed, 25 insertions(+), 39 deletions(-)

===================================================================

diff -Nru a/drivers/media/video/meye.c b/drivers/media/video/meye.c
--- a/drivers/media/video/meye.c	2004-11-04 11:03:16 +01:00
+++ b/drivers/media/video/meye.c	2004-11-04 11:03:16 +01:00
@@ -39,16 +39,31 @@
 #include <linux/vmalloc.h>
 
 #include "meye.h"
-#include "linux/meye.h"
+#include <linux/meye.h>
+
+MODULE_AUTHOR("Stelian Pop <stelian@popies.net>");
+MODULE_DESCRIPTION("v4l/v4l2 driver for the MotionEye camera");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(MEYE_DRIVER_VERSION);
 
-/* driver structure - only one possible */
-static struct meye meye;
 /* number of grab buffers */
 static unsigned int gbuffers = 2;
+module_param(gbuffers, int, 0444);
+MODULE_PARM_DESC(gbuffers, "number of capture buffers, default is 2 (32 max)");
+
 /* size of a grab buffer */
 static unsigned int gbufsize = MEYE_MAX_BUFSIZE;
+module_param(gbufsize, int, 0444);
+MODULE_PARM_DESC(gbufsize, "size of the capture buffers, default is 614400"
+		 " (will be rounded up to a page multiple)");
+
 /* /dev/videoX registration number */
 static int video_nr = -1;
+module_param(video_nr, int, 0444);
+MODULE_PARM_DESC(video_nr, "video device to register (0=/dev/video0, etc)");
+
+/* driver structure - only one possible */
+static struct meye meye;
 
 /****************************************************************************/
 /* Queue routines                                                           */
@@ -1438,7 +1453,7 @@
 #endif
 };
 
-static int __init meye_init_module(void) {
+static int __init meye_init(void) {
 	if (gbuffers < 2)
 		gbuffers = 2;
 	if (gbuffers > MEYE_MAX_BUFNBRS)
@@ -1450,42 +1465,10 @@
 	return pci_module_init(&meye_driver);
 }
 
-static void __exit meye_cleanup_module(void) {
+static void __exit meye_exit(void) {
 	pci_unregister_driver(&meye_driver);
 }
 
-#ifndef MODULE
-static int __init meye_setup(char *str) {
-	int ints[4];
-
-	str = get_options(str, ARRAY_SIZE(ints), ints);
-	if (ints[0] <= 0) 
-		goto out;
-	gbuffers = ints[1];
-	if (ints[0] == 1)
-		goto out;
-	gbufsize = ints[2];
-	if (ints[0] == 2)
-		goto out;
-	video_nr = ints[3];
-out:
-	return 1;
-}
-
-__setup("meye=", meye_setup);
-#endif
-
-MODULE_AUTHOR("Stelian Pop <stelian@popies.net>");
-MODULE_DESCRIPTION("video4linux driver for the MotionEye camera");
-MODULE_LICENSE("GPL");
-
-MODULE_PARM(gbuffers,"i");
-MODULE_PARM_DESC(gbuffers,"number of capture buffers, default is 2 (32 max)");
-MODULE_PARM(gbufsize,"i");
-MODULE_PARM_DESC(gbufsize,"size of the capture buffers, default is 614400");
-MODULE_PARM(video_nr,"i");
-MODULE_PARM_DESC(video_nr,"video device to register (0=/dev/video0, etc)");
-
 /* Module entry points */
-module_init(meye_init_module);
-module_exit(meye_cleanup_module);
+module_init(meye_init);
+module_exit(meye_exit);
diff -Nru a/drivers/media/video/meye.h b/drivers/media/video/meye.h
--- a/drivers/media/video/meye.h	2004-11-04 11:03:16 +01:00
+++ b/drivers/media/video/meye.h	2004-11-04 11:03:16 +01:00
@@ -33,6 +33,9 @@
 #define MEYE_DRIVER_MAJORVERSION	1
 #define MEYE_DRIVER_MINORVERSION	10
 
+#define MEYE_DRIVER_VERSION __stringify(MEYE_DRIVER_MAJORVERSION) "." \
+			    __stringify(MEYE_DRIVER_MINORVERSION)
+
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/pci.h>
