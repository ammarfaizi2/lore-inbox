Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262216AbVBKIMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbVBKIMT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 03:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262218AbVBKIMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 03:12:18 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:45233 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S262216AbVBKILt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 03:11:49 -0500
Subject: Re: [RFC][PATCH 2.6.11-rc3-mm2] Relay Fork Module
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Gerrit Huizenga <gh@us.ibm.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>, Greg KH <greg@kroah.com>,
       Jay Lan <jlan@engr.sgi.com>
In-Reply-To: <20050207154623.33333cda.akpm@osdl.org>
References: <1107786245.9582.27.camel@frecb000711.frec.bull.fr>
	 <20050207154623.33333cda.akpm@osdl.org>
Date: Fri, 11 Feb 2005 09:11:44 +0100
Message-Id: <1108109504.30559.43.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 11/02/2005 09:20:25,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 11/02/2005 09:20:28,
	Serialize complete at 11/02/2005 09:20:28
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-07 at 15:46 -0800, Andrew Morton wrote:
> Guillaume Thouvenin <guillaume.thouvenin@bull.net> wrote:
> >
> > Hello,
> > 	
> >    This module sends a signal to one or several processes (in user
> > space) when a fork occurs in the kernel. It relays information about
> > forks (parent and child pid) to a user space application.
> >
> So this permits ELSA to maintain a complete picture of the process/thread
> hierarchy?  I guess that fits into the "do it in userspace" mantra -
> certainly hooking into fork() is a minimal way of doing this, although I
> wonder what the limitations are.
> 
> Implementation-wise: there's a lot of code there and the interface is a bit
> awkward.  Why not just feed that kobject you have there into
> kobject_uevent()?

  Like Andrew suggested, I wrote a new patch (tested on 2.6.11-rc3-mm2)
that notifies to user space application the creation of a new process
when kernel forks by using the kobject_uevent() routine. This funtion
sends a new event (KOBJ_FORK) through the netlink interface. This new
event needs an environment (parent pid and child pid) so I used
send_uevent() like it is done in kobject_hotplug(). 

  I tested this patch on a 2.6.11-rc3-mm2 kernel and there is a little
overhead when I compile a Linux kernel:

   #time sh -c 'make O=/home/guill/build/k2610 bzImage && 
   make O=/home/guill/build/k2610 modules'

   with a vanilla kernel: real    8m10.797s
	                  user    7m29.652s
			  sys     0m49.275s
   
   with the forkuevent patch : real    8m16.189s
                    	       user    7m28.841s
		    	       sys     0m49.155s

  I paste the diff at the end of the mail with wrap line disabled. is it
better to wrap the patch to 80 characters or is it ok like this?

  Every comments are welcome. For exemple is it better to use a
structure instead of two pid_t parameters? I also like to know if this
is useful for someone else... thus, any feedback will be appreciate.
 
 
Regards,
Guillaume

guill@karakorum $ diffstat linux-2.6.11-rc3-mm2-forkuevent.patch
 include/linux/kobject.h        |    2 +
 include/linux/kobject_uevent.h |    1
 kernel/fork.c                  |   13 ++++++++
 lib/kobject_uevent.c           |   63 ++++++++++++++...++++++++++++
 4 files changed, 79 insertions(+)

Signed-off-by: Guillaume Thouvenin <guillaume.thouvenin@bull.net>

