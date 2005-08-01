Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVHASt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVHASt5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 14:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVHASt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 14:49:56 -0400
Received: from graphe.net ([209.204.138.32]:4036 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261159AbVHASs5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 14:48:57 -0400
Date: Mon, 1 Aug 2005 11:48:55 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Paul Jackson <pj@sgi.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
Subject: Re: [PATCH] String conversions for memory policy
In-Reply-To: <20050730191228.15b71533.pj@sgi.com>
Message-ID: <Pine.LNX.4.62.0508011147030.5541@graphe.net>
References: <Pine.LNX.4.62.0507291137240.3864@graphe.net>
 <20050729152049.4b172d78.pj@sgi.com> <Pine.LNX.4.62.0507291746000.8663@graphe.net>
 <20050729230026.1aa27e14.pj@sgi.com> <Pine.LNX.4.62.0507301042420.26355@graphe.net>
 <20050730181418.65caed1f.pj@sgi.com> <Pine.LNX.4.62.0507301814540.31359@graphe.net>
 <20050730190126.6bec9186.pj@sgi.com> <Pine.LNX.4.62.0507301904420.31882@graphe.net>
 <20050730191228.15b71533.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jul 2005, Paul Jackson wrote:

> Would it make sense for you to do the same thing, when displaying
> mempolicies in /proc/<pid>/numa_policy?

Here is a new rev of the conversions patch. Thanks for all the feedback:

---

String conversions for memory policy

This patch adds two new functions to mm/mempolicy.c that allow the conversion
of a memory policy to a textual representation and vice versa.

Syntax of textual representation:

default
preferred=<nodenumber>
bind=<nodelist>
interleave=<nodelist>

Signed-off-by: Christoph Lameter <christoph@lameter.com>

Index: linux-2.6.13-rc4/mm/mempolicy.c
===================================================================
--- linux-2.6.13-rc4.orig/mm/mempolicy.c	2005-08-01 10:49:36.000000000 -0700
+++ linux-2.6.13-rc4/mm/mempolicy.c	2005-08-01 11:27:33.000000000 -0700
@@ -1170,3 +1170,100 @@
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
+
+	if (!pol || pol->policy == MPOL_DEFAULT) {
+
+		if (e < p + 8)
+			return -ENOSPC;
+
+		strcpy(buffer,"default");
+		p += 7;
+
+	} else if (pol->policy == MPOL_PREFERRED) {
+
+		if (e < p + 8 /* fixed string size */ + 4 /* max len of node number */)
+			return -ENOSPC;
+
+		p += sprintf(p, "prefer=%d", pol->v.preferred_node);
+
+	} else if (pol->policy == MPOL_BIND) {
+		nodemask_t nodes;
+
+		get_zonemask(pol, nodes.bits);
+
+		if (e < p + 8)
+			return -ENOSPC;
+
+		p += sprintf(p, "bind=");
+	 	p += nodelist_scnprintf(p, e - p, nodes);
+
+	} else if (pol->policy == MPOL_INTERLEAVE) {
+
+		if (e < p + 14)
+			return -ENOSPC;
+
+		p += sprintf(p, "interleave=");
+	 	p += nodelist_scnprintf(p, e - p, * (nodemask_t *)pol->v.nodes);
+
+	} else {
+
+		BUG();
+		return -EFAULT;
+
+	}
+	return p - buffer;
+}
+
+/*
+ * Convert a representation of a memory policy from text
+ * form to binary.
+ *
+ * Returns either a memory policy or NULL for error.
+ */
+struct mempolicy *str_to_mpol(char *buffer)
+{
+	nodemask_t nodes;
+	int mode;
+
+	if (strnicmp(buffer, "default", 7) == 0)
+		return &default_policy;
+
+	if (strnicmp(buffer, "prefer=", 7) == 0) {
+		int node;
+
+		mode = MPOL_PREFERRED;
+		node = simple_strtoul(buffer + 7, NULL, 10);
+		if (node >= MAX_NUMNODES || !node_online(node))
+			return NULL;
+
+		nodes_clear(nodes);
+		node_set(node, nodes);
+
+	} else if (strnicmp(buffer, "interleave=", 11) == 0) {
+
+		mode = MPOL_INTERLEAVE;
+		if (nodelist_parse(buffer + 11, nodes) ||
+		    nodes_empty(nodes))
+			return NULL;
+
+	} else if (strnicmp(buffer, "bind=", 5) == 0) {
+
+		mode = MPOL_BIND;
+		if (nodelist_parse(buffer+5, nodes))
+			return NULL;
+
+	}
+
+	return mpol_new(MPOL_BIND, nodes.bits);
+}
+
Index: linux-2.6.13-rc4/include/linux/mempolicy.h
===================================================================
--- linux-2.6.13-rc4.orig/include/linux/mempolicy.h	2005-08-01 10:49:35.000000000 -0700
+++ linux-2.6.13-rc4/include/linux/mempolicy.h	2005-08-01 10:49:41.000000000 -0700
@@ -157,6 +157,10 @@
 extern void numa_policy_init(void);
 extern struct mempolicy default_policy;
 
+/* Conversion functions */
+int mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol);
+struct mempolicy *str_to_mpol(char *buffer);
+
 #else
 
 struct mempolicy {};
