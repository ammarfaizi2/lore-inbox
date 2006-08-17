Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWHQBGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWHQBGY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 21:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbWHQBGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 21:06:24 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:47609 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932159AbWHQBGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 21:06:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=m6VXuA/A7gzFpMeBKeaOgSiYJBx06WTpEtiaMopkEzoEV/sftNyQTAKU/gQQDA3jcT83N0QRwC35agYBLDTgZ3vZ6ZY5AA0/iSiXMDDIJLbBDn+yCoH/mUD+N9+Ph5MvkepCOnkOjUKRDBiaOS5clKRWAJ6JwO5Bic3dEMkVXKY=
Message-ID: <44E3C12B.5030905@gmail.com>
Date: Thu, 17 Aug 2006 03:06:28 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: workqueue lockdep bug.
References: <20060814183319.GJ15569@redhat.com>	 <20060814233626.1e3c41b2.akpm@osdl.org> <3888a5cd0608161631j629ae4a2l929d9b8fead6a2d8@mail.gmail.com>
In-Reply-To: <3888a5cd0608161631j629ae4a2l929d9b8fead6a2d8@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Mon, 14 Aug 2006 14:33:19 -0400
> Dave Jones <davej@redhat.com> wrote:
> 
>> Andrew,
>>  I merged the workqueue changes from -mm into the Fedora-devel kernel to
>> kill off those billion cpufreq lockdep warnings.  The bug has now mutated
>> into this:
>>
>> (Trimmed version of log from  
>> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=202223)
>>
> 
> I don't get it.

Let me extend the output a little bit:

clock = mutex_lock(cpu_add_remove_lock)
wqlock = mutex_lock(workqueue_mutex)
slock = mutex_lock(cpu_chain.rwsem)
similar for cunlock, wqunlock, sunlock.

The number after colon is linenumber, where the mutex_XXX lies.
Prints are _after_ mutex_lock and _before_ mutex_unlock calls.

So here it comes:

[   30.947289] clock: 268
[   30.947340] Disabling non-boot CPUs ...
[   30.947392] slock: 334
[   30.964622] wqlock: 689
[   30.964659] sunlock: 336

Isn't this strange for validator (lock1-lock2-unlock1 + 
(below)lock1-unlock2-unlock1)?

[   30.966762] Breaking affinity for irq 0
[   30.968116] CPU 1 is now offline
[   30.968155] lockdep: not fixing up alternatives.
[   30.968200]
[   30.968201] =======================================================
[   30.968269] [ INFO: possible circular locking dependency detected ]
[   30.968307] 2.6.18-rc4-mm1-bug #11
[   30.968342] -------------------------------------------------------


