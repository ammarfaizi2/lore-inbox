Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262886AbTC0GSO>; Thu, 27 Mar 2003 01:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262887AbTC0GSN>; Thu, 27 Mar 2003 01:18:13 -0500
Received: from dp.samba.org ([66.70.73.150]:41099 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262886AbTC0GSH>;
	Thu, 27 Mar 2003 01:18:07 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: John Levon <levon@movementarian.org>
Cc: oprofile-list@lists.sf.net, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Module load notification take 3 
In-reply-to: Your message of "Thu, 27 Mar 2003 04:17:59 -0000."
             <20030327041759.GA4367@compsoc.man.ac.uk> 
Date: Thu, 27 Mar 2003 16:26:29 +1100
Message-Id: <20030327062921.3D8932C08F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030327041759.GA4367@compsoc.man.ac.uk> you write:
> On Thu, Mar 27, 2003 at 01:20:23PM +1100, Rusty Russell wrote:
> ... and it's the same ill. Half-cleaned up stuff sucks. Either remove it
> or don't.

I like that attitude: I'm not sure I have the energy to match it 8)

However, please look at patch below.

> > That's because everyone realizes that the return value is useless.
> 
> It detects one variant of unmatched register/unregister, so it cannot be
> said to be entirely useless. I would not call it entirely useful,
> though, I admit.

BUG() in the unregister makes sense I think (see patch).

> Beside the point though really, I appear to have made onto Linus'
> shitlist at last ... does this mean I finally graduated Linux School ?

Linus fades every so often.  Has more to do with phase of the moon, I
think, than individuals.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: notifier_unregister should return void
Author: Rusty Russell
Status: Tested on 2.5.66-bk2

D: Noone uses the return value of notifier_chain_unregister and its
D: children: make it BUG() when unregistering a non-existent notifier,
D: and return void.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk2/include/linux/cpufreq.h working-2.5.66-bk2-notifier/include/linux/cpufreq.h
--- linux-2.5.66-bk2/include/linux/cpufreq.h	2003-03-18 12:21:40.000000000 +1100
+++ working-2.5.66-bk2-notifier/include/linux/cpufreq.h	2003-03-27 15:41:52.000000000 +1100
@@ -29,7 +29,7 @@
  *********************************************************************/
 
 int cpufreq_register_notifier(struct notifier_block *nb, unsigned int list);
-int cpufreq_unregister_notifier(struct notifier_block *nb, unsigned int list);
+void cpufreq_unregister_notifier(struct notifier_block *nb, unsigned int list);
 
 #define CPUFREQ_TRANSITION_NOTIFIER     (0)
 #define CPUFREQ_POLICY_NOTIFIER         (1)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk2/include/linux/inetdevice.h working-2.5.66-bk2-notifier/include/linux/inetdevice.h
--- linux-2.5.66-bk2/include/linux/inetdevice.h	2003-01-02 12:34:08.000000000 +1100
+++ working-2.5.66-bk2-notifier/include/linux/inetdevice.h	2003-03-27 15:59:02.000000000 +1100
@@ -77,7 +77,7 @@ struct in_ifaddr
 };
 
 extern int register_inetaddr_notifier(struct notifier_block *nb);
-extern int unregister_inetaddr_notifier(struct notifier_block *nb);
+extern void unregister_inetaddr_notifier(struct notifier_block *nb);
 
 extern struct net_device 	*ip_dev_find(u32 addr);
 extern int		inet_addr_onlink(struct in_device *in_dev, u32 a, u32 b);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk2/include/linux/netdevice.h working-2.5.66-bk2-notifier/include/linux/netdevice.h
