Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbVADNmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVADNmn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 08:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbVADNmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 08:42:43 -0500
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:56073 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261626AbVADNmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 08:42:37 -0500
Date: Tue, 4 Jan 2005 14:44:36 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Gerd Knorr <kraxel@bytesex.org>
Subject: [PATCH 2.4] I2C: Cleanup a couple media/video drivers
Message-Id: <20050104144436.5e7bc84c.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, hi all,

Two media/video drivers in 2.4 have a compatibility trick to make them
work when the kernel tree is patched with i2c 2.8.x. The trick also
allowed to share the same code between Linux 2.4 and 2.5/2.6.
Unfortunately, the trick relies on one define (I2C_PEC) to define (or
not) structure members that are not related with that define at all.
That define was picked just because it happened to be present in i2c
2.8.x and the 2.5/2.6 kernel trees, but not in the (unpatched) 2.4
kernel tree. Basically, the trick was to switch to the new structure
members (found in i2c 2.8.x and the 2.5/2.6 kernels) if I2C_PEC was
defined.

The problem now is that i2c 2.9.0, which was just released, has stepped
back on the changes that had made i2c 2.8.x uncompatible with the 2.4
kernels, to the great joy of i2c/lm_sensors distro packagers and i2c
patch maintainer (i.e. me). Because i2c 2.9.0 still defines I2C_PEC but
uses the old structure members, the trick doesn't work anymore. (No
surprise, that's what happens when you rely on something to take an
unrelated decision just because it seems to work at some point.) Since
the 2.8.x series of i2c is now considered deprecated and unsupported,
the easiest way to get things back in order is to get rid of the trick
altogether. This will make i2c 2.9.0 work while breaking i2c 2.8.x,
which is OK.

The affected drivers are bttv-if and tvmixer. I asked Gerd and he told
me he had no objection to the cleanups I propose.

Note that both the trick and its removal only have an effect when
patching the kernel tree with i2c 2.8.0 or later. This means that the
proposed change is necessarily safe for vanilla kernel users.

Patch follows, please apply. The patch is also available online at:
http://khali.linux-fr.org/devel/i2c/linux-2.4.28/linux-2.4.28-i2c-2.9.0-drivers-media-video.diff

Thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.4.29-pre3/drivers/media/video/bttv-if.c.orig	2003-11-28 19:26:20.000000000 +0100
+++ linux-2.4.29-pre3/drivers/media/video/bttv-if.c	2004-12-04 15:13:46.000000000 +0100
@@ -190,7 +190,6 @@
 	return state;
 }
 
-#ifndef I2C_PEC
 static void bttv_inc_use(struct i2c_adapter *adap)
 {
 	MOD_INC_USE_COUNT;
@@ -200,7 +199,6 @@
 {
 	MOD_DEC_USE_COUNT;
 }
-#endif
 
 static int attach_inform(struct i2c_client *client)
 {
@@ -243,12 +241,8 @@
 };
 
 static struct i2c_adapter bttv_i2c_adap_template = {
-#ifdef I2C_PEC
-	.owner             = THIS_MODULE,
-#else
 	.inc_use           = bttv_inc_use,
 	.dec_use           = bttv_dec_use,
-#endif
 #ifdef I2C_ADAP_CLASS_TV_ANALOG
 	.class             = I2C_ADAP_CLASS_TV_ANALOG,
 #endif
--- linux-2.4.29-pre3/drivers/media/video/tvmixer.c.orig	2004-12-04 15:20:20.000000000 +0100
+++ linux-2.4.29-pre3/drivers/media/video/tvmixer.c	2004-12-04 15:20:07.000000000 +0100
@@ -193,10 +193,8 @@
 
 	/* lock bttv in memory while the mixer is in use  */
 	file->private_data = mix;
-#ifndef I2C_PEC
 	if (client->adapter->inc_use)
 		client->adapter->inc_use(client->adapter);
-#endif
         return 0;
 }
 
@@ -210,17 +208,12 @@
 		return -ENODEV;
 	}
 
-#ifndef I2C_PEC
 	if (client->adapter->dec_use)
 		client->adapter->dec_use(client->adapter);
-#endif
 	return 0;
 }
 
 static struct i2c_driver driver = {
-#ifdef I2C_PEC
-	.owner           = THIS_MODULE,
-#endif
 	.name            = "tv card mixer driver",
         .id              = I2C_DRIVERID_TVMIXER,
 #ifdef I2C_DF_DUMMY


-- 
Jean Delvare
http://khali.linux-fr.org/
