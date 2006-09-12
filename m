Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbWILDAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbWILDAE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 23:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWILDAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 23:00:04 -0400
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:21947 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1750923AbWILDAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 23:00:01 -0400
Date: Tue, 12 Sep 2006 08:30:29 +0530
From: Ankita Garg <ankita@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: maneesh@in.ibm.com, fernando@oss.ntt.co.jp, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Dump Test Module
Message-ID: <20060912030029.GD24676@in.ibm.com>
Reply-To: ankita@in.ibm.com
References: <20060907135329.GA17937@in.ibm.com> <20060908004244.6ef7deb7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fOHHtNG4YXGJ0yqR"
Content-Disposition: inline
In-Reply-To: <20060908004244.6ef7deb7.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fOHHtNG4YXGJ0yqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 08, 2006 at 12:42:44AM -0700, Andrew Morton wrote:
> On Thu, 7 Sep 2006 19:23:29 +0530
> Ankita Garg <ankita@in.ibm.com> wrote:
> 
> > +#include<linux/ide.h>
> 
> s390 doesn't have this, so it breaks the build.
> 
There could be two ways to solve the build issue on s390. One is to
conditionally include the "ide.h" file depending on whether CONFIG_IDE is
defined. The second method would be to make LKDTM dependent on IDE. But this
approach is not right as it would prevent usage of the module on s390
completely.

> And #include is followed by a space, please.

Done.

Thanks,
Ankita

--fOHHtNG4YXGJ0yqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lkdtm-s390.patch"

o This patch enables lkdtm to be built on s390

Signed-off-by: Ankita Garg <ankita@in.ibm.com>
--
 lkdtm.c |   28 ++++++++++++++++++----------
 1 files changed, 18 insertions(+), 10 deletions(-)

Index: linux-2.6.18-rc6-mm1/drivers/misc/lkdtm.c
===================================================================
--- linux-2.6.18-rc6-mm1.orig/drivers/misc/lkdtm.c	2006-09-11 20:58:53.000000000 +0530
+++ linux-2.6.18-rc6-mm1/drivers/misc/lkdtm.c	2006-09-11 21:06:43.000000000 +0530
@@ -43,15 +43,18 @@
  *		  to trigger an action. The default is 10.
  */
 
-#include<linux/kernel.h>
-#include<linux/module.h>
-#include<linux/kprobes.h>
-#include<linux/kallsyms.h>
-#include<linux/init.h>
-#include<linux/irq.h>
-#include<linux/ide.h>
-#include<linux/interrupt.h>
-#include<scsi/scsi_cmnd.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/kprobes.h>
+#include <linux/kallsyms.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <scsi/scsi_cmnd.h>
+
+#ifdef CONFIG_IDE
+#include <linux/ide.h>
+#endif
 
 #define NUM_CPOINTS 8
 #define NUM_CPOINT_TYPES 5
@@ -176,6 +179,7 @@
 	return 0;
 }
 
+#ifdef CONFIG_IDE
 int jp_generic_ide_ioctl(ide_drive_t *drive, struct file *file,
 			struct block_device *bdev, unsigned int cmd,
 			unsigned long arg)
@@ -184,7 +188,7 @@
 	jprobe_return();
 	return 0;
 }
-
+#endif
 
 static int lkdtm_parse_commandline(void)
 {
@@ -304,8 +308,12 @@
 		lkdtm.entry = (kprobe_opcode_t*) jp_scsi_dispatch_cmd;
 		break;
 	case IDE_CORE_CP:
+#ifdef CONFIG_IDE
 		lkdtm.kp.symbol_name = "generic_ide_ioctl";
 		lkdtm.entry = (kprobe_opcode_t*) jp_generic_ide_ioctl;
+#else
+		printk(KERN_INFO "lkdtm : Crash point not available\n");
+#endif
 		break;
 	default:
 		printk(KERN_INFO "lkdtm : Invalid Crash Point\n");

--fOHHtNG4YXGJ0yqR--
