Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263480AbTHWJgA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 05:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264913AbTHWJgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 05:36:00 -0400
Received: from [203.145.184.221] ([203.145.184.221]:64777 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S263480AbTHWJfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 05:35:43 -0400
Subject: [PATCH 2.6.0-test4][RESEND] vx_entry.c: remove release timer
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 23 Aug 2003 15:27:56 +0530
Message-Id: <1061632676.1121.11.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sound/pcmcia/vx/vx_entry.c:
This patch removes the PCMCIA timer release functionality which is no
longer required. Without this the module can not be compiled and
generates the following compiler error:

sound/pcmcia/vx/vx_entry.c: In function `snd_vxpocket_attach':
sound/pcmcia/vx/vx_entry.c:151: structure has no member named `release'
sound/pcmcia/vx/vx_entry.c:152: structure has no member named `release'
sound/pcmcia/vx/vx_entry.c: In function `snd_vxpocket_detach':
sound/pcmcia/vx/vx_entry.c:232: structure has no member named `release'
sound/pcmcia/vx/vx_entry.c: In function `vxpocket_event':
sound/pcmcia/vx/vx_entry.c:329: structure has no member named `release'

vx_entry.c |   12 ++----------
1 files changed, 2 insertions(+), 10 deletions(-)

diff -urN linux-2.6.0-test3-bk9/sound/pcmcia/vx/vx_entry.c linux-2.6.0-test3-nvk/sound/pcmcia/vx/vx_entry.c
--- linux-2.6.0-test3-bk9/sound/pcmcia/vx/vx_entry.c	2003-08-21 20:09:28.000000000 +0530
+++ linux-2.6.0-test3-nvk/sound/pcmcia/vx/vx_entry.c	2003-08-22 17:32:18.000000000 +0530
@@ -34,10 +34,8 @@
 static int vxpocket_event(event_t event, int priority, event_callback_args_t *args);
 

-static void vxpocket_release(u_long arg)
+static void vxpocket_release(dev_link_t* link)
 {
-	dev_link_t *link = (dev_link_t *)arg;
-	
 	if (link->state & DEV_CONFIG) {
 		/* release cs resources */
 		CardServices(ReleaseConfiguration, link->handle);
@@ -56,7 +54,7 @@
 	struct snd_vxp_entry *hw;
 	dev_link_t *link = &vxp->link;
 
-	vxpocket_release((u_long)link);
+	vxpocket_release(link);
 
 	/* Break the link with Card Services */
 	if (link->handle)
@@ -148,9 +146,6 @@
 	link->irq.Handler = &snd_vx_irq_handler;
 	link->irq.Instance = chip;
 
-	link->release.function = &vxpocket_release;
-	link->release.data = (u_long)link;
-
 	link->conf.Attributes = CONF_ENABLE_IRQ;
 	link->conf.Vcc = 50;
 	link->conf.IntType = INT_MEMORY_AND_IO;
@@ -229,8 +224,6 @@
 {
 	vx_core_t *chip = snd_magic_cast(vx_core_t, link->priv, return);
 
-	del_timer(&link->release);
-
 	snd_printdd(KERN_DEBUG "vxpocket_detach called\n");
 	/* Remove the interface data from the linked list */
 	if (hw) {
@@ -326,7 +319,6 @@
 		snd_printdd(KERN_DEBUG "CARD_REMOVAL..\n");
 		link->state &= ~DEV_PRESENT;
 		if (link->state & DEV_CONFIG) {
-			mod_timer(&link->release, jiffies + HZ/20);
 			chip->chip_status |= VX_STAT_IS_STALE;
 		}
 		break;