--- linux-2.5.66-bk2/include/linux/netdevice.h	2003-03-27 12:11:45.000000000 +1100
+++ working-2.5.66-bk2-notifier/include/linux/netdevice.h	2003-03-27 15:41:49.000000000 +1100
@@ -487,7 +487,7 @@ extern int		dev_queue_xmit(struct sk_buf
 extern int		register_netdevice(struct net_device *dev);
 extern int		unregister_netdevice(struct net_device *dev);
 extern int 		register_netdevice_notifier(struct notifier_block *nb);
-extern int		unregister_netdevice_notifier(struct notifier_block *nb);
+extern void		unregister_netdevice_notifier(struct notifier_block *nb);
 extern int		call_netdevice_notifiers(unsigned long val, void *v);
 extern int		dev_new_index(void);
 extern struct net_device	*dev_get_by_index(int ifindex);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk2/include/linux/netlink.h working-2.5.66-bk2-notifier/include/linux/netlink.h
--- linux-2.5.66-bk2/include/linux/netlink.h	2003-02-07 19:16:27.000000000 +1100
+++ working-2.5.66-bk2-notifier/include/linux/netlink.h	2003-03-27 15:42:20.000000000 +1100
@@ -114,7 +114,7 @@ extern int netlink_broadcast(struct sock
 			     __u32 group, int allocation);
 extern void netlink_set_err(struct sock *ssk, __u32 pid, __u32 group, int code);
 extern int netlink_register_notifier(struct notifier_block *nb);
-extern int netlink_unregister_notifier(struct notifier_block *nb);
+extern void netlink_unregister_notifier(struct notifier_block *nb);
 
 /*
  *	skb should fit one page. This choice is good for headerless malloc.
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk2/include/linux/notifier.h working-2.5.66-bk2-notifier/include/linux/notifier.h
--- linux-2.5.66-bk2/include/linux/notifier.h	2003-01-02 12:32:49.000000000 +1100
+++ working-2.5.66-bk2-notifier/include/linux/notifier.h	2003-03-27 15:37:31.000000000 +1100
@@ -22,7 +22,7 @@ struct notifier_block
 #ifdef __KERNEL__
 
 extern int notifier_chain_register(struct notifier_block **list, struct notifier_block *n);
-extern int notifier_chain_unregister(struct notifier_block **nl, struct notifier_block *n);
+extern void notifier_chain_unregister(struct notifier_block **nl, struct notifier_block *n);
 extern int notifier_call_chain(struct notifier_block **n, unsigned long val, void *v);
 
 #define NOTIFY_DONE		0x0000		/* Don't care */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk2/include/linux/profile.h working-2.5.66-bk2-notifier/include/linux/profile.h
--- linux-2.5.66-bk2/include/linux/profile.h	2003-03-18 12:21:40.000000000 +1100
+++ working-2.5.66-bk2-notifier/include/linux/profile.h	2003-03-27 15:42:15.000000000 +1100
@@ -43,10 +43,10 @@ void profile_exit_mmap(struct mm_struct 
 
 int profile_event_register(enum profile_type, struct notifier_block * n);
 
-int profile_event_unregister(enum profile_type, struct notifier_block * n);
+void profile_event_unregister(enum profile_type, struct notifier_block * n);
 
 int register_profile_notifier(struct notifier_block * nb);
-int unregister_profile_notifier(struct notifier_block * nb);
+void unregister_profile_notifier(struct notifier_block * nb);
 
 /* profiling hook activated on each timer interrupt */
 void profile_hook(struct pt_regs * regs);
@@ -58,9 +58,8 @@ static inline int profile_event_register
 	return -ENOSYS;
 }
 
-static inline int profile_event_unregister(enum profile_type t, struct notifier_block * n)
+static inline void profile_event_unregister(enum profile_type t, struct notifier_block * n)
 {
-	return -ENOSYS;
 }
 
 #define profile_exit_task(a) do { } while (0)
@@ -72,9 +71,8 @@ static inline int register_profile_notif
 	return -ENOSYS;
 }
 
-static inline int unregister_profile_notifier(struct notifier_block * nb)
+static inline void unregister_profile_notifier(struct notifier_block * nb)
 {
-	return -ENOSYS;
 }
 
 #define profile_hook(regs) do { } while (0)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk2/include/linux/reboot.h working-2.5.66-bk2-notifier/include/linux/reboot.h
