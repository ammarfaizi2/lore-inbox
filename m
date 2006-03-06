Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751698AbWCFQfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbWCFQfU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 11:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751882AbWCFQfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 11:35:20 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12519 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751698AbWCFQfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 11:35:19 -0500
Date: Mon, 6 Mar 2006 12:57:28 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Andrew Morton <akpm@osdl.org>, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: [patch] fix hardcoded values in collie frontlight
Message-ID: <20060306115728.GB28908@elf.ucw.cz>
References: <20060305142859.GA21173@elf.ucw.cz> <1141587964.6521.55.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141587964.6521.55.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In frontlight support, we should really use values from flash-ROM
instead of hardcoding our own. Cleanup includes.

Signed-off-by: Pavel Machek <pavel@suse.cz>

--- a/drivers/video/backlight/locomolcd.c
+++ b/drivers/video/backlight/locomolcd.c
@@ -20,14 +20,10 @@
 
 #include <asm/hardware/locomo.h>
 #include <asm/irq.h>
+#include <asm/mach/sharpsl_param.h>
+#include <asm/mach-types.h>
 
-#ifdef CONFIG_SA1100_COLLIE
-#include <asm/arch/collie.h>
-#else
-#include <asm/arch/poodle.h>
-#endif
-
-extern void (*sa1100fb_lcd_power)(int on);
+#include "../../../arch/arm/mach-sa1100/generic.h"
 
 static struct locomo_dev *locomolcd_dev;
 
@@ -82,7 +78,7 @@ static void locomolcd_off(int comadj)
 
 void locomolcd_power(int on)
 {
-	int comadj = 118;
+	int comadj = sharpsl_param.comadj;
 	unsigned long flags;
 
 	local_irq_save(flags);
@@ -93,11 +89,12 @@ void locomolcd_power(int on)
 	}
 
 	/* read comadj */
-#ifdef CONFIG_MACH_POODLE
-	comadj = 118;
-#else
-	comadj = 128;
-#endif
+	if (comadj == -1) {
+		if (machine_is_poodle())
+			comadj = 118;
+		if (machine_is_collie())
+			comadj = 128;
+	}
 
 	if (on)
 		locomolcd_on(comadj);


-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
