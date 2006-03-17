Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752155AbWCQKXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbWCQKXv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 05:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752582AbWCQKXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 05:23:51 -0500
Received: from smtp10.wanadoo.fr ([193.252.22.21]:29141 "EHLO
	smtp10.wanadoo.fr") by vger.kernel.org with ESMTP id S1752155AbWCQKXu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 05:23:50 -0500
X-ME-UUID: 20060317102349823.C91CA18000B9@mwinf1001.wanadoo.fr
From: Laurent Wandrebeck <l.wandrebeck@free.fr>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [patch 1/1] OSS msnd_pinnacle missing return check for request_region()
Date: Fri, 17 Mar 2006 11:27:55 +0100
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200603171127.55537.l.wandrebeck@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
in sound/oss/msnd_pinnacle.c, request_region() is called without checking the return
value. Here is a simple patch to fix it.
Patch against 2.6.16-rc6-git8.
Please CC me on replies.
Regards.
PS: trying with a MUA this time, since the webmail I used for previous patch 
( [patch 1/1] OSS ali5455 missing return check for request_region() ) wrapped lines :(

Signed-off-by: Laurent Wandrebeck <l.wandrebeck@free.fr>

--- linux-2.6.16-rc6/sound/oss/msnd_pinnacle.c.ori      2006-03-17 10:45:46.000000000 +0100
+++ linux-2.6.16-rc6/sound/oss/msnd_pinnacle.c  2006-03-17 11:05:42.000000000 +0100
@@ -1397,7 +1397,13 @@ static int __init attach_multisound(void
                printk(KERN_ERR LOGNAME ": Couldn't grab IRQ %d\n", dev.irq);
                return err;
        }
-       request_region(dev.io, dev.numio, dev.name);
+
+       if (!request_region(dev.io, dev.numio, dev.name)) {
+               printk(KERN_ERR LOGNAME ": Unable to reserve region %d\n",
+                                dev->io);
+               free_irq(dev.irq,&dev);
+               return -EBUSY;
+       }

         if ((err = dsp_full_reset()) < 0) {
                release_region(dev.io, dev.numio);

