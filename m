Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbUDHPYO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 11:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbUDHPYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 11:24:14 -0400
Received: from imr1.ericy.com ([198.24.6.9]:40353 "EHLO imr1.ericy.com")
	by vger.kernel.org with ESMTP id S261928AbUDHPWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 11:22:20 -0400
Message-ID: <008701c41d7d$47020a10$0348858e@D4SF2B21>
From: "Mathieu Giguere" <Mathieu.Giguere@ericsson.ca>
To: <linux-kernel@vger.kernel.org>
Cc: "Mathieu Giguere \(QB/LMC\)" <mathieu.giguere@ericsson.com>
Subject: IPv4 and IPv6 stack multi-FIB, scalable in the million of entries.
Date: Thu, 8 Apr 2004 11:22:17 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

    We currently looking for a multi-FIB, scalable routing table in the
million of entries, no routing cache for IPv4 and IPv6.  We want a IP stack
that can have a log(n) (or better) insertion/deletion and lookup
performance.  Predictable performance, even in the million of entries.

    We open the mess, and we soon realize the amplitude of removing the
cache.  I send this e-mail hoping someone have already remove this useless
cache.


    I join a patch with the fib_hash in IPv4 replace with a patricia tree
ready for multi-FIB base on a 2.4.22 kernel.  This is the beginning of a
long cleanup.

Regards,

