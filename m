Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751625AbWH3XRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbWH3XRp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 19:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbWH3XRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 19:17:45 -0400
Received: from tomts16.bellnexxia.net ([209.226.175.4]:57742 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751624AbWH3XRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 19:17:44 -0400
Date: Wed, 30 Aug 2006 19:17:40 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>
Cc: ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: [PATCH 7/16] LTTng : Linux Trace Toolkit Next Generation 0.5.95, kernel 2.6.17
Message-ID: <20060830231740.GH17079@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_Krystal-28273-1156979861-0001-2"
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 19:16:51 up 7 days, 20:25,  9 users,  load average: 0.49, 0.40, 0.27
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Krystal-28273-1156979861-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

7- LTTng helper modules
ltt-control : Netlink interface to control tracing from user space.
ltt-statedump : Module reponsible for grabbing information thorough the kernel
when the trace starts.
patch-2.6.17-lttng-0.5.95-modules.diff

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 

--=_Krystal-28273-1156979861-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-2.6.17-lttng-0.5.95-modules.diff"

--- /dev/null
+++ b/ltt/ltt-control.c
@@ -0,0 +1,119 @@
+/* ltt-control.c
+ *
+ * LTT control module over a netlink socket.
+ *
+ * Inspired from Relay Apps, by Tom Zanussi and iptables
+ *
+ * Copyright 2005 -
+ * 	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/ltt-core.h>
+#include <linux/netlink.h>
+#include <linux/inet.h>
+#include <linux/ip.h>
+#include <linux/security.h>
+#include <linux/skbuff.h>
+#include <linux/types.h>
+#include <net/sock.h>
+#include "ltt-control.h"
+
+#define LTTCTLM_BASE	0x10
+#define LTTCTLM_CONTROL	(LTTCTLM_BASE + 1)	/* LTT control message */
+
+static struct sock *socket;
+
+void ltt_control_input(struct sock *sk, int len)
+{
+	struct sk_buff *skb;
+	struct nlmsghdr *nlh = NULL;
+	u8 *payload = NULL;
+	lttctl_peer_msg_t *msg;
+	int err;
+
+	printk(KERN_DEBUG "ltt-control ltt_control_input\n");
+
+	while ((skb = skb_dequeue(&sk->sk_receive_queue)) != NULL) {
+
+		nlh = (struct nlmsghdr *)skb->data;
+		if(security_netlink_recv(skb)) {
+			netlink_ack(skb, nlh, EPERM);
+			kfree_skb(skb);
+			continue;
+		}
+		/* process netlink message pointed by skb->data */
+		err = EINVAL;
+		payload = NLMSG_DATA(nlh);
+		/* process netlink message with header pointed by 
+		 * nlh and payload pointed by payload
+		 */
+		if(nlh->nlmsg_len !=
+				sizeof(lttctl_peer_msg_t) +
+				sizeof(struct nlmsghdr)) {
+			printk(KERN_ALERT "ltt-control bad message length %d vs. %d\n",
+				nlh->nlmsg_len, sizeof(lttctl_peer_msg_t) +
+				sizeof(struct nlmsghdr));
+			netlink_ack(skb, nlh, EINVAL);
+			kfree_skb(skb);
+			continue;
+		}
+		msg = (lttctl_peer_msg_t*)payload;
+
+		switch(msg->op) {
+			case OP_CREATE:
+				err = ltt_control(LTT_CONTROL_CREATE_TRACE,
+						msg->trace_name,
+						msg->trace_type, msg->args);
+				break;
+			case OP_DESTROY:
+				err = ltt_control(LTT_CONTROL_DESTROY_TRACE,
+						msg->trace_name,
+						msg->trace_type, msg->args);
+				break;
+			case OP_START:
+				err = ltt_control(LTT_CONTROL_START,
+						msg->trace_name,
+						msg->trace_type, msg->args);
+				break;
+			case OP_STOP:
+				err = ltt_control(LTT_CONTROL_STOP,
+						msg->trace_name,
+						msg->trace_type, msg->args);
+				break;
+			default:
+				err = EBADRQC;
+				printk(KERN_INFO 
+					"ltt-control invalid operation\n");
+		}
+		netlink_ack(skb, nlh, err);
+		kfree_skb(skb);
+	}
+}
+
+
+static int ltt_control_init(void)
+{
+	printk(KERN_INFO "ltt-control init\n");
+
+	socket = netlink_kernel_create(NETLINK_LTT, 1,
+			ltt_control_input, THIS_MODULE);
+	if(socket == NULL) return -EPERM;
+	else return 0;
+}
+
+static void ltt_control_exit(void)
+{
+	printk(KERN_INFO "ltt-control exit\n");
+	sock_release(socket->sk_socket);
+}
+
+
+module_init(ltt_control_init)
+module_exit(ltt_control_exit)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mathieu Desnoyers");
+MODULE_DESCRIPTION("Linux Trace Toolkit Controller");
+
diff --git a/ltt/ltt-control.h b/ltt/ltt-control.h
new file mode 100644
index 0000000..15c9e16
--- /dev/null
+++ b/ltt/ltt-control.h
@@ -0,0 +1,31 @@
+/* ltt-control.h
+ *
+ * LTT control module over a netlink socket.
+ *
+ * Inspired from Relay Apps, by Tom Zanussi and iptables
+ *
+ * Copyright 2005 -
+ * 	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
+ */
+
+#ifndef _LTT_CONTROL_H
+#define _LTT_CONTROL_H
+
+enum trace_op {
+	OP_CREATE,
+	OP_DESTROY,
+	OP_START,
+	OP_STOP,
+	OP_ALIGN,
+	OP_NONE
+};
+
+typedef struct lttctl_peer_msg {
+	char trace_name[NAME_MAX];
+	char trace_type[NAME_MAX];
+	enum trace_op op;
+	union ltt_control_args args;
+} lttctl_peer_msg_t;
+
+#endif //_LTT_CONTROL_H
+
diff --git a/ltt/ltt-core.c b/ltt/ltt-core.c
new file mode 100644
index 0000000..2aa723d
--- /dev/null
+++ b/ltt/ltt-statedump.c
@@ -0,0 +1,327 @@
+/* ltt-state-dump.c
+ *
+ * Lunix Trace Toolkit Kernel State Dump
+ *
+ * Copyright 2005 -
+ * Jean-Hugues Deschenes <jean-hugues.deschenes@polymtl.ca>
+ *
+ * Changes:
+ *     Eric Clement:            add listing of network IP interface
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/ltt-core.h>
+#include <linux/netlink.h>
+#include <linux/inet.h>
+#include <linux/ip.h>
+#include <linux/kthread.h>
+#include <linux/proc_fs.h>
+#include <linux/file.h>
+#include <linux/interrupt.h>
+#ifndef CONFIG_ARM
+#include <linux/irq.h>
+#endif //CONFIG_ARM
+#include <linux/cpu.h>
+#include <linux/netdevice.h>
+#include <linux/inetdevice.h>
+#include <linux/ltt/ltt-facility-statedump.h>
+
+#define NB_PROC_CHUNK 20
+
+/* in modules.c */
+extern int ltt_enumerate_modules(void);
+
+static void ltt_enumerate_device(struct net_device *dev)
+{
+	struct in_device *in_dev;
+	struct in_ifaddr *ifa;
+
+	if(dev->flags & IFF_UP) {	
+		in_dev = in_dev_get(dev);
+		if(in_dev) {
+			for (ifa = in_dev->ifa_list;
+					ifa != NULL;
+					ifa = ifa->ifa_next) {
+				trace_statedump_enumerate_network_ip_interface(
+					dev->name, ifa->ifa_address, LTTNG_UP);
+			}
+			in_dev_put(in_dev);		
+		}
+	} else {
+		trace_statedump_enumerate_network_ip_interface(dev->name,
+					0, LTTNG_DOWN);
+	}
+}
+
+static inline int ltt_enumerate_network_ip_interface(void)
+{
+	struct net_device *list;
+	
+	read_lock(&dev_base_lock);
+	for(list=dev_base; list != NULL; list=list->next)
+		ltt_enumerate_device(list);
+	read_unlock(&dev_base_lock);
+	
+	return 0;
+}
+
+static inline void ltt_enumerate_task_fd(struct task_struct *t,
+		char *tmp)
+{
+	struct fdtable *fdt;
+	struct file * filp;
+	unsigned int i;
+  char *path;
+
+	if (!t->files) return;
+
+	spin_lock(&t->files->file_lock);
+	fdt = files_fdtable(t->files);
+	for (i=0; i < fdt->max_fds; i++) {
+		filp = fcheck_files(t->files, i);
+		if (!filp) continue;
+		path = d_path(filp->f_dentry,
+				filp->f_vfsmnt, tmp, PAGE_SIZE);
+		/* Make sure we give at least some info */
+		if(IS_ERR(path))
+			trace_statedump_enumerate_file_descriptors(
+				filp->f_dentry->d_name.name, t->pid, i);
+		else
+			trace_statedump_enumerate_file_descriptors(
+					path, t->pid, i);
+	}
+	spin_unlock(&t->files->file_lock);
+}
+
+static inline int ltt_enumerate_file_descriptors(void)
+{
+	struct task_struct * t = &init_task;
+	char *tmp = (char*)__get_free_page(GFP_KERNEL);
+
+	/* Enumerate active file descriptors */
+	do {
+		read_lock(&tasklist_lock);
+		if(t != &init_task) atomic_dec(&t->usage);
+		t = next_task(t);
+		atomic_inc(&t->usage);
+		read_unlock(&tasklist_lock);
+		task_lock(t);
+		ltt_enumerate_task_fd(t, tmp);
+		task_unlock(t);
+	} while( t != &init_task );
+	free_page((unsigned long)tmp);
+	return 0;
+}
+
+static inline void ltt_enumerate_task_vm_maps(struct task_struct *t)
+{
+	struct mm_struct *mm;
+	struct vm_area_struct *	map;
+	unsigned long ino;
+
+	/* get_task_mm does a task_lock... */
+	mm = get_task_mm(t);
+	if(!mm) return;
+
+	map = mm->mmap;
+	if(map) {
+		down_read(&mm->mmap_sem);
+		while (map) {
+			if (map->vm_file) ino =
+				map->vm_file->f_dentry->d_inode->i_ino;
+			else ino = 0;
+			trace_statedump_enumerate_vm_maps(
+					t->pid,
+					(void *)map->vm_start,
+					(void *)map->vm_end,
+					map->vm_flags,
+					map->vm_pgoff << PAGE_SHIFT,
+					ino);
+			map = map->vm_next;
+		}
+		up_read(&mm->mmap_sem);
+	}
+	mmput(mm);
+}
+
+static inline int ltt_enumerate_vm_maps(void)
+{
+	struct task_struct *  t = &init_task;
+	
+	do {
+		read_lock(&tasklist_lock);
+		if(t != &init_task) atomic_dec(&t->usage);
+		t = next_task(t);
+		atomic_inc(&t->usage);
+		read_unlock(&tasklist_lock);
+		ltt_enumerate_task_vm_maps(t);
+ 	} while( t != &init_task );
+	return 0;
+}
+
+#if defined( CONFIG_ARM )
+/* defined in arch/arm/kernel/irq.c because of dependency on statically-defined
+ * lock & irq_desc */
+int ltt_enumerate_interrupts(void);
+#else
+static inline int ltt_enumerate_interrupts(void)
+{
+	unsigned int i;
+	unsigned long flags = 0;
+
+	/* needs irq_desc */
+	for(i=0; i<NR_IRQS; i++) {
+		struct irqaction * action;
+
+		spin_lock_irqsave(&irq_desc[i].lock, flags);
+		for (action=irq_desc[i].action; action; action=action->next)
+			trace_statedump_enumerate_interrupts(
+				irq_desc[i].handler->typename,
+				action->name,
+				i);
+		spin_unlock_irqrestore(&irq_desc[i].lock, flags);
+	}
+	
+	return 0;
+}
+#endif
+
+static inline int ltt_enumerate_process_states(void)
+{
+	struct task_struct *t = &init_task;
+	struct task_struct *p = t;
+	enum lttng_process_status status;
+	enum lttng_thread_type type;
+	enum lttng_execution_mode mode;
+	enum lttng_execution_submode submode;
+	
+	do {
+		mode = LTTNG_MODE_UNKNOWN;
+		submode = LTTNG_UNKNOWN;
+
+		read_lock(&tasklist_lock);
+		if(t != &init_task) {
+			atomic_dec(&t->usage);
+			t = next_thread(t);
+		}
+		if(t == p) {
+			t = p = next_task(t);
+		}
+		atomic_inc(&t->usage);
+		read_unlock(&tasklist_lock);
+		
+		task_lock(t);
+		
+		if(t->exit_state == EXIT_ZOMBIE)
+			status = LTTNG_ZOMBIE;
+		else if(t->exit_state == EXIT_DEAD)
+			status = LTTNG_DEAD;
+		else if(t->state == TASK_RUNNING) {
+			/* Is this a forked child that has not run yet? */
+			if( list_empty(&t->run_list) )
+				status = LTTNG_WAIT_FORK;
+			else
+				/* All tasks are considered as wait_cpu;
+				 * the viewer will sort out if the task was
+				 * relly running at this time. */
+				status = LTTNG_WAIT_CPU;
+		}
+		else if(t->state & 
+			(TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE)) {
+			/* Task is waiting for something to complete */
+			status = LTTNG_WAIT;
+		}
+		else status = LTTNG_UNNAMED;
+		submode = LTTNG_NONE;
+
+		/* Verification of t->mm is to filter out kernel threads;
+		 * Viewer will further filter out if a user-space thread was
+		 * in syscall mode or not */
+		if(t->mm) type = LTTNG_USER_THREAD;
+		else type = LTTNG_KERNEL_THREAD;
+			
+		trace_statedump_enumerate_process_state(
+				t->pid, t->parent->pid, t->comm,
+				type, mode, submode, status, t->tgid);
+		task_unlock(t);
+	} while( t != &init_task );
+
+	return 0;
+}
+
+void ltt_statedump_work_func(void *sem)
+{
+	/* Our job is just to release the semaphore so
+	 * that we are sure that each CPU has been in syscall
+	 * mode before the end of ltt_statedump_thread */
+	up((struct semaphore *)sem);
+}
+
+static struct work_struct cpu_work[NR_CPUS];
+
+int ltt_statedump_thread(void *data)
+{
+	struct semaphore work_sema4;
+	int cpu;
+
+	printk(KERN_DEBUG "ltt_statedump_thread\n");
+ 	ltt_enumerate_process_states();
+	ltt_enumerate_file_descriptors();
+	ltt_enumerate_modules();
+	ltt_enumerate_vm_maps();
+	ltt_enumerate_interrupts();
+	ltt_enumerate_network_ip_interface();
+	
+	/* Fire off a work queue on each CPU. Their sole purpose in life
+	 * is to guarantee that each CPU has been in a state where is was in
+	 * syscall mode (i.e. not in a trap, an IRQ or a soft IRQ) */
+	sema_init(&work_sema4, 1 - num_online_cpus());
+	lock_cpu_hotplug();
+	for_each_online_cpu(cpu)
+	{
+		INIT_WORK(&cpu_work[cpu], ltt_statedump_work_func, &work_sema4);
+		schedule_delayed_work_on(cpu,&cpu_work[cpu],0);
+	}
+	unlock_cpu_hotplug();
+	/* Wait for all work queues to have completed */
+	down(&work_sema4);
+	/* Our work is done */
+	printk(KERN_DEBUG "trace_statedump_statedump_end\n");
+	trace_statedump_statedump_end();
+	do_exit(0);
+	return 0;
+}
+
+int ltt_statedump_start(struct ltt_trace_struct *trace)
+{
+	printk(KERN_DEBUG "ltt_statedump_start\n");
+	kthread_run(ltt_statedump_thread,
+		NULL, "ltt_statedump");
+	return 0;
+}
+
+/* Dynamic facility. */
+static int __init statedump_init(void)
+{
+	int ret;
+	printk(KERN_INFO "LTT : ltt-facility-statedump init\n");
+	ret = ltt_module_register(LTT_FUNCTION_STATEDUMP,
+			ltt_statedump_start,THIS_MODULE);
+	return ret;
+}
+
+static void __exit statedump_exit(void)
+{
+	printk(KERN_INFO "LTT : ltt-facility-statedump exit\n");
+	ltt_module_unregister(LTT_FUNCTION_STATEDUMP);
+}
+
+module_init(statedump_init)
+module_exit(statedump_exit)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jean-Hugues Deschenes");
+MODULE_DESCRIPTION("Linux Trace Toolkit Statedump");
+
diff --git a/mm/filemap.c b/mm/filemap.c
index fd57442..a09e392 100644

--=_Krystal-28273-1156979861-0001-2--
