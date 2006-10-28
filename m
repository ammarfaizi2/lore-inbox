Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751979AbWJ1IXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbWJ1IXN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 04:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751980AbWJ1IXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 04:23:13 -0400
Received: from [61.48.52.34] ([61.48.52.34]:31911 "EHLO freya.yggdrasil.com")
	by vger.kernel.org with ESMTP id S1751979AbWJ1IXM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 04:23:12 -0400
Date: Sat, 28 Oct 2006 16:23:35 +0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200610280823.k9S8NZ2D004392@freya.yggdrasil.com>
To: torvalds@osdl.org
Subject: Re: [patch] drivers: wait for threaded probes between initcall levels
Cc: akpm@osdl.org, bunk@stusta.de, greg@kroah.com,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       matthew@wil.cx, pavel@ucw.cz, shemminger@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2006 13:42:44 -0700 (PDT), Linus Torvals wrote:
>        static struct semaphore outstanding;
[...]
>        static void allow_parallel(int n)
[...]
>        static void wait_for_parallel(int n)
[...]
>        static void execute_in_parallel(int (*fn)(void *), void *arg)

	This interface would have problems with nesting.

	As a realistic example of nesting, imagine if this facility were
used for initcalls, and one of those initcalls also used this facility to
attempt parallel initialization of several hardware devices attached
to some bus.  In this scenario, do_initcalls would call allow_parallelism(10),
and then one of the initcalls that wanted to spawn its own set of
parallel processes would also call allow_parallel(10) (unintentionally
making the number of allowed processes 20), kick off its parallel
processes, and then call wait_for_parallel(), which could return
prematurely, which could easily lead to one of the child threads that
was incorrectly assumed to have finished to then corrupt memory or do any
number of other things that leads to a crash that is not reliably
reproducible.

	Here are some possible ways to address this problem, and
their drawbacks.

	1. Just document that nesting is prohibited, adding some BUG()
test to prevent such use.  This would limit the usefulness of this
facility, and create some unnecessary coordination issues among
kernel developers in arguing policy over who gets to use this facility.

	2. Turn the "outstanding" counting semaphore into a parameter.
Each group of related threads would share this parameter.  For example,
do_initcalls might look something like this:

struct semaphore initcalls_sem = SEMAPHORE_INITIALIZER(...);

allow_parallel(PARALLELISM, &initcalls_sem);

for (call = __initcall_start; call < __initcall_end; call++)
	execute_in_parallel(call, NULL, &initcalls_sem);

wait_for_parallel(PARALLEISM, &initcalls_sem);

	The drawback of this solution is that the limitation on the total
number of parallel processes is not global.  So, the number of
parallel processes in a nesting situation could get quite high.
For example, if 10 top level threads each initiated another 10
secondary threads, that's up to 111 threads with just a nesting
depth of 2.

	3. Add an rw_semaphore passed as a parameter for
wait_for_parallelism, but keep original static semaphore for limiting
the parallelism.  wait_for_parallel would be the only function ever
to block on the rw_semaphore, so that should avoid any problem with
ordering of taking the two semaphores--I think.

	This solution deadlocks if the nesting depth exceeds the maximum
number of threads allowed, which could realistically occur when the maximum
parallelism allowed is 1.

	4. Same as #3, but also increase the global thread count by 1 on
every call to allow_parallel, and decrease it by one in the matching
wait_for_parallel.  The drawback here is that setting the global
number of threads to one at the outset would no longer guarantee
strict serial execution, which is minor compared to the other
problems listed above.  If we want to guarantee serial execution
when PARALLELISM=1, I think that can be arranged with a little more
complexity, but I'd like to know if that is actually important.

	I have attached an example of approach #4 below, also completely
untested, with no attempt made to try to compile it.

Adam Richter




#define PARALLELISM (10)

static struct semaphore outstanding;

struct thread_exec {
        int (*fn)(void *);
        void *arg;
	struct completion args_copied;
	struct rw_semaphore *fn_done;
};

/* In some .h file: */
static inline void start_parallel(void)
{
	up(&outstanding);
}

/* In some .h file: */
static inline void wait_for_parallel(struct rw_semaphore *fn_done)
{
	down_write(fn_done);
	down(&outstanding);
}

void allow_parallel(int n)	/* called once, at boot time */
{
        while (--n >= 0)
                up(&outstanding);
}

static int do_in_parallel(void *arg)
{
        struct thread_exec *p = arg;
        int (*fn)(void *) = p->fn;
        void *arg = p->arg;
	struct rw_semaphore *fn_done = p->fn_done;
        int retval;

        /* Tell the caller we are done with the arguments */
        complete(&p->args_copied);

        /* Do the actual work in parallel */
        retval = p->fn(p->arg);

        /*
         * And then tell the rest of the world that we've
         * got one less parallel thing outstanding..
         */
	up_read(fn_done);
        up(&outstanding);
        return retval;
}

void execute_in_parallel(int (*fn)(void *),
			void *arg,
			struct semaphore *fn_done)
{
        struct thread_exec arg = { .fn = fn, .arg = arg };

        /* Make sure we can have more outstanding parallel work */
        down(&outstanding);

        arg.fn = fn;
        arg.arg = arg;
	arg.fn_done = fn_done;
	down_read(fn_done);
        init_completion(&arg.args_copied);

        kernel_thread(do_in_parallel, &arg);

        wait_for_completion(&arg.args_copied)
}


Example of usage:

	/* Earlier in the boot process... */
        allow_parallel(PARALLELISM);


static void __init do_initcalls(void)
{
	DECLARE_RWSEM(initcalls_done);
	start_parallel();
	for (call = __initcall_start; call < __initcall_end; call++)
		execute_in_parallel(call, NULL, &initcalls_done);

	wait_for_parallel(&initcalls_done);
}
