Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271270AbTG2GKd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 02:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271278AbTG2GKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 02:10:33 -0400
Received: from main.gmane.org ([80.91.224.249]:26084 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S271270AbTG2GKa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 02:10:30 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Warren Turkal <wturkal@cbu.edu>
Subject: RE: PROBLEM: ACPI hangs when invoked from keyboard
Date: Tue, 29 Jul 2003 01:06:08 -0500
Message-ID: <bg52sa$8o9$1@main.gmane.org>
References: <F760B14C9561B941B89469F59BA3A847E97095@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grover, Andrew wrote:
> This isn't ACPI, it's because 2.5.74+ force the APIC enabled.

You are correct, and here is my addition to this bug report.

Some acpi events appear to lock the system.

svn revisions for pre-bug and post-bug
2.5.73 -> 11245
2.5.74 -> 11487

I will try to compile kernel revisions
(highest_good+(lowest_bad-highest_good)/2) until I
enocunter the bug.

divide and conquer it
11245 good <- 2.5.73
11366 good
11426 good
11457 good
11472 good
11479 good
11483 good
11487 good <- 2.5.74 should have been bad; reason below

After further investigation, the remaining revisions
from 11483 to 11487 (2.5.74) did not look relavant to
my situation. There was mainly an SH arch merge and
two very minimal updates to md and the bumping of the
version in the top Makefile.

At this point, I relized that I had been compiling these
kerenels without SMP, which is not what I did when I
noticed the bug. Therefor, it is an SMP-kernel-only bug.
I have a 1.9GHz Pentium 4M. My understanding is that it
does not support hyperthreading. Why would I see an SMP
bug at this point?

divide and conquer with SMP kernel on
11245 good <- 2.5.73
11306 good
11313 good
11314 good
11315 bad
11317 bad
11321 bad
11336 bad
11366 bad
11487 bad <-- 2.5.74

Therefore, the breaking patch is the changeset from svn
revion 11314 to 11315, which is reproduced below,
including the patch comment.

patch comment:
wt@braindead:/usr/src/linux-trunk$ svn log -r 11315
------------------------------------------------------------------------
rev 11315:  mikpe | 2003-06-24 14:50:23 -0500 (Tue, 24 Jun 2003) | 17 lines

[PATCH] enable local APIC on P4

The current local APIC code refuses to enable the local APIC
on a P4 if the BIOS booted us with the local APIC disabled.
This patch removes this unnecessary restriction. Please apply.

Most P4 machines do boot with the local APIC enabled, but
Keith Owens reported that the P4 based Compaq Evo N800v
disables the local APIC, even though the machine actually
works if Linux enables it.

It is possible that some P4 machines with broken BIOSen
were saved by our refusal to enable the local APIC. We
can handle them via the DMI blacklist rules instead.

BKrev: 3ef8ab7fg7Brw4y1sF1EaSr5fMHG7g

------------------------------------------------------------------------
wt@braindead:/usr/src/linux-trunk$

patch itself:
wt@braindead:/usr/src/linux-trunk$ svn diff -r 11314:11315
Index: arch/i386/kernel/apic.c
===================================================================
--- arch/i386/kernel/apic.c     (revision 11314)
+++ arch/i386/kernel/apic.c     (revision 11315)
@@ -616,7 +616,7 @@
                goto no_apic;
        case X86_VENDOR_INTEL:
                if (boot_cpu_data.x86 == 6 ||
-                   (boot_cpu_data.x86 == 15 && cpu_has_apic) ||
+                   boot_cpu_data.x86 == 15 ||
                    (boot_cpu_data.x86 == 5 && cpu_has_apic))
                        break;
                goto no_apic;
wt@braindead:/usr/src/linux-trunk$ 


Conclusion:
Either there is a bug with supporting my type of APIC or my APIC
must have a bug and is disabled by the BIOS for a reason. Either
my hardware should be blacklisted or the old behavior should be
restored.

AFAIK, I have an Intel 845 chipset. I don't know what other info
is needed for blacklisting.

Thanks, Warren Turkal

