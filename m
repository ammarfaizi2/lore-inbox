Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbVHQOFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbVHQOFV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 10:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbVHQOFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 10:05:21 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:17104 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751135AbVHQOFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 10:05:20 -0400
Subject: Re: 2.6.13-rc6-rt6
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20050817064750.GA8395@elte.hu>
References: <1124208507.5764.20.camel@localhost.localdomain>
	 <20050816163202.GA5288@elte.hu> <20050816163730.GA7879@elte.hu>
	 <20050816165247.GA10386@elte.hu> <20050816170805.GA12959@elte.hu>
	 <1124214647.5764.40.camel@localhost.localdomain>
	 <1124215631.5764.43.camel@localhost.localdomain>
	 <1124218245.5764.52.camel@localhost.localdomain>
	 <1124252419.5764.83.camel@localhost.localdomain>
	 <1124257580.5764.105.camel@localhost.localdomain>
	 <20050817064750.GA8395@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 17 Aug 2005 10:05:05 -0400
Message-Id: <1124287505.5764.141.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-17 at 08:47 +0200, Ingo Molnar wrote:

> 
> unfortunately the space of "patches that break the kernel" is infinitely 
> larger (and infinitely easier to generate) than the space of "patches 
> that improve the kernel" - so i'll skip your patch for now ;-)

Yeah, I took out my "bad" fix and it still locks up. Since I got the NMI
working I was able to get output. Unfortunately, the laptop doesn't have
a serial (damn vendors getting rid of the very useful _for us_ uart).
And so far the netconsole doesn't seem to be working yet. 

Here's the output (typed from screen).

Freeing unused kernel memory: 296k freed
NMI watchdog detected lockup on CPU#1 (50000/50000)

Pid: 796, comm:  hotplug
EIP: 0060:[<c0331662>] CPU: 1
EIP is at _raw_spin_lock+0x72/0xa0
EFLAGS: 00000002 Not tainted (2.6.13-rc6-rt6)
EXI: 00000001 EBX: .... (I'm not about to type all the registers out).
[...]
try_to_wake_up+0x4e
__reacquire_kernel_lock+0x2d
pick_new_owner+0x6b
wake_up_process+0x30
rt_up+0x290
chrdev_open+0xfd
lock_kernel+0x28
chrdev_open+0xfd
tty_open+0x0
chrdev_open+0xfd
file_move+0x20
dentry_open+0x17a
filp_open+0x68
_spin_lock+0x23
get_unused_fd+0xa2
sys_open+0x4f
syscall_call+0x7
----
preempt count: 3
3-level deep critical section nesting:
----
rt_up+0x2c
add_preempt_count+0x1a
add_preempt_count+0x1a
----
showing all locks held by: (hotplug/796 [...]) 

- No locks where shown.


> 
> how come it is stopping the machine during bootup? Or does the lockup 
> occur during shutdown? changing the local_irq_disable() to 
> raw_local_irq_disable() looks wrong because sooner or later we hit 
> complete(). You are probably locking up earlier than that though, 
> perhaps in stopmachine_set_state()?

This is on bootup.  The stopmachine is used in sys_init_module. 

> 
> but stop_machine() looks quite preempt-unsafe to begin with. The 
> local_irq_disable() would not be needed at all if prior the 
> for_each_online_cpu() loop we'd use set_cpus_allowed. The current method 
> of achieving 'no preemption' is simply racy even during normal 
> CONFIG_PREEMPT.

I guess I'll need to look into this further.

-- Steve


