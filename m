Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbVHBAPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbVHBAPr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 20:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVHBAPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 20:15:45 -0400
Received: from graphe.net ([209.204.138.32]:52880 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261397AbVHBAP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 20:15:28 -0400
Date: Mon, 1 Aug 2005 17:15:24 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Paul Jackson <pj@sgi.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
Subject: Re: [PATCH] String conversions for memory policy
In-Reply-To: <20050801165947.36b5da96.pj@sgi.com>
Message-ID: <Pine.LNX.4.62.0508011713540.9824@graphe.net>
References: <Pine.LNX.4.62.0507291137240.3864@graphe.net>
 <20050729152049.4b172d78.pj@sgi.com> <Pine.LNX.4.62.0507291746000.8663@graphe.net>
 <20050729230026.1aa27e14.pj@sgi.com> <Pine.LNX.4.62.0507301042420.26355@graphe.net>
 <20050730181418.65caed1f.pj@sgi.com> <Pine.LNX.4.62.0507301814540.31359@graphe.net>
 <20050730190126.6bec9186.pj@sgi.com> <Pine.LNX.4.62.0507301904420.31882@graphe.net>
 <20050730191228.15b71533.pj@sgi.com> <Pine.LNX.4.62.0508011147030.5541@graphe.net>
 <20050801160351.71ee630a.pj@sgi.com> <Pine.LNX.4.62.0508011618120.9351@graphe.net>
 <20050801165947.36b5da96.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New version without the magic numbers ...

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

Index: linux-2.6.13-rc4-mm1/mm/mempolicy.c
===================================================================
--- linux-2.6.13-rc4-mm1.orig/mm/mempolicy.c	2005-08-01 12:59:49.000000000 -0700
+++ linux-2.6.13-rc4-mm1/mm/mempolicy.c	2005-08-01 17:14:08.000000000 -0700
@@ -1170,3 +1170,95 @@
 {
 	sys_set_mempolicy(MPOL_DEFAULT, NULL, 0);
 }
+
+static const char *policy_types[] = { "default", "prefer", "bind", "interleave" };
+
+/*
+ * Convert a mempolicy into a string.
+ * Returns the number of characters in buffer (if positive)
+ * or an error (negative)
+ */
+int mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
+{
+	char *p = buffer;
+	int l;
+	nodemask_t nodes;
+	mode = pol ? pol->policy : MPOL_DEFAULT;
+
+	switch (mode) {
+	case MPOL_DEFAULT:
+		nodes_clear(nodes);
+		break;
+
+	case MPOL_PREFERRED:
+		nodes_clear(nodes);
+		node_set(pol->v.preferred_node, nodes);
+		break;
+
+	case MPOL_BIND:
+		get_zonemask(pol, nodes.bits);
+		break;
+
+	case MPOL_INTERLEAVE:
+		nodes = * (nodemask_t *)pol->v.nodes;
+		break;
+
+	default:
+		BUG();
+		return -EFAULT;
+	}
+
+	l = strlen(policy_types[mode]);
+	if (buffer + maxlen > p + l + 1)
+		return -ENOSPC;
+	strcpy(p, policy_types[mode]);
+	p += l;
+
+	if (!nodes_empty(nodes)) {
+
+		if (buffer + maxlen > p + 2)
+			return -ENOSPC;
+
+		*p++ = '=';
+	 	p += nodelist_scnprintf(p, buffer + maxlen - p, nodes);
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
+	int l;
+
+	for(mode = 0; mode <= MPOL_MAX; mode++) {
+		l = strlen(policy_types[mode]);
+		if (strnicmp(policy_types[mode], buffer, l)
+			&& (mode == MPOL_DEFAULT || buffer[l] == '='))
+				break;
+	}
+
+	if (mode > MPOL_MAX)
+		return NULL;
+
+	if (mode == MPOL_DEFAULT)
+		return &default_policy;
+
+	if (nodelist_parse(buffer + l + 1, nodes) || nodes_empty(nodes))
+		return NULL;
+
+	/* Update current mems_allowed */
+	cpuset_update_current_mems_allowed();
+	/* Ignore nodes not set in current->mems_allowed */
+	cpuset_restrict_to_mems_allowed(nodes.bits);
+
+	if (!mpol_check_policy(mode, nodes.bits))
+		return NULL;
+	return mpol_new(mode, nodes.bits);
+}
Index: linux-2.6.13-rc4-mm1/include/linux/mempolicy.h
===================================================================
--- linux-2.6.13-rc4-mm1.orig/include/linux/mempolicy.h	2005-08-01 12:59:45.000000000 -0700
+++ linux-2.6.13-rc4-mm1/include/linux/mempolicy.h	2005-08-01 13:00:01.000000000 -0700
@@ -157,6 +157,10 @@
 extern void numa_policy_init(void);
 extern struct mempolicy default_policy;
 
+/* Conversion functions */
+int mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol);
+struct mempolicy *str_to_mpol(char *buffer);
+
 #else
 
 struct mempolicy {};
