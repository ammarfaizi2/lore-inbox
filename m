Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbTDHQBq (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 12:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbTDHQBq (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 12:01:46 -0400
Received: from customer.iplannetworks.net ([200.69.220.85]:35982 "EHLO
	mail.xtech.com.ar") by vger.kernel.org with ESMTP id S261682AbTDHQBD (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 12:01:03 -0400
Message-ID: <3E92F591.5000906@linux.org.ar>
Date: Tue, 08 Apr 2003 13:15:13 -0300
From: diegows <diegows@linux.org.ar>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netfilter-devel@lists.netfilter.org, samj@samj.net,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: quota.patch
Content-Type: multipart/mixed;
 boundary="------------030104080309080409050504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030104080309080409050504
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This is a modified quota match writing by Sam j. I add quota per ip and
quota per connection (this is not very useful i think now...). Please
try this and send  to me any comments and suggestions.

Thanks.


--------------030104080309080409050504
Content-Type: text/plain;
 name="quota.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="quota.patch"

diff -uNr --exclude=Makefile linux-2.4.20/include/linux/netfilter_ipv4/ipt_quota.h linux-2.4.20-2/include/linux/netfilter_ipv4/ipt_quota.h
--- linux-2.4.20/include/linux/netfilter_ipv4/ipt_quota.h	Wed Dec 31 21:00:00 1969
+++ linux-2.4.20-2/include/linux/netfilter_ipv4/ipt_quota.h	Tue Apr  8 12:11:56 2003
@@ -0,0 +1,37 @@
+#ifndef _IPT_QUOTA_H
+#define _IPT_QUOTA_H
+
+/* print debug info in both kernel/netfilter module & iptable library */
+/* #define DEBUG_IPT_QUOTA */
+
+#define QUOTA_HASH_SIZE 1024
+
+/* modes */
+#define IPQUOTA 1		/* quota per ip enable */
+#define QUOTA 0			/* general quota */
+#define CONNQUOTA 2		/* quota per connection */
+ /**/ struct ipquota_list
+{
+  u_int32_t conn_index;
+  u_int64_t quota;
+  struct ipquota_list *next;
+};
+
+struct ipt_quota_info
+{
+  u_int64_t quota;
+  int mode;
+  int invert;
+  struct ipquota_list *quota_hash[QUOTA_HASH_SIZE];
+};
+
+#define QUOTA_INDEX(skb, info) (q->mode == CONNQUOTA ? (skb->nh.iph->saddr + \
+	  skb->nh.iph->daddr + \
+	  skb->h.th->source +  \
+	  skb->h.th->dest +  \
+	  skb->nh.iph->protocol) : \
+	  (skb->nh.iph->saddr))
+
+#define QUOTA_KEY(conn_index) (conn_index % QUOTA_HASH_SIZE)
+
+#endif /*_IPT_QUOTA_H*/
diff -uNr --exclude=Makefile linux-2.4.20/include/linux/netfilter_ipv4/ipt_quota.h~ linux-2.4.20-2/include/linux/netfilter_ipv4/ipt_quota.h~
--- linux-2.4.20/include/linux/netfilter_ipv4/ipt_quota.h~	Wed Dec 31 21:00:00 1969
+++ linux-2.4.20-2/include/linux/netfilter_ipv4/ipt_quota.h~	Tue Apr  8 12:11:56 2003
@@ -0,0 +1,37 @@
+#ifndef _IPT_QUOTA_H
+#define _IPT_QUOTA_H
+
+/* print debug info in both kernel/netfilter module & iptable library */
+/* #define DEBUG_IPT_QUOTA */
+
+#define QUOTA_HASH_SIZE 1024
+
+/* modes */
+#define IPQUOTA 1		/* quota per ip enable */
+#define QUOTA 0			/* general quota */
+#define CONNQUOTA 2		/* quota per connection */
+ /**/ struct ipquota_list
+{
+  u_int32_t conn_index;
+  u_int64_t quota;
+  struct ipquota_list *next;
+};
+
+struct ipt_quota_info
+{
+  u_int64_t quota;
+  int mode;
+  int invert;
+  struct ipquota_list *quota_hash[QUOTA_HASH_SIZE];
+};
+
+#define QUOTA_INDEX(skb, info) (q->mode == CONNQUOTA ? (skb->nh.iph->saddr + \
+	  skb->nh.iph->daddr + \
+	  skb->h.th->source +  \
+	  skb->h.th->dest +  \
+	  skb->nh.iph->protocol) : \
+	  (skb->nh.iph->saddr))
+
+#define QUOTA_KEY(conn_index) (conn_index % QUOTA_HASH_SIZE)
+
+#endif /*_IPT_QUOTA_H*/
diff -uNr --exclude=Makefile linux-2.4.20/net/ipv4/netfilter/ipt_quota.c linux-2.4.20-2/net/ipv4/netfilter/ipt_quota.c
--- linux-2.4.20/net/ipv4/netfilter/ipt_quota.c	Wed Dec 31 21:00:00 1969
+++ linux-2.4.20-2/net/ipv4/netfilter/ipt_quota.c	Tue Apr  8 12:13:10 2003
@@ -0,0 +1,234 @@
+/* 
+ * netfilter module to enforce network quotas
+ *
+ * Sam Johnston <samj@samj.net>
+ *
+ * 2003/04/02 Diego Woitasen (diegows@linux.org.ar) add quota per ip and quota
+ *            per connection
+ */
+#include <linux/module.h>
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <linux/ip.h>
+#include <linux/tcp.h>
+#include <linux/netfilter_ipv4/ip_tables.h>
+#include <linux/netfilter_ipv4/ipt_quota.h>
+#include <linux/netfilter_ipv4/ip_conntrack.h>
+
+MODULE_LICENSE ("GPL");
+
+static spinlock_t quota_lock = SPIN_LOCK_UNLOCKED;
+
+static inline int
+quota_hash_get (struct ipquota_list **hash, u_int32_t conn_index,
+		u_int64_t * quota)
+{
+
+  struct ipquota_list *node = hash[QUOTA_KEY (conn_index)];
+
+  while (node != NULL)
+    {
+      if (node->conn_index == conn_index)
+	{
+	  *quota = node->quota;
+	  return (0);
+	}
+      node = node->next;
+    }
+
+  return (-1);
+
+}
+
+static inline int
+quota_hash_sum (struct ipquota_list **hash, u_int32_t conn_index,
+		u_int16_t datalen)
+{
+
+  struct ipquota_list
+    *node = hash[QUOTA_KEY (conn_index)], *tmp = hash[QUOTA_KEY (conn_index)];
+
+  while (tmp != NULL)
+    {
+      if (tmp->conn_index == conn_index)
+	{
+	  tmp->quota += datalen;
+	  return (0);
+	}
+      tmp = tmp->next;
+    }
+
+  tmp = kmalloc (sizeof (struct ipquota_list), GFP_KERNEL);
+  if (!tmp)
+    {
+      printk ("quota_hash_sum()->kmalloc fail");
+      return (-1);
+    }
+
+  tmp->conn_index = conn_index;
+  tmp->quota = datalen;
+  tmp->next = NULL;
+
+  if (node == NULL)
+    hash[QUOTA_KEY (conn_index)] = tmp;
+  else
+    {
+      while (node->next != NULL)
+	node = node->next;
+      node->next = tmp;
+    }
+
+  return (0);
+
+}
+
+static inline int
+quota_hash_reset (struct ipquota_list **hash, u_int32_t conn_index)
+{
+
+  struct ipquota_list *node = hash[QUOTA_KEY (conn_index)];
+
+  while (node)
+    {
+      if (node->conn_index == conn_index)
+	{
+	  node->quota = 0;
+	  return 0;
+	}
+      node = node->next;
+    }
+
+  return (-1);
+
+}
+
+static int
+match (const struct sk_buff *skb,
+       const struct net_device *in,
+       const struct net_device *out,
+       const void *matchinfo,
+       int offset, const void *hdr, u_int16_t datalen, int *hotdrop)
+{
+
+  struct ipt_quota_info *q = (struct ipt_quota_info *) matchinfo;
+  u_int64_t quota = 0;
+
+  spin_lock_bh (&quota_lock);
+
+  if (q->mode == QUOTA)
+    {
+      if (q->quota >= datalen)
+	{
+	  /* we can affor
+	     d this one */
+	  q->quota -= datalen;
+	  goto quota;
+	}
+      /* so we do not allow even small packets from now on */
+      q->quota = 0;
+    }
+  else
+    {
+
+      if (quota_hash_get (q->quota_hash, QUOTA_INDEX (skb, q), &quota) < 0
+	  || quota < q->quota)
+	{
+
+	  if (quota_hash_sum (q->quota_hash, QUOTA_INDEX (skb, q), datalen)
+	      < 0)
+	    {
+	      printk ("quota_hash_sum() error");
+	      spin_unlock_bh (&quota_lock);
+	      return 0;
+	    }
+	  goto quota;
+	}
+    }
+
+  if (q->mode == CONNQUOTA)
+    {
+      enum ip_conntrack_info ct_state;
+
+      ip_conntrack_get ((struct sk_buff *) skb, &ct_state);
+      if (ct_state == IP_CT_NEW)
+	{
+	  quota_hash_reset (q->quota_hash, QUOTA_INDEX (skb, q));
+	  goto quota;
+	}
+    }
+
+#ifdef DEBUG_IPT_QUOTA
+  printk ("IPT Quota Failed: max=%llu\n", q->quota);
+#endif
+
+  spin_unlock_bh (&quota_lock);
+  if (q->invert == 1)
+    return 1;
+  return 0;
+
+quota:
+  spin_unlock_bh (&quota_lock);
+#ifdef DEBUG_IPT_QUOTA
+  printk ("IPT Quota OK: %llu datlen %d \n", q->quota, datalen);
+#endif
+  if (q->invert == 1)
+    return 0;
+  return 1;
+
+}
+
+static int
+checkentry (const char *tablename,
+	    const struct ipt_ip *ip,
+	    void *matchinfo, unsigned int matchsize, unsigned int hook_mask)
+{
+  /* TODO: spinlocks? sanity checks? */
+  if (matchsize != IPT_ALIGN (sizeof (struct ipt_quota_info)))
+    return 0;
+
+  return 1;
+}
+
+static void
+destroy (void *matchinfo, unsigned int size)
+{
+  struct ipt_quota_info *q = (struct ipt_quota_info *) matchinfo;
+
+  int i;
+
+  for (i = 0; i < QUOTA_HASH_SIZE; i++)
+    {
+      if (q->quota_hash[i])
+	{
+	  struct ipquota_list *tmp1, *tmp2;
+	  tmp1 = q->quota_hash[i];
+
+	  while (tmp1)
+	    {
+	      tmp2 = tmp1;
+	      tmp1 = tmp1->next;
+	      kfree (tmp2);
+	    }
+	}
+
+    }
+}
+
+static struct ipt_match quota_match
+  = { {NULL, NULL}, "quota", &match, &checkentry, &destroy, THIS_MODULE };
+
+static int __init
+init (void)
+{
+  return ipt_register_match (&quota_match);
+}
+
+static void __exit
+fini (void)
+{
+  ipt_unregister_match (&quota_match);
+}
+
+module_init (init);
+module_exit (fini);
diff -uNr --exclude=Makefile linux-2.4.20/net/ipv4/netfilter/ipt_quota.c~ linux-2.4.20-2/net/ipv4/netfilter/ipt_quota.c~
--- linux-2.4.20/net/ipv4/netfilter/ipt_quota.c~	Wed Dec 31 21:00:00 1969
+++ linux-2.4.20-2/net/ipv4/netfilter/ipt_quota.c~	Tue Apr  8 12:11:56 2003
@@ -0,0 +1,241 @@
+/* 
+ * netfilter module to enforce network quotas
+ *
+ * Sam Johnston <samj@samj.net>
+ *
+ * 2003/04/02 Diego Woitasen (diegows@linux.org.ar) add quota per ip and quota
+ *            per connection
+ */
+#include <linux/module.h>
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <linux/ip.h>
+#include <linux/tcp.h>
+#include <linux/netfilter_ipv4/ip_tables.h>
+#include <linux/netfilter_ipv4/ipt_quota.h>
+#include <linux/netfilter_ipv4/ip_conntrack.h>
+
+MODULE_LICENSE ("GPL");
+
+static spinlock_t quota_lock = SPIN_LOCK_UNLOCKED;
+
+static inline int
+quota_hash_get (struct ipquota_list **hash, u_int32_t conn_index,
+		u_int64_t * quota)
+{
+
+  struct ipquota_list *node = hash[QUOTA_KEY (conn_index)];
+
+  while (node != NULL)
+    {
+      if (node->conn_index == conn_index)
+	{
+	  *quota = node->quota;
+	  return (0);
+	}
+      node = node->next;
+    }
+
+  return (-1);
+
+}
+
+static inline int
+quota_hash_sum (struct ipquota_list **hash, u_int32_t conn_index,
+		u_int16_t datalen)
+{
+
+  struct ipquota_list
+    *node = hash[QUOTA_KEY (conn_index)], *tmp = hash[QUOTA_KEY (conn_index)];
+
+  while (tmp != NULL)
+    {
+      if (tmp->conn_index == conn_index)
+	{
+	  tmp->quota += datalen;
+	  return (0);
+	}
+      tmp = tmp->next;
+    }
+
+  tmp = kmalloc (sizeof (struct ipquota_list), GFP_KERNEL);
+  if (!tmp)
+    {
+      printk ("quota_hash_sum()->kmalloc fail");
+      return (-1);
+    }
+
+  tmp->conn_index = conn_index;
+  tmp->quota = datalen;
+  tmp->next = NULL;
+
+  if (node == NULL)
+    hash[QUOTA_KEY (conn_index)] = tmp;
+  else
+    {
+      while (node->next != NULL)
+	node = node->next;
+      node->next = tmp;
+    }
+
+  return (0);
+
+}
+
+static inline int
+quota_hash_reset (struct ipquota_list **hash, u_int32_t conn_index)
+{
+
+  struct ipquota_list *node = hash[QUOTA_KEY (conn_index)];
+
+  while (node)
+    {
+      if (node->conn_index == conn_index)
+	{
+	  node->quota = 0;
+	  return 0;
+	}
+      node = node->next;
+    }
+
+  return (-1);
+
+}
+
+static int
+match (const struct sk_buff *skb,
+       const struct net_device *in,
+       const struct net_device *out,
+       const void *matchinfo,
+       int offset, const void *hdr, u_int16_t datalen, int *hotdrop)
+{
+
+  struct ipt_quota_info *q = (struct ipt_quota_info *) matchinfo;
+  u_int64_t quota = 0;
+
+  spin_lock_bh (&quota_lock);
+
+  if (q->mode == QUOTA)
+    {
+      if (q->quota >= datalen)
+	{
+	  /* we can affor
+	     d this one */
+	  q->quota -= datalen;
+	  spin_unlock_bh (&quota_lock);
+#ifdef DEBUG_IPT_QUOTA
+	  printk ("IPT Quota OK: %llu datlen %d \n", q->quota, datalen);
+#endif
+	goto quota;
+	}
+      /* so we do not allow even small packets from now on */
+      q->quota = 0;
+    }
+  else
+    {
+
+      if (quota_hash_get (q->quota_hash, QUOTA_INDEX (skb, q), &quota) < 0
+	  || quota < q->quota)
+	{
+	  printk ("quota. quota=%llu, max=%llu", quota, q->quota);
+	  if (quota_hash_sum (q->quota_hash, QUOTA_INDEX (skb, q), datalen)
+	      < 0)
+	    {
+	      printk ("quota_hash_sum() error");
+	      spin_unlock_bh (&quota_lock);
+	      return 0;
+	    }
+	  spin_unlock_bh (&quota_lock);
+#ifdef DEBUG_IPT_QUOTA
+	  printk ("IPT IP/CONN Quota OK: %llu datlen %d \n", q->quota,
+		  datalen);
+#endif
+	goto quota;
+	}
+    }
+
+
+  if (q->mode == CONNQUOTA)
+    {
+      enum ip_conntrack_info ct_state;
+
+      ip_conntrack_get ((struct sk_buff *)skb, &ct_state);
+      if (ct_state == IP_CT_NEW)
+	{
+	  quota_hash_reset (q->quota_hash, QUOTA_INDEX (skb, q));
+	  goto quota;
+	}
+    }
+
+#ifdef DEBUG_IPT_QUOTA
+  printk ("IPT Quota Failed: max=%llu\n", q->quota);
+#endif
+
+  spin_unlock_bh (&quota_lock);
+  if (q->invert == 1)
+    return 1;
+  return 0;
+
+quota:
+	  if (q->invert == 1)
+	    return 0;
+	  return 1;
+
+
+}
+
+static int
+checkentry (const char *tablename,
+	    const struct ipt_ip *ip,
+	    void *matchinfo, unsigned int matchsize, unsigned int hook_mask)
+{
+  /* TODO: spinlocks? sanity checks? */
+  if (matchsize != IPT_ALIGN (sizeof (struct ipt_quota_info)))
+    return 0;
+
+  return 1;
+}
+
+static void
+destroy (void *matchinfo, unsigned int size)
+{
+  struct ipt_quota_info *q = (struct ipt_quota_info *) matchinfo;
+
+  int i;
+
+  for (i = 0; i < QUOTA_HASH_SIZE; i++)
+    {
+      if (q->quota_hash[i])
+	{
+	  struct ipquota_list *tmp1, *tmp2;
+	  tmp1 = q->quota_hash[i];
+	  printk ("\ni=%d, tmp1=%p", i, tmp1);
+	  while (tmp1)
+	    {
+	      tmp2 = tmp1;
+	      tmp1 = tmp1->next;
+	      kfree (tmp2);
+	    }
+	}
+
+    }
+}
+
+static struct ipt_match quota_match
+  = { {NULL, NULL}, "quota", &match, &checkentry, &destroy, THIS_MODULE };
+
+static int __init
+init (void)
+{
+  return ipt_register_match (&quota_match);
+}
+
+static void __exit
+fini (void)
+{
+  ipt_unregister_match (&quota_match);
+}
+
+module_init (init);
+module_exit (fini);


