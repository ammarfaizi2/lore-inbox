Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267493AbSLRW1u>; Wed, 18 Dec 2002 17:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267534AbSLRW1u>; Wed, 18 Dec 2002 17:27:50 -0500
Received: from air-2.osdl.org ([65.172.181.6]:9381 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267493AbSLRW1o>;
	Wed, 18 Dec 2002 17:27:44 -0500
Subject: [PATCH] (3/5) improved notifier callback mechanism - use lists
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1040250936.14358.198.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 18 Dec 2002 14:35:36 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts the notifier interface from a single linked list to
using the standard kernel doubly-linked list interface.  The parameters
to notifier_chain_register/unregister changed from being
pointer-to-pointer to notifier_block to pointer list_head.

There is no change in functionality of notifiers, it just makes changing
to RCU easier.

diff -Nru a/arch/i386/kernel/profile.c b/arch/i386/kernel/profile.c
--- a/arch/i386/kernel/profile.c	Wed Dec 18 09:36:46 2002
+++ b/arch/i386/kernel/profile.c	Wed Dec 18 09:36:46 2002
@@ -11,7 +11,7 @@
 #include <linux/irq.h>
 #include <asm/hw_irq.h> 
  
-static struct notifier_block * profile_listeners;
+static LIST_HEAD(profile_listeners);
 static rwlock_t profile_lock = RW_LOCK_UNLOCKED;
  
 int register_profile_notifier(struct notifier_block * nb)
diff -Nru a/arch/x86_64/kernel/traps.c b/arch/x86_64/kernel/traps.c
--- a/arch/x86_64/kernel/traps.c	Wed Dec 18 09:36:46 2002
+++ b/arch/x86_64/kernel/traps.c	Wed Dec 18 09:36:46 2002
@@ -75,7 +75,7 @@
 
 extern int exception_trace;
 
-struct notifier_block *die_chain;
+LIST_HEAD(die_chain);
 
 static int kstack_depth_to_print = 10;
 
diff -Nru a/include/asm-x86_64/kdebug.h b/include/asm-x86_64/kdebug.h
--- a/include/asm-x86_64/kdebug.h	Wed Dec 18 09:03:09 2002
+++ b/include/asm-x86_64/kdebug.h	Wed Dec 18 09:03:09 2002
@@ -11,7 +11,7 @@
 	long err; 
 }; 
 
