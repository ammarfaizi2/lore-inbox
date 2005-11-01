Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964965AbVKAFPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbVKAFPA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 00:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbVKAFPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 00:15:00 -0500
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:49032 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964965AbVKAFO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 00:14:59 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Ian Wienand <ianw@gelato.unsw.edu.au>
Subject: Re: [PATCH] Convert dmasound_awacs to dynamic input_dev allocation
Date: Tue, 1 Nov 2005 00:14:56 -0500
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <20051101020329.GA7773@cse.unsw.EDU.AU> <200510312217.08935.dtor_core@ameritech.net> <20051101035926.GE11202@cse.unsw.EDU.AU>
In-Reply-To: <20051101035926.GE11202@cse.unsw.EDU.AU>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511010014.57026.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 October 2005 22:59, Ian Wienand wrote:
> On Mon, Oct 31, 2005 at 10:17:08PM -0500, Dmitry Torokhov wrote:
> > > +	awacs_beep_dev = input_allocate_device();
> > 
> > We really need to check whether device was allocated here...
> 
> AFAICS there is no easy way to bail without leaking from that point
> (the comment already there suggests as much).  Would it be appropriate
> to just BUG() out in that case and save somebody auditing and
> re-architecturing for an unlikely error in a deprecated interface?

It seems that the change is pretty straightforward... Could you please try
this one?
 
-- 
Dmitry

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
