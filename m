Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263595AbUACRJH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 12:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263596AbUACRJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 12:09:07 -0500
Received: from [193.138.115.2] ([193.138.115.2]:59909 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S263595AbUACRJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 12:09:00 -0500
Date: Sat, 3 Jan 2004 18:06:20 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
cc: H.T.M.v.d.Maarel@marin.nl
Subject: [patch against 2.6.1-rc1-mm1] replace check_region with request_region
 in isp16.c
Message-ID: <Pine.LNX.4.56.0401031750330.4664@jju_lnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

When building linux 2.6.1-rc1-mm1 with "allmodconfig" I saw this warning :

drivers/cdrom/isp16.c
drivers/cdrom/isp16.c: In function `isp16_init':
drivers/cdrom/isp16.c:124: warning: `check_region' is deprecated (declared at include/linux/ioport.h:119)

So I desided to read up up check_region. The material I found indicates to
me (if I interpreted it correctly) that in previous kernels you had to
use check_region/request_region pairs to ensure that the region you wanted
to access was available before requesting it. With newer kernels there is
a chance that the driver could get interrupted in-between the calls to
check_region and request_region, so it was desided to get rid of
check_region and instead have request_region return an error if the region
requested is unavailable.
>From what I've read, it seems that getting rid of check_region should be
as simple as just replacing it with request_region and check the return
value, so that's what the patch below does.

One thing that surprised me was that the isp16 driver does not seem to
ever call request_region, it only ever calls check_region which confuses
me a bit - wouldn't it need to (also with older kernels) always call
request_region ?

In any case, I don't have the hardware to test this driver, so I can't
verify if it still works after patching it, all I can say is that it
compiles without warnings or errors with the patch.

I would appreciate it is someone could take a quick look at the patch and
verify that it does the correct thing.
Patch is against 2.6.1-rc1-mm1


--- linux-2.6.1-rc1-mm1-orig/drivers/cdrom/isp16.c      2003-12-31 05:48:26.000000000 +0100
+++ linux-2.6.1-rc1-mm1/drivers/cdrom/isp16.c   2004-01-03 17:55:14.000000000 +0100
@@ -121,7 +121,7 @@ int __init isp16_init(void)
                return (0);
        }

-       if (check_region(ISP16_IO_BASE, ISP16_IO_SIZE)) {
+       if (!request_region(ISP16_IO_BASE, ISP16_IO_SIZE, "isp16 cdrom")) {
                printk("ISP16: i/o ports already in use.\n");
                return (-EIO);
        }



Kind regards,

Jesper Juhl

