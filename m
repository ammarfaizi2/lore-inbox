Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbVGFEpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbVGFEpa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 00:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbVGFEp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 00:45:29 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:13721 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262088AbVGFCTk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:40 -0400
Subject: [PATCH] [43/48] Suspend2 2.1.9.8 for 2.6.12: 619-userspace-nofreeze.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:44 +1000
Message-Id: <1120616444351@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 620-userui-header.patch-old/include/linux/netlink.h 620-userui-header.patch-new/include/linux/netlink.h
--- 620-userui-header.patch-old/include/linux/netlink.h	2005-06-20 11:47:29.000000000 +1000
+++ 620-userui-header.patch-new/include/linux/netlink.h	2005-07-04 23:14:19.000000000 +1000
@@ -14,6 +14,7 @@
 #define NETLINK_SELINUX		7	/* SELinux event notifications */
 #define NETLINK_ARPD		8
 #define NETLINK_AUDIT		9	/* auditing */
+#define NETLINK_SUSPEND2_USERUI	10	/* For suspend2's userui */
 #define NETLINK_ROUTE6		11	/* af_inet6 route comm channel */
 #define NETLINK_IP6_FW		13
 #define NETLINK_DNRTMSG		14	/* DECnet routing messages */
diff -ruNp 620-userui-header.patch-old/kernel/power/suspend2_core/ui.c 620-userui-header.patch-new/kernel/power/suspend2_core/ui.c
--- 620-userui-header.patch-old/kernel/power/suspend2_core/ui.c	1970-01-01 10:00:00.000000000 +1000
+++ 620-userui-header.patch-new/kernel/power/suspend2_core/ui.c	2005-07-05 23:48:59.000000000 +1000
@@ -0,0 +1,1186 @@
+/*
+ * kernel/power/ui.c
+ *
+ * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu>
+ * Copyright (C) 1998,2001,2002 Pavel Machek <pavel@suse.cz>
+ * Copyright (C) 2002-2003 Florent Chabaud <fchabaud@free.fr>
+ * Copyright (C) 2002-2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * Routines for Software Suspend's user interface.
+ *
+ * The user interface code talks to a userspace program via a
+ * netlink socket.
+ *
+ * The kernel side:
+ * - starts the userui program;
+ * - sends text messages and progress bar status;
+ *
+ * The user space side:
+ * - passes messages regarding user requests (abort, toggle reboot etc)
+ *
+ */
+#define SUSPEND_CONSOLE_C
+
+#define __KERNEL_SYSCALLS__
+
+#include <linux/suspend.h>
+#include <linux/console.h>
+#include <linux/ctype.h>
+#include <linux/tty.h>
+#include <linux/vt_kern.h>
+#include <linux/module.h>
+#include <linux/reboot.h>
+#include <linux/kmod.h>
+#include <linux/netlink.h>
+#include <linux/security.h>
+#include <linux/syscalls.h>
+#include <net/sock.h>
+ 
+#include "proc.h"
+#include "plugins.h"
+#include "suspend.h"
+#include "suspend2_common.h"
+#include "ui.h"
+#include "version.h"
+#include "userui.h"
+
+#include "../power.h"
+
+static struct suspend_plugin_ops userui_ops;
+static int orig_loglevel;
+static int orig_default_message_loglevel;
+static int orig_kmsg;
+
+static char local_printf_buf[1024];	/* Same as printk - should be safe */
+static char lastheader[512];
+static int lastheader_message_len = 0;
+
+#define NUM_USERUI_SKBS 16 /* Number of preallocated skbs for emergencies */
+
+static char userui_program[256] = "";
+
+/* Number of distinct progress amounts that userspace can display */
+static int progress_granularity = 50;
+
+static struct sock *userui_nl;
+static u32 userui_sock_seq;
+static struct sk_buff *userui_skbs[NUM_USERUI_SKBS];
+static int next_free_userui_skb;
+static pid_t userui_pid = -1;
+
+DECLARE_WAIT_QUEUE_HEAD(userui_wait_for_process);
+DECLARE_WAIT_QUEUE_HEAD(userui_wait_for_key);
+
+void s2_userui_message(unsigned long section, unsigned long level,
+		int normally_logged,
+		const char *fmt, va_list args);
+unsigned long userui_update_progress(unsigned long value, unsigned long maximum,
+		const char *fmt, va_list args);
+void userui_prepare_console(void);
+void userui_cleanup_console(void);
+
+/* 
+ * Refill our pool of SKBs for use in emergencies (eg, when eating memory and none
+ * can be allocated).
+ */
+static void userui_replenish_skbs(void)
+{
+	while (next_free_userui_skb+1 < NUM_USERUI_SKBS) {
+		userui_skbs[next_free_userui_skb+1] =
+			alloc_skb(NLMSG_SPACE(sizeof(struct userui_msg_params)), GFP_ATOMIC);
+		if (userui_skbs[next_free_userui_skb+1])
+			next_free_userui_skb++;
+		else
+			break;
+	}
+}
+
+/* 
+ * Return a single skbuff either from our pool, or try to allocate one if
+ * the pool is exhausted.
+ */
+static struct sk_buff * userui_get_skb(void)
+{
+	struct sk_buff *skb;
+	if (next_free_userui_skb == -1)
+		skb = alloc_skb(NLMSG_SPACE(sizeof(struct userui_msg_params)), GFP_ATOMIC);
+	else {
+		skb = userui_skbs[next_free_userui_skb];
+		userui_skbs[next_free_userui_skb] = NULL;
+		next_free_userui_skb--;
+	}
+
+	userui_replenish_skbs();
+
+	return skb;
+}
+
+static void userui_notify_userspace(void* data)
+{
+	struct task_struct *t;
+	read_lock(&tasklist_lock);
+	if ((t = find_task_by_pid(userui_pid)))
+		wake_up_process(t);
+	read_unlock(&tasklist_lock);
+}
+
+DECLARE_WORK(userui_notify_userspace_work, userui_notify_userspace, NULL);
+
+static void userui_send_message(int type, void* params, size_t len)
+{
+	struct sk_buff *skb;
+	struct nlmsghdr *nlh;
+	void *dest;
+
+	skb = userui_get_skb();
+	if (!skb) {
+		printk("suspend_userui: Can't allocate skb!\n");
+		return;
+	}
+
+	/* NLMSG_PUT contains a hidden goto nlmsg_failure */
+	nlh = NLMSG_PUT(skb, 0, userui_sock_seq, type, len);
+	userui_sock_seq++;
+
+	dest = NLMSG_DATA(nlh);
+	if (params && len > 0)
+		memcpy(dest, params, len);
+
+	netlink_unicast(userui_nl, skb, userui_pid, 0);
+
+	/* We may be in an interrupt context so defer waking up userspace */
+	schedule_work(&userui_notify_userspace_work);
+
+	return;
+
+nlmsg_failure:
+	if (skb)
+		kfree_skb(skb);
+}
+
+/*
+ * Set the PF_NOFREEZE flag on the given process to ensure it can run whilst we
+ * are suspending.
+ */
+static int userui_nl_set_nofreeze(int pid)
+{
+	struct task_struct *t;
+	userui_pid = pid;
+
+	read_lock(&tasklist_lock);
+	if ((t = find_task_by_pid(userui_pid)) == NULL) {
+		read_unlock(&tasklist_lock);
+		return -EINVAL;
+	}
+
+	t->flags |= PF_NOFREEZE;
+
+	read_unlock(&tasklist_lock);
+
+	userui_send_message(USERUI_MSG_NOFREEZE_ACK, NULL, 0);
+
+	return 0;
+}
+
+#if CONFIG_PM_DEBUG
+static int is_debugging = 1;
+#else
+static int is_debugging = 0;
+#endif
+
+static void send_whether_debugging(void)
+{
+	userui_send_message(USERUI_MSG_IS_DEBUGGING, &is_debugging, sizeof(int));
+}
+
+/*
+ * Called when the userspace process has informed us that it's ready to roll.
+ */
+static int userui_nl_ready(int version)
+{
+	int ret = 0;
+	if (version != SUSPEND_USERUI_INTERFACE_VERSION) {
+		printk("suspend_userui: Userspace process using invalid interface version\n");
+		SET_RESULT_STATE(SUSPEND_ABORTED);
+		ret = -EINVAL;
+	}
+
+	wake_up_interruptible(&userui_wait_for_process);
+
+	return ret;
+}
+
+static int userui_nl_set_state(int n)
+{
+	/* Only let them change certain settings */
+	static const int suspend_action_mask =
+		(1 << SUSPEND_REBOOT) | (1 << SUSPEND_PAUSE) | (1 << SUSPEND_SLOW) |
+		(1 << SUSPEND_LOGALL) | (1 << SUSPEND_SINGLESTEP) |
+		(1 << SUSPEND_PAUSE_NEAR_PAGESET_END);
+
+	suspend_action = (suspend_action & (~suspend_action_mask)) |
+		(n & suspend_action_mask);
+
+	return 0;
+}
+
+static int userui_nl_set_progress_granularity(int n)
+{
+	if (n < 1) n = 1;
+	progress_granularity = n;
+	return 0;
+}
+
+static int userui_user_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh, int *errp)
+{
+	int type;
+	int *data;
+
+	*errp = 0;
+
+	if (!(nlh->nlmsg_flags & NLM_F_REQUEST))
+		return 0;
+
+	type = nlh->nlmsg_type;
+
+	/* A control message: ignore them */
+	if (type < USERUI_MSG_BASE)
+		return 0;
+
+	/* Unknown message: reply with EINVAL */
+	if (type >= USERUI_MSG_MAX) {
+		*errp = -EINVAL;
+		return -1;
+	}
+
+	/* All operations require privileges, even GET */
+	if (security_netlink_recv(skb)) {
+		*errp = -EPERM;
+		return -1;
+	}
+
+	/* Only allow one task to receive NOFREEZE privileges */
+	if (type == USERUI_MSG_NOFREEZE_ME && userui_pid != -1) {
+		*errp = -EBUSY;
+		return -1;
+	}
+
+	data = (int*)NLMSG_DATA(nlh);
+
+	switch (type) {
+		case USERUI_MSG_NOFREEZE_ME:
+			if ((*errp = userui_nl_set_nofreeze(nlh->nlmsg_pid)))
+				return -1;
+			break;
+		case USERUI_MSG_READY:
+			if (nlh->nlmsg_len < NLMSG_LENGTH(sizeof(int))) {
+				*errp = -EINVAL;
+				return -1;
+			}
+			if ((*errp = userui_nl_ready(*data)))
+				return -1;
+			break;
+		case USERUI_MSG_ABORT:
+			request_abort_suspend();
+			break;
+		case USERUI_MSG_GET_STATE:
+			userui_send_message(USERUI_MSG_GET_STATE, &suspend_action,
+					sizeof(suspend_action));
+			break;
+		case USERUI_MSG_SET_STATE:
+			if (nlh->nlmsg_len < NLMSG_LENGTH(sizeof(int))) {
+				*errp = -EINVAL;
+				return -1;
+			}
+			if ((*errp = userui_nl_set_state(*data)))
+				return -1;
+			break;
+		case USERUI_MSG_SET_PROGRESS_GRANULARITY:
+			if (nlh->nlmsg_len < NLMSG_LENGTH(sizeof(int))) {
+				*errp = -EINVAL;
+				return -1;
+			}
+			if ((*errp = userui_nl_set_progress_granularity(*data)))
+				return -1;
+			break;
+		case USERUI_MSG_SPACE:
+			wake_up_interruptible(&userui_wait_for_key);
+			break;
+		case USERUI_MSG_GET_DEBUGGING:
+			send_whether_debugging();
+			break;
+	}
+
+	return 0;
+}
+
+static int userui_user_rcv_skb(struct sk_buff *skb)
+{
+	int err;
+	struct nlmsghdr *nlh;
+
+	while (skb->len >= NLMSG_SPACE(0)) {
+		u32 rlen;
+
+		nlh = (struct nlmsghdr *) skb->data;
+		if (nlh->nlmsg_len < sizeof(*nlh) ||
+		    skb->len < nlh->nlmsg_len)
+			return 0;
+		rlen = NLMSG_ALIGN(nlh->nlmsg_len);
+		if (rlen > skb->len)
+			rlen = skb->len;
+		if (userui_user_rcv_msg(skb, nlh, &err) < 0) {
+			if (err == 0)
+				return -1;
+			netlink_ack(skb, nlh, err);
+		} else if (nlh->nlmsg_flags & NLM_F_ACK)
+			netlink_ack(skb, nlh, 0);
+		skb_pull(skb, rlen);
+	}
+
+	return 0;
+}
+
+static void userui_netlink_input(struct sock *sk, int len)
+{
+	do {
+		struct sk_buff *skb;
+		while ((skb = skb_dequeue(&sk->sk_receive_queue)) != NULL) {
+			if (userui_user_rcv_skb(skb)) {
+				if (skb->len)
+					skb_queue_head(&sk->sk_receive_queue, skb);
+				else
+					kfree_skb(skb);
+				break;
+			}
+			kfree_skb(skb);
+		}
+	} while (userui_nl && userui_nl->sk_receive_queue.qlen);
+}
+
+static int open_userui_netlink(void)
+{
+	int i;
+
+	userui_sock_seq = 0x42c0ffee;
+	userui_nl = netlink_kernel_create(NETLINK_SUSPEND2_USERUI, userui_netlink_input);
+	if (!userui_nl) {
+		printk("suspend_userui: Failed to allocate netlink socket.\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < NUM_USERUI_SKBS; i++)
+		userui_skbs[i] = NULL;
+
+	next_free_userui_skb = -1;
+
+	userui_replenish_skbs();
+
+	return 0;
+}
+
+static void close_userui_netlink(void)
+{
+	int i;
+
+	if (userui_nl) {
+		sock_release(userui_nl->sk_socket);
+		userui_nl = NULL;
+	}
+
+	for (i = 0; i < NUM_USERUI_SKBS; i++)
+		if (userui_skbs[i])
+			kfree_skb(userui_skbs[i]);
+}
+
+static int launch_userui_program(void)
+{
+	int retval;
+	static char *envp[] = {
+			"HOME=/",
+			"TERM=linux",
+			"PATH=/sbin:/usr/sbin:/bin:/usr/bin",
+			NULL };
+	static char *argv[] = { userui_program, NULL };
+
+	retval = call_usermodehelper(userui_program, argv, envp, 0);
+
+	if (retval)
+		printk("suspend_userui: Failed to launch userui program: Error %d\n", retval);
+
+	return retval;
+}
+
+static int wait_for_userui_contact(void) 
+{
+	DECLARE_WAITQUEUE(wait, current);
+
+	add_wait_queue(&userui_wait_for_process, &wait);
+	set_current_state(TASK_INTERRUPTIBLE);
+
+	/* Wait 2 seconds for the userspace UI process to make contact */
+	if (userui_pid == -1 && !TEST_RESULT_STATE(SUSPEND_ABORTED))
+		interruptible_sleep_on_timeout(&userui_wait_for_process, 2*HZ);
+
+	set_current_state(TASK_RUNNING);
+	remove_wait_queue(&userui_wait_for_process, &wait);
+
+	return 0;
+}
+
+void userui_redraw(void)
+{
+	if (userui_pid == -1)
+		return;
+
+	userui_send_message(USERUI_MSG_REDRAW, NULL, 0);
+}
+
+void userui_prepare_console(void)
+{
+	userui_pid = -1;
+
+	if (!*userui_program) {
+		printk("suspend_userui: userui_program not configured. suspend_userui disabled.\n");
+		return;
+	}
+
+	if (open_userui_netlink() < 0)
+		return;
+
+	if (launch_userui_program() < 0)
+		goto out_close;
+
+	if (wait_for_userui_contact() < 0)
+		goto out_close;
+
+	if (userui_pid == -1) {
+		printk("suspend_userui: Failed to contact userui process. suspend_userui disabled.\n");
+		goto out_close;
+	}
+
+	return;
+
+out_close:
+	close_userui_netlink();
+}
+
+void userui_cleanup_console(void)
+{
+	struct task_struct *t;
+
+	if (userui_pid == -1)
+		return;
+
+	userui_send_message(USERUI_MSG_CLEANUP, NULL, 0);
+
+	read_lock(&tasklist_lock);
+	if ((t = find_task_by_pid(userui_pid)))
+		t->flags &= ~PF_NOFREEZE;
+	read_unlock(&tasklist_lock);
+
+	close_userui_netlink();
+
+	userui_pid = -1;
+}
+
+static unsigned long userui_storage_needed(void)
+{
+	return sizeof(userui_program);
+}
+
+static int userui_save_config_info(char *buf)
+{
+	*((int *) buf) = progress_granularity;
+	memcpy(buf + sizeof(int), userui_program, sizeof(userui_program));
+	return sizeof(userui_program) + sizeof(int);
+}
+
+static void userui_load_config_info(char *buf, int size)
+{
+	/* Don't load the saved path if one has already been set */
+	if (userui_program[0])
+		return;
+
+	progress_granularity = *((int *) buf);
+	size -= sizeof(int);
+	
+	if (size > sizeof(userui_program))
+		size = sizeof(userui_program);
+
+	memcpy(userui_program, buf + sizeof(int), size);
+	userui_program[sizeof(userui_program)-1] = '\0';
+}
+
+static unsigned long userui_memory_needed(void)
+{
+	/* ball park figure of 128 pages */
+	return (128 * PAGE_SIZE);
+}
+
+unsigned long userui_update_progress(unsigned long value, unsigned long maximum,
+		const char *fmt, va_list args)
+{
+	static int last_step = -1;
+	struct userui_msg_params msg;
+	int bitshift = generic_fls(maximum) - 16;
+	int this_step;
+	unsigned long next_update;
+
+	if (userui_pid == -1)
+		return 0;
+
+	if ((!maximum) || (!progress_granularity))
+		return maximum;
+
+	if (value < 0)
+		value = 0;
+
+	if (value > maximum)
+		value = maximum;
+
+	/* Try to avoid math problems - we can't do 64 bit math here
+	 * (and shouldn't need it - anyone got screen resolution
+	 * of 65536 pixels or more?) */
+	if (bitshift > 0) {
+		unsigned long temp_maximum = maximum >> bitshift;
+		unsigned long temp_value = value >> bitshift;
+		this_step = (int) (temp_value * progress_granularity / temp_maximum);
+		next_update = (((this_step + 1) * temp_maximum / progress_granularity) + 1) << bitshift;
+	} else {
+		this_step = (int) (value * progress_granularity / maximum);
+		next_update = ((this_step + 1) * maximum / progress_granularity) + 1;
+	}
+
+	if (this_step == last_step)
+		return next_update;
+
+	memset(&msg, 0, sizeof(msg));
+
+	msg.a = this_step;
+	msg.b = progress_granularity;
+
+	if (fmt) {
+		vsnprintf(msg.text, sizeof(msg.text), fmt, args);
+		msg.text[sizeof(msg.text)-1] = '\0';
+	}
+
+	userui_send_message(USERUI_MSG_PROGRESS, &msg, sizeof(msg));
+	last_step = this_step;
+
+	return next_update;
+}
+
+/* __suspend_message.
+ *
+ * Description:	This function is intended to do the same job as printk, but
+ * 		without normally logging what is printed. The point is to be
+ * 		able to get debugging info on screen without filling the logs
+ * 		with "1/534. ^M 2/534^M. 3/534^M"
+ *
+ * 		It may be called from an interrupt context - can't sleep!
+ *
+ * Arguments:	int mask: The debugging section(s) this message belongs to.
+ * 		int level: The level of verbosity of this message.
+ * 		int restartline: Whether to output a \r or \n with this line
+ * 			(\n if we're logging all output).
+ * 		const char *fmt, ...: Message to be displayed a la printk.
+ */
+void __suspend_message(unsigned long section, unsigned long level,
+		int normally_logged,
+		const char *fmt, ...)
+{
+	struct userui_msg_params msg;
+
+	va_list args;
+
+	if ((level) && (level > console_loglevel))
+		return;
+
+	if (userui_pid == -1)
+		return;
+
+	memset(&msg, 0, sizeof(msg));
+
+	msg.a = section;
+	msg.b = level;
+	msg.c = normally_logged;
+
+	if (fmt) {
+		va_start(args, fmt);
+		vsnprintf(msg.text, sizeof(msg.text), fmt, args);
+		va_end(args);
+		msg.text[sizeof(msg.text)-1] = '\0';
+	}
+
+	userui_send_message(USERUI_MSG_MESSAGE, &msg, sizeof(msg));
+}
+
+static void wait_for_key_via_userui(void)
+{
+	DECLARE_WAITQUEUE(wait, current);
+
+	add_wait_queue(&userui_wait_for_key, &wait);
+	set_current_state(TASK_INTERRUPTIBLE);
+
+	interruptible_sleep_on(&userui_wait_for_key);
+
+	set_current_state(TASK_RUNNING);
+	remove_wait_queue(&userui_wait_for_key, &wait);
+}
+
+char suspend_wait_for_keypress(int timeout)
+{
+	int fd;
+	char key = '\0';
+	struct termios t, t_backup;
+
+	if (userui_pid != -1) {
+		wait_for_key_via_userui();
+		key = 32;
+		goto out;
+	}
+	
+	/* We should be guaranteed /dev/console exists after populate_rootfs() in
+	 * init/main.c
+	 */
+	if ((fd = sys_open("/dev/console", O_RDONLY, 0)) < 0)
+		goto out;
+
+	if (sys_ioctl(fd, TCGETS, (long)&t) < 0)
+		goto out_close;
+
+	memcpy(&t_backup, &t, sizeof(t));
+
+	t.c_lflag &= ~(ISIG|ICANON|ECHO);
+	t.c_cc[VMIN] = 0;
+	if (timeout)
+		t.c_cc[VTIME] = timeout*10;
+
+	if (sys_ioctl(fd, TCSETS, (long)&t) < 0)
+		goto out_restore;
+
+	while (1) {
+		if (sys_read(fd, &key, 1) <= 0) {
+			key = '\0';
+			break;
+		}
+		key = tolower(key);
+		if (test_suspend_state(SUSPEND_SANITY_CHECK_PROMPT)) {
+			if (key == 'c') {
+				set_suspend_state(SUSPEND_CONTINUE_REQ);
+				break;
+			} else if (key == ' ')
+				break;
+		} else
+			break;
+	}
+
+out_restore:
+	sys_ioctl(fd, TCSETS, (long)&t_backup);
+
+out_close:
+	sys_close(fd);
+out:
+	return key;
+}
+
+/* abort_suspend
+ *
+ * Description: Begin to abort a cycle. If this wasn't at the user's request
+ * 		(and we're displaying output), tell the user why and wait for
+ * 		them to acknowledge the message.
+ * Arguments:	A parameterised string (imagine this is printk) to display,
+ *	 	telling the user why we're aborting.
+ */
+
+void abort_suspend(const char *fmt, ...)
+{
+	va_list args;
+	int printed_len = 0;
+
+	if (!TEST_RESULT_STATE(SUSPEND_ABORTED)) {
+		if (!TEST_RESULT_STATE(SUSPEND_ABORT_REQUESTED)) {
+			va_start(args, fmt);
+			printed_len = vsnprintf(local_printf_buf, 
+					sizeof(local_printf_buf), fmt, args);
+			va_end(args);
+			if (userui_pid != -1)
+				printed_len = sprintf(local_printf_buf + printed_len,
+					" (Press SPACE to continue)");
+			suspend2_prepare_status(1, 1, local_printf_buf);
+
+			/* 
+			 * Make sure message seen - wait for shift to be
+			 * released if being pressed 
+			 */
+			if (userui_pid != -1)
+				suspend_wait_for_keypress(0);
+		}
+		/* Turn on aborting flag */
+		SET_RESULT_STATE(SUSPEND_ABORTED);
+	}
+}
+
+/* suspend2_prepare_status
+ * Description:	Prepare the 'nice display', drawing the header and version,
+ * 		along with the current action and perhaps also resetting the
+ * 		progress bar.
+ * Arguments:	int printalways: Whether to print the action when debugging
+ * 		is on.
+ * 		int clearbar: Whether to reset the progress bar.
+ * 		const char *fmt, ...: The action to be displayed.
+ */
+void suspend2_prepare_status(int printalways, int clearbar, const char *fmt, ...)
+{
+	va_list args;
+
+	if (fmt) {
+		va_start(args, fmt);
+		lastheader_message_len = vsnprintf(lastheader, 512, fmt, args);
+		va_end(args);
+	}
+
+	if (clearbar)
+		userui_update_progress(0, 1, NULL, NULL);
+
+	__suspend_message(0, SUSPEND_STATUS, 1, lastheader, NULL);
+
+	if (userui_pid == -1)
+		printk("%s\n", lastheader);
+}
+
+/* update_status
+ *
+ * Description: Update the progress bar and (if on) in-bar message.
+ * Arguments:	UL value, maximum: Current progress percentage (value/max).
+ * 		const char *fmt, ...: Message to be displayed in the middle
+ * 		of the progress bar.
+ * 		Note that a NULL message does not mean that any previous
+ * 		message is erased! For that, you need suspend2_prepare_status with
+ * 		clearbar on.
+ * Returns:	Unsigned long: The next value where status needs to be updated.
+ * 		This is to reduce unnecessary calls to update_status.
+ */
+unsigned long suspend2_update_status(unsigned long value, unsigned long maximum,
+		const char *fmt, ...)
+{
+	unsigned long next_update = maximum;
+	va_list args;
+
+	if (!maximum)
+		return maximum;
+
+	if (value < 0)
+		value = 0;
+
+	if (value > maximum)
+		value = maximum;
+
+	va_start(args, fmt);
+
+	next_update = userui_update_progress(value, maximum, fmt, args);
+
+	va_end(args);
+
+	return next_update;
+}
+
+static struct waiting_message
+{
+	int message;
+	struct waiting_message * next;
+} * waiting_messages = NULL;
+
+/* display_suspend_message
+ *
+ * Description:	Display a message as a result of the user pressing a key
+ * 		and the key being processed in an interrupt handler.
+ */
+
+int display_suspend_messages(void)
+{
+	int did_work = (waiting_messages != NULL);
+
+	while (waiting_messages) {
+		struct waiting_message * this_message = waiting_messages;
+
+		switch(waiting_messages->message) {
+			case 5:
+				suspend2_prepare_status(1, 1,
+					"--- ESCAPE PRESSED AGAIN :"
+					" TRYING HARDER TO ABORT ---");
+				break;
+			case 6:
+				suspend2_prepare_status(1, 1, "--- ESCAPE PRESSED :"
+						" ABORTING PROCESS ---");
+				break;
+		}
+
+		waiting_messages = this_message->next;
+		kfree(this_message);
+	}
+	return did_work;
+}
+
+/* suspend2_schedule_message
+ *
+ * Description:
+ * 
+ */
+
+void suspend2_schedule_message(int message_number)
+{
+	struct waiting_message * new_message =
+		kmalloc(sizeof(struct waiting_message), GFP_ATOMIC);
+
+	if (!new_message) {
+		printk("Argh. Unable to allocate memory for "
+				"scheduling the display of a message.\n");
+		return;
+	}
+
+	new_message->message = message_number;
+	new_message->next = waiting_messages;
+
+	waiting_messages = new_message;
+	return;
+}
+
+/* request_abort_suspend
+ *
+ * Description:	Handle the user requesting the cancellation of a suspend by
+ * 		pressing escape. Note that on a second press, we try a little
+ * 		harder, attempting to forcefully thaw processes. This shouldn't
+ * 		been needed, and may result in an oops (if we've overwritten
+ * 		memory), but has been useful on ocassion.
+ * Callers:	Invoked from a netlink packet from userspace when the user presses
+ *  	escape.
+ */
+void request_abort_suspend(void)
+{
+	if (test_suspend_state(SUSPEND_NOW_RESUMING) || (TEST_RESULT_STATE(SUSPEND_ABORT_REQUESTED)))
+		return;
+
+	if (TEST_RESULT_STATE(SUSPEND_ABORTED)) {
+		suspend2_schedule_message(5);
+		show_state();
+		thaw_processes(FREEZER_ALL_THREADS);
+	} else {
+		suspend2_schedule_message(6);
+		SET_RESULT_STATE(SUSPEND_ABORTED);
+		SET_RESULT_STATE(SUSPEND_ABORT_REQUESTED);
+	}
+}
+
+/* check_shift_keys
+ * 
+ * Description:	Potentially pause and wait for the user to tell us to continue.
+ * 		We normally only pause when @pause is set.
+ * Arguments:	int pause: Whether we normally pause.
+ * 		char * message: The message to display. Not parameterised
+ * 		 because it's normally a constant.
+ */
+
+void check_shift_keys(int pause, char * message)
+{
+#ifdef CONFIG_PM_DEBUG
+	int displayed_message = 0, last_key = 0;
+	
+	display_suspend_messages();
+	while (last_key != 32 &&
+		userui_pid != -1 &&
+		((TEST_ACTION_STATE(SUSPEND_PAUSE) && pause) || 
+		 (TEST_ACTION_STATE(SUSPEND_SINGLESTEP)))) {
+		if (!displayed_message) {
+			suspend2_prepare_status(1, 0, 
+			   "%s Press SPACE to continue.%s",
+			   message ? message : "",
+			   (TEST_ACTION_STATE(SUSPEND_SINGLESTEP)) ? 
+			   " Single step on." : "");
+			displayed_message = 1;
+		}
+		last_key = suspend_wait_for_keypress(0);
+		display_suspend_messages();
+	}
+#else
+	display_suspend_messages();
+#endif
+	schedule();
+}
+
+extern asmlinkage long sys_ioctl(unsigned int fd, unsigned int cmd, 
+		unsigned long arg);
+
+/* suspend2_prepare_console
+ *
+ * Description:	Prepare a console for use, save current settings.
+ * Returns:	Boolean: Whether an error occured. Errors aren't
+ * 		treated as fatal, but a warning is printed.
+ */
+int suspend2_prepare_console(void)
+{
+	orig_loglevel = console_loglevel;
+	orig_default_message_loglevel = default_message_loglevel;
+	orig_kmsg = kmsg_redirect;
+	kmsg_redirect = fg_console + 1;
+	default_message_loglevel = 1;
+	console_loglevel = suspend_default_console_level;
+	userui_prepare_console();
+
+	return 0;
+}
+
+/* suspend2_restore_console
+ *
+ * Description: Restore the settings we saved above.
+ */
+
+void suspend2_cleanup_console(void)
+{
+	userui_cleanup_console();
+	suspend_default_console_level = console_loglevel;
+	console_loglevel = orig_loglevel;
+	kmsg_redirect = orig_kmsg;
+	default_message_loglevel = orig_default_message_loglevel;
+}
+
+/* suspend_early_boot_message()
+ * Description:	Handle errors early in the process of booting.
+ * 		The user may press C to continue booting, perhaps
+ * 		invalidating the image,  or space to reboot. 
+ * 		This works from either the serial console or normally 
+ * 		attached keyboard.
+ *
+ * 		Note that we come in here from init, while the kernel is
+ * 		locked. If we want to get events from the serial console,
+ * 		we need to temporarily unlock the kernel.
+ *
+ * 		suspend_early_boot_message may also be called post-boot.
+ * 		In this case, it simply printks the message and returns.
+ *
+ * Arguments:	int	Whether we are able to erase the image.
+ * 		int	default_answer. What to do when we timeout. This
+ * 			will normally be continue, but the user might
+ * 			provide command line options (__setup) to override
+ * 			particular cases.
+ * 		Char *. Pointer to a string explaining why we're moaning.
+ */
+
+#define say(message, a...) printk(KERN_EMERG message, ##a)
+#define message_timeout 25 /* message_timeout * 10 must fit in 8 bits */
+
+int suspend_early_boot_message(int can_erase_image, int default_answer, char *warning_reason, ...)
+{
+	unsigned long orig_state = get_suspend_state(), continue_req = 0;
+	va_list args;
+	int printed_len;
+
+	if (warning_reason) {
+		va_start(args, warning_reason);
+		printed_len = vsnprintf(local_printf_buf, 
+				sizeof(local_printf_buf), 
+				warning_reason,
+				args);
+		va_end(args);
+	}
+
+	if (!test_suspend_state(SUSPEND_BOOT_TIME)) {
+		printk(name_suspend "%s", local_printf_buf);
+		return default_answer;
+	}
+
+	/* We might be called directly from do_mounts_initrd if the
+	 * user fails to set up their initrd properly. We need to
+	 * enable the keyboard handler by setting the running flag */
+	set_suspend_state(SUSPEND_RUNNING);
+
+#if defined(CONFIG_VT) || defined(CONFIG_SERIAL_CONSOLE)
+	console_loglevel = 7;
+
+	say("=== Software Suspend ===\n\n");
+	if (warning_reason) {
+		say("BIG FAT WARNING!! %s\n\n", local_printf_buf);
+		if (can_erase_image) {
+			say("If you want to use the current suspend image, reboot and try\n");
+			say("again with the same kernel that you suspended from. If you want\n");
+			say("to forget that image, continue and the image will be erased.\n");
+		} else {
+			say("If you continue booting, note that any image WILL NOT BE REMOVED.\n");
+			say("Suspend is unable to do so because the appropriate modules aren't\n");
+			say("loaded. You should manually remove the image to avoid any\n");
+			say("possibility of corrupting your filesystem(s) later.\n");
+		}
+		say("Press SPACE to reboot or C to continue booting with this kernel\n\n");
+		say("Default action if you don't select one in %d seconds is: %s.\n",
+			message_timeout,
+			default_answer == SUSPEND_CONTINUE_REQ ?
+			"continue booting" : "reboot");
+	} else {
+		say("BIG FAT WARNING!!\n\n");
+		say("You have tried to resume from this image before.\n");
+		say("If it failed once, may well fail again.\n");
+		say("Would you like to remove the image and boot normally?\n");
+		say("This will be equivalent to entering noresume2 on the\n");
+		say("kernel command line.\n\n");
+		say("Press SPACE to remove the image or C to continue resuming.\n\n");
+		say("Default action if you don't select one in %d seconds is: %s.\n",
+			message_timeout,
+			!!default_answer ?
+			"continue resuming" : "remove the image");
+	}
+	
+	set_suspend_state(SUSPEND_SANITY_CHECK_PROMPT);
+	clear_suspend_state(SUSPEND_CONTINUE_REQ);
+
+	if (suspend_wait_for_keypress(message_timeout) == 0) /* We timed out */
+		continue_req = !!default_answer;
+	else
+		continue_req = test_suspend_state(SUSPEND_CONTINUE_REQ);
+
+	if ((warning_reason) && (!continue_req))
+		machine_restart(NULL);
+	
+	restore_suspend_state(orig_state);
+	if (continue_req)
+		set_suspend_state(SUSPEND_CONTINUE_REQ);
+
+#endif // CONFIG_VT or CONFIG_SERIAL_CONSOLE
+	return -EPERM;
+}
+#undef say
+
+/*
+ * User interface specific /proc/suspend entries.
+ */
+
+static struct suspend_proc_data proc_params[] = {
+#ifdef CONFIG_PROC_FS
+	{ .filename			= "default_console_level",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_INTEGER,
+	  .data = {
+		  .integer = {
+			  .variable	= &suspend_default_console_level,
+			  .minimum	= 0,
+#ifdef CONFIG_PM_DEBUG
+			  .maximum	= 7,
+#else
+			  .maximum	= 1,
+#endif
+
+		  }
+	  }
+	},
+
+	{ .filename			= "enable_escape",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_BIT,
+	  .data = {
+		  .bit = {
+			  .bit_vector	= &suspend_action,
+			  .bit		= SUSPEND_CAN_CANCEL,
+		  }
+	  }
+	},
+
+#ifdef CONFIG_PM_DEBUG
+	{ .filename			= "debug_sections",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_UL,
+	  .data = {
+		  .ul = {
+			  .variable	= &suspend_debug_state,
+			  .minimum	= 0,
+			  .maximum	= 2 << 30,
+		  }
+	  }
+	},
+
+	{ .filename			= "log_everything",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_BIT,
+	  .data = {
+		  .bit = {
+			  .bit_vector	= &suspend_action,
+			  .bit		= SUSPEND_LOGALL,
+		  }
+	  }
+	},
+	  
+	{ .filename			= "pause_between_steps",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_BIT,
+	  .data = {
+		  .bit = {
+			  .bit_vector	= &suspend_action,
+			  .bit		= SUSPEND_PAUSE,
+		  }
+	  }
+	},
+#endif
+	{ .filename			= "disable_userui_support",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_INTEGER,
+	  .data = {
+		.integer = {
+			.variable	= &userui_ops.disabled,
+			.minimum	= 0,
+			.maximum	= 1,
+		}
+	  }
+	},
+	{ .filename			= "userui_progress_granularity",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_INTEGER,
+	  .data = {
+		.integer = {
+			.variable	= &progress_granularity,
+			.minimum	= 1,
+			.maximum	= 2048,
+		}
+	  }
+	},
+	{ .filename			= "userui_program",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_STRING,
+	  .data = {
+		.string = {
+			.variable	= userui_program,
+			.max_length	= 255,
+		}
+	  }
+	}
+#endif
+};
+
+static struct suspend_plugin_ops userui_ops = {
+	.type				= MISC_PLUGIN,
+	.name				= "Userspace UI Support",
+	.module				= THIS_MODULE,
+	.storage_needed			= userui_storage_needed,
+	.save_config_info		= userui_save_config_info,
+	.load_config_info		= userui_load_config_info,
+	.memory_needed			= userui_memory_needed,
+};
+
+/* suspend_console_proc_init
+ * Description: Boot time initialisation for user interface.
+ */
+static __init int suspend_console_proc_init(void)
+{
+	int result, i, numfiles = sizeof(proc_params) / sizeof(struct suspend_proc_data);
+
+	if (!(result = suspend_register_plugin(&userui_ops)))
+		for (i=0; i< numfiles; i++)
+			suspend_register_procfile(&proc_params[i]);
+
+	userui_nl = NULL;
+	userui_program[0] = '\0';
+
+	return result;
+}
+
+late_initcall(suspend_console_proc_init);
diff -ruNp 620-userui-header.patch-old/kernel/power/suspend2_core/ui.h 620-userui-header.patch-new/kernel/power/suspend2_core/ui.h
--- 620-userui-header.patch-old/kernel/power/suspend2_core/ui.h	1970-01-01 10:00:00.000000000 +1000
+++ 620-userui-header.patch-new/kernel/power/suspend2_core/ui.h	2005-07-04 23:14:19.000000000 +1000
@@ -0,0 +1,20 @@
+/*
+ *
+ */
+
+extern int suspend2_prepare_console(void);
+extern void suspend2_cleanup_console(void);
+
+extern void check_shift_keys(int pause, char * message);
+
+extern void suspend2_prepare_status(int printalways, int clearbar, const char *fmt, ...);
+extern void check_shift_keys(int pause, char * message);
+extern unsigned long suspend2_update_status(unsigned long value, unsigned long maximum,
+		const char *fmt, ...);
+
+extern void request_abort_suspend(void);
+extern void abort_suspend(const char *fmt, ...);
+
+extern void suspend2_schedule_message (int message_number);
+
+extern void userui_redraw(void);
diff -ruNp 620-userui-header.patch-old/kernel/power/suspend2_core/userui.h 620-userui-header.patch-new/kernel/power/suspend2_core/userui.h
--- 620-userui-header.patch-old/kernel/power/suspend2_core/userui.h	1970-01-01 10:00:00.000000000 +1000
+++ 620-userui-header.patch-new/kernel/power/suspend2_core/userui.h	2005-07-04 23:14:19.000000000 +1000
@@ -0,0 +1,36 @@
+#ifndef _SUSPEND_USERUI_H_
+#define _SUSPEND_USERUI_H_
+
+#define SUSPEND_USERUI_INTERFACE_VERSION 5
+
+enum {
+	USERUI_MSG_BASE = 0x10,
+
+	/* Userspace -> Kernel */
+	USERUI_MSG_READY = 0x10,
+	USERUI_MSG_ABORT = 0x11,
+	USERUI_MSG_SET_STATE = 0x12,
+	USERUI_MSG_GET_STATE = 0x13,
+	USERUI_MSG_NOFREEZE_ME = 0x16,
+	USERUI_MSG_SET_PROGRESS_GRANULARITY = 0x17,
+	USERUI_MSG_SPACE = 0x18,
+	USERUI_MSG_GET_DEBUGGING = 0x19,
+
+	/* Kernel -> Userspace */
+	USERUI_MSG_MESSAGE = 0x21,
+	USERUI_MSG_PROGRESS = 0x22,
+	USERUI_MSG_CLEANUP = 0x24,
+	USERUI_MSG_REDRAW = 0x25,
+	USERUI_MSG_KEYPRESS = 0x26,
+	USERUI_MSG_NOFREEZE_ACK = 0x27,
+	USERUI_MSG_IS_DEBUGGING = 0x28,
+
+	USERUI_MSG_MAX,
+};
+
+struct userui_msg_params {
+	unsigned long a, b, c, d;
+	char text[80];
+};
+
+#endif /* _SUSPEND_USERUI_H_ */

