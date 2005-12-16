Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbVLPRz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbVLPRz0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 12:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbVLPRz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 12:55:26 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:25288 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751321AbVLPRzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 12:55:25 -0500
Date: Fri, 16 Dec 2005 09:55:40 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, Eric Dumazet <dada1@cosmosbay.com>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Simon Derr <Simon.Derr@bull.net>, Andi Kleen <ak@suse.de>,
       Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH 02/04] Cpuset: use rcu directly optimization
Message-ID: <20051216175540.GB24876@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051214084031.21054.13829.sendpatchset@jackhammer.engr.sgi.com> <20051214084037.21054.4269.sendpatchset@jackhammer.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051214084037.21054.4269.sendpatchset@jackhammer.engr.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 12:40:37AM -0800, Paul Jackson wrote:
> Optimize the cpuset impact on page allocation, the most
> performance critical cpuset hook in the kernel.
> 
> On each page allocation, the cpuset hook needs to check for a
> possible change in the current tasks cpuset.  It can now handle
> the common case, of no change, without taking any spinlock or
> semaphore, thanks to RCU.
> 
> Convert a spinlock on the current task to an rcu_read_lock(),
> saving approximately a memory barrier and an atomic op, depending
> on architecture.
> 
> This is done by adding rcu_assign_pointer() and synchronize_rcu()
> calls to the write side of the task->cpuset pointer, in
> cpuset.c:attach_task(), to delay freeing up a detached cpuset
> until after any critical sections referencing that pointer.
> 
> Thanks to Andi Kleen, Nick Piggin and Eric Dumazet for ideas.

Looks good to me from an RCU perspective!

Moving from synchronize_rcu() to call_rcu() would be tricky, since
the check_for_release() function can block in kmalloc().  If updates
become a bottleneck, one approach would be to invoke work queues
from within the RCU callback.

						Thanx, Paul

Acked-by: <paulmck@us.ibm.com>
> Signed-off-by: Paul Jackson <pj@sgi.com>
> 
> ---
> 
>  kernel/cpuset.c |   40 ++++++++++++++++++++++++++++++----------
>  1 files changed, 30 insertions(+), 10 deletions(-)
> 
> --- 2.6.15-rc3-mm1.orig/kernel/cpuset.c	2005-12-13 16:49:01.767509666 -0800
> +++ 2.6.15-rc3-mm1/kernel/cpuset.c	2005-12-13 17:19:37.989982316 -0800
> @@ -39,6 +39,7 @@
>  #include <linux/namei.h>
>  #include <linux/pagemap.h>
>  #include <linux/proc_fs.h>
> +#include <linux/rcupdate.h>
>  #include <linux/sched.h>
>  #include <linux/seq_file.h>
>  #include <linux/slab.h>
> @@ -248,6 +249,11 @@ static struct super_block *cpuset_sb;
>   * a tasks cpuset pointer we use task_lock(), which acts on a spinlock
>   * (task->alloc_lock) already in the task_struct routinely used for
>   * such matters.
> + *
> + * P.S.  One more locking exception.  RCU is used to guard the
> + * update of a tasks cpuset pointer by attach_task() and the
> + * access of task->cpuset->mems_generation via that pointer in
> + * the routine cpuset_update_task_memory_state().
>   */
>  
>  static DECLARE_MUTEX(manage_sem);
> @@ -610,12 +616,24 @@ static void guarantee_online_mems(const 
>   * cpuset pointer.  This routine also might acquire callback_sem and
>   * current->mm->mmap_sem during call.
>   *
> - * The task_lock() is required to dereference current->cpuset safely.
> - * Without it, we could pick up the pointer value of current->cpuset
> - * in one instruction, and then attach_task could give us a different
> - * cpuset, and then the cpuset we had could be removed and freed,
> - * and then on our next instruction, we could dereference a no longer
> - * valid cpuset pointer to get its mems_generation field.
> + * Reading current->cpuset->mems_generation doesn't need task_lock
> + * to guard the current->cpuset derefence, because it is guarded
> + * from concurrent freeing of current->cpuset by attach_task(),
> + * using RCU.
> + *
> + * The rcu_dereference() is technically probably not needed,
> + * as I don't actually mind if I see a new cpuset pointer but
> + * an old value of mems_generation.  However this really only
> + * matters on alpha systems using cpusets heavily.  If I dropped
> + * that rcu_dereference(), it would save them a memory barrier.
> + * For all other arch's, rcu_dereference is a no-op anyway, and for
> + * alpha systems not using cpusets, another planned optimization,
> + * avoiding the rcu critical section for tasks in the root cpuset
> + * which is statically allocated, so can't vanish, will make this
> + * irrelevant.  Better to use RCU as intended, than to engage in
> + * some cute trick to save a memory barrier that is impossible to
> + * test, for alpha systems using cpusets heavily, which might not
> + * even exist.
>   *
>   * This routine is needed to update the per-task mems_allowed data,
>   * within the tasks context, when it is trying to allocate memory
> @@ -627,11 +645,12 @@ void cpuset_update_task_memory_state()
>  {
>  	int my_cpusets_mem_gen;
>  	struct task_struct *tsk = current;
> -	struct cpuset *cs = tsk->cpuset;
> +	struct cpuset *cs;
>  
> -	task_lock(tsk);
> +	rcu_read_lock();
> +	cs = rcu_dereference(tsk->cpuset);
>  	my_cpusets_mem_gen = cs->mems_generation;
> -	task_unlock(tsk);
> +	rcu_read_unlock();
>  
>  	if (my_cpusets_mem_gen != tsk->cpuset_mems_generation) {
>  		down(&callback_sem);
> @@ -1131,7 +1150,7 @@ static int attach_task(struct cpuset *cs
>  		return -ESRCH;
>  	}
>  	atomic_inc(&cs->count);
> -	tsk->cpuset = cs;
> +	rcu_assign_pointer(tsk->cpuset, cs);
>  	task_unlock(tsk);
>  
>  	guarantee_online_cpus(cs, &cpus);
> @@ -1151,6 +1170,7 @@ static int attach_task(struct cpuset *cs
>  	if (is_memory_migrate(cs))
>  		do_migrate_pages(tsk->mm, &from, &to, MPOL_MF_MOVE_ALL);
>  	put_task_struct(tsk);
> +	synchronize_rcu();
>  	if (atomic_dec_and_test(&oldcs->count))
>  		check_for_release(oldcs, ppathbuf);
>  	return 0;
> 
> -- 
>                           I won't rest till it's the best ...
>                           Programmer, Linux Scalability
>                           Paul Jackson <pj@sgi.com> 1.650.933.1373
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
