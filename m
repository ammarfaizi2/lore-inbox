Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265506AbSLXR2h>; Tue, 24 Dec 2002 12:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265578AbSLXR2h>; Tue, 24 Dec 2002 12:28:37 -0500
Received: from franka.aracnet.com ([216.99.193.44]:16073 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265506AbSLXR2f>; Tue, 24 Dec 2002 12:28:35 -0500
Date: Tue, 24 Dec 2002 09:36:43 -0800
From: "Martin J. Bligh" <fletch@aracnet.com>
To: Andrew Morton <akpm@zip.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix 4 compile time warnings in 2.5.53
Message-ID: <48180000.1040751403@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warnings:

drivers/serial/core.c: In function `uart_get_divisor':
drivers/serial/core.c:390: warning: `quot' might be used uninitialized in 
this function
net/ipv4/route.c: In function `rt_cache_seq_stop':
net/ipv4/route.c:279: warning: unused variable `st'
drivers/net/starfire.c: In function `netdev_close':
drivers/net/starfire.c:1851: warning: unsigned int format, different type 
arg (arg 2)
drivers/net/starfire.c:1858: warning: unsigned int format, different type 
arg (arg 2)
arch/i386/kernel/smpboot.c:691: warning: `wakeup_secondary_via_INIT' 
defined but not used

My build is now eerily quiet.


M.


diff -urpN -X /home/fletch/.diff.exclude virgin/arch/i386/kernel/smpboot.c 
fix_numaq_warning/arch/i386/kernel/smpboot.c
--- virgin/arch/i386/kernel/smpboot.c	Mon Dec 23 23:01:44 2002
+++ fix_numaq_warning/arch/i386/kernel/smpboot.c	Tue Dec 24 08:58:44 2002
@@ -596,6 +596,8 @@ static inline void inquire_remote_apic(i
 }
 #endif

+#ifdef CONFIG_X86_NUMAQ
+
 static int __init wakeup_secondary_via_NMI(int logical_apicid)
 /*
  * Poke the other CPU in the eye to wake it up. Remember that the normal
@@ -644,6 +646,8 @@ static int __init wakeup_secondary_via_N
 	return (send_status | accept_status);
 }

+#else /* ! CONFIG_X86_NUMAQ */
+
 static int __init wakeup_secondary_via_INIT(int phys_apicid, unsigned long 
start_eip)
 {
 	unsigned long send_status = 0, accept_status = 0;
@@ -766,6 +770,8 @@ static int __init wakeup_secondary_via_I

 	return (send_status | accept_status);
 }
+
+#endif /* CONFIG_X86_NUMAQ */

 extern unsigned long cpu_initialized;

diff -urpN -X /home/fletch/.diff.exclude virgin/net/ipv4/route.c 
fix_rtcache_warning/net/ipv4/route.c
--- virgin/net/ipv4/route.c	Mon Dec 23 23:01:58 2002
+++ fix_rtcache_warning/net/ipv4/route.c	Tue Dec 24 09:21:00 2002
@@ -275,11 +275,8 @@ static void *rt_cache_seq_next(struct se

 static void rt_cache_seq_stop(struct seq_file *seq, void *v)
 {
-	if (v && v != (void *)1) {
-		struct rt_cache_iter_state *st = seq->private;
-
+	if (v && v != (void *)1)
 		rcu_read_unlock();
-	}
 }

 static int rt_cache_seq_show(struct seq_file *seq, void *v)
diff -urpN -X /home/fletch/.diff.exclude virgin/drivers/serial/core.c 
fix_serial_warning/drivers/serial/core.c
--- virgin/drivers/serial/core.c	Fri Dec 13 23:18:02 2002
+++ fix_serial_warning/drivers/serial/core.c	Tue Dec 24 08:56:28 2002
@@ -396,7 +396,7 @@ uart_get_divisor(struct uart_port *port,
 		baud = uart_get_baud_rate(port, termios);
 		quot = uart_calculate_quot(port, baud);
 		if (quot)
-			break;
+			return quot;

 		/*
 		 * Oops, the quotient was zero.  Try again with
diff -urpN -X /home/fletch/.diff.exclude virgin/drivers/net/starfire.c 
fix_starfire_warning/drivers/net/starfire.c
--- virgin/drivers/net/starfire.c	Fri Dec 13 23:17:59 2002
+++ fix_starfire_warning/drivers/net/starfire.c	Tue Dec 24 09:18:12 2002
@@ -1847,15 +1847,15 @@ static int netdev_close(struct net_devic

 #ifdef __i386__
 	if (debug > 2) {
-		printk("\n"KERN_DEBUG"  Tx ring at %8.8x:\n",
-			   np->tx_ring_dma);
+		printk("\n"KERN_DEBUG"  Tx ring at %9.9Lx:\n",
+			   (u64) np->tx_ring_dma);
 		for (i = 0; i < 8 /* TX_RING_SIZE is huge! */; i++)
 			printk(KERN_DEBUG " #%d desc. %8.8x %8.8x -> %8.8x.\n",
 			       i, le32_to_cpu(np->tx_ring[i].status),
 			       le32_to_cpu(np->tx_ring[i].first_addr),
 			       le32_to_cpu(np->tx_done_q[i].status));
-		printk(KERN_DEBUG "  Rx ring at %8.8x -> %p:\n",
-		       np->rx_ring_dma, np->rx_done_q);
+		printk(KERN_DEBUG "  Rx ring at %9.9Lx -> %p:\n",
+		       (u64) np->rx_ring_dma, np->rx_done_q);
 		if (np->rx_done_q)
 			for (i = 0; i < 8 /* RX_RING_SIZE */; i++) {
 				printk(KERN_DEBUG " #%d desc. %8.8x -> %8.8x\n",