>>  > Breaking affinity for irq 185
>>  > Breaking affinity for irq 193
>>  > Breaking affinity for irq 209
>>  > CPU 1 is now offline
>>  > lockdep: not fixing up alternatives.
>>  >
>>  > =======================================================
>>  > [ INFO: possible circular locking dependency detected ]
>>  > 2.6.17-1.2548.fc6 #1
>>  > -------------------------------------------------------
>>  > pm-hibernate/4335 is trying to acquire lock:
>>  >  ((cpu_chain).rwsem){..--}, at: [<c0430fa4>] 
>> blocking_notifier_call_chain+0x11/0x2d
>>  >
>>  > but task is already holding lock:
>>  >  (workqueue_mutex){--..}, at: [<c0612820>] mutex_lock+0x21/0x24
>>  >
>>  > which lock already depends on the new lock.
>>  >
>>  >
>>  > the existing dependency chain (in reverse order) is:
>>  >
>>  > -> #1 (workqueue_mutex){--..}:
>>  >        [<c043c08e>] lock_acquire+0x4b/0x6d
>>  >        [<c06126b1>] __mutex_lock_slowpath+0xbc/0x20a
>>  >        [<c0612820>] mutex_lock+0x21/0x24
>>  >        [<c0433c25>] workqueue_cpu_callback+0xfd/0x1ee
>>  >        [<c0614ef5>] notifier_call_chain+0x20/0x31
>>  >        [<c0430fb0>] blocking_notifier_call_chain+0x1d/0x2d
>>  >        [<c043f4c5>] _cpu_down+0x47/0x1c4
>>  >        [<c043f805>] disable_nonboot_cpus+0x9b/0x11a
>>  >        [<c0445b32>] prepare_processes+0xe/0x41
>>  >        [<c0445d87>] pm_suspend_disk+0x9/0xf3
>>  >        [<c0444e12>] enter_state+0x54/0x1b7
>>  >        [<c0444ffb>] state_store+0x86/0x9c
>>  >        [<c04a9f88>] subsys_attr_store+0x20/0x25
>>  >        [<c04aa08c>] sysfs_write_file+0xab/0xd1
>>  >        [<c04732cb>] vfs_write+0xab/0x157
>>  >        [<c0473910>] sys_write+0x3b/0x60
>>  >        [<c0403faf>] syscall_call+0x7/0xb
> 
> cpu_add_remove_lock -> cpu_chain.rwsem -> workqueue_mutex
> 
>>  > -> #0 ((cpu_chain).rwsem){..--}:
>>  >        [<c043c08e>] lock_acquire+0x4b/0x6d
>>  >        [<c04390a0>] down_read+0x2d/0x40
>>  >        [<c0430fa4>] blocking_notifier_call_chain+0x11/0x2d
>>  >        [<c043f5aa>] _cpu_down+0x12c/0x1c4
>>  >        [<c043f805>] disable_nonboot_cpus+0x9b/0x11a
>>  >        [<c0445b32>] prepare_processes+0xe/0x41
>>  >        [<c0445d87>] pm_suspend_disk+0x9/0xf3
>>  >        [<c0444e12>] enter_state+0x54/0x1b7
>>  >        [<c0444ffb>] state_store+0x86/0x9c
>>  >        [<c04a9f88>] subsys_attr_store+0x20/0x25
>>  >        [<c04aa08c>] sysfs_write_file+0xab/0xd1
>>  >        [<c04732cb>] vfs_write+0xab/0x157
>>  >        [<c0473910>] sys_write+0x3b/0x60
>>  >        [<c0403faf>] syscall_call+0x7/0xb
> 
> cpu_add_remove_lock -> cpu_chain.rwsem
> 
>>  > other info that might help us debug this:
>>  >
>>  > 2 locks held by pm-hibernate/4335:
>>  >  #0:  (cpu_add_remove_lock){--..}, at: [<c0612820>] 
>> mutex_lock+0x21/0x24
>>  >  #1:  (workqueue_mutex){--..}, at: [<c0612820>] mutex_lock+0x21/0x24
>>  >
>>  > stack backtrace:
>>  >  [<c04051ee>] show_trace_log_lvl+0x58/0x159
>>  >  [<c04057ea>] show_trace+0xd/0x10
>>  >  [<c0405903>] dump_stack+0x19/0x1b
>>  >  [<c043b176>] print_circular_bug_tail+0x59/0x64
>>  >  [<c043b98e>] __lock_acquire+0x80d/0x99c
>>  >  [<c043c08e>] lock_acquire+0x4b/0x6d
>>  >  [<c04390a0>] down_read+0x2d/0x40
>>  >  [<c0430fa4>] blocking_notifier_call_chain+0x11/0x2d
>>  >  [<c043f5aa>] _cpu_down+0x12c/0x1c4
>>  >  [<c043f805>] disable_nonboot_cpus+0x9b/0x11a
>>  >  [<c0445b32>] prepare_processes+0xe/0x41
>>  >  [<c0445d87>] pm_suspend_disk+0x9/0xf3
>>  >  [<c0444e12>] enter_state+0x54/0x1b7
>>  >  [<c0444ffb>] state_store+0x86/0x9c
>>  >  [<c04a9f88>] subsys_attr_store+0x20/0x25
>>  >  [<c04aa08c>] sysfs_write_file+0xab/0xd1
>>  >  [<c04732cb>] vfs_write+0xab/0x157
>>  >  [<c0473910>] sys_write+0x3b/0x60
>>  >  [<c0403faf>] syscall_call+0x7/0xb

[   30.981176]  [<c0170514>] sys_write+0x47/0x6e
[   30.981249]  [<c01031fb>] syscall_call+0x7/0xb
[   30.981322]  =======================
[   30.981378] slock: 334

The one, that failed.

[   30.981882] wqunlock: 702
[   30.981939] sunlock: 336
[   30.981996] CPU1 is down
[   30.982036] cunlock: 309
[   30.982075] Stopping tasks: ============
[   31.149008] ==================|

> cpu_add_remove_lock -> cpu_chain.rwsem
> 
> I don't see anywhere where this process took workqueue_mutex.

Hope this helps?

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E


