Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261278AbSJYFQ4>; Fri, 25 Oct 2002 01:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261285AbSJYFQ4>; Fri, 25 Oct 2002 01:16:56 -0400
Received: from mail.eskimo.com ([204.122.16.4]:52490 "EHLO mail.eskimo.com")
	by vger.kernel.org with ESMTP id <S261278AbSJYFQw>;
	Fri, 25 Oct 2002 01:16:52 -0400
Date: Thu, 24 Oct 2002 22:20:01 -0700
To: Rasmus Andersen <rasmus@jaquet.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Untested patch 2/2 - Fix some kernel sources for macro printk (was Re: [RFC] CONFIG_TINY)
Message-ID: <20021025052001.GB20357@eskimo.com>
References: <20021023215117.A29134@jaquet.dk> <20021024030143.GA13661@eskimo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021024030143.GA13661@eskimo.com>
User-Agent: Mutt/1.4i
From: Elladan <elladan@eskimo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The previous patch added some complex, ugly macros to replace printk()
in the kernel in a way which allows printk() calls to be selectively
disabled at compile time.  These macros cannot work in all situations,
because some parts of the kernel depend on eg. KERN_ERR actually being a
simple string.  

This patch modifies certain kernel sources to fix this.  It either
removes the dependency, or changes these places to use a new
KERN_ERR_STR etc. macro.

This is not at all a complete patch - it was just the minimal change
required to get the core kernel to build with my own particular
configuration.  I'm only including it since the previous patch doesn't
build at all without it.

-J


