Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263296AbUCNFZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 00:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263292AbUCNFZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 00:25:26 -0500
Received: from fed1mtao04.cox.net ([68.6.19.241]:52730 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S263296AbUCNFZM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 00:25:12 -0500
Date: Sat, 13 Mar 2004 21:25:10 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: linux-kernel@vger.kernel.org, toshiba_acpi@memebeam.org, arjanv@redhat.com
Subject: [PATCH] (2.6.x) toshiba_acpi needs copy_from_user (fixes oops)
Message-ID: <20040314052510.GA2587@ip68-4-255-84.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On kernels with the 4G/4G patch (like some of the recent kernels in
Fedora Core 2 development), writing stuff to the /proc/acpi/toshiba/*
files causes an oops. As it turns out, this is because the driver is
accessing userspace data without first doing copy_from_user(). IOW, this
is a bug in toshiba_acpi, not a bug in the 4G/4G patch.

Here's a patch to fix this bug. I've tested it on 2.6.4 + some patches
from the FC kernels (including the 4G/4G patch) and it fixes my oopses.
I have also tested it against vanilla 2.6.4 and I haven't encountered
any regressions.

If there are any problems with this patch, let me know.

-Barry K. Nathan <barryn@pobox.com>


diff -ruN linux-2.6.4/drivers/acpi/toshiba_acpi.c linux-2.6.4-bkn1/drivers/acpi/toshiba_acpi.c
--- linux-2.6.4/drivers/acpi/toshiba_acpi.c	2004-03-12 21:31:59.000000000 -0800
+++ linux-2.6.4-bkn1/drivers/acpi/toshiba_acpi.c	2004-03-12 22:27:07.000000000 -0800
@@ -41,6 +41,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/proc_fs.h>
+#include <asm/uaccess.h>
 
 #include <acpi/acpi_drivers.h>
 
@@ -269,10 +270,18 @@
 }
 
 static int
-dispatch_write(struct file* file, const char* buffer, unsigned long count,
-	ProcItem* item)
+dispatch_write(struct file* file, const char __user *buffer,
+	unsigned long count, ProcItem* item)
 {
-	return item->write_func(buffer, count);
+	char str[48] = {'\0'};
+
+	if (count > sizeof(str) - 1)
+		return count;
+	
+	if (copy_from_user(str, buffer, count))
+		return -EFAULT;
+
+	return item->write_func(str, count);
 }
 
 static char*

