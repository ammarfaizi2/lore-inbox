Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267374AbUG1Xqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267374AbUG1Xqk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 19:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266531AbUG1Xps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 19:45:48 -0400
Received: from gprs214-195.eurotel.cz ([160.218.214.195]:40320 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S267327AbUG1XoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 19:44:15 -0400
Date: Thu, 29 Jul 2004 01:43:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: mochel@digitalimplant.org, akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: -mm swsusp: do not default to platform/firmware
Message-ID: <20040728234352.GA14319@elf.ucw.cz>
References: <20040728222445.GA18210@elf.ucw.cz> <20040728161448.336183e2.akpm@osdl.org> <20040728233929.GD16494@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728233929.GD16494@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > -mm swsusp now defaults to platform/firmware suspend... That's
> > > certainly unexpected, changes behaviour from previous version, and
> > > only works on one of three machines I have here. I'd like the default
> > > to be changed back.
> > 
> > You overestimate my knowledge of suspend stuff.  AFAICT the current -mm
> > default is to enter ACPI sleep state via the BIOS rather than via Linux's
> > ACPI driver.  Correct?
> 
> Its actually bit more complex. There are 3 methods:
> 
> shutdown: save state in linux, then tell bios to powerdown
> 
> platform: save state in linux, then tell bios to powerdown and blink
> 	  "suspended led"
> 
> firmware: tell bios to save state itself
> 
> "platform" is actually right thing to do, but "shutdown" is most
> reliable.

...could you apply this? I hope it is accurate.
								Pavel

--- clean/Documentation/power/swsusp.txt	2004-06-22 12:35:44.000000000 +0200
+++ linux/Documentation/power/swsusp.txt	2004-07-29 01:42:29.000000000 +0200
@@ -199,3 +202,30 @@
 should be sent to the mailing list available through the suspend2
 website, and not to the Linux Kernel Mailing List. We are working
 toward merging suspend2 into the mainline kernel.
+
+Q: Kernel thread must voluntarily freeze itself (call 'refrigerator'). But
+I did found some kernel threads don't do it, and they don't freeze, and
+so the system can't sleep. Is this a known behavior?
+
+A: All such kernel threads need to be fixed, one by one. Select place
+where it is safe to be frozen (no kernel semaphores should be held at
+that point and it must be safe to sleep there), and add:
+
+            if (current->flags & PF_FREEZE)
+                    refrigerator(PF_FREEZE);
+
+Q: What is the difference between between "platform", "shutdown" and
+"firmware" in /sys/power/disk?
+
+A:
+
+shutdown: save state in linux, then tell bios to powerdown
+
+platform: save state in linux, then tell bios to powerdown and blink
+          "suspended led"
+
+firmware: tell bios to save state itself [needs BIOS-specific suspend
+	  partition, and has very little to do with swsusp]
+
+"platform" is actually right thing to do, but "shutdown" is most
+reliable.



-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