--- kernel/module.c-orig	2002-10-24 18:59:02.000000000 -0700
+++ kernel/module.c	2002-10-24 18:59:09.000000000 -0700
@@ -379,8 +379,8 @@
 		goto err1;
 	if (mod_user_size < (unsigned long)&((struct module *)0L)->persist_start
 	    || mod_user_size > sizeof(struct module) + 16*sizeof(void*)) {
-		printk(KERN_ERR "init_module: Invalid module header size.\n"
-		       KERN_ERR "A new version of the modutils is likely "
+		printk(KERN_ERR     "init_module: Invalid module header size.\n"
+		       KERN_ERR_STR "A new version of the modutils is likely "
 				"needed.\n");
 		error = -EINVAL;
 		goto err1;
--- mm/slab.c-orig	2002-10-24 19:02:28.000000000 -0700
+++ mm/slab.c	2002-10-24 19:02:39.000000000 -0700
@@ -658,7 +658,7 @@
 	unsigned long flags, void (*ctor)(void*, kmem_cache_t *, unsigned long),
 	void (*dtor)(void*, kmem_cache_t *, unsigned long))
 {
-	const char *func_nm = KERN_ERR "kmem_create: ";
+	const char *func_nm = "kmem_create: ";
 	size_t left_over, align, slab_size;
 	kmem_cache_t *cachep = NULL;
 
@@ -676,13 +676,13 @@
 #if DEBUG
 	if ((flags & SLAB_DEBUG_INITIAL) && !ctor) {
 		/* No constructor, but inital state check requested */
-		printk("%sNo con, but init state check requested - %s\n", func_nm, name);
+		printk(KERN_ERR "%sNo con, but init state check requested - %s\n", func_nm, name);
 		flags &= ~SLAB_DEBUG_INITIAL;
 	}
 
 	if ((flags & SLAB_POISON) && ctor) {
 		/* request for poisoning, but we can't do that with a constructor */
-		printk("%sPoisoning requested, but con given - %s\n", func_nm, name);
+		printk(KERN_ERR "%sPoisoning requested, but con given - %s\n", func_nm, name);
 		flags &= ~SLAB_POISON;
 	}
 #if FORCED_DEBUG
@@ -717,7 +717,7 @@
 	if (size & (BYTES_PER_WORD-1)) {
 		size += (BYTES_PER_WORD-1);
 		size &= ~(BYTES_PER_WORD-1);
-		printk("%sForcing size word alignment - %s\n", func_nm, name);
+		printk(KERN_ERR "%sForcing size word alignment - %s\n", func_nm, name);
 	}
 	
 #if DEBUG
@@ -788,7 +788,7 @@
 	} while (1);
 
 	if (!cachep->num) {
-		printk("kmem_cache_create: couldn't create cache %s.\n", name);
+		printk(KERN_ERR "kmem_cache_create: couldn't create cache %s.\n", name);
 		kmem_cache_free(&cache_cache, cachep);
 		cachep = NULL;
 		goto opps;
--- drivers/md/md.c-orig	2002-10-24 19:07:52.000000000 -0700
+++ drivers/md/md.c	2002-10-24 19:12:17.000000000 -0700
@@ -56,7 +56,7 @@
 #include <linux/blk.h>
 
 #define DEBUG 0
-#define dprintk(x...) ((void)(DEBUG && printk(x)))
+#define dprintk(x...) do { if(DEBUG) printk(x); } while(0)
 
 
 #ifndef MODULE
@@ -2977,7 +2977,7 @@
 	struct list_head *tmp, *rtmp;
 
 
-	dprintk(KERN_INFO "md: recovery thread got woken up ...\n");
+	dprintk(KERN_INFO_STR "md: recovery thread got woken up ...\n");
 
 	ITERATE_MDDEV(mddev,tmp) if (mddev_lock(mddev)==0) {
 		if (!mddev->raid_disks || !mddev->pers || mddev->ro)
@@ -3054,7 +3054,7 @@
 	unlock:
 		mddev_unlock(mddev);
 	}
-	dprintk(KERN_INFO "md: recovery thread finished ...\n");
+	dprintk(KERN_INFO_STR "md: recovery thread finished ...\n");
 
 }
 
--- drivers/char/tty_io.c-orig	2002-10-24 19:06:14.000000000 -0700
+++ drivers/char/tty_io.c	2002-10-24 19:07:10.000000000 -0700
@@ -212,9 +212,9 @@
 			      const char *routine)
 {
 #ifdef TTY_PARANOIA_CHECK
-	static const char badmagic[] = KERN_WARNING
+	static const char badmagic[] = KERN_WARNING_STR
 		"Warning: bad magic number for tty struct (%s) in %s\n";
-	static const char badtty[] = KERN_WARNING
+	static const char badtty[] = KERN_WARNING_STR
 		"Warning: null TTY for (%s) in %s\n";
 
 	if (!tty) {
--- drivers/block/floppy.c-orig	2002-10-24 19:04:29.000000000 -0700
+++ drivers/block/floppy.c	2002-10-24 19:05:46.000000000 -0700
@@ -3653,7 +3653,7 @@
 		if (name) {
 			const char * prepend = ",";
 			if (first) {
-				prepend = KERN_INFO "Floppy drive(s):";
+				prepend = KERN_INFO_STR "Floppy drive(s):";
 				first = 0;
 			}
 			printk("%s fd%d is %s", prepend, drive, name);
--- net/sunrpc/sched.c-orig	2002-10-24 19:41:21.000000000 -0700
+++ net/sunrpc/sched.c	2002-10-24 19:41:35.000000000 -0700
@@ -338,7 +338,7 @@
 	} else {
 		rpc_clear_running(task);
 		if (task->tk_callback) {
-			dprintk(KERN_ERR "RPC: %4d overwrites an active callback\n", task->tk_pid);
+			dprintk(KERN_ERR_STR "RPC: %4d overwrites an active callback\n", task->tk_pid);
 			BUG();
 		}
 		task->tk_callback = action;
--- net/sunrpc/clnt.c-orig	2002-10-24 19:35:53.000000000 -0700
+++ net/sunrpc/clnt.c	2002-10-24 19:39:59.000000000 -0700
@@ -909,7 +909,7 @@
 	task->tk_client->cl_stats->rpcgarbage++;
 	if (task->tk_garb_retry) {
 		task->tk_garb_retry--;
-		dprintk(KERN_WARNING "RPC: garbage, retrying %4d\n", task->tk_pid);
+		dprintk(KERN_WARNING_STR "RPC: garbage, retrying %4d\n", task->tk_pid);
 		task->tk_action = call_encode;
 		return NULL;
 	}
--- net/sunrpc/svcsock.c-orig	2002-10-24 19:41:56.000000000 -0700
+++ net/sunrpc/svcsock.c	2002-10-24 19:42:31.000000000 -0700
@@ -715,7 +715,7 @@
 	 * tell us anything. For now just warn about unpriv connections.
 	 */
 	if (ntohs(sin.sin_port) >= 1024) {
-		dprintk(KERN_WARNING
+		dprintk(KERN_WARNING_STR
 			"%s: connect from unprivileged port: %u.%u.%u.%u:%d\n",
 			serv->sv_name, 
 			NIPQUAD(sin.sin_addr.s_addr), ntohs(sin.sin_port));
@@ -1304,7 +1304,7 @@
 		kfree(svsk);
 	} else {
 		spin_unlock_bh(&serv->sv_lock);
-		dprintk(KERN_NOTICE "svc: server socket destroy delayed\n");
+		dprintk(KERN_NOTICE_STR "svc: server socket destroy delayed\n");
 		/* svsk->sk_server = NULL; */
 	}
 }
--- net/core/netfilter.c-orig	2002-10-24 19:16:38.000000000 -0700
+++ net/core/netfilter.c	2002-10-24 19:18:45.000000000 -0700
@@ -584,15 +584,16 @@
 		fl.fl4_src = 0;
 
 	if ((err=ip_route_output_key(&rt, &fl)) != 0) {
+#ifdef CONFIG_IP_ROUTE_FWMARK
+#define FWMARK (*pskb)->nfmark
+#else
+#define FWMARK 0UL
+#endif
 		printk("route_me_harder: ip_route_output_key(dst=%u.%u.%u.%u, src=%u.%u.%u.%u, oif=%d, tos=0x%x, fwmark=0x%lx) error %d\n",
 			NIPQUAD(iph->daddr), NIPQUAD(iph->saddr),
 			(*pskb)->sk ? (*pskb)->sk->bound_dev_if : 0,
 			RT_TOS(iph->tos)|RTO_CONN,
-#ifdef CONFIG_IP_ROUTE_FWMARK
-			(*pskb)->nfmark,
-#else
-			0UL,
-#endif
+                        FWMARK,
 			err);
 		goto out;
 	}
--- net/unix/af_unix.c-orig	2002-10-24 19:43:00.000000000 -0700
+++ net/unix/af_unix.c	2002-10-24 19:44:07.000000000 -0700
@@ -1882,7 +1882,8 @@
 static inline void unix_sysctl_unregister(void) {}
 #endif
 
-static char banner[] __initdata = KERN_INFO "NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.\n";
+static char banner[] __initdata = KERN_INFO_STR 
+	"NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.\n";
 
 static int __init af_unix_init(void)
 {
--- net/ipv4/tcp_timer.c-orig	2002-10-24 19:19:27.000000000 -0700
+++ net/ipv4/tcp_timer.c	2002-10-24 19:19:48.000000000 -0700
@@ -35,7 +35,7 @@
 static void tcp_delack_timer(unsigned long);
 static void tcp_keepalive_timer (unsigned long data);
 
-const char timer_bug_msg[] = KERN_DEBUG "tcpbug: unknown timer value\n";
+const char timer_bug_msg[] = KERN_DEBUG_STR "tcpbug: unknown timer value\n";
 
 /*
  * Using different timers for retransmit, delayed acks and probes
--- arch/i386/kernel/head.S-orig	2002-10-24 19:45:20.000000000 -0700
+++ arch/i386/kernel/head.S	2002-10-24 19:45:41.000000000 -0700
@@ -323,7 +323,7 @@
 	movl %eax,%ds
 	movl %eax,%es
 	pushl $int_msg
-	call printk
+	call _printk
 	popl %eax
 	popl %ds
 	popl %es
--- arch/i386/kernel/dmi_scan.c-orig	2002-10-24 18:55:01.000000000 -0700
+++ arch/i386/kernel/dmi_scan.c	2002-10-24 18:55:05.000000000 -0700
@@ -756,7 +756,7 @@
 			NO_MATCH, NO_MATCH, NO_MATCH
 			} },
 
-	{ print_if_true, KERN_WARNING "IBM T23 - BIOS 1.03b+ and controller firmware 1.02+ may be needed for Linux APM.", {
+	{ print_if_true, KERN_WARNING_STR "IBM T23 - BIOS 1.03b+ and controller firmware 1.02+ may be needed for Linux APM.", {
 			MATCH(DMI_SYS_VENDOR, "IBM"),
 			MATCH(DMI_BIOS_VERSION, "1AET38WW (1.01b)"),
 			NO_MATCH, NO_MATCH
