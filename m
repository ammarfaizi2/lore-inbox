Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbTCYFKb>; Tue, 25 Mar 2003 00:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261442AbTCYFKb>; Tue, 25 Mar 2003 00:10:31 -0500
Received: from [131.215.233.56] ([131.215.233.56]:7432 "EHLO haxor-lan")
	by vger.kernel.org with ESMTP id <S261427AbTCYFKa>;
	Tue, 25 Mar 2003 00:10:30 -0500
Date: Mon, 24 Mar 2003 21:09:00 -0800
From: Bryan Rittmeyer <bryanr@bryanr.org>
To: oprofile-list@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Segher Boessenkool <segher@koffie.nl>,
       Andrew Fleming <afleming@motorola.com>, mikpe@csd.uu.se,
       o.oppitz@web.de
Subject: [patch] oprofile + ppc750cx perfmon
Message-ID: <20030325050900.GA30294@bryanr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've created very preliminary patches to add PPC Performance Monitor
support to oprofile cvs and linux 2.4.20-ben8:

http://bryanr.org/linux/oprofile/

Sadly, this approach seems very unstable on a 750CX imac (PVR 0008 2214).
The box freezes hard and requires a cold reboot after just a few minutes of
profiling. As benh hinted in a previous thread, I suspect there's an
undocumented erratum for this CPU related to decrementer + pm use.
If anyone has contacts in IBM, further info would be helpful to rule out
software error and possibly to obtain a workaround...

Assuming lots of PPC perfmon hardware is effectively useless with the
decrementer, some solutions are:

1. use the pm irq for all timer-related stuff in Linux, and turn off the
decrementer completely. May mean we need to disable idle loop HLTs, hurting
thermal dissipation / power consumption--I believe the PMC cycle counters
stop incrementing inside power_save_6xx().

2. use the decrementer for profiling. we'd forfeits the perfmon's ability to
sample when MSR[EE]=0 (irqs disabled), taking a big chunk out of
oprofile's appeal imo.

3. hybrid approach. when not using oprofile, the kernel runs as it does
now via the decrementer. when profiling, we switch everything over to the
pm system, disabling the power_save stuff. I suspect this is the best
approach on broken silicon, though there may be some minor nastiness with
swapping between different exception mechanisms for timer_interrupt()

I'm going to try the hybrid approach and will post new patches soon.

My work is commercially sponsored by Ixia and therefore focuses on 2.4
and the IBM PPC750FX/CXe. However, I'm happy to discuss a 2.5 port,
support for other chips, an eventual upstream merge, and any other issues
related to bringing up oprofile on the PPC.

-Bryan
