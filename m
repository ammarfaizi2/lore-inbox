Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269237AbUJKUk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269237AbUJKUk6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 16:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269240AbUJKUk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 16:40:57 -0400
Received: from vsmtp3alice.tin.it ([212.216.176.143]:10449 "EHLO vsmtp3.tin.it")
	by vger.kernel.org with ESMTP id S269237AbUJKUkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 16:40:42 -0400
From: "andreamrl@tiscali.it" <andreamrl@tiscali.it>
Reply-To: andreamrl@tiscali.it
To: dagb@cs.uit.no
Subject: PATCH: trivial, nsc-ircc dongle_id fix
Date: Mon, 11 Oct 2004 22:41:02 +0200
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410112241.02734.andreamrl@tiscali.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
The following patch add checks for parameter dongle_id in module nsc-ircc.
In the original version kernel opsed if passed mad dongle_id values, also 
expliciting forcing dongle_id 0 was not possible.
This patch proposal trivially fix it.
altought this is against 2.6.6 kernel (sorry for that), quickly looking the 
code of 2.6.8.1 seems that the bug still exist (code is mostly unchanged).
Regards,
Andrea Merello

--- nsc-ircc.c.orig     2004-10-11 16:32:16.000000000 +0200
+++ nsc-ircc.c  2004-10-11 17:13:38.000000000 +0200
@@ -72,7 +72,7 @@ static char *driver_name = "nsc-ircc";

 /* Module parameters */
 static int qos_mtt_bits = 0x07;  /* 1 ms or more */
-static int dongle_id;
+static int dongle_id=-1;

 /* Use BIOS settions by default, but user may supply module parameters */
 static unsigned int io[]  = { ~0, ~0, ~0, ~0 };
@@ -349,12 +349,17 @@ static int __init nsc_ircc_open(int i, c
        MESSAGE("IrDA: Registered device %s\n", dev->name);

        /* Check if user has supplied the dongle id or not */
-       if (!dongle_id) {
+       if (dongle_id == -1) {
                dongle_id = nsc_ircc_read_dongle_id(self->io.fir_base);
-
                MESSAGE("%s, Found dongle: %s\n", driver_name,
                        dongle_types[dongle_id]);
        } else {
+               if(dongle_id < 0 || dongle_id >= sizeof(dongle_types) / 
sizeof(char*)){
+                       MESSAGE ("%s, Invalid dongle_id: %d\n",driver_name,
+                       dongle_id);
+                       err=-1;
+                       goto out5;
+               }
                MESSAGE("%s, Using dongle: %s\n", driver_name,
                        dongle_types[dongle_id]);
        }
@@ -367,6 +372,8 @@ static int __init nsc_ircc_open(int i, c
                 pmdev->data = self;

        return 0;
+ out5:
+       unregister_netdev(dev);
  out4:
        kfree(self->tx_buff.head);
