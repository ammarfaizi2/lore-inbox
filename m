Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314154AbSDVNPM>; Mon, 22 Apr 2002 09:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314187AbSDVNPL>; Mon, 22 Apr 2002 09:15:11 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:8 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S314154AbSDVNPK>; Mon, 22 Apr 2002 09:15:10 -0400
Message-Id: <200204221312.g3MDCCX11604@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: user/system/nice accounting (SMP): need help understanding the code
Date: Mon, 22 Apr 2002 16:15:23 -0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As you see below, in SMP case update_one_process() is not called
in do_timer().
OTOH, global grep over entire tree (*.[chsS]) for 'per_cpu_utime'
and 'per_cpu_user' did not turn out SMP accounting code.
Or maybe I am stupid.

Anybody with cluebat?

kernel/timer.c:
===============
void update_one_process(struct task_struct *p, unsigned long user,
                        unsigned long system, int cpu)
{
        p->per_cpu_utime[cpu] += user;
        p->per_cpu_stime[cpu] += system;
        do_process_times(p, user, system);
        do_it_virt(p, user);
        do_it_prof(p);
}
...
void update_process_times(int user_tick)
{
        struct task_struct *p = current;
        int cpu = smp_processor_id(), system = user_tick ^ 1;

        update_one_process(p, user_tick, system, cpu);
        if (p->pid) {
                if (--p->counter <= 0) {
                        p->counter = 0;
                        p->need_resched = 1;
                }
                if (p->nice > 0)
                        kstat.per_cpu_nice[cpu] += user_tick;
                else
                        kstat.per_cpu_user[cpu] += user_tick;
                kstat.per_cpu_system[cpu] += system;
        } else if (local_bh_count(cpu) || local_irq_count(cpu) > 1)
                kstat.per_cpu_system[cpu] += system;
}
...
void do_timer(struct pt_regs *regs)
{
        (*(unsigned long *)&jiffies)++;
#ifndef CONFIG_SMP
        /* SMP process accounting uses the local APIC timer */

        update_process_times(user_mode(regs));
#endif
        mark_bh(TIMER_BH);
        if (TQ_ACTIVE(tq_timer))
                mark_bh(TQUEUE_BH);
}
--
vda
