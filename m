Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbVKAFu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbVKAFu6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 00:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbVKAFu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 00:50:57 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:62870 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S1750976AbVKAFu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 00:50:57 -0500
From: Ian Wienand <ianw@gelato.unsw.edu.au>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Date: Tue, 1 Nov 2005 16:50:52 +1100
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Convert dmasound_awacs to dynamic input_dev allocation
Message-ID: <20051101055052.GA16672@cse.unsw.EDU.AU>
References: <20051101020329.GA7773@cse.unsw.EDU.AU> <200510312217.08935.dtor_core@ameritech.net> <20051101035926.GE11202@cse.unsw.EDU.AU> <200511010014.57026.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511010014.57026.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2005 at 12:14:56AM -0500, Dmitry Torokhov wrote:
> It seems that the change is pretty straightforward... Could you please try
> this one?

Ahh, ok!  I thought that that comment meant it was deliberately
ignoring the return of input_register_device (by which time it's got
memory, irq's, io, etc), but now I see it's void anyway.  So why not
just move the setup right to the top?

-i

Signed-off-by: Ian Wienand <ianw@gelato.unsw.edu.au>
---
diff --git a/sound/oss/dmasound/dmasound_awacs.c b/sound/oss/dmasound/dmasound_awacs.c
--- a/sound/oss/dmasound/dmasound_awacs.c
+++ b/sound/oss/dmasound/dmasound_awacs.c
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
@@ -2828,6 +2819,20 @@ int __init dmasound_awacs_init(void)
 	awacs_revision = 0;
 	hw_can_byteswap = 1 ; /* most can */
 
+	/* setup the beep input event */
+	awacs_beep_dev = input_allocate_device();
+	if (!awacs_beep_dev)
+	{
+		printk(KERN_ERR "dmasound: can't allocate input device!\n");
+		return -ENOMEM;
+	}
+	awacs_beep_dev->name = "dmasound beeper";
+	awacs_beep_dev->phys = "macio/input0";
+	awacs_beep_dev->id.bustype = BUS_HOST;
+	awacs_beep_dev->event = awacs_beep_event;
+	awacs_beep_dev->sndbit[0] = BIT(SND_BELL) | BIT(SND_TONE);
+	awacs_beep_dev->evbit[0] = BIT(EV_SND);
+
 	/* look for models we need to handle specially */
 	set_model() ;
 
@@ -3136,18 +3141,14 @@ printk("dmasound_pmac: Awacs/Screamer Co
 			break ;
 	}
 
-	/*
-	 * XXX: we should handle errors here, but that would mean
-	 * rewriting the whole init code.  later..
-	 */
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
