Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbUKWXHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbUKWXHY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 18:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbUKWXFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 18:05:35 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:950 "EHLO lirs02.phys.au.dk")
	by vger.kernel.org with ESMTP id S261517AbUKWXDj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 18:03:39 -0500
Date: Wed, 24 Nov 2004 00:03:34 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
In-Reply-To: <20041123133456.GA10453@elte.hu>
Message-Id: <Pine.OSF.4.05.10411232343010.4816-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 I have updated the test to take into account nested locking where
traversal of the dependency chain has to be traversed when priorities are
boosted. Basicly, I made a test which makes pi_walk in /proc/stat be
non-zero!

I both changed the code in user space and in the blocker device in the
kernel - the patch to the kernel is below and the full code is at
 http://www.phys.au.dk/~simlo/Linux/pi_test2.tgz
along with detailed explanations.

Results (in short): 
-30-9 doesn't resolved nested locking well. The expected max locking time
in my test would be depth * 1ms - it is much higher just at a locking
depth at two.

I have an idea about what the error(s) is(are): In rt.c policy ==
SCHED_NORMAL tasks are threaded specially. A task boosted into the
real-time realm by mutex_setprio() is _still_ SCHED_NORMAL and do not gain
all the privileges of a real-time task. I suggest that the tests on
SCHED_NORMAL are replaced by using the rt_task() test which just looks at
the current priority and thus also would be true on tasks temporarely
boosted in the real-time realm. Another thing: A SCHED_NORMAL task will
not be added to the pi_waiters list, but it ought to be when it is later
boosted into the real-time realm. Also, you ignore all tasks being
SCHED_NORMAL in the tail of the wait list when you try to find the next
owner: It could be that one of those is boosted.

Esben


--- linux-2.6.10-rc2-mm2-V0.7.30-9/drivers/char/blocker.c.orig  2004-11-23 20:18:28.000000000 +0100
+++ linux-2.6.10-rc2-mm2-V0.7.30-9/drivers/char/blocker.c       2004-11-23 20:41:57.742899751 +0100
@@ -24,11 +24,41 @@
                get_cpu_tick();
 }
 
-spinlock_t lock = SPIN_LOCK_UNLOCKED;
-
 #define BLOCK_IOCTL 4245
+#define BLOCK_SET_DEPTH  4246
 #define BLOCKER_MINOR  221
 
+
+#define MAX_LOCK_DEPTH 10
+
+static spinlock_t blocker_lock[MAX_LOCK_DEPTH];
+
+static unsigned int lock_depth = 1;
+
+void do_the_lock_and_loop(unsigned int args)
+{
+       int i,max;
+       
+       if(rt_task(current)) {
+               max = lock_depth;
+       } 
+       else if(lock_depth>1) {
+               max = (current->pid % lock_depth)+1;
+       }
+       else {
+               max = 1;
+       }
+       
+       /* Always lock from the top down */
+       for(i=max-1;i>=0; i--) {
+               spin_lock(&blocker_lock[i]);
+       }
+       loop(args);
+       for(i=0;i<max; i++) {
+               spin_unlock(&blocker_lock[i]);
+       }
+}
+
 static int blocker_open(struct inode *in, struct file *file)
 {
        printk(KERN_INFO "blocker_open called\n");
@@ -40,9 +70,13 @@
 {
        switch(cmd) {
        case BLOCK_IOCTL:
-               spin_lock(&lock);
-               loop(args);
-               spin_unlock(&lock);
+               do_the_lock_and_loop(args);
+               return 0;
+       case BLOCK_SET_DEPTH:
+               if(args>=MAX_LOCK_DEPTH) {
+                       return -EINVAL;
+               }
+               lock_depth = args;
                return 0;
        default:
                return -EINVAL;
@@ -66,11 +100,17 @@
 
 static int __init blocker_init(void)
 {
+       int i;
+
        printk(KERN_INFO "blocker device installed\n");
 
        if (misc_register(&blocker_dev))
                return -ENODEV;
 
+       for(i=0;i<MAX_LOCK_DEPTH;i++) {
+               blocker_lock[i] = SPIN_LOCK_UNLOCKED;
+       }
+
        return 0;
 }


On Tue, 23 Nov 2004, Ingo Molnar wrote:

> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > 
> > >  From realfeel I wrote a small, simple test to test how well priority
> > > inheritance mechanism works. 
> > 
> > cool - this is a really useful testsuite.
> 
> FYI, i've put the 'blocker device' kernel code into the current -RT
> patch (-30-7). This makes it possible to build it on SMP (which didnt
> work when it was a module), and generally makes it easier to do testing
> via pi_test.
> 
> The only change needed on the userspace pi_test side was to add -O2 to
> the CFLAGS in the Makefile to make the loop() timings equivalent, and to
> remove the module compilations. I've added a .config option for it too
> and cleaned up the code.
> 
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