-extern struct notifier_block *die_chain;
+extern LIST_HEAD(die_chain);
 
 /* Grossly misnamed. */
 enum die_val { 
diff -Nru a/include/linux/notifier.h b/include/linux/notifier.h
--- a/include/linux/notifier.h	Wed Dec 18 09:03:09 2002
+++ b/include/linux/notifier.h	Wed Dec 18 09:03:09 2002
@@ -9,21 +9,22 @@
  
 #ifndef _LINUX_NOTIFIER_H
 #define _LINUX_NOTIFIER_H
-#include <linux/errno.h>
 
-struct notifier_block
-{
-	int (*notifier_call)(struct notifier_block *self, unsigned long, void
*);
-	struct notifier_block *next;
+#include <linux/list.h>
+
+struct notifier_block {
+	int (*notifier_call)(struct notifier_block *, unsigned long, void *);
 	int priority;
+
+	struct list_head link;
 };
 
 
 #ifdef __KERNEL__
 
-extern int notifier_chain_register(struct notifier_block **list, struct
notifier_block *n);
-extern int notifier_chain_unregister(struct notifier_block **nl, struct
notifier_block *n);
-extern int notifier_call_chain(struct notifier_block **n, unsigned long
val, void *v);
+extern int notifier_chain_register(struct list_head *, struct
notifier_block *);
+extern int notifier_chain_unregister(struct list_head *, struct
notifier_block *);
+extern int notifier_call_chain(struct list_head *, unsigned long, void
*);
 
 extern int register_panic_notifier(struct notifier_block *);
 extern int unregister_panic_notifier(struct notifier_block *);
diff -Nru a/kernel/cpu.c b/kernel/cpu.c
--- a/kernel/cpu.c	Wed Dec 18 09:03:09 2002
+++ b/kernel/cpu.c	Wed Dec 18 09:03:09 2002
@@ -13,7 +13,7 @@
 /* This protects CPUs going up and down... */
 DECLARE_MUTEX(cpucontrol);
 
-static struct notifier_block *cpu_chain = NULL;
+static LIST_HEAD(cpu_chain);
 
 /* Need to know about CPUs going up/down? */
 int register_cpu_notifier(struct notifier_block *nb)
diff -Nru a/kernel/cpufreq.c b/kernel/cpufreq.c
--- a/kernel/cpufreq.c	Wed Dec 18 09:03:09 2002
+++ b/kernel/cpufreq.c	Wed Dec 18 09:03:09 2002
@@ -48,8 +48,8 @@
  * and cpufreq_notifier_sem need to be hold, get cpufreq_driver_sem
  * first.
  */
-static struct notifier_block    *cpufreq_policy_notifier_list;
-static struct notifier_block    *cpufreq_transition_notifier_list;
+static LIST_HEAD(cpufreq_policy_notifier_list);
+static LIST_HEAD(cpufreq_transition_notifier_list);
 static DECLARE_MUTEX            (cpufreq_notifier_sem);
 
 
diff -Nru a/kernel/panic.c b/kernel/panic.c
--- a/kernel/panic.c	Wed Dec 18 09:03:09 2002
+++ b/kernel/panic.c	Wed Dec 18 09:03:09 2002
@@ -14,6 +14,7 @@
 #include <linux/reboot.h>
 #include <linux/notifier.h>
 #include <linux/init.h>
+#include <linux/errno.h>
 #include <linux/sysrq.h>
 #include <linux/interrupt.h>
 
@@ -21,7 +22,7 @@
 
 int panic_timeout;
 
-static struct notifier_block *panic_notifier_list;
+static LIST_HEAD(panic_notifier_list);
 
 int register_panic_notifier(struct notifier_block * nb)
 {
diff -Nru a/kernel/profile.c b/kernel/profile.c
--- a/kernel/profile.c	Wed Dec 18 09:03:09 2002
+++ b/kernel/profile.c	Wed Dec 18 09:03:09 2002
@@ -48,9 +48,9 @@
 #ifdef CONFIG_PROFILING
  
 static DECLARE_RWSEM(profile_rwsem);
-static struct notifier_block * exit_task_notifier;
-static struct notifier_block * exit_mmap_notifier;
-static struct notifier_block * exec_unmap_notifier;
+static LIST_HEAD(exit_task_notifier);
+static LIST_HEAD(exit_mmap_notifier);
+static LIST_HEAD(exec_unmap_notifier);
  
 void profile_exit_task(struct task_struct * task)
 {
diff -Nru a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c	Wed Dec 18 09:03:09 2002
+++ b/kernel/sys.c	Wed Dec 18 09:03:09 2002
@@ -77,8 +77,8 @@
  *	and the like. 
  */
 
-static struct notifier_block *reboot_notifier_list;
-rwlock_t notifier_lock = RW_LOCK_UNLOCKED;
+static LIST_HEAD(reboot_notifier_list);
+static rwlock_t notifier_lock = RW_LOCK_UNLOCKED;
 
 /**
  *	notifier_chain_register	- Add notifier to a notifier chain
@@ -90,17 +90,20 @@
  *	Currently always returns zero.
  */
  
-int notifier_chain_register(struct notifier_block **list, struct
notifier_block *n)
+int notifier_chain_register(struct list_head *list, struct
notifier_block *n)
 {
+	struct list_head *p;
+
+	INIT_LIST_HEAD(&n->link);
 	write_lock(&notifier_lock);
-	while(*list)
-	{
-		if(n->priority > (*list)->priority)
+	list_for_each(p, list) {
+		struct notifier_block *e 
+			= list_entry(p, struct notifier_block, link);
+		if (n->priority > e->priority) 
 			break;
-		list= &((*list)->next);
 	}
-	n->next = *list;
-	*list=n;
+
+	list_add(&n->link, p);
 	write_unlock(&notifier_lock);
 	return 0;
 }
@@ -115,18 +118,17 @@
  *	Returns zero on success, or %-ENOENT on failure.
  */
  
-int notifier_chain_unregister(struct notifier_block **nl, struct
notifier_block *n)
+int notifier_chain_unregister(struct list_head *list, struct
notifier_block *n)
 {
+	struct list_head *cur;
+
 	write_lock(&notifier_lock);
-	while((*nl)!=NULL)
-	{
-		if((*nl)==n)
-		{
-			*nl=n->next;
+	list_for_each(cur, list) {
+		if (n == list_entry(cur, struct notifier_block, link)) {
+			list_del(cur);
 			write_unlock(&notifier_lock);
 			return 0;
 		}
-		nl=&((*nl)->next);
 	}
 	write_unlock(&notifier_lock);
 	return -ENOENT;
@@ -148,20 +150,21 @@
  *	of the last notifier function called.
  */
  
-int notifier_call_chain(struct notifier_block **n, unsigned long val,
void *v)
+int notifier_call_chain(struct list_head *list, unsigned long val, void
*v)
 {
-	int ret=NOTIFY_DONE;
-	struct notifier_block *nb = *n;
+	struct list_head *p;
+	int ret = NOTIFY_DONE;
 
-	while(nb)
-	{
-		ret=nb->notifier_call(nb,val,v);
-		if(ret&NOTIFY_STOP_MASK)
-		{
-			return ret;
-		}
-		nb=nb->next;
+	list_for_each(p, list) {
+		struct notifier_block *nb =
+			list_entry(p, struct notifier_block, link);
+
+		ret = nb->notifier_call(nb,val,v);
+		if (ret & NOTIFY_STOP_MASK) 
+			goto end_loop;
 	}
+
+ end_loop:
 	return ret;
 }
 
@@ -195,6 +198,8 @@
 {
 	return notifier_chain_unregister(&reboot_notifier_list, nb);
 }
+
+
 
 asmlinkage long sys_ni_syscall(void)
 {
diff -Nru a/net/core/dev.c b/net/core/dev.c
--- a/net/core/dev.c	Wed Dec 18 09:03:09 2002
+++ b/net/core/dev.c	Wed Dec 18 09:03:09 2002
@@ -188,7 +188,7 @@
  *	Our notifier list
  */
 
-static struct notifier_block *netdev_chain;
+static LIST_HEAD(netdev_chain);
 
 /*
  *	Device drivers call our routines to queue packets here. We empty the
diff -Nru a/net/ipv4/devinet.c b/net/ipv4/devinet.c
--- a/net/ipv4/devinet.c	Wed Dec 18 09:03:09 2002
+++ b/net/ipv4/devinet.c	Wed Dec 18 09:03:09 2002
@@ -78,7 +78,7 @@
 
 static void rtmsg_ifa(int event, struct in_ifaddr *);
 
-static struct notifier_block *inetaddr_chain;
+static LIST_HEAD(inetaddr_chain);
 static void inet_del_ifa(struct in_device *in_dev, struct in_ifaddr
**ifap,
 			 int destroy);
 #ifdef CONFIG_SYSCTL
diff -Nru a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
--- a/net/ipv6/addrconf.c	Wed Dec 18 09:03:09 2002
+++ b/net/ipv6/addrconf.c	Wed Dec 18 09:03:09 2002
@@ -106,7 +106,7 @@
 static void addrconf_rs_timer(unsigned long data);
 static void ipv6_ifa_notify(int event, struct inet6_ifaddr *ifa);
 
-static struct notifier_block *inet6addr_chain;
+static LIST_HEAD(inet6addr_chain);
 
 struct ipv6_devconf ipv6_devconf =
 {
diff -Nru a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
--- a/net/netlink/af_netlink.c	Wed Dec 18 09:03:09 2002
+++ b/net/netlink/af_netlink.c	Wed Dec 18 09:03:09 2002
@@ -83,7 +83,7 @@
 static rwlock_t nl_table_lock = RW_LOCK_UNLOCKED;
 static atomic_t nl_table_users = ATOMIC_INIT(0);
 
-static struct notifier_block *netlink_chain;
+static LIST_HEAD(netlink_chain);
 
 static void netlink_sock_destruct(struct sock *sk)
 {



