Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965006AbVKAD7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbVKAD7d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 22:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbVKAD7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 22:59:33 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:16366 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S965006AbVKAD7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 22:59:32 -0500
From: Ian Wienand <ianw@gelato.unsw.edu.au>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Date: Tue, 1 Nov 2005 14:59:27 +1100
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Convert dmasound_awacs to dynamic input_dev allocation
Message-ID: <20051101035926.GE11202@cse.unsw.EDU.AU>
References: <20051101020329.GA7773@cse.unsw.EDU.AU> <200510312217.08935.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510312217.08935.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 10:17:08PM -0500, Dmitry Torokhov wrote:
> > +	awacs_beep_dev = input_allocate_device();
> 
> We really need to check whether device was allocated here...

AFAICS there is no easy way to bail without leaking from that point
(the comment already there suggests as much).  Would it be appropriate
to just BUG() out in that case and save somebody auditing and
re-architecturing for an unlikely error in a deprecated interface?

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
@@ -3136,18 +3127,32 @@ printk("dmasound_pmac: Awacs/Screamer Co
 			break ;
 	}
 
+	awacs_beep_dev = input_allocate_device();
 	/*
 	 * XXX: we should handle errors here, but that would mean
 	 * rewriting the whole init code.  later..
 	 */
-	input_register_device(&awacs_beep_dev);
+	if (awacs_beep_dev == NULL)
+	{
+		printk(KERN_ERR "%s() input_allocate_device failed\n", __FUNCTION__);
+		BUG();
+	}
+
+	awacs_beep_dev->name = "dmasound beeper";
+	awacs_beep_dev->phys = "macio/input0";
+	awacs_beep_dev->id.bustype = BUS_HOST;
+	awacs_beep_dev->event = awacs_beep_event;
+	awacs_beep_dev->sndbit[0] = BIT(SND_BELL) | BIT(SND_TONE);
+	awacs_beep_dev->evbit[0] = BIT(EV_SND);
+
+	input_register_device(awacs_beep_dev);
 
 	return dmasound_init();
 }
 
 static void __exit dmasound_awacs_cleanup(void)
 {
-	input_unregister_device(&awacs_beep_dev);
+	input_unregister_device(awacs_beep_dev);
 
 	switch (awacs_revision) {
 		case AWACS_TUMBLER:
