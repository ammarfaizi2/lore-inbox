Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262739AbTHUPkH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 11:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262708AbTHUPkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 11:40:07 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:27539
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262771AbTHUPkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 11:40:00 -0400
Date: Thu, 21 Aug 2003 17:41:13 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hannes Reinecke <Hannes.Reinecke@suse.de>
Cc: Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Dumb question: BKL on reboot ?
Message-ID: <20030821154113.GE29612@dualathlon.random>
References: <3F434BD1.9050704@suse.de> <20030820112918.0f7ce4fe.akpm@osdl.org> <20030820113520.281fe8bb.davem@redhat.com> <1061411024.9371.33.camel@nighthawk> <3F447D40.5020000@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F447D40.5020000@suse.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 10:05:20AM +0200, Hannes Reinecke wrote:
> Dave Hansen wrote:
> [ .. ]
> >
> >Or, are you saying that a CPU could have the BKL, and have
> >stop_this_cpu() called on it?  I guess we could add
> >release_kernel_lock() to stop_this_cpu().
> Exactly what happened here. CPU#1 entered sys_reboot, got BKL and 
> prepared to stop. It will never release BKL, leaving a nice big window 
> for CPU#0 to deadlock.

if that was really the case it shouldn't deadlock, because CPU0
shouldn't depend on a big kernel lock to be able to re-enable the irqs,
and to receive the IPI. Nor any IPI handler could ever be allowed to
take the big kernel lock.

Unless you can demonstrate a dependency on the big kernel lock for CPU0
to re-enable the irqs eventually, I can't see how the above could
deadlock.

The only clear deadlock prone thing I can see from the code is the IPI
handler looping forever w/o allowing the stopped cpu to release all its
underlying spinlocks. Not sure exactly how this generates the deadlock
in practice, but you only need to hit one of the held spinlocks
(including possibly the BKL) in the context of the reboot "cpu" to hang
forever during reboot. Looping forever and giving the OK to reboot the
machine from the context of a kernel thread instead of an IPI will fix
it as far as I can tell.

Andrea
