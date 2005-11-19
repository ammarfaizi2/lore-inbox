Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbVKSCjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbVKSCjl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 21:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbVKSCjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 21:39:41 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:7623 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750831AbVKSCjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 21:39:41 -0500
Subject: Re: 2.6.14-rt13
From: Steven Rostedt <rostedt@goodmis.org>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>,
       "K.R. Foley" <kr@cybsft.com>, Thomas Gleixner <tglx@linutronix.de>,
       pluto@agmk.net, john cooper <john.cooper@timesys.com>,
       Benedikt Spranger <bene@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>,
       Tom Rini <trini@kernel.crashing.org>,
       George Anzinger <george@mvista.com>
In-Reply-To: <1132353689.4735.43.camel@cmn3.stanford.edu>
References: <20051115090827.GA20411@elte.hu>
	 <1132336954.20672.11.camel@cmn3.stanford.edu>
	 <1132350882.6874.23.camel@mindpipe>
	 <1132351533.4735.37.camel@cmn3.stanford.edu>
	 <20051118220755.GA3029@elte.hu>
	 <1132353689.4735.43.camel@cmn3.stanford.edu>
Content-Type: text/plain
Date: Fri, 18 Nov 2005 21:39:07 -0500
Message-Id: <1132367947.5706.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-18 at 14:41 -0800, Fernando Lopez-Lezcano wrote:
> On Fri, 2005-11-18 at 23:07 +0100, Ingo Molnar wrote:
> > * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> > 
> > > Arghhh, at least I take this as a confirmation that the TSCs do drift 
> > > and there is no workaround. It currently makes the -rt/Jack 
> > > combination not very useful, at least in my tests.
> > > 
> > > Is there a way to resync the TSCs?
> > 
> > no reasonable way. Does idle=poll make any difference?
> 
> I don't know yet, and I may never know :-) I've been running it for a
> while and so far works but that's what I thought yesterday of -rt13. It
> is not practical for normal use, it just heats the cpu unnecessarily and
> there's no way to control it other than a reboot.

Not anymore! 

OK, I used this as an exercise to learn how kobject and sysfs work (I've
been putting this off for too long). So if this isn't exactly proper,
let me know :-)

Ingo,  This could be a temporary patch until we come up with a better
solution.  This adds  /sys/kernel/idle/idle_poll, which if idle=poll is
_not_ set, it still lets you switch the machine to idle=poll on the fly,
as well as turn it off. If you have idle=poll, this doesn't even show
up.

So for example (I'm currently running it):

# cat /sys/kernel/idle/idle_poll
off
# echo 1 > /sys/kernel/idle/idle_poll
# cat /sys/kernel/idle/idle_poll on
# echo 0 > /sys/kernel/idle/idle_poll
# cat /sys/kernel/idle/idle_poll off

# echo on > /sys/kernel/idle/idle_poll
and 
# echo off > /sys/kernel/idle/idle_poll
also work.

So like I said.  This could be used for just those that need to have
idle=poll for running benchmarks but don't want to reboot when they are
done.

-- Steve

PS. I haven't tested to see if the idle actually changes, but it looks
pretty obvious in the code in cpu_idle:

			idle = pm_idle;
			if (!idle)
				idle = default_idle;
			if (cpu_is_offline(smp_processor_id()))
				play_dead();
			stop_critical_timing();
			propagate_preempt_locks_value();
			idle();



Index: linux-2.6.14-rt13/arch/x86_64/kernel/process.c
===================================================================
--- linux-2.6.14-rt13.orig/arch/x86_64/kernel/process.c	2005-11-15 11:12:37.000000000 -0500
+++ linux-2.6.14-rt13/arch/x86_64/kernel/process.c	2005-11-18 21:12:53.000000000 -0500
@@ -822,3 +822,104 @@
 		sp -= get_random_int() % 8192;
 	return sp & ~0xf;
 }
+
+#ifdef CONFIG_SYSFS
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
+#include <linux/spinlock.h>
+
+#define KERNEL_ATTR_RW(_name) \
+static struct subsys_attribute _name##_attr = \
+	__ATTR(_name, 0644, _name##_show, _name##_store)
+
+static spinlock_t idle_switch_lock = SPIN_LOCK_UNLOCKED(idle_switch_lock);
+
+static struct idlep_kobject
+{
+	struct kobject kobj;
+	int is_poll;
+	void (*idle)(void);
+} idle_kobj;
+
+static ssize_t idle_poll_show(struct subsystem *subsys, char *page)
+{
+	return sprintf(page, "%s\n", (idle_kobj.is_poll ? "on" : "off"));
+}
+
+static ssize_t idle_poll_store(struct subsystem *subsys,
+			       const char *buf, size_t len)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&idle_switch_lock, flags);
+
+	if (strncmp(buf,"1",1)==0 ||
+	    (len >=2 && strncmp(buf,"on",2)==0)) {
+		if (idle_kobj.is_poll != 1) {
+			idle_kobj.is_poll = 1;
+			pm_idle = poll_idle;
+		}
+	} else if (strncmp(buf,"0",1)==0 ||
+		   (len >= 3 && strncmp(buf,"off",3)==0)) {
+		if (idle_kobj.is_poll != 0) {
+			idle_kobj.is_poll = 0;
+			pm_idle = idle_kobj.idle;
+		}
+	}
+
+	spin_unlock_irqrestore(&idle_switch_lock, flags);
+
+	return len;
+}
+
+
+KERNEL_ATTR_RW(idle_poll);
+
+static struct attribute * idle_attrs[] = {
+	&idle_poll_attr.attr,
+	NULL
+};
+
+static struct attribute_group idle_attr_group = {
+	.attrs = idle_attrs,
+};
+
+static int __init idle_poll_set_init(void)
+{
+	int err;
+
+	/*
+	 * If the default is alread poll_idle then
+	 * don't even bother with this.
+	 */
+	if (pm_idle == poll_idle)
+		return 0;
+
+	memset(&idle_kobj, 0, sizeof(idle_kobj));
+
+	idle_kobj.is_poll = 0;
+	idle_kobj.idle = pm_idle;
+
+	err = kobject_set_name(&idle_kobj.kobj, "%s", "idle");
+	if (err)
+		goto out;
+
+	idle_kobj.kobj.parent = &kernel_subsys.kset.kobj;
+	err = kobject_register(&idle_kobj.kobj);
+	if (err)
+		goto out;
+
+	err = sysfs_create_group(&idle_kobj.kobj,
+				 &idle_attr_group);
+	if (err)
+		goto out;
+
+	return 0;
+out:
+	printk(KERN_INFO "Problem setting up sysfs idle_poll\n");
+	return 0;
+}
+
+late_initcall(idle_poll_set_init);
+#endif /* CONFIG_FS */
+


