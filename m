Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbUCDMh2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 07:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbUCDMh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 07:37:27 -0500
Received: from gprs40-143.eurotel.cz ([160.218.40.143]:35512 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261870AbUCDMhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 07:37:13 -0500
Date: Thu, 4 Mar 2004 13:35:23 +0100
From: Pavel Machek <pavel@ucw.cz>
To: paul.devriendt@amd.com
Cc: davej@redhat.com, cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org,
       davej@codemonkey.ork.uk
Subject: Re: powernow-k8-acpi driver
Message-ID: <20040304123523.GD308@elf.ucw.cz>
References: <99F2150714F93F448942F9A9F112634C109A392F@txexmtae.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99F2150714F93F448942F9A9F112634C109A392F@txexmtae.amd.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> you're aware of Dominik/Bruno's work on the 'acpilib'[1] stuff in this 
> >> area right ? We'll need that anyway for Powernow-k7 and maybe longhaul 
> >> too and its senseless duplicating this code.
> > 
> > That [1] looks like promise of url, but I don't see that url.
> 
> No, I am not aware of this, and I think Dominik is out for a few days.
> If there is some sort of library functionality I can use and eliminate
> code in the powernow-k8 driver, I will glad make the change to use
> >> it.

This fixes typo, makes pollflg normal (no need for volatile, it is
protected by poll_sem) and fixes assignment. Please apply,

								Pavel

--- tmp/linux/arch/i386/kernel/cpu/cpufreq/powernow-k8-acpi.c	2004-03-04 13:26:34.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k8-acpi.c	2004-03-04 13:24:12.000000000 +0100
@@ -36,14 +36,14 @@
 #include <asm/io.h>
 #include <asm/delay.h>
 
-#define DEBUG
-#define VERSION "Version 1.20.02, Mar 1, 2004"
+#undef DEBUG
+#define VERSION "Version 1.20.02a"
 #include "powernow-k8-acpi.h"
 
 static u8 **procs;                  /* per processor data structure     */
 static u32 rstps;                   /* pstates allowed restrictions     */
 static u32 seenrst;                 /* remember old bat restrictions    */
-static volatile int pollflg;        /* remember the state of the poller */
+static int pollflg;	            /* remember the state of the poller, protected by poll_sem */
 static int acpierr;                 /* retain acpi error across walker  */
 static acpi_handle ppch;	    /* handle of the ppc object         */
 static acpi_handle psrh;            /* handle of the acpi power object  */
@@ -857,7 +857,7 @@
 	return 0;
 }
 
-/* transiion if needed, restart if needed */
+/* transition if needed, restart if needed */
 static void ac_poller(unsigned long x)  
 {
 	int pow;
@@ -870,7 +870,7 @@
 
 	down(&poll_sem);
 	if (pollflg == POLLER_UNLOAD) {
-		pollflg == POLLER_DEAD;
+		pollflg = POLLER_DEAD;
 		up(&poll_sem);
 		return;
 	}


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
