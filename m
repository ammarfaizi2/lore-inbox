Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbVK2QFD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbVK2QFD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 11:05:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbVK2QFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 11:05:01 -0500
Received: from aun.it.uu.se ([130.238.12.36]:55538 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1751387AbVK2QFA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 11:05:00 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17292.31749.278879.822369@alkaid.it.uu.se>
Date: Tue, 29 Nov 2005 17:04:21 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: Enabling RDPMC in user space by default
In-Reply-To: <20051129151515.GG19515@wotan.suse.de>
References: <20051129151515.GG19515@wotan.suse.de>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
 > Hallo,
 > 
 > I'm considering to enable CR4.PCE by default on x86-64/i386. Currently it's 0
 > which means RDPMC doesn't work. On x86-64 PMC 0 is always programmed
 > to be a cycle counter, so it would be useful to be able to access
 > this for measuring instructions. That's especially useful because RDTSC 
 > does not necessarily count cycles in the current P state (already
 > the case on Intel CPUs and AMD's future direction seems to also
 > to decouple it from cycles) Drawback is that it stops during idle, but 
 > that shouldn't be a big issue for normal measuring. It's not useful
 > as a real timer anyways.
 > 
 > On Pentium 4 it also has the advantage that unlike RDTSC it's not
 > serializing so should be much faster.
 > 
 > The kernel change would be to always set CR4.PCE to allow RDPMC
 > in ring 3. 
 > 
 > It would be actually a good idea to disable RDTSC in ring 3 too
 > (because user space usually doesn't have enough information to make
 > good use of it and gets it wrong), but I fear that will break 
 > too many applications right now.

PMC0 stops being a cycle counter as soon as any real driver
(not the NMI watchdog) takes over the hardware, such as oprofile,
perfmon2, or perfctr. So user-space cannot rely on the semantics
of PMC0. I have no objection to globally enabling CR4.PCE.

Disabling user-space RDTSC (setting CR4.TSD) seems evil and pointless.
At least some users of it (the perfctr library and I hope eventually
also perfmon2) do use it in an SMP-safe manner (through special
user/kernel protocols).

/Mikael
