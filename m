Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932744AbWCQOHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932744AbWCQOHH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 09:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932745AbWCQOHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 09:07:07 -0500
Received: from smtp13.wanadoo.fr ([193.252.22.54]:55419 "EHLO
	smtp13.wanadoo.fr") by vger.kernel.org with ESMTP id S932746AbWCQOHF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 09:07:05 -0500
X-ME-UUID: 20060317140704151.24EE2700009D@mwinf1306.wanadoo.fr
From: Laurent Wandrebeck <l.wandrebeck@free.fr>
To: linux-kernel@vger.kernel.org
Subject: missing return value check for request_region() in in2000.c
Date: Fri, 17 Mar 2006 15:11:10 +0100
User-Agent: KMail/1.8
Cc: akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603171511.10791.l.wandrebeck@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
in drivers/scsi/in2000.c, request_region() is called without checking the return
value. Here is a patch to fix it.
Patch against 2.6.16-rc6-git8.
Please CC me on replies.
Regards.

Signed-off-by: Laurent Wandrebeck <l.wandrebeck@free.fr>

--- linux-2.6.16-rc6/drivers/scsi/in2000.c.ori  2006-03-17 14:42:20.000000000 +0100
+++ linux-2.6.16-rc6/drivers/scsi/in2000.c      2006-03-17 14:50:14.000000000 +0100
@@ -2010,7 +2010,12 @@ static int __init in2000_detect(struct s
                }
                instance->irq = x;
                instance->n_io_port = 13;
-               request_region(base, 13, "in2000");     /* lock in this IO space for our use */
+               if (!request_region(base, 13, "in2000")) {      /* lock in this IO space for our use */
+                       printk(KERN_ERR "in2000: unable to reserve region 0x%x\n", base);
+                       free_irq(instance->irq, instance);
+                       detect_count--;
+                       continue;
+               }

                for (x = 0; x < 8; x++) {
                        hostdata->busy[x] = 0;

