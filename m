Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbWARGlB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWARGlB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 01:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWARGlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 01:41:01 -0500
Received: from thorn.pobox.com ([208.210.124.75]:4811 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S1751358AbWARGlA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 01:41:00 -0500
Date: Wed, 18 Jan 2006 00:40:50 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       anton@au1.ibm.com, linux-kernel@vger.kernel.org, michael@ellerman.id.au,
       linuxppc64-dev@ozlabs.org, serue@us.ibm.com, paulus@au1.ibm.com
Subject: Re: 2.6.15-mm4 failure on power5
Message-ID: <20060118064050.GQ2846@localhost.localdomain>
References: <20060116063530.GB23399@sergelap.austin.ibm.com> <20060115230557.0f07a55c.akpm@osdl.org> <200601170000.58134.michael@ellerman.id.au> <20060116153748.GA25866@sergelap.austin.ibm.com> <20060116215252.GA10538@cs.umn.edu> <20060116170907.60149236.akpm@osdl.org> <20060117081749.GA10135@elte.hu> <20060117165244.GA23254@cs.umn.edu> <20060117165555.GA24562@cs.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060117165555.GA24562@cs.umn.edu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave C Boutcher wrote:
> On Tue, Jan 17, 2006 at 10:52:44AM -0600, Dave C Boutcher wrote:
> > Well, it turns out that I've been running with CONFIG_DEBUG_MUTEXES all
> > along...so no noise.  My console output is a little different that
> > Serge's, so I think this is timing related.  Also note that I'm dying in
> > the timer interrupt...
> 
> duh... here's the backtrace
> 0:mon> t
> [c000000000577890] c0000000000034b4 decrementer_common+0xb4/0x100
> --- Exception: 901 (Decrementer) at c0000000004627ec
> .__mutex_lock_interruptible_slowpath+0x3bc/0x4c4
> [c000000000577c60] c000000000075064 .__lock_cpu_hotplug+0x44/0xa8
> [c000000000577ce0] c000000000075600 .register_cpu_notifier+0x24/0x68
> [c000000000577d70] c00000000052cd7c .do_init_bootmem+0x68c/0xab0
> [c000000000577e50] c000000000522c84 .setup_arch+0x21c/0x2c0
> [c000000000577ef0] c00000000051a538 .start_kernel+0x40/0x280
> [c000000000577f90] c000000000008574 .hmt_init+0x0/0x8c

The mutex debug code (debug_spin_unlock in kernel/mutex-debug.h) is
doing a local_irq_enable way before we're ready.

BTW: I couldn't build powerpc without mutex debugging until I changed
the SYNC_ON_SMP in include/asm-powerpc/mutex.h:__mutex_fastpath_unlock
to ISYNC_ON_SMP.

With that change, I was able to boot semi-successfully with mutex
debugging off -- the system got hung up when udev started, apparently
(or maybe I was too impatient).

