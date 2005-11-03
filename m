Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030314AbVKCEad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030314AbVKCEad (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 23:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030320AbVKCEad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 23:30:33 -0500
Received: from smtp110.sbc.mail.re2.yahoo.com ([68.142.229.95]:64667 "HELO
	smtp110.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030314AbVKCEac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 23:30:32 -0500
Message-Id: <20051103042818.129317000.dtor_core@ameritech.net>
References: <20051103042121.394220000.dtor_core@ameritech.net>
Date: Wed, 02 Nov 2005 23:21:22 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Vojtech Pavlik <vojtech@ucw.cz>
Subject: [patch 1/7] dmasound_awacs: convert to dynamic input allocation
Content-Disposition: inline; filename=input-dynalloc-dmasound.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Wienand <ianw@gelato.unsw.edu.au>

Input: convert dmasound_awacs (OSS) to dynamic input allocation

Signed-off-by: Ian Wienand <ianw@gelato.unsw.edu.au>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 sound/oss/dmasound/dmasound_awacs.c |   31 +++++++++++++++++++------------
 1 files changed, 19 insertions(+), 12 deletions(-)

Index: work/sound/oss/dmasound/dmasound_awacs.c
===================================================================
--- work.orig/sound/oss/dmasound/dmasound_awacs.c
+++ work/sound/oss/dmasound/dmasound_awacs.c
@@ -2805,16 +2805,7 @@ __init setup_beep(void)
 	return 0 ;
 }
 
-static struct input_dev awacs_beep_dev = {
-	.evbit		= { BIT(EV_SND) },
-	.sndbit		= { BIT(SND_BELL) | BIT(SND_TONE) },
-	.event		= awacs_beep_event,
-	.name		= "dmasound beeper",
-	.phys		= "macio/input0", /* what the heck is this?? */
-	.id		= {
-		.bustype	= BUS_HOST,
-	},
-};
+static struct input_dev *awacs_beep_dev;
 
 int __init dmasound_awacs_init(void)
 {
@@ -2907,6 +2898,22 @@ printk("dmasound_pmac: couldn't find a C
 		return -ENODEV;
 	}
 
+	awacs_beep_dev = input_allocate_device();
+	if (!awacs_beep_dev) {
+		release_OF_resource(io, 0);
+		release_OF_resource(io, 1);
+		release_OF_resource(io, 2);
+		printk(KERN_ERR "dmasound: can't allocate input device !\n");
+		return -ENOMEM;
+	}
+
+	awacs_beep_dev->name = "dmasound beeper";
+	awacs_beep_dev->phys = "macio/input0";
+	awacs_beep_dev->id.bustype = BUS_HOST;
+	awacs_beep_dev->event = awacs_beep_event;
+	awacs_beep_dev->sndbit[0] = BIT(SND_BELL) | BIT(SND_TONE);
+	awacs_beep_dev->evbit[0] = BIT(EV_SND);
+
 	/* all OF versions I've seen use this value */
 	if (i2s_node)
 		i2s = ioremap(io->addrs[0].address, 0x1000);
@@ -3140,14 +3147,14 @@ printk("dmasound_pmac: Awacs/Screamer Co
 	 * XXX: we should handle errors here, but that would mean
 	 * rewriting the whole init code.  later..
 	 */
-	input_register_device(&awacs_beep_dev);
+	input_register_device(awacs_beep_dev);
 
 	return dmasound_init();
 }
 
 static void __exit dmasound_awacs_cleanup(void)
 {
-	input_unregister_device(&awacs_beep_dev);
+	input_unregister_device(awacs_beep_dev);
 
 	switch (awacs_revision) {
 		case AWACS_TUMBLER:

