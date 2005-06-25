Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVFYVBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVFYVBn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 17:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVFYVBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 17:01:43 -0400
Received: from smtpauth07.mail.atl.earthlink.net ([209.86.89.67]:20679 "EHLO
	smtpauth07.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S261337AbVFYVBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 17:01:12 -0400
Date: Sat, 25 Jun 2005 14:01:10 -0700
From: Stefan Baums <baums@u.washington.edu>
To: linux-kernel@vger.kernel.org
Subject: ACPI and the idle loop - possible bug
Message-ID: <20050625210110.GA7738@localhost.localdomain>
Mail-Followup-To: Stefan Baums <baums@u.washington.edu>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
X-ELNK-Trace: e038963e4549bfac9083c4ad5838e4354d2b10475b571120f96fe132b06acb9c8befb9d65759e416c6b317bf5bc479bb350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 67.101.5.154
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some Lenove (IBM) ThinkPad models (in my case the ThinkPad X41
2528-6NU) produce irritating high-pitch crackling noises under
Linux in certain conditions, see the discussion here:

   http://thinkwiki.org/wiki/Problem_with_high_pitch_noises

This noise only occurs when the processor is not busy (with, e.g.,
compiling or video playback), so it seems to be related to the
idle loop (see also below about 'idle=halt').  Furthermore, it
seems to be caused by something that ACPI is doing to the
processor: if the 'processor' module (and its dependants:
'speedstep_centrino'/'acpi_cpufreq' and 'thermal') are not loaded,
the high-pitch noise does not occur.

If the 'processor' module (and its dependants) _are_ loaded, then
the noise can be initially avoided by passing the boot parameter

   idle=halt

to the kernel (causing it to halt, not poll, the processor during
idle loops), but this workaround _only_ works until either

   1) the system resumes from either suspend or hibernation, or

   2) the power state changes from battery to plugged-in or vice
      versa.

whereupon the high-pitch noise makes a return.

Taken all together, it would appear that the ACPI system is doubly
at fault:

   - First, for causing the high-pitch noise to start with, though
     it could be argued that this is a hardware defect that is
     just triggered by ACPI.  (However not by Windows XP, on the
     same computer, so it is definitely avoidable.)

   - Second, for apparently not respecting the kernel boot
     parameter "idle=halt" when it resumes or changes power state:
     it seems like ACPI is reverting to idle polling on those
     occasions.

Do you agree with this analysis?  Is it clear what ACPI's root
problem ('first' above) is, and will it be solved?  (Not loading
the 'processor', 'speedstep_centrino'/'acpi_cpufreq' and 'thermal'
modules - and losing their features - is not an acceptable
solution.)

As for the 'idle=halt' workaround: Is there any way to test
whether a running kernel actually uses polling or halt for the
idle loop?  What can I do to force ACPI never to use idle polling,
but halt instead?

My kernel version is Linux 2.6.12, custom-compiled on Ubuntu 5.04.
I have enabled all the usual ACPI features as modules.  The noise
problem occurs both with the 'speedstep_centrino' and the
'acpi_cpufreq' modules.  If necessary for diagnosis, I can put up
my kernel .config file online somewhere.

Many thanks for your help,
Stefan

PS.  Setting the polling frequency to 100 Hz instead of 1000 Hz at
compile time, as recommended by some people on the ThinkWiki page,
did not have any effect on the noise problem on my computer.

-- 
Stefan Baums
Asian Languages and Literature
University of Washington
