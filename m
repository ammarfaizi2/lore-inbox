Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315525AbSFCUuf>; Mon, 3 Jun 2002 16:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315528AbSFCUue>; Mon, 3 Jun 2002 16:50:34 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:54284 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S315525AbSFCUue>; Mon, 3 Jun 2002 16:50:34 -0400
Date: Mon, 3 Jun 2002 22:50:37 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix suspend-to-RAM in 2.5.20
Message-ID: <20020603205036.GD28911@atrey.karlin.mff.cuni.cz>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7ECB@orsmsx111.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Please keep the ifdefs in place in acpi/system.c. It's marked broken for a
> reason until I have a chance to look at it.

I tried to fix it. I believe I'll have it working within 30 minutes
with followup patch. Well, so it was less than 30 ;-).

> Also -- what's the point of moving obviously ACPI-specific code into
> suspend.c, instead of leaving it in acpi.c?

The code is also suspend-specific, and suspend-to-disk will have very
similar function in very near future.

Here's followup patch that makes it work. Notice freeze_processes() --
if you don't do that you risk data corruption. Please apply,
								Pavel

--- linux-swsusp.linus/arch/i386/kernel/suspend.c	Mon Jun  3 19:01:07 2002
+++ linux-swsusp/arch/i386/kernel/suspend.c	Mon Jun  3 22:35:15 2002
@@ -41,5 +41,6 @@
 		return;
 	}
 acpi_sleep_done:
+	acpi_restore_register_state();
 	restore_processor_context();
 }
--- linux-swsusp.linus/drivers/acpi/system.c	Mon Jun  3 18:57:34 2002
+++ linux-swsusp/drivers/acpi/system.c	Mon Jun  3 22:42:25 2002
@@ -267,25 +267,15 @@
 	switch (state)
 	{
 	case ACPI_STATE_S1:
-		/* do nothing */
+		barrier();
+		status = acpi_enter_sleep_state(state);
 		break;
 
 	case ACPI_STATE_S2:
 	case ACPI_STATE_S3:
-		save_processor_context();
-		/* TODO: this is horribly broken, fix it */
-		/* TODO: inline this function in acpi_suspend,or something. */
+		do_suspend_lowlevel(0);
 		break;
 	}
-
-	barrier();
-	status = acpi_enter_sleep_state(state);
-
-acpi_sleep_done:
-
-	restore_processor_context();
-	fix_processor_context();
-
 	restore_flags(flags);
 
 	return status;
@@ -307,6 +297,8 @@
 	if (state < ACPI_STATE_S1 || state > ACPI_STATE_S5)
 		return AE_ERROR;
 
+	freeze_processes();		/* device_suspend needs processes to be stopped */
+
 	/* do we have a wakeup address for S2 and S3? */
 	if (state == ACPI_STATE_S2 || state == ACPI_STATE_S3) {
 		if (!acpi_wakeup_address)
@@ -339,6 +331,7 @@
 
 	/* reset firmware waking vector */
 	acpi_set_firmware_waking_vector((ACPI_PHYSICAL_ADDRESS) 0);
+	thaw_processes();
 
 	return status;
 }


-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.

