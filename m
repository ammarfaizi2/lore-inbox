Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263846AbTCVUdd>; Sat, 22 Mar 2003 15:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263849AbTCVUdd>; Sat, 22 Mar 2003 15:33:33 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:47431
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S263846AbTCVUdb>; Sat, 22 Mar 2003 15:33:31 -0500
Date: Sat, 22 Mar 2003 15:41:05 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Manfred Spraul <manfred@colorfullife.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG: Use after free in detach_pid
In-Reply-To: <3E7CC4F2.8000500@colorfullife.com>
Message-ID: <Pine.LNX.4.50.0303221533340.18911-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303221152460.18911-100000@montezuma.mastecende.com>
 <3E7CC4F2.8000500@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Mar 2003, Manfred Spraul wrote:

> >Code: 89 01 89 48 04 f0 ff 4b 04 0f 94 c0 31 f6 84 c0 74 1f 8b 43 
> >
> >  
> >
>    0:   89 01                     mov    %eax,(%ecx)
>    2:   89 48 04                  mov    %ecx,0x4(%eax)
> 	list_del(&link->pid_chain):
> 		link->pid_chain->next, prev == 0x6b6b6b6b 
>    5:   f0 ff 4b 04               lock decl 0x4(%ebx)
> 		%ebx: link->pidptr == 0x6b6b6b6b

Yep, sorry i should have given this to you earlier.

0xc01232d0 <__unhash_process+240>:      push   $0xc0505400
0xc01232d5 <__unhash_process+245>:      call   0xc011ef20 <__preempt_spin_lock>
0xc01232da <__unhash_process+250>:      pop    %eax
0xc01232db <__unhash_process+251>:      jmp    0xc0123259 <__unhash_process+121>
0xc01232e0 <__unhash_process+256>:      mov    $0x2,%edx
0xc01232e5 <__unhash_process+261>:      mov    %ebx,%eax
0xc01232e7 <__unhash_process+263>:      call   0xc0134780 <detach_pid> <==
0xc01232ec <__unhash_process+268>:      mov    %ebx,%eax
0xc01232ee <__unhash_process+270>:      mov    $0x3,%edx
0xc01232f3 <__unhash_process+275>:      call   0xc0134780 <detach_pid>
0xc01232f8 <__unhash_process+280>:      mov    0x7c(%ebx),%edx
0xc01232fb <__unhash_process+283>:      test   %edx,%edx
0xc01232fd <__unhash_process+285>:      je     0xc012331f <__unhash_process+319>
0xc01232ff <__unhash_process+287>:      mov    $0xffffe000,%edx
0xc0123304 <__unhash_process+292>:      mov    $0xc057b434,%eax

0xc0134780 <detach_pid>:        lea    (%edx,%edx,4),%edx
0xc0134783 <detach_pid+3>:      push   %ebp
0xc0134784 <detach_pid+4>:      push   %edi
0xc0134785 <detach_pid+5>:      lea    (%eax,%edx,8),%edx
0xc0134788 <detach_pid+8>:      push   %esi
0xc0134789 <detach_pid+9>:      push   %ebx
0xc013478a <detach_pid+10>:     lea    0xb0(%edx),%eax
0xc0134790 <detach_pid+16>:     mov    0x4(%eax),%ecx
0xc0134793 <detach_pid+19>:     mov    0x8(%eax),%ebx
0xc0134796 <detach_pid+22>:     mov    0xb0(%edx),%eax
0xc013479c <detach_pid+28>:     mov    %eax,(%ecx) <===
0xc013479e <detach_pid+30>:     mov    %ecx,0x4(%eax)
0xc01347a1 <detach_pid+33>:     lock decl 0x4(%ebx)


> The whole link structure is filled with slab poison. The link structure is embedded in the task struct stucture.
> You mentioned that the last detach_pid() within __unhash_process oopsed.
> That means the reference count of the task structure was off by one, and the
> 	put_task_struct(pid->task)
> within 
> 	detach_pid(p,PIDTYPE_PGID);
> freed the task structure.

Yes that corresponds with where it oopsed.

0xc01232ec is in __unhash_process (kernel/exit.c:43).
38              nr_threads--;
39              detach_pid(p, PIDTYPE_PID);
40              detach_pid(p, PIDTYPE_TGID);
41              if (thread_group_leader(p)) {
42                      detach_pid(p, PIDTYPE_PGID); 
43                      detach_pid(p, PIDTYPE_SID);

> The process was bash - does your bash use anything fancy, or plain boring single threaded app?

No nothing special, it's a default RH install type thing.

Thanks,
	Zwane
-- 
function.linuxpower.ca
