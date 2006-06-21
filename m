Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932499AbWFUTsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbWFUTsU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWFUTsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:48:20 -0400
Received: from rrcs-24-227-247-53.sw.biz.rr.com ([24.227.247.53]:909 "EHLO
	linux.local") by vger.kernel.org with ESMTP id S932499AbWFUTsT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:48:19 -0400
From: Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH 1/2] Network Event Notifier Mechanism.
Date: Wed, 21 Jun 2006 14:48:19 -0500
To: swise@opengridcomputing.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Message-Id: <20060621194818.4507.80455.stgit@stevo-desktop>
In-Reply-To: <20060621194816.4507.4090.stgit@stevo-desktop>
References: <20060621194816.4507.4090.stgit@stevo-desktop>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch uses notifier blocks to implement a network event
notifier mechanism.

Clients register their callback function by calling
register_netevent_notifier() like this:

static struct notifier_block nb = {
        .notifier_call = my_callback_func
};

...

register_netevent_notifier(&nb);
---

 include/net/netevent.h |   41 +++++++++++++++++++++++++++++
 net/core/netevent.c    |   67 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+), 0 deletions(-)

diff --git a/include/net/netevent.h b/include/net/netevent.h
new file mode 100644
index 0000000..9ceab27
--- /dev/null
+++ b/include/net/netevent.h
@@ -0,0 +1,41 @@
+#ifndef _NET_EVENT_H
+#define _NET_EVENT_H
+
+/*
+ *	Generic netevent notifiers
+ *
+ *	Authors:
+ *      Tom Tucker              <tom@opengridcomputing.com>
+ *
+ * 	Changes:
+ */
+
+#ifdef __KERNEL__
+
+#include <net/dst.h>
+
+struct netevent_redirect {
+	struct dst_entry *old;
+	struct dst_entry *new;
+};
+
+struct netevent_route_change {
+        int event;
+        struct fib_info *fib_info;
+};
+
+enum netevent_notif_type {
+	NETEVENT_NEIGH_UPDATE = 1, /* arg is * struct neighbour */
+	NETEVENT_ROUTE_UPDATE,	   /* arg is * netevent_route_change */
+	NETEVENT_PMTU_UPDATE,
+	NETEVENT_REDIRECT,	   /* arg is * struct netevent_redirect */
+};
+
+extern int register_netevent_notifier(struct notifier_block *nb);
+extern int unregister_netevent_notifier(struct notifier_block *nb);
+extern int call_netevent_notifiers(unsigned long val, void *v);
+
+#endif
+#endif
+
+
diff --git a/net/core/netevent.c b/net/core/netevent.c
new file mode 100644
index 0000000..2261fb3
--- /dev/null
+++ b/net/core/netevent.c
@@ -0,0 +1,67 @@
+/*
+ *	Network event notifiers
+ *
+ *	Authors:
+ *      Tom Tucker             <tom@opengridcomputing.com>
+ *
+ *	This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ *
+ *	Fixes:
+ */
+
+#include <linux/rtnetlink.h>
+#include <linux/notifier.h>
+
+static struct atomic_notifier_head netevent_notif_chain;
+
+/**
+ *	register_netevent_notifier - register a netevent notifier block
+ *	@nb: notifier
+ *
+ *	Register a notifier to be called when a netevent occurs.
+ *	The notifier passed is linked into the kernel structures and must
+ *	not be reused until it has been unregistered. A negative errno code
+ *	is returned on a failure.
+ */
+int register_netevent_notifier(struct notifier_block *nb)
+{
+	int err;
+
+	err = atomic_notifier_chain_register(&netevent_notif_chain, nb);
+	return err;
+}
+
+/**
+ *	netevent_unregister_notifier - unregister a netevent notifier block
+ *	@nb: notifier
+ *
+ *	Unregister a notifier previously registered by
+ *	register_neigh_notifier(). The notifier is unlinked into the
+ *	kernel structures and may then be reused. A negative errno code
+ *	is returned on a failure.
+ */
+
+int unregister_netevent_notifier(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_unregister(&netevent_notif_chain, nb);
+}
+
+/**
+ *	call_netevent_notifiers - call all netevent notifier blocks
+ *      @val: value passed unmodified to notifier function
+ *      @v:   pointer passed unmodified to notifier function
+ *
+ *	Call all neighbour notifier blocks.  Parameters and return value
+ *	are as for notifier_call_chain().
+ */
+
+int call_netevent_notifiers(unsigned long val, void *v)
+{
+	return atomic_notifier_call_chain(&netevent_notif_chain, val, v);
+}
+
+EXPORT_SYMBOL_GPL(register_netevent_notifier);
+EXPORT_SYMBOL_GPL(unregister_netevent_notifier);
