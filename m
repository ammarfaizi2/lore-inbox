Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbTLHWMG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 17:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbTLHWMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 17:12:06 -0500
Received: from uucp.cistron.nl ([62.216.30.38]:41659 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S261827AbTLHWMA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 17:12:00 -0500
From: age <ahuisman@cistron.nl>
Subject: Re: [patch] sched-HT-2.6.0-test11-A5
Date: Mon, 08 Dec 2003 23:20:24 +0100
Organization: Cistron
Message-ID: <br2svf$usb$1@news.cistron.nl>
References: <20031117021511.GA5682@averell> <Pine.LNX.4.56.0311231300290.16152@earth> <1027750000.1069604762@[10.10.2.4]> <Pine.LNX.4.58.0312011102540.3323@earth> <20031208175622.GY19856@holomorphy.com> <Pine.LNX.4.58.0312081859100.8707@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: ncc1701.cistron.net 1070921519 31627 62.216.17.166 (8 Dec 2003 22:11:59 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

> 
> On Mon, 8 Dec 2003, William Lee Irwin III wrote:
> 
>> This appears to either leak migration threads or not set
>> rq->cpu[x].migration_thread basically ever for x > 0. Or if they are
>> shut down, how? Also, what makes sure cpu_idx is initialized before they
>> wake? They'll all spin on cpu_rq(0)->lock, no?
> 
> yep, it just leaks migration threads. Not a big problem right now, but for
> hotplug CPU support this needs to be fixed.
> 
>> Furthermore, sched_map_runqueue() is performed after all the idle
>> threads are running and all the notifiers have kicked the migration
>> threads, but does no locking whatsoever.
> 
> yep - at this point nothing else is really supposed to run but you are
> right it must be locked properly.
> 
>> Also, does init_idle() need to move into rest_init()? It should be
>> equivalent to its current placement.
> 
> this is a leftover of a change that went into 2.6 already. I've removed
> this change.
> 
>> Why not per_cpu for __rq_idx[] and __cpu_idx[]? This would have the
>> advantage of residing on node-local memory for sane architectures (and
>> perhaps in the future, some insane ones).
> 
> agreed, i've changed them to be per-cpu.
> 
> new patch with all your suggestions included is at:
> 
>   redhat.com/~mingo/O(1)-scheduler/sched-SMT-2.6.0-test11-C1
> 
> it also includes the bounce-to-cpu1 fix from/for Anton.
> 
> Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Hi Mingo

The same trouble:

kernel/built-in.o(.text+0x34f): In function `try_to_wake_up':
: undefined reference to `wake_up_cpu'
kernel/built-in.o(.text+0x4ad): In function `wake_up_forked_process':
: undefined reference to `set_task_cpu'
kernel/built-in.o(.text+0xea1): In function `schedule':
: undefined reference to `set_task_cpu'
kernel/built-in.o(.text+0x1203): In function `schedule':
: undefined reference to `active_load_balance'
kernel/built-in.o(.init.text+0xaa): In function `init_idle':
: undefined reference to `set_task_cpu'
kernel/built-in.o(.init.text+0x1d6): In function `sched_init':
: undefined reference to `set_task_cpu'
make: *** [.tmp_vmlinux1] Error 1

groetjes,

Age Huisman

