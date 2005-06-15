Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVFOQss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVFOQss (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 12:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVFOQss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 12:48:48 -0400
Received: from mail.aknet.ru ([82.179.72.26]:8467 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261214AbVFOQpt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 12:45:49 -0400
Message-ID: <42B05B3F.7000405@aknet.ru>
Date: Wed, 15 Jun 2005 20:45:51 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/2] pcspeaker driver update
References: <42AF25C7.90109@aknet.ru> <20050614185535.GA4041@ucw.cz> <42AF2FFC.8010601@aknet.ru> <20050614200043.GA4171@ucw.cz>
In-Reply-To: <20050614200043.GA4171@ucw.cz>
Content-Type: multipart/mixed;
 boundary="------------010903040607020009080409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010903040607020009080409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

Vojtech Pavlik wrote:
> It might be desirable to separate the in/out paths in the input layer in
> the future.
If it will allow to grab the events to
the device, then I think it would be the
best solution for my problem indeed.

> for enabling/disabling the driver. If anything, it would fall into the
> EV_SYN class, but still that doesn't seem like a clean solution.
> I don't want to pollute the input API with ad hoc stuff like that.
> I think that it'd be best, if you need to share the PC-speaker hardware
> with a different driver, to just provide an interface between the two
> drivers that doesn't go through the input subsystem.
I definitely agree with you that it is
not the clean solution, but the "interface"
approach has the disadvantages too. Besides
the fact that the hooks for the out-of-tree
modules are not accepted to the kernel, there
is also a technical one: if I add that interface,
then loading my module will load the pcspkr
module as a dependancy, enabling those
annoying beeps. Right now I am working
around that by adding an extra parameter
to my module, which, if enabled, will keep
the pcspkr shut up forever, but I'd like to
avoid that. So the only way looks like via
the use of the input API.
And this might be the temporary thing anyway.
As soon as the way to grab an events is
there, the problem is solved in a clean way.
So unless you feel really bad about that, I'd
like something like the attached patch to be
applied. It now uses EV_SYN.

Signed-off-by: stsp@aknet.ru


--------------010903040607020009080409
Content-Type: text/x-patch;
 name="pcspkr-2.6.12-rc6-02.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcspkr-2.6.12-rc6-02.diff"

diff -urN linux-2.6.12-rc6/drivers/input/misc/pcspkr.c linux-2.6.12-rc6-spinlk/drivers/input/misc/pcspkr.c
--- linux-2.6.12-rc6/drivers/input/misc/pcspkr.c	2005-06-07 11:11:49.000000000 +0400
+++ linux-2.6.12-rc6-spinlk/drivers/input/misc/pcspkr.c	2005-06-14 12:57:59.000000000 +0400
@@ -26,27 +26,13 @@
 static char pcspkr_name[] = "PC Speaker";
 static char pcspkr_phys[] = "isa0061/input0";
 static struct input_dev pcspkr_dev;
+enum { PCSPKR_NORMAL, PCSPKR_SUSPENDED };
 
-static DEFINE_SPINLOCK(i8253_beep_lock);
-
-static int pcspkr_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
+static void pcspkr_do_sound(unsigned int count)
 {
-	unsigned int count = 0;
 	unsigned long flags;
 
-	if (type != EV_SND)
-		return -1;
-
-	switch (code) {
-		case SND_BELL: if (value) value = 1000;
-		case SND_TONE: break;
-		default: return -1;
-	}
-
-	if (value > 20 && value < 32767)
-		count = PIT_TICK_RATE / value;
-
-	spin_lock_irqsave(&i8253_beep_lock, flags);
+	spin_lock_irqsave(&i8253_lock, flags);
 
 	if (count) {
 		/* enable counter 2 */
@@ -61,14 +47,48 @@
 		outb(inb_p(0x61) & 0xFC, 0x61);
 	}
 
-	spin_unlock_irqrestore(&i8253_beep_lock, flags);
+	spin_unlock_irqrestore(&i8253_lock, flags);
+}
+
+static int pcspkr_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
+{
+	unsigned int count = 0;
+
+	switch (type) {
+		case EV_SND:
+			switch (code) {
+				case SND_BELL: if (value) value = 1000;
+				case SND_TONE: break;
+				default: return -1;
+			}
+			break;
+
+		case EV_SYN:
+			switch (code) {
+				case SYN_CONFIG:
+					dev->state = value ? PCSPKR_SUSPENDED : PCSPKR_NORMAL;
+					return 0;
+				default: return -1;
+			}
+			break;
+
+		default: return -1;
+	}
+
+	if (dev->state == PCSPKR_SUSPENDED)
+		return 0;
+
+	if (value > 20 && value < 32767)
+		count = PIT_TICK_RATE / value;
+
+	pcspkr_do_sound(count);
 
 	return 0;
 }
 
 static int __init pcspkr_init(void)
 {
-	pcspkr_dev.evbit[0] = BIT(EV_SND);
+	pcspkr_dev.evbit[0] = BIT(EV_SND) | BIT(EV_SYN);
 	pcspkr_dev.sndbit[0] = BIT(SND_BELL) | BIT(SND_TONE);
 	pcspkr_dev.event = pcspkr_event;
 
@@ -78,6 +98,7 @@
 	pcspkr_dev.id.vendor = 0x001f;
 	pcspkr_dev.id.product = 0x0001;
 	pcspkr_dev.id.version = 0x0100;
+	pcspkr_dev.state = PCSPKR_NORMAL;
 
 	input_register_device(&pcspkr_dev);
 
@@ -90,7 +111,7 @@
 {
         input_unregister_device(&pcspkr_dev);
 	/* turn off the speaker */
-	pcspkr_event(NULL, EV_SND, SND_BELL, 0);
+	pcspkr_do_sound(0);
 }
 
 module_init(pcspkr_init);



--------------010903040607020009080409--
