Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262518AbUKWC2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262518AbUKWC2m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 21:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbUKWC0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 21:26:35 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:5649 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262451AbUKWCXh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 21:23:37 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: Add disable_clkrun option
References: <87brdqxjn1.fsf@devron.myhome.or.jp>
	<20041122142439.45d5f439.akpm@osdl.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 23 Nov 2004 11:23:22 +0900
In-Reply-To: <20041122142439.45d5f439.akpm@osdl.org> (Andrew Morton's
 message of "Mon, 22 Nov 2004 14:24:39 -0800")
Message-ID: <87fz31wbfp.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> What is a CLKRUN protocol and why do we need to disable it?  Is it a
> hardware bug, or is the kernel malfunctioning in some way?

CLKRUN is used for controling the PCI clock by PCI devices (for power
saving). If device has bug, probably it becomes the cause of stopping
the PCI clock at an unexpected timing.

In the problem of realtek 8139 case, the TX packet which the driver
set to the device was not sent out (still pending state in device).

If "disable_clkrun" is enabled, the problem of TX stopped occurring.
So, I thought the cause is CLKRUN, and is hardware bug of Cardbus or
realtek 8139. (8139 seems only can control by rewriting EEPROM)

And looks like also
http://support.microsoft.com/default.aspx?scid=kb;en-us;q294465
http://support.microsoft.com/default.aspx?scid=kb;en-us;182591
has the problem of CLKRUN.

By these, I thought "disable_clrun" would be useful.

> We should add a MODULE_PARM_DESC as well, so users have some hope of finding
> this option.

Indeed.

Please review the attached patch.

> But what are the symptoms of the problem?  How would a user know that he
> should try using this option?

Umm.. Probably the PC card stop working, or is strange behavior. Sorry, I
don't know what happens actually.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


[PATCH] pcmcia: Add disable_clkrun option

I received report that transmission of Realtek 8139 doesn't work.  The
cause of this problem was CLKRUN protocols of laptop's TI 12xx CardBus
bridge.

And I remember that this problem had happened on Thinkpad before. In
the case, problem seems solved by similar workaround of sound/oss/cs46xx.c.

This patch adds "disable_clkrun" option as workaround of problem to
yenta_socket.

Please apply.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 drivers/pcmcia/ti113x.h       |   11 ++++++++---
 drivers/pcmcia/yenta_socket.c |    3 +++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff -puN drivers/pcmcia/ti113x.h~pcmcia-clkrun-disable drivers/pcmcia/ti113x.h
--- linux-2.6.10-rc2/drivers/pcmcia/ti113x.h~pcmcia-clkrun-disable	2004-11-23 11:06:02.000000000 +0900
+++ linux-2.6.10-rc2-hirofumi/drivers/pcmcia/ti113x.h	2004-11-23 11:06:03.000000000 +0900
@@ -592,15 +592,20 @@ out:
 
 static int ti12xx_override(struct yenta_socket *socket)
 {
-	u32 val;
+	u32 val, val_orig;
 
 	/* make sure that memory burst is active */
-	val = config_readl(socket, TI113X_SYSTEM_CONTROL);
+	val_orig = val = config_readl(socket, TI113X_SYSTEM_CONTROL);
+	if (disable_clkrun && PCI_FUNC(socket->dev->devfn) == 0) {
+		printk(KERN_INFO "Yenta: Disabling CLKRUN feature\n");
+		val |= TI113X_SCR_KEEPCLK;
+	}
 	if (!(val & TI122X_SCR_MRBURSTUP)) {
 		printk(KERN_INFO "Yenta: Enabling burst memory read transactions\n");
 		val |= TI122X_SCR_MRBURSTUP;
-		config_writel(socket, TI113X_SYSTEM_CONTROL, val);
 	}
+	if (val_orig != val)
+		config_writel(socket, TI113X_SYSTEM_CONTROL, val);
 
 	/*
 	 * for EnE bridges only: clear testbit TLTEnable. this makes the
diff -puN drivers/pcmcia/yenta_socket.c~pcmcia-clkrun-disable drivers/pcmcia/yenta_socket.c
--- linux-2.6.10-rc2/drivers/pcmcia/yenta_socket.c~pcmcia-clkrun-disable	2004-11-23 11:06:02.000000000 +0900
+++ linux-2.6.10-rc2-hirofumi/drivers/pcmcia/yenta_socket.c	2004-11-23 11:06:03.000000000 +0900
@@ -28,6 +28,9 @@
 #include "yenta_socket.h"
 #include "i82365.h"
 
+static int disable_clkrun;
+module_param(disable_clkrun, bool, 0444);
+MODULE_PARM_DESC(disable_clkrun, "If PC card does'nt function properly, please try this option");
 
 #if 0
 #define debug(x,args...) printk(KERN_DEBUG "%s: " x, __func__ , ##args)
_
