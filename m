Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289167AbSAJFK0>; Thu, 10 Jan 2002 00:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289227AbSAJFKQ>; Thu, 10 Jan 2002 00:10:16 -0500
Received: from pool-141-157-232-117.ny325.east.verizon.net ([141.157.232.117]:10505
	"EHLO arizona.localdomain") by vger.kernel.org with ESMTP
	id <S289167AbSAJFKG>; Thu, 10 Jan 2002 00:10:06 -0500
Date: Thu, 10 Jan 2002 00:10:02 -0500
From: kevin@koconnor.net
To: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: lock order in O(1) scheduler
Message-ID: <20020110001002.A13456@arizona.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ingo,

I was looking through the new O(1) scheduler (found in linux-2.5.2-pre11),
when I came upon the following code in try_to_wake_up():

        lock_task_rq(rq, p, flags);
        p->state = TASK_RUNNING;
        if (!p->array) {
                if (!rt_task(p) && synchronous && (smp_processor_id() < p->cpu)) {
                        spin_lock(&this_rq()->lock);
                        p->cpu = smp_processor_id();
                        activate_task(p, this_rq());
                        spin_unlock(&this_rq()->lock);
                } else {

I was unable to figure out what the logic of the '(smp_processor_id() <
p->cpu)' test is..  (Why should the CPU number of the process being awoken
matter?)  My best guess is that this is to enforce a locking invariant -
but if so, isn't this test backwards?  If p->cpu > current->cpu then
p->cpu's runqueue is locked first followed by this_rq - locking greatest to
least, where the rest of the code does least to greatest..

Also, this code in set_cpus_allowed() looks bogus:

        if (target_cpu < smp_processor_id()) {
                spin_lock_irq(&target_rq->lock);
                spin_lock(&this_rq->lock);
        } else {
                spin_lock_irq(&target_rq->lock);
                spin_lock(&this_rq->lock);
        }

The lock order is the same regardless of the if statement..


-Kevin

-- 
 ------------------------------------------------------------------------
 | Kevin O'Connor                     "BTW, IMHO we need a FAQ for      |
 | kevin@koconnor.net                  'IMHO', 'FAQ', 'BTW', etc. !"    |
 ------------------------------------------------------------------------