--- linux-2.5.66-bk2/include/linux/reboot.h	2003-02-07 19:17:54.000000000 +1100
+++ working-2.5.66-bk2-notifier/include/linux/reboot.h	2003-03-27 15:41:56.000000000 +1100
@@ -37,7 +37,7 @@
 #include <linux/notifier.h>
 
 extern int register_reboot_notifier(struct notifier_block *);
-extern int unregister_reboot_notifier(struct notifier_block *);
+extern void unregister_reboot_notifier(struct notifier_block *);
 
 
 /*
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk2/include/net/addrconf.h working-2.5.66-bk2-notifier/include/net/addrconf.h
--- linux-2.5.66-bk2/include/net/addrconf.h	2003-03-25 12:17:31.000000000 +1100
+++ working-2.5.66-bk2-notifier/include/net/addrconf.h	2003-03-27 15:42:38.000000000 +1100
@@ -123,7 +123,7 @@ extern int			ipv6_chk_acast_addr(struct 
 
 /* Device notifier */
 extern int register_inet6addr_notifier(struct notifier_block *nb);
-extern int unregister_inet6addr_notifier(struct notifier_block *nb);
+extern void unregister_inet6addr_notifier(struct notifier_block *nb);
 
 static inline struct inet6_dev *
 __in6_dev_get(struct net_device *dev)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk2/include/net/bluetooth/hci_core.h working-2.5.66-bk2-notifier/include/net/bluetooth/hci_core.h
--- linux-2.5.66-bk2/include/net/bluetooth/hci_core.h	2003-02-25 10:11:10.000000000 +1100
+++ working-2.5.66-bk2-notifier/include/net/bluetooth/hci_core.h	2003-03-27 15:42:35.000000000 +1100
@@ -467,7 +467,7 @@ static inline void hci_proto_encrypt_cfm
 int hci_register_proto(struct hci_proto *hproto);
 int hci_unregister_proto(struct hci_proto *hproto);
 int hci_register_notifier(struct notifier_block *nb);
-int hci_unregister_notifier(struct notifier_block *nb);
+void hci_unregister_notifier(struct notifier_block *nb);
 
 int hci_send_cmd(struct hci_dev *hdev, __u16 ogf, __u16 ocf, __u32 plen, void *param);
 int hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk2/kernel/cpufreq.c working-2.5.66-bk2-notifier/kernel/cpufreq.c
--- linux-2.5.66-bk2/kernel/cpufreq.c	2003-03-25 12:17:31.000000000 +1100
+++ working-2.5.66-bk2-notifier/kernel/cpufreq.c	2003-03-27 15:43:36.000000000 +1100
@@ -484,27 +484,22 @@ EXPORT_SYMBOL(cpufreq_register_notifier)
  *
  *	Remove a driver from the CPU frequency notifier list.
  *
- *	This function may sleep, and has the same return conditions as
- *	notifier_chain_unregister.
+ *	This function may sleep.
  */
-int cpufreq_unregister_notifier(struct notifier_block *nb, unsigned int list)
+void cpufreq_unregister_notifier(struct notifier_block *nb, unsigned int list)
 {
-	int ret;
-
 	down_write(&cpufreq_notifier_rwsem);
 	switch (list) {
 	case CPUFREQ_TRANSITION_NOTIFIER:
-		ret = notifier_chain_unregister(&cpufreq_transition_notifier_list, nb);
+		notifier_chain_unregister(&cpufreq_transition_notifier_list, nb);
 		break;
 	case CPUFREQ_POLICY_NOTIFIER:
-		ret = notifier_chain_unregister(&cpufreq_policy_notifier_list, nb);
+		notifier_chain_unregister(&cpufreq_policy_notifier_list, nb);
 		break;
 	default:
-		ret = -EINVAL;
+		BUG();
 	}
 	up_write(&cpufreq_notifier_rwsem);
-
-	return ret;
 }
 EXPORT_SYMBOL(cpufreq_unregister_notifier);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk2/kernel/profile.c working-2.5.66-bk2-notifier/kernel/profile.c
