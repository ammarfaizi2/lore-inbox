Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751874AbWJMUNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbWJMUNq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 16:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbWJMUNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 16:13:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:16355 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751874AbWJMUNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 16:13:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tJs+lFpb2XKH/XVrcAUU8vVHd/v4hltKtjvnI/tZJubGk3MKoMp+RtQBMXv6ewCoTWJTCoFfz1H9ZkUQ2JHrelLPX+j6q/3RigJzvPEVfrlD6JNDqC+tkFBj3OVUC81Lgy2HKbtTT98KOcWnnlnGqZtRH2d/TSIkgXz9qmoRNF8=
Message-ID: <6bffcb0e0610131313h2f872cc9uf4dbc3f2b41de3f6@mail.gmail.com>
Date: Fri, 13 Oct 2006 22:13:43 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: + convert-cpu-hotplug-notifiers-to-use-raw_notifier-instead-of-blocking_notifier.patch added to -mm tree
Cc: neilb@suse.de, rusty@rustcorp.com.au, LKML <linux-kernel@vger.kernel.org>,
       "Thomas Gleixner" <tglx@linutronix.de>
In-Reply-To: <20061013114132.9e5afab9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200610130506.k9D56YJY031111@shell0.pdx.osdl.net>
	 <452FAE74.1020500@googlemail.com>
	 <20061013114132.9e5afab9.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/06, Andrew Morton <akpm@osdl.org> wrote:
> On Fri, 13 Oct 2006 17:19:16 +0200
> Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
>
> > There is something really wrong with this patch (or my hardware).
> >
> > echo shutdown > /sys/power/disk; echo disk > /sys/power/state
> > works fine for me on 2.6.19-rc1-g8770c018.
> >
> > On 2.6.19-rc1-mm1 +
> > convert-cpu-hotplug-notifiers-to-use-raw_notifier-instead-of-blocking_notifier.patch
> > + Neil's avoid_lockdep_warning_in_md.patch
> > (http://www.ussg.iu.edu/hypermail/linux/kernel/0610.1/0642.html)
> > I get a lot of "end_request: I/O error, dev sda, sector 31834343" messages.
>
> That's not exactly an expected result.  What makes you think it's due to
> this patch?  Does 2.6.19-rc1-mm1 run OK?

Yes. (the only one issue is
http://www.stardust.webpages.pl/files/tbf/euridica/2.6.19-rc1-mm1/mm-dmesg)

I get many "random" bugs that avoid hibernation with this patch.
Unfortunately I can't catch backtraces (broken sysklogd, lack of
serial console).

Here is the only one bug that I can reproduce and copy (by hand)

---
BUG: bad unlock balance detected!
---
klogd/1751 is trying release lock (&cpu_base->lock_key) at:
[<c0137a3d>] hrtimer_sched_tick
but there are no more locks to release!
other info that might help us debug this:
1 lock held by klogd/1751
#0 (&cpu_base->lock_key#2){++..}, at [<c0137f2f>] hrtimer_interupt
Stack backtrace:
c01042eb dump_stack_trace
c0104461 show_trace_log
c0104a08 show_trace
c0104a4f dump_stack
c013abdb print_unlock_irqbalance_bug
c013c781 lock_release_non_nested
c013cc08 lock_release
c013575f _spin_unlock
c0137a3d hrtimer_sched_tick
c0137fc5 hrtimer_interupt
c0113d00 smp_apic_timer_interupt
c0103d56 apic_timer_interupt

DWARF2 unwinder stuck at apic_timer_interupt

Stopping tasks: ========
BUG spinlock lockup on CPU#0, aio/1/179/c742a940
c01042e6 dump_trace
c0104461 show_trace_log_lvl
c0104a08 show_trace
c0104a4f dump_stack
c0201c91 _raw__spin_lock
c03155ab _spin_lock_irqsave
c013708f lock_hrtimer_base
c013711b hrtimer_try_to_cancel
c0137182 hrtimer_cancel
c01246e2 do_exit
c0103f39 kernel_thread_helper


l *0xc0137a3d
0xc0137a3d is in hrtimer_sched_tick
(/mnt/md0/devel/linux-mm/kernel/hrtimer.c:780).
775                      * update_process_times() might take
tasklist_lock, hence
776                      * drop the base lock. sched-tick hrtimers are
per-CPU and
777                      * never accessible by userspace APIs, so this
is safe to do.
778                      */
779                     spin_unlock(&cpu_base->lock);
780                     update_process_times(user_mode(regs));
781                     profile_tick(CPU_PROFILING);
782                     spin_lock(&cpu_base->lock);
783             }
784

l *0xc0137f2f
0xc0137f2f is in hrtimer_interrupt
(/mnt/md0/devel/linux-mm/kernel/hrtimer.c:1389).
1384                    ktime_t basenow;
1385                    struct rb_node *node;
1386
1387                    spin_lock(&cpu_base->lock);
1388
1389                    basenow = ktime_add(now, base->offset);
1390
1391                    while ((node = base->first)) {
1392                            struct hrtimer *timer;
1393

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
