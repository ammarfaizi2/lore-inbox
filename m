Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261899AbTCaXCF>; Mon, 31 Mar 2003 18:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261898AbTCaXB7>; Mon, 31 Mar 2003 18:01:59 -0500
Received: from air-2.osdl.org ([65.172.181.6]:57240 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261897AbTCaXBo>;
	Mon, 31 Mar 2003 18:01:44 -0500
Subject: [PATCH 2.5.66] sychronize_net patch (2/2)
From: Stephen Hemminger <shemminger@osdl.org>
To: David Miller <davem@redhat.com>
Cc: linux-net@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1049152382.2204.24.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 31 Mar 2003 15:13:03 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new synchronize_net function for all the place in netfilter that
call lock/unlock just to assure that net packets don't see old data.


By putting it in one place, it gets the brlock semantics out of several
places. The motivation is that eventually on 2.5 based kernels the
function can call synchronize_kernel for RCU but leave the 2.4 code
alone. In future, these places can sleep since they are called during
module unload when unregistering.


diff -urN -X dontdiff linux-2.5/net/ipv4/netfilter/ip_conntrack_core.c linux-2.5-netsync/net/ipv4/netfilter/ip_conntrack_core.c
--- linux-2.5/net/ipv4/netfilter/ip_conntrack_core.c	2003-03-31 10:46:01.000000000 -0800
+++ linux-2.5-netsync/net/ipv4/netfilter/ip_conntrack_core.c	2003-03-31 13:42:42.000000000 -0800
@@ -24,7 +24,6 @@
 #include <linux/skbuff.h>
 #include <linux/proc_fs.h>
 #include <linux/vmalloc.h>
-#include <linux/brlock.h>
 #include <net/checksum.h>
 #include <linux/stddef.h>
 #include <linux/sysctl.h>
@@ -1160,8 +1159,7 @@
 	WRITE_UNLOCK(&ip_conntrack_lock);
 
 	/* Someone could be still looking at the helper in a bh. */
-	br_write_lock_bh(BR_NETPROTO_LOCK);
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	synchronize_net();
 }
 
 /* Refresh conntrack for this many jiffies. */
@@ -1401,8 +1399,7 @@
 	/* This makes sure all current packets have passed through
            netfilter framework.  Roll on, two-stage module
            delete... */
-	br_write_lock_bh(BR_NETPROTO_LOCK);
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	synchronize_net();
  
  i_see_dead_people:
 	ip_ct_selective_cleanup(kill_all, NULL);
diff -urN -X dontdiff linux-2.5/net/ipv4/netfilter/ip_conntrack_standalone.c linux-2.5-netsync/net/ipv4/netfilter/ip_conntrack_standalone.c
--- linux-2.5/net/ipv4/netfilter/ip_conntrack_standalone.c	2003-03-31 10:46:01.000000000 -0800
+++ linux-2.5-netsync/net/ipv4/netfilter/ip_conntrack_standalone.c	2003-03-31 13:42:42.000000000 -0800
@@ -15,7 +15,6 @@
 #include <linux/skbuff.h>
 #include <linux/proc_fs.h>
 #include <linux/version.h>
-#include <linux/brlock.h>
 #include <net/checksum.h>
 
 #define ASSERT_READ_LOCK(x) MUST_BE_READ_LOCKED(&ip_conntrack_lock)
@@ -342,8 +341,7 @@
 	WRITE_UNLOCK(&ip_conntrack_lock);
 	
 	/* Somebody could be still looking at the proto in bh. */
-	br_write_lock_bh(BR_NETPROTO_LOCK);
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	synchronize_net();
 
 	/* Remove all contrack entries for this protocol */
 	ip_ct_selective_cleanup(kill_proto, &proto->proto);
diff -urN -X dontdiff linux-2.5/net/ipv4/netfilter/ip_nat_helper.c linux-2.5-netsync/net/ipv4/netfilter/ip_nat_helper.c
--- linux-2.5/net/ipv4/netfilter/ip_nat_helper.c	2003-03-31 10:46:01.000000000 -0800
+++ linux-2.5-netsync/net/ipv4/netfilter/ip_nat_helper.c	2003-03-31 13:42:42.000000000 -0800
@@ -20,7 +20,6 @@
 #include <linux/timer.h>
 #include <linux/skbuff.h>
 #include <linux/netfilter_ipv4.h>
