Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbWBOXrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWBOXrv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 18:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWBOXrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 18:47:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52425 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751300AbWBOXru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 18:47:50 -0500
Date: Wed, 15 Feb 2006 15:46:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: torvalds@osdl.org, frankeh@watson.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: SMP BUG
Message-Id: <20060215154634.7677edda.akpm@osdl.org>
In-Reply-To: <20060215233700.GF1508@flint.arm.linux.org.uk>
References: <43F12207.9010507@watson.ibm.com>
	<20060215230701.GD1508@flint.arm.linux.org.uk>
	<Pine.LNX.4.64.0602151521320.22082@g5.osdl.org>
	<20060215153013.474ff5e0.akpm@osdl.org>
	<20060215233700.GF1508@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> On Wed, Feb 15, 2006 at 03:30:13PM -0800, Andrew Morton wrote:
> > Linus Torvalds <torvalds@osdl.org> wrote:
> > > That said, nobody seemed to comment on this patch by Rik, which seemed to 
> > >  be a nice cleanup regardless of any other issues.
> > 
> > I thought that patch wasn't a good one.  The runqueues should be
> > initialised in sched_init().  init_idle() is called from fork_idle() which
> > is called from the bowels of arch code.  I'm not sure that it gets called
> > at all if !SMP (which seems strange).
> 
> Wouldn't it make sense to do this initialisation in a CPU_UP_PREPARE
> notifier, if not already done?
> 

Could be - we have a couple of notifier handlers in sched.c already,
although they're inside awkward CONFIG_* wrappers.

But architectures need to initialise cpu_possible_map in setup_arch()
anyway, because we immediately call setup_per_cpu_areas(), which needs to
know which CPUs are possible so it will only allocate memory for them.

Yes, architectures can override the generic setup_per_cpu_areas(), but the
same argument applies: they don't want to be allocating memory for
!possible CPUs.

So I think it's sanest to say that the arch shalt initialise cpu_possible_map
in setup_arch().
