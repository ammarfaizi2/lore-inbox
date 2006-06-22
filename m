Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161175AbWFVSvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161175AbWFVSvN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161183AbWFVSvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:51:12 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:24479 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161175AbWFVSvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:51:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=k2xxb1mVZ2SKplFFp442CSUHnYgK41vLOamVv+W9pdf2qsTweZdTShMZJW47VUbMzxs0ffNkpxGGvrnW0o+7fyhPxbot52FbuZgHWYkUQCBUZklYxRs3c+1nZOs8OmuvvJ1Q8izLPHo+oQvVmv38YQjBkoZcN8kga0g+SqGbxK0=
Message-ID: <449AE69C.1040404@gmail.com>
Date: Thu, 22 Jun 2006 12:51:08 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [ patch -mm1 04/11 ] gpio-patchset-fixups: request-region
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff.13-fix-request-region

Usage of request_region() was wrong ( returns 0 on error - docpatch sent 
to trivial ).
This fixes it, and clarifies the err-msg.

Signed-off-by:   Jim Cromie <jim.cromie@gmail.com>

---

diff -ruNp -X dontdiff -X exclude-diffs 17-mm-pre0/drivers/char/pc8736x_gpio.c 13/drivers/char/pc8736x_gpio.c
--- 17-mm-pre0/drivers/char/pc8736x_gpio.c	2006-06-20 20:42:39.000000000 -0600
+++ 13/drivers/char/pc8736x_gpio.c	2006-06-21 10:31:31.000000000 -0600
@@ -297,9 +297,12 @@ static int __init pc8736x_gpio_init(void
 	pc8736x_gpio_base = (superio_inb(SIO_BASE_HADDR) << 8
 			     | superio_inb(SIO_BASE_LADDR));
 
-	if (request_region(pc8736x_gpio_base, 16, DEVNAME))
-		dev_info(&pdev->dev, "GPIO ioport %x reserved\n",
-			 pc8736x_gpio_base);
+	if (!request_region(pc8736x_gpio_base, 16, DEVNAME)) {
+		dev_err(&pdev->dev, "GPIO ioport %x busy\n",
+			pc8736x_gpio_base);
+		return -ENODEV;
+	}
+	dev_info(&pdev->dev, "GPIO ioport %x reserved\n", pc8736x_gpio_base);
 
 	r = register_chrdev(major, DEVNAME, &pc8736x_gpio_fops);
 	if (r < 0) {


