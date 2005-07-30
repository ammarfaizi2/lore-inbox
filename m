Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVG3NHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVG3NHK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 09:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbVG3NHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 09:07:09 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44702 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261156AbVG3NHH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 09:07:07 -0400
Date: Sat, 30 Jul 2005 15:07:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: lenz@cs.wisc.edu, linux-kernel@vger.kernel.org
Subject: Re: [patch] Support powering sharp zaurus sl-5500 LCD up and down
Message-ID: <20050730130701.GD1830@elf.ucw.cz>
References: <20050727092613.GA4713@elf.ucw.cz> <20050727023754.6846f3a2.akpm@osdl.org> <20050727095324.GE4270@elf.ucw.cz> <1122458769.7773.39.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122458769.7773.39.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +	/* read comadj */
> > +#ifdef CONFIG_MACH_POODLE
> > +	comadj = 118;
> > +#else
> > +	comadj = 128;
> > +#endif
> 
> Can you go back to the Sharp source and confirm that these values should
> be hardcoded in both the poodle and collie cases please? I know the
> sharpsl_param code can provide them but I can't remember exactly which
> models use which fields. I want to make sure this isn't a quick hack
> John made before sharpsl_param was written :).

Sharp sources are a big mess (as usual), but reading it from
sharpsl_param seems to be okay for at least poodle. I'll read it for
collie, too, and see what happens... seems to work.

[Not for andrew, yet.]
								Pavel


diff --git a/drivers/video/backlight/locomolcd.c b/drivers/video/backlight/locomolcd.c
--- a/drivers/video/backlight/locomolcd.c
+++ b/drivers/video/backlight/locomolcd.c
@@ -20,6 +20,7 @@
 
 #include <asm/hardware/locomo.h>
 #include <asm/irq.h>
+#include <asm/mach/sharpsl_param.h>
 
 #ifdef CONFIG_SA1100_COLLIE
 #include <asm/arch/collie.h>
@@ -29,7 +30,7 @@
 
 extern void (*sa1100fb_lcd_power)(int on);
 
-static struct locomo_dev *locomolcd_dev = NULL;
+static struct locomo_dev *locomolcd_dev;
 
 static void locomolcd_on(int comadj)
 {
@@ -82,7 +83,7 @@ static void locomolcd_off(int comadj)
 
 void locomolcd_power(int on)
 {
-	int comadj = 118;
+	int comadj = sharpsl_param.comadj;
 	unsigned long flags;
 	
 	local_irq_save(flags);
@@ -93,11 +94,13 @@ void locomolcd_power(int on)
 	}
 
 	/* read comadj */
+	if (comadj == -1) {
 #ifdef CONFIG_MACH_POODLE
-	comadj = 118;
+		comadj = 118;
 #else
-	comadj = 128;
+		comadj = 128;
 #endif
+	}
 
 	if (on)
 		locomolcd_on(comadj);

-- 
teflon -- maybe it is a trademark, but it should not be.
