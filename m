Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265331AbUGaOAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265331AbUGaOAU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 10:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267951AbUGaOAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 10:00:20 -0400
Received: from li2-47.members.linode.com ([69.56.173.47]:26888 "EHLO
	li2-47.members.linode.com") by vger.kernel.org with ESMTP
	id S265331AbUGaOAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 10:00:10 -0400
Date: Sat, 31 Jul 2004 09:00:10 -0500
From: Randall Nortman <linuxkernellist@wonderclown.com>
To: linux-kernel@vger.kernel.org
Subject: MSI K8N Neo + powernow-k8: ACPI info is worse than BIOS PST
Message-ID: <20040731140008.GJ4108@li2-47.members.linode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running kernel 2.6.7 (as distributed by Gentoo in
gentoo-dev-sources) on an Athlon 3000+ with an MSI K8N Neo Platinum
motherboard, BIOS v1.1 (most recent available).  The stock powernow-k8
first queries ACPI for CPU frequency/voltage tables, and on this
system that information is hopeless:

-----
Jul 29 19:09:34 terry powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.00.09b)
Jul 29 19:09:34 terry powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x2 (1500 mV)
Jul 29 19:09:34 terry powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x6 (1400 mV)
Jul 29 19:09:34 terry powernow-k8:    2 : fid 0xa (1800 MHz), vid 0x6 (1400 mV)
Jul 29 19:09:34 terry powernow-k8: cpu_init done, current fid 0xc, vid 0x2
-----

I hacked arch/i386/kernel/cpu/cpufreq/powernow-k8.c a bit so that the
ACPI info is ingored in favor of the BIOS PST table, with this result:

-----
Jul 30 21:49:23 terry powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.00.09b)
Jul 30 21:49:23 terry powernow-k8: BIOS error: numpst must be 1
-----

So, I found a patch that Tony Lindgren posted back in May to work
around buggy BIOSes, which included a change to make it ignore the
numpst error, and then I got this:

-----
Jul 30 21:38:39 terry powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.00.09b)
Jul 30 21:38:39 terry powernow-k8: BIOS error: numpst listed as 2 should be 1. Ignoring it.
Jul 30 21:38:39 terry powernow-k8:    0 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
Jul 30 21:38:39 terry powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x6 (1400 mV)
Jul 30 21:38:39 terry powernow-k8:    2 : fid 0xc (2000 MHz), vid 0x2 (1500 mV)
Jul 30 21:38:39 terry powernow-k8: cpu_init done, current fid 0xc, vid 0x2
-----

That's much better, but this CPU really ought to be able to clock all
the way down to 800MHz, so then I did a little more hacking to ignore
both the BIOS and ACPI info, and just use the hardcoded tables
provided in Tony's patch, which gives me what I want:

-----
Jul 30 22:04:55 terry powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.00.09b)
Jul 30 22:04:55 terry powernow-k8: BIOS error: numpst listed as 2 should be 1. Ignoring it.
Jul 30 22:04:55 terry powernow-k8: BIOS error: overriding frequency table
Jul 30 22:04:55 terry powernow-k8:    0 : fid 0x0 (800 MHz), vid 0x12 (1100 mV)
Jul 30 22:04:55 terry powernow-k8:    1 : fid 0xc (2000 MHz), vid 0x2 (1500 mV)
Jul 30 22:04:55 terry powernow-k8: cpu_init done, current fid 0xc, vid 0x2
-----

My "patch" is brute-force and ugly, and I didn't bother understanding
the code fully before I hacked it to pieces, so I refuse to release it
into the wild.  However, if you have this mobo and want to live
dangerously, you may write to me directly to get my code.

If anybody qualified to hack this code is interested in creating a
real workaround for BIOSes like this, I offer my system (and my time,
as I cannot give remote access) for testing.  I would suggest adding a
compile-time or load-time option to prefer the BIOS over ACPI (as in
powernow-k7, I think), and maybe a compile-time option to use Tony's
hardcoded tables.

(I do not read this list regularly, but I'll try to follow this thread
for the next few weeks.  Past that time, I request that you CC me
directly on anything related to this issue.  Thanks!)
