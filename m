Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267878AbTBRPqR>; Tue, 18 Feb 2003 10:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267879AbTBRPqR>; Tue, 18 Feb 2003 10:46:17 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:24236 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S267878AbTBRPqO>;
	Tue, 18 Feb 2003 10:46:14 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15954.22427.557293.353363@gargle.gargle.HOWL>
Date: Tue, 18 Feb 2003 16:56:11 +0100
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: module changes 
In-Reply-To: <20030218072006.4C6502C054@lists.samba.org>
References: <20030217213221.3103.qmail@eklektix.com>
	<20030218072006.4C6502C054@lists.samba.org>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell writes:
 > In message <20030217213221.3103.qmail@eklektix.com> you write:
 > > I had a quick question: is the inability to declare per-CPU variables in
 > > modules going to be permanent?
 > 
 > <sigh>
 > 
 > I'd really like to fix it, but that's *hard*.
 > 
 > <think think think, ask Paulus>
 > 
 > There might be a neater way, and there's definitely a more
 > space-efficient way, but this is a start (the wastage is small as long
 > as there are only a few per-cpu vars, as there are at the moment).
 > 
 > Rusty.
 > --
 >   Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
 > 
 > Name: per-cpu support inside modules
 > Author: Rusty Russell
 > Status: Tested on 2.5.62
 > 
 > D: This adds percpu support for modules.  A module cannot have more
 > D: percpu data than the base kernel does (on my kernel 5636 bytes).

This limitation is quite horrible.

Does the implementation have to be perfect? The per_cpu API can easily
be simulated using good old NR_CPUS arrays:

#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,8) && !defined(MODULE)
#include <linux/percpu.h>	/* why doesn't this work for modules? */
#else
/* Simulate per_cpu() for older kernels or modular builds. */
#define DEFINE_PER_CPU(type, name) \
	__typeof__(type) name[NR_CPUS] __cacheline_aligned
#define per_cpu(var, cpu)	((var)[(cpu)])
#endif

Yes it wastes space. Big deal. Rather that than arbitrary limitations.

/Mikael
