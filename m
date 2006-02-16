Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWBPAOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWBPAOQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 19:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWBPAOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 19:14:16 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33033 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932191AbWBPAOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 19:14:15 -0500
Date: Thu, 16 Feb 2006 00:14:09 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, frankeh@watson.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: SMP BUG
Message-ID: <20060216001409.GG1508@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	frankeh@watson.ibm.com, linux-kernel@vger.kernel.org
References: <43F12207.9010507@watson.ibm.com> <20060215230701.GD1508@flint.arm.linux.org.uk> <Pine.LNX.4.64.0602151521320.22082@g5.osdl.org> <20060215153013.474ff5e0.akpm@osdl.org> <20060215233700.GF1508@flint.arm.linux.org.uk> <20060215154634.7677edda.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060215154634.7677edda.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 03:46:34PM -0800, Andrew Morton wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> >
> > On Wed, Feb 15, 2006 at 03:30:13PM -0800, Andrew Morton wrote:
> > > Linus Torvalds <torvalds@osdl.org> wrote:
> > > > That said, nobody seemed to comment on this patch by Rik, which seemed to 
> > > >  be a nice cleanup regardless of any other issues.
> > > 
> > > I thought that patch wasn't a good one.  The runqueues should be
> > > initialised in sched_init().  init_idle() is called from fork_idle() which
> > > is called from the bowels of arch code.  I'm not sure that it gets called
> > > at all if !SMP (which seems strange).
> > 
> > Wouldn't it make sense to do this initialisation in a CPU_UP_PREPARE
> > notifier, if not already done?
> > 
> 
> Could be - we have a couple of notifier handlers in sched.c already,
> although they're inside awkward CONFIG_* wrappers.
> 
> But architectures need to initialise cpu_possible_map in setup_arch()
> anyway, because we immediately call setup_per_cpu_areas(), which needs to
> know which CPUs are possible so it will only allocate memory for them.
> 
> Yes, architectures can override the generic setup_per_cpu_areas(), but the
> same argument applies: they don't want to be allocating memory for
> !possible CPUs.
> 
> So I think it's sanest to say that the arch shalt initialise cpu_possible_map
> in setup_arch().

Is that the only thing which needs to be initialised early for SMP, or
are there other changes with early SMP init looming?

The reason I ask is that the cleanest solution for ARM would be to
introduce yet another initialisation function for MP platforms to
implement, which setup_arch() will call after the initial page tables
have been setup.  Hence, I'm wondering if the platform specific parts
could be simplified by moving more stuff earlier.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