diff -uprN -X dontdiff linux-2.6.11-rc3-mm2/include/linux/kobject.h linux-2.6.11-rc3-mm2-forkuevent/include/linux/kobject.h
--- linux-2.6.11-rc3-mm2/include/linux/kobject.h	2005-02-03 02:54:59.000000000 +0100
+++ linux-2.6.11-rc3-mm2-forkuevent/include/linux/kobject.h	2005-02-11 08:38:25.000000000 +0100
@@ -253,5 +253,7 @@ static inline int add_hotplug_env_var(ch
 { return 0; }
 #endif
 
+extern void kobject_fork(struct kobject *, pid_t, pid_t);
+
 #endif /* __KERNEL__ */
 #endif /* _KOBJECT_H_ */
diff -uprN -X dontdiff linux-2.6.11-rc3-mm2/include/linux/kobject_uevent.h linux-2.6.11-rc3-mm2-forkuevent/include/linux/kobject_uevent.h
--- linux-2.6.11-rc3-mm2/include/linux/kobject_uevent.h	2005-02-03 02:54:38.000000000 +0100
+++ linux-2.6.11-rc3-mm2-forkuevent/include/linux/kobject_uevent.h	2005-02-11 08:38:25.000000000 +0100
@@ -29,6 +29,7 @@ enum kobject_action {
 	KOBJ_UMOUNT	= (__force kobject_action_t) 0x05,	/* umount event for block devices */
 	KOBJ_OFFLINE	= (__force kobject_action_t) 0x06,	/* offline event for hotplug devices */
 	KOBJ_ONLINE	= (__force kobject_action_t) 0x07,	/* online event for hotplug devices */
+	KOBJ_FORK	= (__force kobject_action_t) 0x08,	/* a child process has been created */
 };
 
 
diff -uprN -X dontdiff linux-2.6.11-rc3-mm2/kernel/fork.c linux-2.6.11-rc3-mm2-forkuevent/kernel/fork.c
--- linux-2.6.11-rc3-mm2/kernel/fork.c	2005-02-11 08:37:48.000000000 +0100
+++ linux-2.6.11-rc3-mm2-forkuevent/kernel/fork.c	2005-02-11 08:39:33.000000000 +0100
@@ -41,6 +41,7 @@
 #include <linux/profile.h>
 #include <linux/rmap.h>
 #include <linux/acct.h>
+#include <linux/kobject.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -57,6 +58,9 @@ int nr_threads; 		/* The idle threads do
 
 int max_threads;		/* tunable limit on nr_threads */
 
+/* kobject used to notify user space application when a fork occurs */
+struct kobject fork_kobj;
+			
 DEFINE_PER_CPU(unsigned long, process_counts) = 0;
 
  __cacheline_aligned DEFINE_RWLOCK(tasklist_lock);  /* outer */
@@ -148,6 +152,13 @@ void __init fork_init(unsigned long memp
 
 	init_task.signal->rlim[RLIMIT_NPROC].rlim_cur = max_threads/2;
 	init_task.signal->rlim[RLIMIT_NPROC].rlim_max = max_threads/2;
+
+	/*
+	 * We init the fork_kobj which is the event sends when a fork
+	 * occurs.
+	 */
+	kobject_init(&fork_kobj);
+	kobject_set_name(&fork_kobj, "fork_kobj");
 }
 
 static struct task_struct *dup_task_struct(struct task_struct *orig)
@@ -1238,6 +1249,8 @@ long do_fork(unsigned long clone_flags,
 			if (unlikely (current->ptrace & PT_TRACE_VFORK_DONE))
 				ptrace_notify ((PTRACE_EVENT_VFORK_DONE << 8) | SIGTRAP);
 		}
+
+		kobject_fork(&fork_kobj, current->pid, p->pid);
 	} else {
 		free_pidmap(pid);
 		pid = PTR_ERR(p);
diff -uprN -X dontdiff linux-2.6.11-rc3-mm2/lib/kobject_uevent.c linux-2.6.11-rc3-mm2-forkuevent/lib/kobject_uevent.c
--- linux-2.6.11-rc3-mm2/lib/kobject_uevent.c	2005-02-11 08:37:48.000000000 +0100
+++ linux-2.6.11-rc3-mm2-forkuevent/lib/kobject_uevent.c	2005-02-11 08:38:25.000000000 +0100
@@ -46,6 +46,8 @@ static char *action_to_string(enum kobje
 		return "offline";
 	case KOBJ_ONLINE:
 		return "online";
+	case KOBJ_FORK:
+		return "fork";
 	default:
 		return NULL;
 	}
@@ -433,3 +435,64 @@ int add_hotplug_env_var(char **envp, int
 EXPORT_SYMBOL(add_hotplug_env_var);
 
 #endif /* CONFIG_HOTPLUG */
+
+/* 
+ * The buffer will contain 1 integer which has 20 digits for
+ * 64 bits integer. So a size of 32 is large enough...
+ */
+#define FORK_BUFFER_SIZE	32
+
+/* 
+ * number of env pointers is set to FORK_BUFFER_NB 
+ *	env[0] - Not used
+ *	env[1] - Not used
+ *	env[2] - parent pid
+ *	env[3] - child pid
+ *	env[4] - NULL
+ */
+#define FORK_BUFFER_NB		5
+
+/**
+ * kobject_fork - notify userspace when forking
+ *
+ * @kobj: struct kobject that the action is happening to
+ */
+void kobject_fork(struct kobject *kobj, pid_t parent, pid_t child)
+{
+	char *kobj_path = NULL;
+	char *action_string = NULL;
+	char **envp = NULL;
+	char ppid_string[FORK_BUFFER_SIZE];
+	char cpid_string[FORK_BUFFER_SIZE];
+
+	action_string = action_to_string(KOBJ_FORK);
+	if (!action_string)
+		return;
+	
+	kobj_path = kobject_get_path(kobj, GFP_KERNEL);
+	if (!kobj_path)
+		return;
+
+	envp = kmalloc(FORK_BUFFER_NB * sizeof (char *), GFP_KERNEL);
+	if (!envp) {
+		kfree(kobj_path);
+		return;
+	}
+	memset (envp, 0x0, FORK_BUFFER_NB * sizeof (char *));
+
+	snprintf(ppid_string, FORK_BUFFER_SIZE, "%i", parent);
+	snprintf(cpid_string, FORK_BUFFER_SIZE, "%i", child);
+	
+	envp[0] = "Not used";
+	envp[1] = "Not used";
+	envp[2] = ppid_string;
+	envp[3] = cpid_string;
+	envp[4] = NULL;
+	
+	send_uevent(action_string, kobj_path, envp, GFP_KERNEL);
+
+	kfree(envp);
+	kfree(kobj_path);
+	return;
+}
+EXPORT_SYMBOL(kobject_fork);