--------------030104080309080409050504
Content-Type: text/plain;
 name="quota.patch.config.in"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="quota.patch.config.in"

  dep_tristate '  limit match support' CONFIG_IP_NF_MATCH_LIMIT $CONFIG_IP_NF_IPTABLES
  dep_tristate '  quota match support' CONFIG_IP_NF_MATCH_QUOTA $CONFIG_IP_NF_IPTABLES


--------------030104080309080409050504
Content-Type: text/plain;
 name="quota.patch.configure.help"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="quota.patch.configure.help"

CONFIG_IP_NF_MATCH_LIMIT
quota match support
CONFIG_IP_NF_MATCH_QUOTA
  This match implements network quotas, quota per ip and quota per connection.

  If you want to compile it as a module, say M here and read
  Documentation/modules.txt.  If unsure, say `N'.



--------------030104080309080409050504
Content-Type: text/plain;
 name="quota.patch.help"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="quota.patch.help"

Author: Sam Johnston <samj@samj.net>
Status: worksforme

This option adds CONFIG_IP_NF_MATCH_QUOTA, which implements network
quotas by decrementing a byte counter with each packet.
Also implements quota per source ip address and quota per connection 
(Diego Woitasen <diegows@linux.org.ar>)

Supported options are:
--quota <bytes>
  The quota in bytes.
  
--ipquota <bytes>
  The quota per source ip address in bytes
  
--connquota <bytes>
  The quota per connection in bytes



--------------030104080309080409050504
Content-Type: text/plain;
 name="quota.patch.makefile"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="quota.patch.makefile"

obj-$(CONFIG_IP_NF_MATCH_LIMIT) += ipt_limit.o
obj-$(CONFIG_IP_NF_MATCH_QUOTA) += ipt_quota.o


--------------030104080309080409050504--

