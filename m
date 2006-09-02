Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751739AbWIBXRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbWIBXRO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 19:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751738AbWIBXRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 19:17:14 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60106 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751736AbWIBXRN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 19:17:13 -0400
Date: Sun, 3 Sep 2006 01:16:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: prevent swsusp with PAE
Message-ID: <20060902231654.GD13031@elf.ucw.cz>
References: <20060831135336.GL3923@elf.ucw.cz> <20060831104304.e3514401.akpm@osdl.org> <20060831223521.GB31125@elf.ucw.cz> <20060831154828.4313327c.akpm@osdl.org> <20060831225232.GE31125@elf.ucw.cz> <20060831160546.3309d745.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060831160546.3309d745.rdunlap@xenotime.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Next version of prevent-swsusp-with-PAE, this time I disable it in
Kconfig.

PAE + swsusp results in hard-to-debug crash about 50% of time during
resume. Cause is known, fix needs to be ported from x86-64 (but we
can't make it to 2.6.18, and I'd like this to be worked around in
2.6.18).

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index ae44a70..619ecab 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -56,7 +56,7 @@ config PM_TRACE
 
 config SOFTWARE_SUSPEND
 	bool "Software Suspend"
-	depends on PM && SWAP && (X86 && (!SMP || SUSPEND_SMP)) || ((FRV || PPC32) && !SMP)
+	depends on PM && SWAP && ((X86 && (!SMP || SUSPEND_SMP) && !X86_PAE) || ((FRV || PPC32) && !SMP))
 	---help---
 	  Enable the possibility of suspending the machine.
 	  It doesn't need ACPI or APM.
@@ -78,6 +78,10 @@ config SOFTWARE_SUSPEND
 
 	  For more information take a look at <file:Documentation/power/swsusp.txt>.
 
+	  (For now, swsusp is incompatible with PAE aka HIGHMEM_64G on i386.
+	  we need identity mapping for resume to work, and that is trivial
+	  to get with 4MB pages, but less than trivial on PAE).
+
 config PM_STD_PARTITION
 	string "Default resume partition"
 	depends on SOFTWARE_SUSPEND

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-- 
VGER BF report: U 0.489608