(please CC me, since I'm not part of the mailing list)

Mathieu Giguere ing.
Software designer
Ericsson Research Canada. mathieu.giguere@ericsson.com



----------------------------------------------------------------------------
diff -HNaur /tmp/linux-2.4.22/include/net/ip_fib.h
linux-2.4.22/include/net/ip_fib.h
--- /tmp/linux-2.4.22/include/net/ip_fib.h 2001-02-09
14:34:13.000000000 -0500
+++ linux-2.4.22/include/net/ip_fib.h 2004-04-02 17:34:50.000000000 -0500
@@ -227,6 +227,10 @@
/* Exported by fib_hash.c */
extern struct fib_table *fib_hash_init(int id);

+/* Exported by fib_table.c */
+extern struct fib_table *fib_table_init(int id);
+
+
#ifdef CONFIG_IP_MULTIPLE_TABLES
/* Exported by fib_rules.c */

diff -HNaur /tmp/linux-2.4.22/include/net/table.h
linux-2.4.22/include/net/table.h
--- /tmp/linux-2.4.22/include/net/table.h 1969-12-31
19:00:00.000000000 -0500
+++ linux-2.4.22/include/net/table.h 2004-04-05 17:12:28.000000000 -0400
@@ -0,0 +1,82 @@
+/*
+ * Routing Table
+ * Copyright (C) 1998 Kunihiro Ishiguro
+ *
+ * This file is part of GNU Zebra.
+ *
+ * GNU Zebra is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * GNU Zebra is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with GNU Zebra; see the file COPYING. If not, write to the Free
+ * Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+ * 02111-1307, USA.
+ */
+
+#ifndef _TABLE_H
+#define _TABLE_H
+
+#include <linux/slab.h>
+#include <linux/in.h>
+#include <linux/in6.h>
+
+
+#define PREFIX_SIZE 19
+#define PREFIXLEN_MAX (PREFIX_SIZE*8) //160 bits of key.
+
+struct prefix
+{
+ u_char prefix[PREFIX_SIZE];
+ u_char prefixlen;
+};
+
+void prefix_copy(struct prefix *to, struct prefix *from);
+int prefix_match (struct prefix *n, struct prefix *p);
+
+/* Routing table top structure. */
+struct route_table
+{
+ struct route_node *top;
+};
+
+/* Each routing entry. */
+struct route_node
+{
+ /* Actual prefix of this radix. */
+ struct prefix p;
+
+ /* Tree link. */
+ struct route_table *table;
+ struct route_node *parent;
+ struct route_node *link[2];
+#define l_left link[0]
+#define l_right link[1]
+
+ /* Lock of this radix */
+ unsigned int lock;
+
+ /* Each node of route. */
+ void *info;
+};
+
+/* Prototypes. */
+struct route_table *route_table_init (void);
+void route_table_finish (struct route_table *);
+
+void route_unlock_node (struct route_node *node);
+struct route_node *route_top (struct route_table *);
+struct route_node *route_next (struct route_node *);
+struct route_node *route_next_until (struct route_node *, struct route_node
*);
+struct route_node *route_node_get (struct route_table *, struct prefix *);
+struct route_node *route_node_lookup (struct route_table *, struct prefix
*);
+struct route_node *route_lock_node (struct route_node *node);
+struct route_node *route_node_match (struct route_table *, struct prefix
*);
+
+#endif /* _TABLE_H */
diff -HNaur /tmp/linux-2.4.22/net/core/Makefile
linux-2.4.22/net/core/Makefile
--- /tmp/linux-2.4.22/net/core/Makefile 2002-08-02 20:39:46.000000000 -0400
+++ linux-2.4.22/net/core/Makefile 2004-04-02 12:00:50.000000000 -0500
@@ -21,7 +21,7 @@

obj-$(CONFIG_FILTER) += filter.o

-obj-$(CONFIG_NET) += dev.o dev_mcast.o dst.o neighbour.o rtnetlink.o
utils.o
+obj-$(CONFIG_NET) += dev.o dev_mcast.o dst.o neighbour.o rtnetlink.o
utils.o table.o

obj-$(CONFIG_NETFILTER) += netfilter.o
obj-$(CONFIG_NET_DIVERT) += dv.o
diff -HNaur /tmp/linux-2.4.22/net/core/table.c linux-2.4.22/net/core/table.c
--- /tmp/linux-2.4.22/net/core/table.c 1969-12-31 19:00:00.000000000 -0500
+++ linux-2.4.22/net/core/table.c 2004-04-05 11:35:23.000000000 -0400
@@ -0,0 +1,455 @@
+/*
+ * Routing Table functions.
+ * Copyright (C) 1998 Kunihiro Ishiguro
+ *
+ * This file is part of GNU Zebra.
+ *
+ * GNU Zebra is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * GNU Zebra is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with GNU Zebra; see the file COPYING. If not, write to the Free
+ * Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+ * 02111-1307, USA.
+ */
+
+#include <net/table.h>
+
+/* Utility mask array. */
+static u_char maskbit[] =
+{
+ 0x00, 0x80, 0xc0, 0xe0, 0xf0, 0xf8, 0xfc, 0xfe, 0xff
+};
+
+void prefix_copy(struct prefix *to, struct prefix *from){
+ to->prefixlen = from->prefixlen;
+ memcpy(to->prefix, from->prefix, PREFIX_SIZE);
+}
+
+/* If n includes p prefix then return 1 else return 0. */
+int prefix_match (struct prefix *n, struct prefix *p)
+{
+ int offset;
+ int shift;
+
+ /* Set both prefix's head pointer. */
+ u_char *np = n->prefix;
+ u_char *pp = p->prefix;
+
+ /* If n's prefix is longer than p's one return 0. */
+ if (n->prefixlen > p->prefixlen) return 0;
+
+ offset = n->prefixlen / 8;
+ shift = n->prefixlen % 8;
+
+ if (shift) {
+ if (maskbit[shift] & (np[offset] ^ pp[offset])) return 0;
+ }
+
+ while (offset--) {
+ if (np[offset] != pp[offset]) return 0;
+ }
+ return 1;
+}
+
+void route_node_delete (struct route_node *);
+void route_table_free (struct route_table *);
+
+struct route_table * route_table_init (void)
+{
+ struct route_table *rt;
+
+ rt = kmalloc(sizeof (struct route_table), GFP_KERNEL);
+ if(rt != NULL) memset(rt, 0, sizeof(struct route_table));
+
+ return rt;
+}
+
+void route_table_finish (struct route_table *rt)
+{
+ route_table_free (rt);
+}
+
+/* Allocate new route node. */
+struct route_node * route_node_new (void)
+{
+ struct route_node *node;
+ node = kmalloc(sizeof (struct route_node), GFP_KERNEL);
+ if(node != NULL) memset(node, 0, sizeof(struct route_node));
+
+ return node;
+}
+
+/* Allocate new route node with prefix set. */
+struct route_node * route_node_set (struct route_table *table, struct
prefix *prefix)
+{
+ struct route_node *node;
+
+ node = route_node_new ();
+
+ prefix_copy (&node->p, prefix);
+ node->table = table;
+
+ return node;
+}
+
+/* Free route node. */
+void route_node_free (struct route_node *node)
+{
+ kfree (node);
+}
+
+/* Free route table. */
+void route_table_free (struct route_table *rt)
+{
+ struct route_node *tmp_node;
+ struct route_node *node;
+
+ if (rt == NULL)
+ return;
+
+ node = rt->top;
+
+ while (node)
+ {
+ if (node->l_left)
+ {
+ node = node->l_left;
+ continue;
+ }
+
+ if (node->l_right)
+ {
+ node = node->l_right;
+ continue;
+ }
+
+ tmp_node = node;
+ node = node->parent;
+
+ if (node != NULL)
+ {
+ if (node->l_left == tmp_node)
+ node->l_left = NULL;
+ else
+ node->l_right = NULL;
+
+ route_node_free (tmp_node);
+ }
+ else
+ {
+ route_node_free (tmp_node);
+ break;
+ }
+ }
+
+ kfree(rt);
+}
+
+/* Common prefix route genaration. */
+static void route_common (struct prefix *n, struct prefix *p, struct prefix
*new)
+{
+ int i;
+ u_char diff;
+ u_char mask;
+
+ u_char *np = n->prefix;
+ u_char *pp = p->prefix;
+ u_char *newp = new->prefix;
+
+ for (i = 0; i < p->prefixlen / 8; i++)
+ {
+ if (np[i] == pp[i])
+ newp[i] = np[i];
+ else
+ break;
+ }
+
+ new->prefixlen = i * 8;
+
+ if (new->prefixlen != p->prefixlen)
+ {
+ diff = np[i] ^ pp[i];
+ mask = 0x80;
+ while (new->prefixlen < p->prefixlen && !(mask & diff))
+ {
+ mask >>= 1;
+ new->prefixlen++;
+ }
+ newp[i] = np[i] & maskbit[new->prefixlen % 8];
+ }
+}
+
+/* Macro version of check_bit (). */
+#define CHECK_BIT(X,P) ((((u_char *)(X))[(P) / 8]) >> (7 - ((P) % 8)) & 1)
+
+/* Check bit of the prefix. */
+static int check_bit (u_char *prefix, u_char prefixlen)
+{
+ int offset;
+ int shift;
+ u_char *p = (u_char *)prefix;
+
+ offset = prefixlen / 8;
+ shift = 7 - (prefixlen % 8);
+
+ return (p[offset] >> shift & 1);
+}
+
+/* Macro version of set_link (). */
+#define SET_LINK(X,Y) (X)->link[CHECK_BIT(&(Y)->prefix,(X)->prefixlen)] =
(Y);\
+ (Y)->parent = (X)
+
+static void set_link (struct route_node *node, struct route_node *new)
+{
+ int bit;
+
+ bit = check_bit (new->p.prefix, node->p.prefixlen);
+
+ node->link[bit] = new;
+ new->parent = node;
+}
+
+/* Lock node. */
+struct route_node * route_lock_node (struct route_node *node)
+{
+ node->lock++;
+ return node;
+}
+
+/* Unlock node. */
+void route_unlock_node (struct route_node *node)
+{
+ node->lock--;
+
+ if (node->lock == 0) route_node_delete (node);
+}
+
+/* Find matched prefix. */
+struct route_node * route_node_match (struct route_table *table, struct
prefix *p)
+{
+ struct route_node *node;
+ struct route_node *matched;
+
+ matched = NULL;
+ node = table->top;
+
+ /* Walk down tree. If there is matched route then store it to
+ matched. */
+ while (node && node->p.prefixlen <= p->prefixlen && prefix_match
(&node->p, p))
+ {
+ if (node->info != NULL) matched = node;
+ node = node->link[check_bit(p->prefix, node->p.prefixlen)];
+ }
+
+ /* If matched route found, return it. */
+ if (matched) return route_lock_node (matched);
+
+ return NULL;
+}
+
+/* Lookup same prefix node. Return NULL when we can't find route. */
+struct route_node * route_node_lookup (struct route_table *table, struct
prefix *p)
+{
+ struct route_node *node;
+
+ node = table->top;
+
+ while (node && node->p.prefixlen <= p->prefixlen && prefix_match
(&node->p, p)) {
+ if (node->p.prefixlen == p->prefixlen && (node->info != NULL)) return
route_lock_node (node);
+ node = node->link[check_bit(p->prefix, node->p.prefixlen)];
+ }
+
+ return NULL;
+}
+
+/* Add node to routing table. */
+struct route_node * route_node_get (struct route_table *table, struct
prefix *p)
+{
+ struct route_node *new;
+ struct route_node *node;
+ struct route_node *match;
+
+ if(p->prefixlen > PREFIXLEN_MAX) {
+ printk(KERN_ERR "table: route_node_get prefix length to big for this table
%d, max %d.\n", p->prefixlen, PREFIXLEN_MAX);
+ return NULL;
+ }
+
+ match = NULL;
+ node = table->top;
+ while (node && node->p.prefixlen <= p->prefixlen &&
+ prefix_match (&node->p, p))
+ {
+ if (node->p.prefixlen == p->prefixlen)
+ {
+ route_lock_node (node);
+ return node;
+ }
+ match = node;
+ node = node->link[check_bit(p->prefix, node->p.prefixlen)];
+ }
+
+ if (node == NULL)
+ {
+ new = route_node_set (table, p);
+ if (match)
+ set_link (match, new);
+ else
+ table->top = new;
+ }
+ else
+ {
+ new = route_node_new ();
+ route_common (&node->p, p, &new->p);
+ new->table = table;
+ set_link (new, node);
+
+ if (match)
+ set_link (match, new);
+ else
+ table->top = new;
+
+ if (new->p.prefixlen != p->prefixlen)
+ {
+ match = new;
+ new = route_node_set (table, p);
+ set_link (match, new);
+ }
+ }
+ route_lock_node (new);
+
+ return new;
+}
+
+/* Delete node from the routing table. */
+void route_node_delete (struct route_node *node)
+{
+ struct route_node *child;
+ struct route_node *parent;
+
+ if (node->l_left && node->l_right) return;
+
+ if (node->l_left) {
+ child = node->l_left;
+ } else {
+ child = node->l_right;
+ }
+
+ parent = node->parent;
+
+ if (child) child->parent = parent;
+
+ if (parent) {
+ if (parent->l_left == node) {
+ parent->l_left = child;
+ } else {
+ parent->l_right = child;
+ }
+ } else {
+ node->table->top = child;
+ }
+
+ route_node_free (node);
+
+ /* If parent node is stub then delete it also. */
+ if (parent && parent->lock == 0) route_node_delete (parent);
+}
+
+/* Get fist node and lock it. This function is useful when one want
+ to lookup all the node exist in the routing table. */
+struct route_node * route_top (struct route_table *table)
+{
+ /* If there is no node in the routing table return NULL. */
+ if (table->top == NULL) return NULL;
+
+ /* Lock the top node and return it. */
+ route_lock_node (table->top);
+ return table->top;
+}
+
+/* Unlock current node and lock next node then return it. */
+struct route_node * route_next (struct route_node *node)
+{
+ struct route_node *next;
+ struct route_node *start;
+
+ /* Node may be deleted from route_unlock_node so we have to preserve
+ next node's pointer. */
+
+ if (node->l_left)
+ {
+ next = node->l_left;
+ route_lock_node (next);
+ route_unlock_node (node);
+ return next;
+ }
+ if (node->l_right)
+ {
+ next = node->l_right;
+ route_lock_node (next);
+ route_unlock_node (node);
+ return next;
+ }
+
+ start = node;
+ while (node->parent)
+ {
+ if (node->parent->l_left == node && node->parent->l_right)
+ {
+ next = node->parent->l_right;
+ route_lock_node (next);
+ route_unlock_node (start);
+ return next;
+ }
+ node = node->parent;
+ }
+ route_unlock_node (start);
+ return NULL;
+}
+
+/* Unlock current node and lock next node until limit. */
+struct route_node * route_next_until (struct route_node *node, struct
route_node *limit)
+{
+ struct route_node *next;
+ struct route_node *start;
+
+ /* Node may be deleted from route_unlock_node so we have to preserve
+ next node's pointer. */
+
+ if (node->l_left)
+ {
+ next = node->l_left;
+ route_lock_node (next);
+ route_unlock_node (node);
+ return next;
+ }
+ if (node->l_right)
+ {
+ next = node->l_right;
+ route_lock_node (next);
+ route_unlock_node (node);
+ return next;
+ }
+
+ start = node;
+ while (node->parent && node != limit)
+ {
+ if (node->parent->l_left == node && node->parent->l_right)
+ {
+ next = node->parent->l_right;
+ route_lock_node (next);
+ route_unlock_node (start);
+ return next;
+ }
+ node = node->parent;
+ }
+ route_unlock_node (start);
+ return NULL;
+}
diff -HNaur /tmp/linux-2.4.22/net/ipv4/fib_frontend.c
linux-2.4.22/net/ipv4/fib_frontend.c
--- /tmp/linux-2.4.22/net/ipv4/fib_frontend.c 2003-08-25
07:44:44.000000000 -0400
+++ linux-2.4.22/net/ipv4/fib_frontend.c 2004-04-02 17:33:38.000000000 -0500
@@ -64,7 +64,7 @@
{
struct fib_table *tb;

- tb = fib_hash_init(id);
+ tb = fib_table_init(id);
if (!tb)
return NULL;
fib_tables[id] = tb;
@@ -648,8 +648,8 @@
#endif /* CONFIG_PROC_FS */

#ifndef CONFIG_IP_MULTIPLE_TABLES
- local_table = fib_hash_init(RT_TABLE_LOCAL);
- main_table = fib_hash_init(RT_TABLE_MAIN);
+ local_table = fib_table_init(RT_TABLE_LOCAL);
+ main_table = fib_table_init(RT_TABLE_MAIN);
#else
fib_rules_init();
#endif
diff -HNaur /tmp/linux-2.4.22/net/ipv4/fib_hash.c
linux-2.4.22/net/ipv4/fib_hash.c
--- /tmp/linux-2.4.22/net/ipv4/fib_hash.c 2003-08-25
07:44:44.000000000 -0400
+++ linux-2.4.22/net/ipv4/fib_hash.c 2004-04-02 15:31:55.000000000 -0500
@@ -246,7 +246,6 @@
kmem_cache_free(fn_hash_kmem, f);
}

-
static struct fn_zone *
fn_new_zone(struct fn_hash *table, int z)
{
diff -HNaur /tmp/linux-2.4.22/net/ipv4/fib_table.c
linux-2.4.22/net/ipv4/fib_table.c
--- /tmp/linux-2.4.22/net/ipv4/fib_table.c 1969-12-31
19:00:00.000000000 -0500
+++ linux-2.4.22/net/ipv4/fib_table.c 2004-04-06 11:16:40.000000000 -0400
@@ -0,0 +1,343 @@
+/*
+ * INET An implementation of the TCP/IP protocol suite for the LINUX
+ * operating system. INET is implemented using the BSD Socket
+ * interface as the means of communication with the user level.
+ *
+ * IPv4 FIB: lookup engine and maintenance routines.
+ *
+ * Version: $Id: fib_hash.c,v 1.13 2001/10/31 21:55:54 davem Exp $
+ *
+ * Authors: Alexey Kuznetsov, <kuznet@ms2.inr.ac.ru>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/config.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+#include <asm/bitops.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/string.h>
+#include <linux/socket.h>
+#include <linux/sockios.h>
+#include <linux/errno.h>
+#include <linux/in.h>
+#include <linux/inet.h>
+#include <linux/netdevice.h>
+#include <linux/if_arp.h>
+#include <linux/proc_fs.h>
+#include <linux/skbuff.h>
+#include <linux/netlink.h>
+#include <linux/init.h>
+
+#include <net/ip.h>
+#include <net/protocol.h>
+#include <net/route.h>
+#include <net/tcp.h>
+#include <net/sock.h>
+#include <net/ip_fib.h>
+#include <net/table.h>
+
+static kmem_cache_t * fn_table_kmem;
+
+#define KEY_BITMASK_TOTAL 48
+#define KEY_BITMASK_TO_IPV4 16
+
+#define KEY_VR_OFFSET 0
+#define KEY_IPV4_OFFSET 2
+
+struct fib_node
+{
+ struct fib_info *fn_info;
+#define FIB_INFO(f) ((f)->fn_info)
+ u8 fn_type;
+ u8 fn_scope;
+};
+
+static void rtmsg_fib(int event, struct route_node *rn, int tb_id, struct
nlmsghdr *n, struct netlink_skb_parms *req);
+
+
+
+
+
+static void fn_free_node(struct fib_node * f)
+{
+ fib_release_info(FIB_INFO(f));
+ kmem_cache_free(fn_table_kmem, f);
+}
+
+
+static int fn_table_lookup(struct fib_table *tb, const struct rt_key *key,
struct fib_result *res) {
+ struct route_table *table = (struct route_table*)tb->tb_data;
+ int err = -EINVAL;
+ struct prefix p;
+ struct route_node *rn = NULL;
+ struct fib_node *fn = NULL;
+
+ memset(&p, 0, sizeof(struct prefix));
+ p.prefixlen = KEY_BITMASK_TOTAL; //add 16 bits length for the VR + 32 for
IPv4
+ memcpy(p.prefix+KEY_IPV4_OFFSET, &key->dst, 4);
+
+ rn = route_node_match(table, &p);
+ if(rn == NULL) {
+ return 1; //Return 1 if not found
+ }
+
+ fn = (struct fib_node *)rn->info;
+
+ err = fib_semantic_match(fn->fn_type, FIB_INFO(fn), key, res);
+ if (err == 0) {
+ res->type = fn->fn_type;
+ res->scope = fn->fn_scope;
+ res->prefixlen = rn->p.prefixlen-KEY_BITMASK_TO_IPV4;
+ goto out; //Return 0 if found
+ }
+ if (err < 0) goto out;
+ err = 1; //Return 1 if not found
+
+out:
+ route_unlock_node(rn);
+ return err;
+}
+
+static void fn_table_select_default(struct fib_table *tb, const struct
rt_key *key, struct fib_result *res){
+ struct route_table *table = (struct route_table*)tb->tb_data;
+
+ printk(KERN_ERR "fn_table_select_default.\n");
+}
+
+
+static int fn_table_insert(struct fib_table *tb, struct rtmsg *r, struct
kern_rta *rta, struct nlmsghdr *n, struct netlink_skb_parms *req) {
+ struct route_table *table = (struct route_table*)tb->tb_data;
+ struct fib_info *fi = NULL;
+ struct fib_node *fn = NULL;
+ struct prefix p;
+ struct route_node *rn = NULL;
+ int err = -EINVAL;
+
+ memset(&p, 0, sizeof(struct prefix));
+ p.prefixlen = r->rtm_dst_len+KEY_BITMASK_TO_IPV4; //add 16 bits length for
the VR.
+
+ if(p.prefixlen > KEY_BITMASK_TOTAL) { //16 bits for VR + 32 bits for IPv4
+ printk(KERN_ERR "fn_table_insert, prefix too long %d, max%d.\n",
p.prefixlen, KEY_BITMASK_TOTAL);
+ return -EINVAL;
+ }
+ if (rta->rta_dst) memcpy(p.prefix+KEY_IPV4_OFFSET, rta->rta_dst, 4);
+
+ if ((fi = fib_create_info(r, rta, n, &err)) == NULL) {
+ printk(KERN_ERR "fn_table_insert, fib_create_info failed %d.\n", err);
+ return err;
+ }
+
+ rn = route_node_get(table, &p);
+ if(rn == NULL) {
+ printk(KERN_ERR "fn_table_insert, node_get.\n");
+ goto out;
+ }
+
+ if(rn->info != NULL) {
+ if(n->nlmsg_flags&NLM_F_EXCL) goto out; // An entry, but need to to
replace, so out.
+
+ //if NLM_F_REPLACE or NLM_F_APPEND we replace the current entry. So we
need first to remove the old one.
+ rtmsg_fib(RTM_DELROUTE, rn, tb->tb_id, n, req);
+ fn_free_node((struct fib_node *)rn->info);
+ route_unlock_node(rn);
+ } else {
+ if(!(n->nlmsg_flags&NLM_F_CREATE)) goto out; //Not already define and not
set to create, out.
+ }
+
+ //Alloc the slab for the fib node
+ fn = kmem_cache_alloc(fn_table_kmem, SLAB_KERNEL);
+ if(fn == NULL) {
+ printk(KERN_ERR "fn_table_insert, cache alloc failed.\n");
+ goto out;
+ }
+
+ //Make all the pointer and value fill correctly.
+ memset(fn, 0, sizeof(struct fib_node));
+ fn->fn_type = r->rtm_type;
+ fn->fn_scope = r->rtm_scope;
+ FIB_INFO(fn) = fi;
+ rn->info = fn;
+
+ rtmsg_fib(RTM_NEWROUTE, rn, tb->tb_id, n, req);
+ return 0;
+
+out:
+ if(rn != NULL) route_unlock_node(rn);
+ fib_release_info(fi);
+ return err;
+}
+
+
+static int fn_table_delete(struct fib_table *tb, struct rtmsg *r, struct
kern_rta *rta, struct nlmsghdr *n, struct netlink_skb_parms *req) {
+ struct route_table *table = (struct route_table*)tb->tb_data;
+ struct prefix p;
+ struct route_node *rn = NULL;
+
+ memset(&p, 0, sizeof(struct prefix));
+ p.prefixlen = r->rtm_dst_len+KEY_BITMASK_TO_IPV4; //add 16 bits length for
the VR.
+
+ if(p.prefixlen > KEY_BITMASK_TOTAL) { //16 bits for VR + 32 bits for IPv4
+ printk(KERN_ERR "fn_table_insert, prefix too long %d, max%d.\n",
p.prefixlen, KEY_BITMASK_TOTAL);
+ return -EINVAL;
+ }
+ if (rta->rta_dst) memcpy(p.prefix+KEY_IPV4_OFFSET, rta->rta_dst, 4);
+
+ rn = route_node_lookup(table, &p);
+ if(rn != NULL) {
+ struct fib_node *f = (struct fib_node*)rn->info;
+
+ rtmsg_fib(RTM_DELROUTE, rn, tb->tb_id, n, req);
+ fn_free_node(f);
+
+ rn->info = NULL;
+ route_unlock_node(rn);
+ return 0;
+ }
+
+ return -ESRCH;
+}
+
+static int fn_table_flush(struct fib_table *tb) {
+ struct route_table *table = (struct route_table*)tb->tb_data;
+ struct route_node *rn = NULL;
+ struct fib_node *f = NULL;
+ struct fib_info *fi;
+ int found = 0;
+
+ rn = route_top(table); //Not defined use the top.
+
+ while(rn != NULL) {
+ if(rn->info != NULL) {
+ f = (struct fib_node*)rn->info;
+ fi = FIB_INFO(f);
+ if (fi && fi->fib_flags&RTNH_F_DEAD) {
+ fn_free_node(f);
+ found++;
+
+ rn->info = NULL;
+ route_unlock_node(rn);
+ }
+ }
+ rn = route_next(rn);
+ }
+
+ return found;
+}
+
+
+#ifdef CONFIG_PROC_FS
+
+static int fn_table_get_info(struct fib_table *tb, char *buffer, int first,
int count) {
+ struct route_table *table = (struct route_table*)tb->tb_data;
+ struct route_node *rn = NULL;
+ struct fib_node *f = NULL;
+ int pos = 0;
+ int n = 0;
+
+ rn = route_top(table);
+ while(rn != NULL) {
+ if(rn->info != NULL) {
+ if(++pos > first) {
+ int ipv4_mask_len = rn->p.prefixlen-KEY_BITMASK_TO_IPV4;
+ f = (struct fib_node*)rn->info;
+
+ fib_node_get_info(f->fn_type, 0, FIB_INFO(f),
*((u32*)(rn->p.prefix+KEY_IPV4_OFFSET)), inet_make_mask(ipv4_mask_len),
buffer);
+ buffer += 128;
+ if (++n >= count) {
+ route_unlock_node(rn);
+ return n;
+ }
+ }
+ }
+ rn = route_next(rn);
+ }
+
+ return n;
+}
+#endif
+
+
+static int fn_table_dump(struct fib_table *tb, struct sk_buff *skb, struct
netlink_callback *cb) {
+ struct route_table *table = (struct route_table*)tb->tb_data;
+ struct route_node *rn = NULL;
+ struct fib_node *f = NULL;
+
+ rn = (struct route_node *)cb->args[1];
+
+ if(rn == NULL) {
+ rn = route_top(table); //Not defined use the top.
+ }
+
+ while(rn != NULL) {
+ printk(KERN_ERR "fn_table_dump, Route Node found %d.%d.%d.%d/%d.\n",
(rn->p.prefix+KEY_IPV4_OFFSET)[0], (rn->p.prefix+KEY_IPV4_OFFSET)[1],
(rn->p.prefix+KEY_IPV4_OFFSET)[2], (rn->p.prefix+KEY_IPV4_OFFSET)[3],
rn->p.prefixlen-KEY_BITMASK_TO_IPV4);
+ if(rn->info != NULL) {
+ f = (struct fib_node*)rn->info;
+
+ if (fib_dump_info(skb, NETLINK_CB(cb->skb).pid, cb->nlh->nlmsg_seq,
RTM_NEWROUTE, tb->tb_id, f->fn_type, f->fn_scope,
rn->p.prefix+KEY_IPV4_OFFSET, rn->p.prefixlen-KEY_BITMASK_TO_IPV4,
0/*f->fn_tos*/, FIB_INFO(f)) < 0) {
+ cb->args[1] = (long)rn; //continue from this node.
+ return -1;
+ }
+ }
+ rn = route_next(rn);
+ }
+
+ return skb->len;
+}
+
+
+static void rtmsg_fib(int event, struct route_node *rn, int tb_id, struct
nlmsghdr *n, struct netlink_skb_parms *req)
+{
+ struct fib_node* f = (struct fib_node*)rn->info;
+ struct sk_buff *skb;
+ u32 pid = req ? req->pid : 0;
+ int size = NLMSG_SPACE(sizeof(struct rtmsg)+256);
+
+ skb = alloc_skb(size, GFP_KERNEL);
+ if (!skb) return;
+
+ if (fib_dump_info(skb, pid, n->nlmsg_seq, event, tb_id, f->fn_type,
f->fn_scope, rn->p.prefix+KEY_IPV4_OFFSET,
rn->p.prefixlen-KEY_BITMASK_TO_IPV4, 0/*f->fn_tos*/, FIB_INFO(f)) < 0) {
+ kfree_skb(skb);
+ return;
+ }
+ NETLINK_CB(skb).dst_groups = RTMGRP_IPV4_ROUTE;
+ if (n->nlmsg_flags&NLM_F_ECHO) atomic_inc(&skb->users);
+ netlink_broadcast(rtnl, skb, pid, RTMGRP_IPV4_ROUTE, GFP_KERNEL);
+ if (n->nlmsg_flags&NLM_F_ECHO) netlink_unicast(rtnl, skb, pid,
MSG_DONTWAIT);
+}
+
+
+
+#ifdef CONFIG_IP_MULTIPLE_TABLES
+struct fib_table * fib_table_init(int id)
+#else
+struct fib_table * __init fib_table_init(int id)
+#endif
+{
+ struct fib_table *tb;
+
+ if (fn_table_kmem == NULL) fn_table_kmem =
kmem_cache_create("ip_fib_table",sizeof(struct fib_node), 0,
SLAB_HWCACHE_ALIGN, NULL, NULL);
+
+ tb = kmalloc(sizeof(struct fib_table) + sizeof(struct route_table),
GFP_KERNEL);
+ if (tb == NULL) return NULL;
+
+ tb->tb_id = id;
+ tb->tb_lookup = fn_table_lookup;
+ tb->tb_insert = fn_table_insert;
+ tb->tb_delete = fn_table_delete;
+ tb->tb_flush = fn_table_flush;
+ tb->tb_select_default = fn_table_select_default;
+ tb->tb_dump = fn_table_dump;
+#ifdef CONFIG_PROC_FS
+ tb->tb_get_info = fn_table_get_info;
+#endif
+ memset(tb->tb_data, 0, sizeof(struct route_table)); //Finish the init of
the routing table for IPv4
+ return tb;
+}
diff -HNaur /tmp/linux-2.4.22/net/ipv4/Makefile
linux-2.4.22/net/ipv4/Makefile
--- /tmp/linux-2.4.22/net/ipv4/Makefile 2001-12-21 12:42:05.000000000 -0500
+++ linux-2.4.22/net/ipv4/Makefile 2004-04-02 12:00:09.000000000 -0500
@@ -16,7 +16,7 @@
ip_output.o ip_sockglue.o \
tcp.o tcp_input.o tcp_output.o tcp_timer.o tcp_ipv4.o tcp_minisocks.o \
tcp_diag.o raw.o udp.o arp.o icmp.o devinet.o af_inet.o igmp.o \
- sysctl_net_ipv4.o fib_frontend.o fib_semantics.o fib_hash.o
+ sysctl_net_ipv4.o fib_frontend.o fib_semantics.o fib_hash.o fib_table.o

obj-$(CONFIG_IP_MULTIPLE_TABLES) += fib_rules.o
obj-$(CONFIG_IP_ROUTE_NAT) += ip_nat_dumb.o
