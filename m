Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269690AbSIRXF7>; Wed, 18 Sep 2002 19:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269696AbSIRXF7>; Wed, 18 Sep 2002 19:05:59 -0400
Received: from ns2.nealtech.net ([64.29.20.117]:13264 "EHLO nealtech.net")
	by vger.kernel.org with ESMTP id <S269690AbSIRXFj>;
	Wed, 18 Sep 2002 19:05:39 -0400
Message-Id: <200209182310.TAA18081@nealtech.net>
Content-Type: text/plain; charset=US-ASCII
From: anton wilson <anton.wilson@camotion.com>
To: linux-kernel@vger.kernel.org
Subject: garbage returned from do_gettimeofday
Date: Wed, 18 Sep 2002 19:00:52 -0400
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm using do_gettimeofday in the scheduler, once per schedule.
Ocassioanlly, i'll get what seems to be a random garbage number.
For example:

tv_sec     tv_usec 
1032378775 627501
1032378775 627521
3433001412 1
1032378775 627573
1032378775 627617
1032378775 627638

or

1032379233 253008
1032379233 253028
3387638236 1
1032379233 253068
1032379233 253125


The garbage number tv_sec always seems to begin with a 3 and is followed by 9 
digits. The tv_usec garbage number is always 1.


Most of the code I changed in sched.c follows. It attempts to allow a normal
process to run in place of a SCHED_RR process with a certain limited 
frequency and within a certain window of time. A starvation threshold is 
added which allows a normal process to run disregarding the requested window. 
The patch is very constrained in it's application. It's for a program in 
which a fifo thread runs once every millisecond, and round robin threads take 
up the remainder of the time.

=====================================================

#define NORM_THRESH             1000             
#define NORM_STARVE             20000
#define NORM_WINDOW             800   

#ifdef CONFIG_SCHED_RR_NONSTARVE

int inline rr_should_yield(runqueue_t *rq, struct timeval now)
{
   unsigned long normdiff, secdiff, fifodiff;
   
   secdiff = now.tv_sec - rq->last_normal.tv_sec;
   normdiff = now.tv_usec - ((secdiff * 1000000) + rq->last_normal.tv_usec);

   if( normdiff > NORM_STARVE)
     {
       return 1;
     }

   secdiff = now.tv_sec - rq->last_fifo.tv_sec;
   fifodiff = now.tv_usec - ((secdiff * 1000000) + rq->last_fifo.tv_usec);
   
 
   if( (normdiff > NORM_THRESH) && (fifodiff > NORM_WINDOW) )
     {
       return 1;
     }
 
   return 0;   

}

#endif /*CONFIG_RT_NONSTARVE*/
/*
 * 'schedule()' is the main scheduler function.
 */
