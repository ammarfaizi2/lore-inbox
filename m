Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317697AbSFLNK6>; Wed, 12 Jun 2002 09:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317698AbSFLNK5>; Wed, 12 Jun 2002 09:10:57 -0400
Received: from kim.it.uu.se ([130.238.12.178]:13454 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S317697AbSFLNK4>;
	Wed, 12 Jun 2002 09:10:56 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15623.18520.760673.208158@kim.it.uu.se>
Date: Wed, 12 Jun 2002 15:10:48 +0200
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support 
In-Reply-To: <E17I39U-00054u-00@wagner.rustcorp.com.au>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty,

You've stated that you don't care about micro-optimisations,
but please consider providing an iteration construct with
O(nr_online_cpus) rather than O(NR_CPUS) (*) complexity. One
suitable data structure for this was described by this paper
<http://softlib.rice.edu/MSCP/papers/loplas.sets.ps.gz>
by Preston Briggs and Linda Torzcon.

This means keeping a logical->physical map and iterating like this:

     for(i = 0; i < nr_online_cpus; ++i)
	   do_something_with(cpu_logical_map(i));

but since cpu add/remove events are quite rare, the overhead for
maintaining that map is negligible. Note: a cpu would be identified
by its physical number only; the logical numbers are just for
enumeration and don't need to stay the same over add/remove events.

With this and a callback that informs me of add/remove events,
I would have no problems with the nonlinear CPU patch.

(I care because my performance-monitoring counters driver by necessity
is closely tied to CPU identities and the set of online CPUs.)

/Mikael

(*) At least as long as NR_CPUS defaults to 32 on x86.
