Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272373AbRH3Ru3>; Thu, 30 Aug 2001 13:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272372AbRH3RuU>; Thu, 30 Aug 2001 13:50:20 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:3345 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S272370AbRH3RuE>; Thu, 30 Aug 2001 13:50:04 -0400
Message-ID: <3B8E7CCB.7BE302C3@zip.com.au>
Date: Thu, 30 Aug 2001 10:50:04 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.4.9-ac3 kpnpbios gets zombie
In-Reply-To: <3B8E44C0.6B5DD4A@loewe-komp.de> from "Peter =?iso-8859-1?Q?W=E4chtler?=" at Aug 30, 2001 03:50:56 PM <E15cSMi-00017g-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > IIRC Andrew Morton had fixed that with
> > a proper daemonize.
> > Am I wrong or did this bug crept in again?
> 
> Nobody has ever finished it or merged it

I was uncomfortable with the idea of changing the behaviour
of daemonize(), so this patch gives us a new API function,
called reparent_to_init().  It is designed to detach the
calling process from its current parent and it reparents itself
to child_reaper.

reparent_to_init() also initialises various members of
*current to sane defaults, to avoid possible problems where
kernel threads which are parented by userspace processes
could have inappropriate state.  The selection of *which*
fields to initialise was fairly ad-hoc - I basically scanned
task_struct and tossed in any fields which looked like they
shouldn't be randomised.  Comments on omissions or unnecessary
entries would be welcome.

Also note that reparent_to_init() has only been called from
two places - rtl8139_thread and the pnpbios code.  There
are probably other kernel threads which need to make a call
to this function - basically anything which is started up by
a userspace task and which can exit.  nfs daemons, raid daemons,
loopback, journalling fs daemons, etc.

We normally don't observe problems with this stuff because the userspace
process which starts the kernel thread does an exit(), and hides the
problem.  Think of mount(8), ifconfig(8), raidstart(8), etc.

The main problems which we're fixing here are:

- kernel threads which do not set their exit signal to
  SIGCHLD are not reapable by init's waitpid(-1, ...).
  So we set the exit signal to SIGCHLD.

- kernel threads which *do* set SIGCHLD will send a signal to
  their parent on exit.  The parent could be a userspace
  process, such as (in the case of 8139too.c) ifconfig or
  dhcpcd.  The kernel should not be sending signals out
  to userspace tasks just because they opened a netdevice
  recently...

The 8139too.c problem is the biggest one - DHCP clients like
to open and close the interface regularly and we end up with
a huge number of defunct kernel threads.  Presumably these
all go away when the dhcp client is killed off.

Anyway, the code works OK - there may be other ways of solving
these problems...  Patch is against 2.4.9-ac4


--- linux-2.4.9-ac4/include/linux/sched.h	Thu Aug 30 10:11:12 2001
+++ ac/include/linux/sched.h	Thu Aug 30 10:37:37 2001
@@ -755,6 +755,7 @@ extern void exit_mm(struct task_struct *
 extern void exit_files(struct task_struct *);
 extern void exit_sighand(struct task_struct *);
 
+extern void reparent_to_init(void);
 extern void daemonize(void);
 
 extern int do_execve(char *, char **, char **, struct pt_regs *);
--- linux-2.4.9-ac4/kernel/sched.c	Thu Aug 30 10:11:12 2001
+++ ac/kernel/sched.c	Thu Aug 30 10:38:30 2001
@@ -109,6 +109,7 @@ static union {
 #define last_schedule(cpu) aligned_data[(cpu)].schedule_data.last_schedule
 
 struct kernel_stat kstat;
+extern struct task_struct *child_reaper;
 
 #ifdef CONFIG_SMP
 
@@ -1222,6 +1223,59 @@ void show_state(void)
 		show_task(p);
 	}
 	read_unlock(&tasklist_lock);
+}
+
+/**
+ * reparent_to_init() - Reparent the calling kernel thread to the init task.
+ *
+ * If a kernel thread is launched as a result of a system call, or if
+ * it ever exits, it should generally reparent itself to init so that
+ * it is correctly cleaned up on exit.
+ *
+ * The various task state such as scheduling policy and priority may have
+ * been inherited fro a user process, so we reset them to sane values here.
+ *
+ * NOTE that reparent_to_init() gives the caller full capabilities.
+ */
+void reparent_to_init(void)
+{
+	struct task_struct *this_task = current;
+
+	write_lock_irq(&tasklist_lock);
+
+	/* Reparent to init */
+	REMOVE_LINKS(this_task);
+	this_task->p_pptr = child_reaper;
+	this_task->p_opptr = child_reaper;
+	SET_LINKS(this_task);
+
+	/* Set the exit signal to SIGCHLD so we signal init on exit */
+	if (this_task->exit_signal != 0) {
+		printk(KERN_ERR "task `%s' exit_signal %d in "
+				__FUNCTION__ "\n",
+			this_task->comm, this_task->exit_signal);
+	}
+	this_task->exit_signal = SIGCHLD;
+
+	/* We also take the runqueue_lock while altering task fields
+	 * which affect scheduling decisions */
+	spin_lock(&runqueue_lock);
+
+	this_task->ptrace = 0;
+	this_task->nice = DEF_NICE;
+	this_task->policy = SCHED_OTHER;
+	/* cpus_allowed? */
+	/* rt_priority? */
+	/* signals? */
+	this_task->cap_effective = CAP_INIT_EFF_SET;
+	this_task->cap_inheritable = CAP_INIT_INH_SET;
+	this_task->cap_permitted = CAP_FULL_SET;
+	this_task->keep_capabilities = 0;
+	memcpy(this_task->rlim, init_task.rlim, sizeof(*(this_task->rlim)));
+	this_task->user = INIT_USER;
+
+	spin_unlock(&runqueue_lock);
+	write_unlock_irq(&tasklist_lock);
 }
 
 /*
--- linux-2.4.9-ac4/kernel/ksyms.c	Thu Aug 30 10:11:12 2001
+++ ac/kernel/ksyms.c	Thu Aug 30 10:37:37 2001
@@ -475,6 +475,7 @@ EXPORT_SYMBOL(secure_tcp_sequence_number
 EXPORT_SYMBOL(get_random_bytes);
 EXPORT_SYMBOL(securebits);
 EXPORT_SYMBOL(cap_bset);
+EXPORT_SYMBOL(reparent_to_init);
 EXPORT_SYMBOL(daemonize);
 EXPORT_SYMBOL(csum_partial); /* for networking and md */
 
--- linux-2.4.9-ac4/drivers/pnp/pnp_bios.c	Thu Aug 30 10:11:08 2001
+++ ac/drivers/pnp/pnp_bios.c	Thu Aug 30 10:37:37 2001
@@ -506,6 +506,7 @@ static int pnp_dock_thread(void * unused
 	static struct pnp_docking_station_info now;
 	int docked = -1, d;
 	daemonize();
+	reparent_to_init();
 	strcpy(current->comm, "kpnpbios");
 	while(!unloading && !signal_pending(current))
 	{
--- linux-2.4.9-ac4/drivers/net/8139too.c	Thu Aug 16 12:23:16 2001
+++ ac/drivers/net/8139too.c	Thu Aug 30 10:37:37 2001
@@ -1610,6 +1610,7 @@ static int rtl8139_thread (void *data)
 	unsigned long timeout;
 
 	daemonize ();
+	reparent_to_init();
 	spin_lock_irq(&current->sigmask_lock);
 	sigemptyset(&current->blocked);
 	recalc_sigpending(current);