--- linux-2.5.66-bk2/kernel/profile.c	2003-02-25 10:11:11.000000000 +1100
+++ working-2.5.66-bk2-notifier/kernel/profile.c	2003-03-27 15:44:06.000000000 +1100
@@ -97,26 +97,23 @@ int profile_event_register(enum profile_
 }
 
  
-int profile_event_unregister(enum profile_type type, struct notifier_block * n)
+void profile_event_unregister(enum profile_type type, struct notifier_block * n)
 {
-	int err = -EINVAL;
- 
 	down_write(&profile_rwsem);
  
 	switch (type) {
 		case EXIT_TASK:
-			err = notifier_chain_unregister(&exit_task_notifier, n);
+			notifier_chain_unregister(&exit_task_notifier, n);
 			break;
 		case EXIT_MMAP:
-			err = notifier_chain_unregister(&exit_mmap_notifier, n);
+			notifier_chain_unregister(&exit_mmap_notifier, n);
 			break;
 		case EXEC_UNMAP:
-			err = notifier_chain_unregister(&exec_unmap_notifier, n);
+			notifier_chain_unregister(&exec_unmap_notifier, n);
 			break;
 	}
 
 	up_write(&profile_rwsem);
-	return err;
 }
 
 static struct notifier_block * profile_listeners;
@@ -132,13 +129,11 @@ int register_profile_notifier(struct not
 }
 
 
