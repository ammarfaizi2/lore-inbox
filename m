Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264133AbTEGR0G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 13:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264134AbTEGR0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 13:26:06 -0400
Received: from holomorphy.com ([66.224.33.161]:1681 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264133AbTEGR0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 13:26:03 -0400
Date: Wed, 7 May 2003 10:38:25 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: Torsten Landschoff <torsten@debian.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
Message-ID: <20030507173825.GU8931@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	J?rn Engel <joern@wohnheim.fh-wedel.de>,
	Torsten Landschoff <torsten@debian.org>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de> <20030507143315.GA6879@stargate.galaxy> <20030507144736.GE8978@holomorphy.com> <20030507164901.GB19324@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030507164901.GB19324@wohnheim.fh-wedel.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 06:49:01PM +0200, J?rn Engel wrote:
> It also matters if people writing applications for embedded systems
> have a fetish for many threads. 1000 threads, each eating 8k memory
> for pure existance (no actual work done yet), do put some memory
> pressure on small machines. Yes, it would be possible to educate those
> people, but changing kernel code is more fun and less work.

If they're embedded and UP they can probably get by on a userspace
threading library that only creates one kernel thread.

It's highly unlikely anyone will get anywhere "fixing" this in the
kernel. The closest approximations to mitigating the pinned memory
overhead with UNIX-style kernel semantics are swappable stacks a la the
u area and M:N threading, neither of which are popular notions. If
you're trying the other approach I mentioned in this thread, good luck
ever getting it done and good luck ever surviving even a single merge.

$ grep -nr schedule . | wc -l
   3773

Basically monsterpatch Hell for a resource scalability problem no one's
taking very seriously at the moment. We're already into the territory of
trivially userspace-triggerable NMI oopsing on 32x with merely linear
algorithms on 10000 threads, so the VM side isn't even worth talking
about until answers for the issues triggerable with the thread counts
the VM can currently handle appear, and even then only if there is some
real demand from apps and/or systems for it.

Just consider forkbombing infeasible; most (if not all) forkbombing apps
do so out of stupidity or outright bugs. 32-bit machines have something
to do mostly because pagetables are enormous and many process address
spaces are needed to establish per-sub-pool mappings and are largely an
entirely separate issue from general thread scalability (it adds up to
a lot of processes but usually well under 50000 and mostly vastly less).


-- wli