-#include <linux/brlock.h>
 #include <net/checksum.h>
 #include <net/icmp.h>
 #include <net/ip.h>
@@ -545,8 +544,7 @@
 	WRITE_UNLOCK(&ip_nat_lock);
 
 	/* Someone could be still looking at the helper in a bh. */
-	br_write_lock_bh(BR_NETPROTO_LOCK);
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	synchronize_net();
 
 	/* Find anything using it, and umm, kill them.  We can't turn
 	   them into normal connections: if we've adjusted SYNs, then
diff -urN -X dontdiff linux-2.5/net/ipv4/netfilter/ip_nat_snmp_basic.c linux-2.5-netsync/net/ipv4/netfilter/ip_nat_snmp_basic.c
--- linux-2.5/net/ipv4/netfilter/ip_nat_snmp_basic.c	2003-03-31 10:46:01.000000000 -0800
+++ linux-2.5-netsync/net/ipv4/netfilter/ip_nat_snmp_basic.c	2003-03-31 13:42:42.000000000 -0800
@@ -50,7 +50,6 @@
 #include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_ipv4/ip_nat.h>
 #include <linux/netfilter_ipv4/ip_nat_helper.h>
-#include <linux/brlock.h>
 #include <linux/types.h>
 #include <linux/ip.h>
 #include <net/udp.h>
@@ -1351,8 +1350,7 @@
 {
 	ip_nat_helper_unregister(&snmp);
 	ip_nat_helper_unregister(&snmp_trap);
-	br_write_lock_bh(BR_NETPROTO_LOCK);
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	synchronize_net();
 }
 
 module_init(init);
diff -urN -X dontdiff linux-2.5/net/ipv4/netfilter/ip_nat_standalone.c linux-2.5-netsync/net/ipv4/netfilter/ip_nat_standalone.c
--- linux-2.5/net/ipv4/netfilter/ip_nat_standalone.c	2003-03-31 10:46:01.000000000 -0800
+++ linux-2.5-netsync/net/ipv4/netfilter/ip_nat_standalone.c	2003-03-31 13:42:42.000000000 -0800
@@ -24,7 +24,6 @@
 #include <net/checksum.h>
 #include <linux/spinlock.h>
 #include <linux/version.h>
-#include <linux/brlock.h>
 
 #define ASSERT_READ_LOCK(x) MUST_BE_READ_LOCKED(&ip_nat_lock)
 #define ASSERT_WRITE_LOCK(x) MUST_BE_WRITE_LOCKED(&ip_nat_lock)
@@ -286,8 +285,7 @@
 	WRITE_UNLOCK(&ip_nat_lock);
 
 	/* Someone could be still looking at the proto in a bh. */
-	br_write_lock_bh(BR_NETPROTO_LOCK);
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	synchronize_net();
 }
 
 static int init_or_cleanup(int init)
diff -urN -X dontdiff linux-2.5/net/ipv4/netfilter/ip_queue.c linux-2.5-netsync/net/ipv4/netfilter/ip_queue.c
--- linux-2.5/net/ipv4/netfilter/ip_queue.c	2003-03-31 10:46:01.000000000 -0800
+++ linux-2.5-netsync/net/ipv4/netfilter/ip_queue.c	2003-03-31 13:42:42.000000000 -0800
@@ -23,7 +23,6 @@
 #include <linux/netfilter_ipv4/ip_tables.h>
 #include <linux/netlink.h>
 #include <linux/spinlock.h>
-#include <linux/brlock.h>
 #include <linux/sysctl.h>
 #include <linux/proc_fs.h>
 #include <linux/security.h>
@@ -679,8 +678,7 @@
 
 cleanup:
 	nf_unregister_queue_handler(PF_INET);
-	br_write_lock_bh(BR_NETPROTO_LOCK);
-	br_write_unlock_bh(BR_NETPROTO_LOCK);
+	synchronize_net();
 	ipq_flush(NF_DROP);
 	
 cleanup_sysctl:



