Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265687AbSKAKiv>; Fri, 1 Nov 2002 05:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265690AbSKAKiv>; Fri, 1 Nov 2002 05:38:51 -0500
Received: from h-64-105-136-52.SNVACAID.covad.net ([64.105.136.52]:48316 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265687AbSKAKiq>; Fri, 1 Nov 2002 05:38:46 -0500
Date: Fri, 1 Nov 2002 03:45:00 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: netdev@oss.sgi.com, linux-net@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Patch?: linux-2.5.45/net - __secpath_destroy made net depend on ipv4
Message-ID: <20021101034500.A484@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	In linux-2.5.45, the core networking code calls
__secpath_destroy via the static inline routine secpath_put in
include/net/xfrm.h.  However, __secpath destroy is defined in
ipv4.  So, I believe that compiling networking without ipv4
will result in a kernel that fails to link (haven't actually
tried it), and it also causes problems for anyone who has
tweaked ipv4 into a loadable module (which is my case; I posted
patches long ago and would be happy to post them again if there
is interest).

	Here is a possible patch that creates a secpath_destroy_hook,
although I hope that a cleaner and safer solution can be found (safer
because hook variables if multiple modules save and restore the old
values of the hook variable in some order other than
last-in-first-out).

	I'm littering linux-kernel with this patch also because I
think __secpath_destroy comes from ipsec and those maintainers might
not be on the netdev and linux-net lists.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="secpath.diffs"

--- linux-2.5.45/include/net/xfrm.h	2002-10-30 16:42:22.000000000 -0800
+++ linux/include/net/xfrm.h	2002-10-31 02:48:20.000000000 -0800
@@ -338,12 +338,14 @@
 }
 
 extern void __secpath_destroy(struct sec_path *sp);
+extern void secpath_destroy_noop(struct sec_path *sp);
+extern void (*secpath_destroy_hook)(struct sec_path *sp);
 
 static inline void
 secpath_put(struct sec_path *sp)
 {
 	if (sp && atomic_dec_and_test(&sp->refcnt))
-		__secpath_destroy(sp);
+		(*secpath_destroy_hook)(sp);
 }
 
 extern int __xfrm_policy_check(int dir, struct sk_buff *skb);
--- linux-2.5.45/net/core/Makefile	2002-10-30 16:43:43.000000000 -0800
+++ linux/net/core/Makefile	2002-10-31 00:31:25.000000000 -0800
@@ -2,6 +2,8 @@
 # Makefile for the Linux networking core.
 #
 
+export-objs := dev.o netfilter.o profile.o skbuff.o
+
 obj-y := sock.o skbuff.o iovec.o datagram.o scm.o
 
 ifeq ($(CONFIG_SYSCTL),y)
--- linux-2.5.45/net/core/skbuff.c	2002-10-30 16:43:08.000000000 -0800
+++ linux/net/core/skbuff.c	2002-10-31 00:31:25.000000000 -0800
@@ -38,6 +38,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -1218,11 +1219,22 @@
 }
 #endif
 
+void
+secpath_destroy_noop (struct sec_path *sp)
+{
+	return;
+}
+EXPORT_SYMBOL(secpath_destroy_noop);
+
+void (*secpath_destroy_hook)(struct sec_path *sp) = secpath_destroy_noop;
+EXPORT_SYMBOL(secpath_destroy_hook);
+
 void __init skb_init(void)
 {
 	int i;
--- linux-2.5.45/net/ipv4/af_inet.c	2002-10-30 16:41:56.000000000 -0800
+++ linux/net/ipv4/af_inet.c	2002-11-01 03:31:37.000000000 -0800
@@ -105,16 +105,17 @@
 #include <linux/skbuff.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <net/sock.h>
 #include <net/raw.h>
 #include <net/icmp.h>
 #include <net/ipip.h>
 #include <net/inet_common.h>
+#include <net/xfrm.h>
 #ifdef CONFIG_IP_MROUTE
 #include <linux/mroute.h>
 #endif
 
 struct linux_mib net_statistics[NR_CPUS * 2];
 
 #ifdef INET_REFCNT_DEBUG
 atomic_t inet_sock_nr;
@@ -1054,16 +1055,18 @@
 static int __init inet_init(void)
 {
 	struct sk_buff *dummy_skb;
 	struct inet_protosw *q;
 	struct list_head *r;
 
 	printk(KERN_INFO "NET4: Linux TCP/IP 1.0 for NET4.0\n");
 
+	secpath_destroy_hook = __secpath_destroy;
+
 	if (sizeof(struct inet_skb_parm) > sizeof(dummy_skb->cb)) {
 		printk(KERN_CRIT "inet_proto_init: panic\n");
 		return -EINVAL;
 	}
 
 	tcp_sk_cachep = kmem_cache_create("tcp_sock",
 					  sizeof(struct tcp_sock), 0,
 					  SLAB_HWCACHE_ALIGN, 0, 0);

--n8g4imXOkfNTN/H1--
