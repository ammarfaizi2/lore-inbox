Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbULAF0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbULAF0F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 00:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbULAF0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 00:26:04 -0500
Received: from ozlabs.org ([203.10.76.45]:1445 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261183AbULAFZ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 00:25:28 -0500
Subject: [PATCH] Remove netfilter warnings on copy_to_user
From: Rusty Russell <rusty@rustcorp.com.au>
To: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Netfilter development mailing list 
	<netfilter-devel@lists.netfilter.org>
Content-Type: text/plain
Date: Wed, 01 Dec 2004 16:25:16 +1100
Message-Id: <1101878716.11835.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: Remove copy_to_user Warnings in Netfilter
Status: Trivial
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

After changing firewall rules, we try to return the counters to
userspace.  We didn't fail at that point if the copy failed, but it
doesn't really matter.  Someone added a warn_unused_result attribute
to copy_to_user, so we get bogus warnings.

Index: linux-2.6.10-rc2-bk13-Netfilter/net/ipv4/netfilter/ip_tables.c
===================================================================
--- linux-2.6.10-rc2-bk13-Netfilter.orig/net/ipv4/netfilter/ip_tables.c	2004-11-30 12:45:23.000000000 +1100
+++ linux-2.6.10-rc2-bk13-Netfilter/net/ipv4/netfilter/ip_tables.c	2004-12-01 15:49:35.000000000 +1100
@@ -1141,12 +1141,12 @@
 	/* Decrease module usage counts and free resource */
 	IPT_ENTRY_ITERATE(oldinfo->entries, oldinfo->size, cleanup_entry,NULL);
 	vfree(oldinfo);
-	/* Silent error: too late now. */
-	copy_to_user(tmp.counters, counters,
-		     sizeof(struct ipt_counters) * tmp.num_counters);
+	if (copy_to_user(tmp.counters, counters,
+			 sizeof(struct ipt_counters) * tmp.num_counters) != 0)
+		ret = -EFAULT;
 	vfree(counters);
 	up(&ipt_mutex);
-	return 0;
+	return ret;
 
  put_module:
 	module_put(t->me);
Index: linux-2.6.10-rc2-bk13-Netfilter/net/ipv6/netfilter/ip6_tables.c
===================================================================
--- linux-2.6.10-rc2-bk13-Netfilter.orig/net/ipv6/netfilter/ip6_tables.c	2004-11-16 15:30:12.000000000 +1100
+++ linux-2.6.10-rc2-bk13-Netfilter/net/ipv6/netfilter/ip6_tables.c	2004-12-01 15:50:28.000000000 +1100
@@ -1222,11 +1222,12 @@
 	IP6T_ENTRY_ITERATE(oldinfo->entries, oldinfo->size, cleanup_entry,NULL);
 	vfree(oldinfo);
 	/* Silent error: too late now. */
-	copy_to_user(tmp.counters, counters,
-		     sizeof(struct ip6t_counters) * tmp.num_counters);
+	if (copy_to_user(tmp.counters, counters,
+			 sizeof(struct ip6t_counters) * tmp.num_counters) != 0)
+		ret = -EFAULT;
 	vfree(counters);
 	up(&ip6t_mutex);
-	return 0;
+	return ret;
 
  put_module:
 	module_put(t->me);
Index: linux-2.6.10-rc2-bk13-Netfilter/net/ipv4/netfilter/arp_tables.c
===================================================================
--- linux-2.6.10-rc2-bk13-Netfilter.orig/net/ipv4/netfilter/arp_tables.c	2004-11-16 15:30:12.000000000 +1100
+++ linux-2.6.10-rc2-bk13-Netfilter/net/ipv4/netfilter/arp_tables.c	2004-12-01 15:49:54.000000000 +1100
@@ -948,12 +948,12 @@
 	/* Decrease module usage counts and free resource */
 	ARPT_ENTRY_ITERATE(oldinfo->entries, oldinfo->size, cleanup_entry,NULL);
 	vfree(oldinfo);
-	/* Silent error: too late now. */
-	copy_to_user(tmp.counters, counters,
-		     sizeof(struct arpt_counters) * tmp.num_counters);
+	if (copy_to_user(tmp.counters, counters,
+			 sizeof(struct arpt_counters) * tmp.num_counters) != 0)
+		ret = -EFAULT;
 	vfree(counters);
 	up(&arpt_mutex);
-	return 0;
+	return ret;
 
  put_module:
 	module_put(t->me);

-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

