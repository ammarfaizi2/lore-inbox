Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbULEKQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbULEKQK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 05:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbULEKQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 05:16:10 -0500
Received: from linaeum.absolutedigital.net ([63.87.232.45]:42909 "EHLO
	linaeum.absolutedigital.net") by vger.kernel.org with ESMTP
	id S261291AbULEKP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 05:15:59 -0500
Date: Sun, 5 Dec 2004 05:15:42 -0500 (EST)
From: Cal Peake <cp@absolutedigital.net>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.10-rc3 oops when 'modprobe -r dvb-bt8xx'
In-Reply-To: <41B1BD24.4050603@eyal.emu.id.au>
Message-ID: <Pine.LNX.4.61.0412050455440.27512@linaeum.absolutedigital.net>
References: <Pine.LNX.4.58.0412031611460.22796@ppc970.osdl.org>
 <41B1BD24.4050603@eyal.emu.id.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Dec 2004, Eyal Lebedinsky wrote:

> In the spirit of festive testing I would like to say that the oops that I
> enjoyed throughout rc2-bk* is still present in -rc3. -mm series does not
> have this problem.
> 
> EIP is at bttv_i2c_info+0x36/0x6a [bttv]

Hi Eyal,

>From what I can tell the oops comes from the above function calling 
dvb_bt8xx_i2c_info after the module that holds it (dvb-bt8xx) gets 
unloaded. The dvb_bt8xx... function has been removed from rc2-mm4 so 
that's prolly why you don't get the oops in the -mm kernels.

Until the changes propagate from -mm to Linus' tree the below patch should 
take care of it.

-- Cal

Signed-off-by: Cal Peake <cp@absolutedigital.net>

--- linux-2.6.10-rc3/drivers/media/dvb/bt8xx/dvb-bt8xx.c.orig	2004-12-05 02:19:58.000000000 -0500
+++ linux-2.6.10-rc3/drivers/media/dvb/bt8xx/dvb-bt8xx.c	2004-12-05 05:11:14.000000000 -0500
@@ -331,24 +331,6 @@
 	return 0;
 	}
 
-static void dvb_bt8xx_i2c_info(struct bttv_sub_device *sub,
-			       struct i2c_client *client, int attach)
-{
-	struct dvb_bt8xx_card *card = dev_get_drvdata(&sub->dev);
-
-	if (attach) {
-		printk("xxx attach\n");
-		if (client->driver->command)
-			client->driver->command(client, FE_REGISTER,
-						card->dvb_adapter);
-	} else {
-		printk("xxx detach\n");
-		if (client->driver->command)
-			client->driver->command(client, FE_UNREGISTER,
-						card->dvb_adapter);
-	}
-}
-
 static struct bttv_sub_driver driver = {
 	.drv = {
 		.name		= "dvb-bt8xx",
@@ -360,7 +342,6 @@
 		 * .resume	= dvb_bt8xx_resume,
 		 */
 	},
-	.i2c_info = dvb_bt8xx_i2c_info,
 };
 
 static int __init dvb_bt8xx_init(void)
