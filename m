Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264337AbUFKV6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264337AbUFKV6d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 17:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264352AbUFKV6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 17:58:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:26526 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264337AbUFKV6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 17:58:30 -0400
Date: Fri, 11 Jun 2004 15:01:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Permit inode & dentry hash tables to be allocated >
 MAX_ORDER size [#2]
Message-Id: <20040611150110.73fadefb.akpm@osdl.org>
In-Reply-To: <6567.1086963705@redhat.com>
References: <567.1086950642@redhat.com>
	<6567.1086963705@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> Here's an update to my patch.

-static void __init dcache_init(unsigned long mempages)
+static void __init dcache_init_early(void)
 {
-	struct hlist_head *d;
-	unsigned long order;
-	unsigned int nr_hash;
-	int i;
+	struct hlist_head *p;
+	int loop;
+
+	dentry_hashtable =
+		alloc_large_system_hash("Dentry cache",
+					sizeof(struct hlist_head),
+					dhash_entries,
+					13,
+					0,
+					&d_hash_shift,
+					&d_hash_mask);
+
+	p = dentry_hashtable;
+	loop = 1 << d_hash_shift;
+	do {
+		INIT_HLIST_HEAD(p);
+		p++;
+		loop--;
+	} while (loop);
+}

We have an opportunity to make this loop less baroque.

	for (i = 0; i < (1 << d_hash_shift); i++)
		INIT_HLIST_HEAD(p[i]);




+void __init vfs_caches_init_early(void)

This function was declared

+extern void vfs_caches_init_early(void);

whereas in other places you _have_ made the definition of __init functions
include the "__init".  I'm not sure which is best, really, but it seems
better to include the __init in the declaration.

+static inline int log2(unsigned long x) __attribute__((pure));

What's the attribute((pure)) for?

It generates a warning on older gcc - please use __attribute_pure__.

+static inline int log2(unsigned long x)

This is just asking for namespace collisions.

+{
+	int r = 0;
+	for (x >>= 1; x > 0; x >>= 1)
+		r++;
+	return r;
+}

The other four or five implementations of log2() use ffx(~n).