-int unregister_profile_notifier(struct notifier_block * nb)
+void unregister_profile_notifier(struct notifier_block * nb)
 {
-	int err;
 	write_lock_irq(&profile_lock);
-	err = notifier_chain_unregister(&profile_listeners, nb);
+	notifier_chain_unregister(&profile_listeners, nb);
 	write_unlock_irq(&profile_lock);
-	return err;
 }
 
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk2/kernel/sys.c working-2.5.66-bk2-notifier/kernel/sys.c
--- linux-2.5.66-bk2/kernel/sys.c	2003-03-25 12:17:32.000000000 +1100
+++ working-2.5.66-bk2-notifier/kernel/sys.c	2003-03-27 16:07:33.000000000 +1100
@@ -111,11 +111,9 @@ int notifier_chain_register(struct notif
  *	@n: New entry in notifier chain
  *
  *	Removes a notifier from a notifier chain.
- *
- *	Returns zero on success, or %-ENOENT on failure.
  */
  
-int notifier_chain_unregister(struct notifier_block **nl, struct notifier_block *n)
+void notifier_chain_unregister(struct notifier_block **nl, struct notifier_block *n)
 {
 	write_lock(&notifier_lock);
 	while((*nl)!=NULL)
@@ -124,12 +122,12 @@ int notifier_chain_unregister(struct not
 		{
 			*nl=n->next;
 			write_unlock(&notifier_lock);
-			return 0;
+			return;
 		}
 		nl=&((*nl)->next);
 	}
 	write_unlock(&notifier_lock);
-	return -ENOENT;
+	BUG();
 }
 
 /**
@@ -187,13 +185,11 @@ int register_reboot_notifier(struct noti
  *
  *	Unregisters a previously registered reboot
  *	notifier function.
- *
- *	Returns zero on success, or %-ENOENT on failure.
  */
  
-int unregister_reboot_notifier(struct notifier_block * nb)
+void unregister_reboot_notifier(struct notifier_block * nb)
 {
-	return notifier_chain_unregister(&reboot_notifier_list, nb);
+	notifier_chain_unregister(&reboot_notifier_list, nb);
 }
 
 asmlinkage long sys_ni_syscall(void)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk2/net/bluetooth/hci_core.c working-2.5.66-bk2-notifier/net/bluetooth/hci_core.c
--- linux-2.5.66-bk2/net/bluetooth/hci_core.c	2003-02-25 10:11:12.000000000 +1100
+++ working-2.5.66-bk2-notifier/net/bluetooth/hci_core.c	2003-03-27 15:44:54.000000000 +1100
@@ -83,9 +83,9 @@ int hci_register_notifier(struct notifie
 	return notifier_chain_register(&hci_notifier, nb);
 }
 
-int hci_unregister_notifier(struct notifier_block *nb)
+void hci_unregister_notifier(struct notifier_block *nb)
 {
-	return notifier_chain_unregister(&hci_notifier, nb);
+	notifier_chain_unregister(&hci_notifier, nb);
 }
 
 void hci_notify(struct hci_dev *hdev, int event)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk2/net/core/dev.c working-2.5.66-bk2-notifier/net/core/dev.c
--- linux-2.5.66-bk2/net/core/dev.c	2003-03-25 12:17:32.000000000 +1100
+++ working-2.5.66-bk2-notifier/net/core/dev.c	2003-03-27 15:45:14.000000000 +1100
@@ -912,13 +912,12 @@ int register_netdevice_notifier(struct n
  *
  *	Unregister a notifier previously registered by
  *	register_netdevice_notifier(). The notifier is unlinked into the
- *	kernel structures and may then be reused. A negative errno code
- *	is returned on a failure.
+ *	kernel structures and may then be reused.
  */
 
-int unregister_netdevice_notifier(struct notifier_block *nb)
+void unregister_netdevice_notifier(struct notifier_block *nb)
 {
-	return notifier_chain_unregister(&netdev_chain, nb);
+	notifier_chain_unregister(&netdev_chain, nb);
 }
 
 /**
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk2/net/ipv4/devinet.c working-2.5.66-bk2-notifier/net/ipv4/devinet.c
--- linux-2.5.66-bk2/net/ipv4/devinet.c	2003-02-11 14:26:21.000000000 +1100
+++ working-2.5.66-bk2-notifier/net/ipv4/devinet.c	2003-03-27 15:45:31.000000000 +1100
@@ -818,9 +818,9 @@ int register_inetaddr_notifier(struct no
 	return notifier_chain_register(&inetaddr_chain, nb);
 }
 
-int unregister_inetaddr_notifier(struct notifier_block *nb)
+void unregister_inetaddr_notifier(struct notifier_block *nb)
 {
-	return notifier_chain_unregister(&inetaddr_chain, nb);
+	notifier_chain_unregister(&inetaddr_chain, nb);
 }
 
 /* Rename ifa_labels for a device name change. Make some effort to preserve existing
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk2/net/ipv6/addrconf.c working-2.5.66-bk2-notifier/net/ipv6/addrconf.c
--- linux-2.5.66-bk2/net/ipv6/addrconf.c	2003-03-25 12:17:33.000000000 +1100
+++ working-2.5.66-bk2-notifier/net/ipv6/addrconf.c	2003-03-27 15:45:42.000000000 +1100
@@ -2636,9 +2636,9 @@ int register_inet6addr_notifier(struct n
         return notifier_chain_register(&inet6addr_chain, nb);
 }
 
-int unregister_inet6addr_notifier(struct notifier_block *nb)
+void unregister_inet6addr_notifier(struct notifier_block *nb)
 {
-        return notifier_chain_unregister(&inet6addr_chain,nb);
+	notifier_chain_unregister(&inet6addr_chain,nb);
 }
 
 /*
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk2/net/netlink/af_netlink.c working-2.5.66-bk2-notifier/net/netlink/af_netlink.c
--- linux-2.5.66-bk2/net/netlink/af_netlink.c	2003-03-18 12:21:41.000000000 +1100
+++ working-2.5.66-bk2-notifier/net/netlink/af_netlink.c	2003-03-27 15:45:53.000000000 +1100
@@ -1023,9 +1023,9 @@ int netlink_register_notifier(struct not
 	return notifier_chain_register(&netlink_chain, nb);
 }
 
-int netlink_unregister_notifier(struct notifier_block *nb)
+void netlink_unregister_notifier(struct notifier_block *nb)
 {
-	return notifier_chain_unregister(&netlink_chain, nb);
+	notifier_chain_unregister(&netlink_chain, nb);
 }
                 
 struct proto_ops netlink_ops = {
