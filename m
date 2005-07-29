Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262701AbVG2SjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262701AbVG2SjI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 14:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262699AbVG2Siw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 14:38:52 -0400
Received: from graphe.net ([209.204.138.32]:24228 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262705AbVG2Sik (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 14:38:40 -0400
Date: Fri, 29 Jul 2005 11:38:35 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: linux-kernel@vger.kernel.org
cc: akpm@osdl.org, pj@sgi.com
Subject: [PATCH] String conversions for memory policy
Message-ID: <Pine.LNX.4.62.0507291137240.3864@graphe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds two new functions to mm/mempolicy.c that allow the conversion
of a memorypolicy to a textual representation and vice versa.

The patch provides necessary functions for the merging of numa_maps into 
smap.

Signed-off-by: Christoph Lameter <christoph@lameter.com>

Index: linux-2.6.13-rc3-mm3/mm/mempolicy.c
===================================================================
--- linux-2.6.13-rc3-mm3.orig/mm/mempolicy.c	2005-07-29 10:37:26.000000000 -0700
+++ linux-2.6.13-rc3-mm3/mm/mempolicy.c	2005-07-29 11:08:13.000000000 -0700
@@ -1170,3 +1170,214 @@
 {
 	sys_set_mempolicy(MPOL_DEFAULT, NULL, 0);
 }
+
+/*
+ * Convert a mempolicy into a string.
+ * Returns the number of characters in buffer (if positive)
+ * or an error (negative)
+ */
+int mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
+{
+	char *p = buffer;
+	char *e = buffer + maxlen;
+	int first = 1;
+	int node;
+	struct zone **z;
+
+	if (!pol || pol->policy == MPOL_DEFAULT) {
+		strcpy(buffer,"default");
+		return 7;
+	}
+
+	if (pol->policy == MPOL_PREFERRED) {
+		if (e < p + 8 /* fixed string size */ + 4 /* max len of node number */)
+			return -ENOSPC;
+
+		sprintf(p, "prefer=%d", pol->v.preferred_node);
+		return strlen(buffer);
+
+	} else if (pol->policy == MPOL_BIND) {
+
+		if (e < p + 9 + 4)
+			return -ENOSPC;
+
+		p+= sprintf(p, "bind={");
+
+		for (z = pol->v.zonelist->zones; *z ; *z++) {
+			if (!first)
+				*p++ = ',';
+			else
+				first = 0;
+			if (e < p + 2 + 4 + strlen((*z)->name))
+				return -ENOSPC;
+			p += sprintf(p, "%d/%s", (*z)->zone_pgdat->node_id, (*z)->name);
+		}
+
+		*p++ = '}';
+		*p++ = 0;
+		return p-buffer;
+
+	} else if (pol->policy == MPOL_INTERLEAVE) {
+
+		if (e < p + 14 + 4)
+			return -ENOSPC;
+
+		p += sprintf(p, "interleave={");
+
+		for_each_node(node)
+			if (test_bit(node, pol->v.nodes)) {
+				if (!first)
+					*p++ = ',';
+				else
+					first = 0;
+				if (e < p + 2 /* min bytes that follow */ + 4 /* node number */)
+					return -ENOSPC;
+				p += sprintf(p, "%d", node);
+			}
+
+		*p++ = '}';
+		*p++ = 0;
+		return p-buffer;
+	}
+	BUG();
+	return -EFAULT;
+}
+
+/*
+ * Convert a representation of a memory policy from text
+ * form to binary.
+ *
+ * Returns either a memory policy or NULL for error.
+ */
+struct mempolicy *str_to_mpol(char *buffer, char **end)
+{
+	char *p;
+	struct mempolicy *pol;
+	int node;
+	size_t size;
+
+	if (strnicmp(buffer, "default", 7) == 0) {
+
+		*end = buffer + 7;
+		return &default_policy;
+
+	}
+
+	pol = __mpol_copy(&default_policy);
+	if (IS_ERR(pol))
+		return NULL;
+
+	if (strnicmp(buffer, "prefer=", 7) == 0) {
+
+		node = simple_strtoul(buffer + 7, &p, 10);
+		if (node >= MAX_NUMNODES || !node_online(node))
+			goto out;
+
+		pol->policy = MPOL_PREFERRED;
+		pol->v.preferred_node = node;
+
+	} else if (strnicmp(buffer, "interleave={", 12) == 0) {
+
+		pol->policy = MPOL_INTERLEAVE;
+		p = buffer + 12;
+		bitmap_zero(pol->v.nodes, MAX_NUMNODES);
+
+		do {
+			node = simple_strtoul(p, &p, 10);
+
+			/* Check here for cpuset restrictions on nodes */
+			if (node >= MAX_NUMNODES || !node_online(node))
+				goto out;
+			set_bit(node, pol->v.nodes);
+
+		} while (*p++ == ',');
+
+		if (p[-1] != '}' || bitmap_empty(pol->v.nodes, MAX_NUMNODES))
+			goto out;
+
+	} else if (strnicmp(buffer, "bind={", 6) == 0) {
+
+		struct zonelist *zonelist = kmalloc(sizeof(struct zonelist), GFP_KERNEL);
+		struct zone **z = zonelist->zones;
+		struct zonelist *new;
+
+		pol->policy = MPOL_BIND;
+		p = buffer + 6;
+
+		do {
+			pg_data_t *pgdat;
+			struct zone *zone = NULL;
+
+			node = simple_strtoul(p, &p, 10);
+
+			/* Try to find the pgdat for the specified node */
+			for_each_pgdat(pgdat) {
+				if (pgdat->node_id == node) {
+					zone = pgdat->node_zones;
+					break;
+				}
+			}
+			if (!zone || node >= MAX_NUMNODES || !node_online(node))
+				goto bind_out;
+
+			/*
+			 * If there is no zone specified then take the first
+			 * zone. Otherwise we need to look for a matching name
+			 */
+			if (*p == '/') {
+				char *start = ++p;
+				struct zone *q;
+				struct zone *found = NULL;
+
+				/* Find end of the zone name */
+				while (*p && *p != ',' && *p != '}')
+					p++;
+
+				if (start == p)
+					goto bind_out;
+				/*
+				 * Go through the zones in this node and check
+				 * if any have the name we are looking for
+				 */
+				for(q = zone; q < zone + MAX_NR_ZONES; q++) {
+					if (strnicmp(q->name, start, p-start) == 0) {
+						found = q;
+						break;
+					}
+				}
+				zone = found;
+			}
+
+			if (!zone || z > zonelist->zones + MAX_NUMNODES * MAX_NR_ZONES)
+				goto bind_out;
+			*z++ = zone;
+
+		} while (*p++ == ',');
+
+		if (p[-1] != '}') {
+bind_out:
+			kfree(zonelist);
+			goto out;
+		}
+
+		/* Allocate only the necessary elements */
+		*z++ = NULL;
+		size = (z - zonelist->zones) * sizeof(struct zonelist *);
+		new = kmalloc(size, GFP_KERNEL);
+		if (!new)
+			goto out;
+		memcpy(new, zonelist, size);
+		kfree(zonelist);
+
+		pol->v.zonelist = new;
+
+	} else {
+out:
+		__mpol_free(pol);
+		return NULL;
+	}
+
+	*end = p;
+	return pol;
+}
+
Index: linux-2.6.13-rc3-mm3/include/linux/mempolicy.h
===================================================================
--- linux-2.6.13-rc3-mm3.orig/include/linux/mempolicy.h	2005-07-29 10:37:26.000000000 -0700
+++ linux-2.6.13-rc3-mm3/include/linux/mempolicy.h	2005-07-29 11:08:13.000000000 -0700
@@ -157,6 +157,10 @@
 extern void numa_policy_init(void);
 extern struct mempolicy default_policy;
 
+/* Conversion functions */
+int mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol);
+struct mempolicy *str_to_mpol(char *buffer, char **end);
+
 #else
 
 struct mempolicy {};
