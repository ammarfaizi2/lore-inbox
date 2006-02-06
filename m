Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWBFWPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWBFWPc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 17:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWBFWPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 17:15:32 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:32636 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932264AbWBFWPb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 17:15:31 -0500
Message-ID: <43E7CAF2.5010705@openvz.org>
Date: Tue, 07 Feb 2006 01:17:22 +0300
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
CC: Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, frankeh@watson.ibm.com, clg@fr.ibm.com,
       haveblue@us.ibm.com, greg@kroah.com, alan@lxorguk.ukuu.org.uk,
       serue@us.ibm.com, arjan@infradead.org, riel@redhat.com,
       kuznet@ms2.inr.ac.ru, saw@sawoct.com, devel@openvz.org,
       Dmitry Mishin <dim@sw.ru>
Subject: [PATCH 3/4] Virtualization/containers: UID hash
References: <43E7C65F.3050609@openvz.org>
In-Reply-To: <43E7C65F.3050609@openvz.org>
Content-Type: multipart/mixed;
 boundary="------------050309010209010304080502"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050309010209010304080502
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch virtualizes UID hash, so that processes in container can use 
it's own UID set.
Can be done as an option if some virtualization solutions do not require it.

Signed-Off-By: Kirill Korotaev <dev@openvz.org>

Kirill

--------------050309010209010304080502
Content-Type: text/plain;
 name="diff-container-uidhash"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-container-uidhash"

--- ./include/linux/container.h.uids	2006-02-06 23:46:40.000000000 +0300
+++ ./include/linux/container.h	2006-02-07 00:05:33.000000000 +0300
@@ -6,11 +6,14 @@
 #include <asm/atomic.h>
 
 struct task_struct;
+struct list_head;
 
 struct container {
 	u32 id;
 	struct task_struct *init_task;
 	atomic_t refcnt;
+
+	struct list_head *c_uid_hash;
 };
 
 extern struct container init_container;
--- ./kernel/user.c.uids	2006-02-06 22:15:06.000000000 +0300
+++ ./kernel/user.c	2006-02-06 23:58:06.000000000 +0300
@@ -14,6 +14,7 @@
 #include <linux/bitops.h>
 #include <linux/key.h>
 #include <linux/interrupt.h>
+#include <linux/container.h>
 
 /*
  * UID task count cache, to get fast user lookup in "alloc_uid"
@@ -24,7 +25,12 @@
 #define UIDHASH_SZ		(1 << UIDHASH_BITS)
 #define UIDHASH_MASK		(UIDHASH_SZ - 1)
 #define __uidhashfn(uid)	(((uid >> UIDHASH_BITS) + uid) & UIDHASH_MASK)
+
+#ifdef CONFIG_CONTAINER
+#define uidhashentry(uid)	(econtainer()->c_uid_hash + __uidhashfn((uid)))
+#else
 #define uidhashentry(uid)	(uidhash_table + __uidhashfn((uid)))
+#endif
 
 static kmem_cache_t *uid_cachep;
 static struct list_head uidhash_table[UIDHASH_SZ];
@@ -200,6 +206,9 @@ static int __init uid_cache_init(void)
 
 	/* Insert the root user immediately (init already runs as root) */
 	spin_lock_irq(&uidhash_lock);
+#ifdef CONFIG_CONTAINER
+	init_container.c_uid_hash = uidhash_table;
+#endif
 	uid_hash_insert(&root_user, uidhashentry(0));
 	spin_unlock_irq(&uidhash_lock);
 

--------------050309010209010304080502--