asmlinkage void schedule(void)
{
	task_t *prev, *next;
	runqueue_t *rq;
	prio_array_t *array;
	list_t *queue;
	int idx;
#ifdef CONFIG_SCHED_RR_NONSTARVE
        struct timeval now; /* schedule timestamp */
        int idx2;
#endif
#ifdef CONFIG_RT_SWITCH_PRINT
        int policy1;
        int policy2;
        struct timeval tv;
	unsigned long flags;
        int allowed = 0;
#endif


	if (unlikely(in_interrupt()))
		BUG();

need_resched:
	preempt_disable();
	prev = current;
	rq = this_rq();

	release_kernel_lock(prev, smp_processor_id());
	prev->sleep_timestamp = jiffies;
	spin_lock_irq(&rq->lock);
        
	/*
	 * if entering from preempt_schedule, off a kernel preemption,
	 * go straight to picking the next task.
	 */
	if (unlikely(preempt_get_count() & PREEMPT_ACTIVE))
		goto pick_next_task;

#if CONFIG_RR_RESCHED_SWITCH || CONFIG_SCHED_RR_NONSTARVE
        /*
         * Move a SCHED_RR task to end of RQ each time schedule is called
         */

        do_gettimeofday(&now); 

        if (prev->policy == SCHED_RR){

#ifdef CONFIG_SCHED_RR_NONSTARVE
            if(unlikely(rq->non_rt_starving)){

                  /* if all normal processes are expired
                   * we dequeue the round robin processes
                   * instead of putting them at the end
                   * of their queue in the active array
                   * This will trigger a active/expired switch
                   * eventually
                   */
                  printk("moving RR to expired\n");
              /*    dequeue_task(prev, rq->active);
                  prev->first_time_slice = 0;
                  enqueue_task(prev, rq->expired);*/
                  //rq->expired_timestamp = jiffies;
                  goto pick_next_task;
             }
#endif /*CONFIG_SCHED_RR_NONSTARVE*/

#ifdef CONFIG_RR_RESCHED_SWITCH
             dequeue_task(prev, rq->active);
             enqueue_task(prev, rq->active);
#endif /*CONFIG_RR_RESCHED_SWITCH*/

out_rr_move:
        }
#endif /*CONFIG_RR_RESCHED_SWITCH || CONFIG_SCHED_RR_NONSTARVE*/


	switch (prev->state) {
	case TASK_INTERRUPTIBLE:
		if (unlikely(signal_pending(prev))) {
			prev->state = TASK_RUNNING;
			break;
		}
	default:
		deactivate_task(prev, rq);
	case TASK_RUNNING:
		;
	}
pick_next_task:
	if (unlikely(!rq->nr_running)) {
#if CONFIG_SMP
		load_balance(rq, 1);
		if (rq->nr_running)
			goto pick_next_task;
#endif
		/*
		 * Pick a task from the batch queue if available.
		 */
		if (rq->nr_batch) {
			list_t *tmp = rq->batch_queue.next;

			next = list_entry(tmp, task_t, run_list);
			activate_batch_task(next, rq);
		} else
			next = rq->idle;
		rq->expired_timestamp = 0;
		goto switch_tasks;
	}

	array = rq->active;
	if (unlikely(!array->nr_active)) {
		/*
		 * Switch the active and expired arrays.
		 */
		rq->active = rq->expired;
		rq->expired = array;
		array = rq->active;
		rq->expired_timestamp = 0;
#ifdef CONFIG_SCHED_RR_NONSTARVE
		if(rq->non_rt_starving){
                rq->non_rt_starving = 0;
		printk("exchange!\n");
		}
#endif /* CONFIG_SCHED_RR_NONSTARVE*/
	}

	idx = sched_find_first_bit(array->bitmap);
	queue = array->queue + idx;
	next = list_entry(queue->next, task_t, run_list);


#ifdef CONFIG_SCHED_RR_NONSTARVE
        /*
         * if SCHED_RR task should yeild and next task is SCHED_RR
         *               let a SCHED_NORMAL process take the CPU
         */

        switch (next->policy){
           case SCHED_FIFO:
                rq->last_fifo = now;      
                break;
           case SCHED_NORMAL:
                rq->last_normal = now;
                break;
           case SCHED_RR:
               if( rr_should_yield(rq, now) ){

                    /*find non RT process*/
                    idx2 = find_next_bit(array->bitmap, MAX_PRIO,MAX_RT_PRIO);

                    /*if nothing found, they must be expired*/
                    if(idx2 == MAX_PRIO && EXPIRED_STARVING(rq)){
                       rq->non_rt_starving = 1;
	               goto switch_tasks;
		     }
			
                   /*use process list at idx2*/
                    if(idx2 < MAX_PRIO){
                      queue = array->queue + idx2;
                      next = list_entry(queue->next, task_t, run_list);
                      rq->last_normal = now;
                      printk("allowing %d\n", next->pid);     
                      allowed = 1;
                     }
                 }
           }
        

#endif /*CONFIG_SCHED_RR_NONSTARVE*/

switch_tasks:

#ifdef CONFIG_RT_SWITCH_PRINT

        policy1 = prev->policy;
        policy2 = next->policy;

        if(allowed || (policy1 != SCHED_NORMAL || policy2 != SCHED_NORMAL)){

             switch (policy1){
                case SCHED_FIFO:
                printk("[{%d} ",prev->pid);
                break;
                case SCHED_RR:
                printk("[(%d) ",prev->pid);
                break;
                default:
                printk("[%d ",prev->pid);
                }

             switch (policy2){
                case SCHED_FIFO:
                printk("{%d} - %lu %lu]\n",next->pid, now.tv_sec, 
now.tv_usec);
                break;
                case SCHED_RR:
                printk("(%d) - %lu %lu]",next->pid, now.tv_sec, now.tv_usec);
                break;
                default:
                printk("%d - %lu %lu]",next->pid, now.tv_sec, now.tv_usec);
                }
#ifdef CONFIG_RT_PRINT_DEFAULT
	     printk("\n");	
#endif /* CONFIG_RT_PRINT_DEFAULT*/


        }
#endif /*CONFIG_RT_SWITCH_PRINT */

	prefetch(next);
	clear_tsk_need_resched(prev);

	if (likely(prev != next)) {
		rq->nr_switches++;
		rq->curr = next;
	
		prepare_arch_switch(rq, next);
		prev = context_switch(prev, next);
		barrier();
		rq = this_rq();
		finish_arch_switch(rq, prev);
	} else
		spin_unlock_irq(&rq->lock);

	reacquire_kernel_lock(current);
	preempt_enable_no_resched();
	if (need_resched())
		goto need_resched;
}
