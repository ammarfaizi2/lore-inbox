Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbTHXVms (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 17:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbTHXVms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 17:42:48 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:7049
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261325AbTHXVmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 17:42:46 -0400
Date: Sun, 24 Aug 2003 23:43:16 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hannes Reinecke <Hannes.Reinecke@suse.de>
Cc: Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       uweigand@de.ibm.com
Subject: Re: Dumb question: BKL on reboot ?
Message-ID: <20030824214316.GA1460@dualathlon.random>
References: <3F434BD1.9050704@suse.de> <20030820112918.0f7ce4fe.akpm@osdl.org> <20030820113520.281fe8bb.davem@redhat.com> <1061411024.9371.33.camel@nighthawk> <3F447D40.5020000@suse.de> <20030821154113.GE29612@dualathlon.random> <3F44EB85.5000108@suse.de> <20030821163938.GG29612@dualathlon.random> <3F45BA87.1060902@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F45BA87.1060902@suse.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hannes,

On Fri, Aug 22, 2003 at 08:39:03AM +0200, Hannes Reinecke wrote:
> Agreed, this smp_processor_id() == 0 thing is interesting. I'll try you 
> suggestion and see how far I'll progress.

Ulrich pointed me out that only cpu0 can call into the VM (thanks!), and
in turn the s390 code I tocuehd was infact correct (despite it looked
suspect given the trace and the special ==0 case). After a closer
inspection my (last ;) conclusion is this (cut-and-past from bugzilla)

----------------------
[..]
But the data.started counter is already enforcing a good enough
guarantee, that the CPU1 will execute
"signal_processor(smp_processor_id(), sigp_stop);" only when the CPU0 is
already executing inside the IPI handler. So I can't imagine the IPI on
CPU0 getting lost. 
 
the last explanation I can think, is that the CPU0 executes the IPI,
waits for cpu_restart_map to become 0 (i.e. CPU1 offline), and
eventually executes this code correctly: 
 
                do_store_status(); 
                /* 
                 * Finally call reipl. Because we waited for all other 
                 * cpus to enter this function we know that they do 
                 * not hold any s390irq-locks (the cpus have been 
                 * interrupted by an external interrupt and s390irq 
                 * locks are always held disabled). 
                 */ 
                reipl(S390_lowcore.ipl_device); 
        } 
        signal_processor(smp_processor_id(), sigp_stop); 
 
but the box doesn't reboot and the CPU0 returns from the IPI and goes
idle until kupdate kicks in (finds the first idle cpu and tries to take
the big kernel lock that is correctly held by CPU1 in sys_reboot). 
 
This seems a bug in the s390 lowlevel code above, it just doesn't reboot
the machine. 
----------------------

Maybe it's related to signal_processor(smp_processor_id(), sigp_stop)
failing inside IPI handlers or whatever similar arch specific, dunno.

The patch removing the BKL from sys_reboot shouldn't help either if my
above theory is correct: when the IPI runs in cpu0, it's not even
running on top of the BKL. It's just that the machine not rebooting,
eventually will have the first idle cpu (cpu0) execute kupdate in mean
in 2.5 sec, and it will eventually go in the state you found in lkcd
since the BKL is held by cpu1 in sys_reboot that is already offline (no
valid EIP in lkcd).

So if you want to test, probably one interesting info you could generate
to confirm my above theory, is to reproduce the very same deadlock even
with the BKL removal patch applied to sys_reboot. Not sure how easy it
is to reproduce it. If you can hang it again, it would not deadlock in
kupdate anymore: you should find cpu0 stuck in the idle loop instead of
sync_old_buffers.

It maybe something slightly different going wrong too, but still I'm
convinced the lock_kernel in sys_reboot is absoltely innocent and needed
(at least in 2.4).

Andrea
