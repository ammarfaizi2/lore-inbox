Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWBCRBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWBCRBy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 12:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWBCRBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 12:01:54 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:24171 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751234AbWBCRBx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 12:01:53 -0500
Message-ID: <43E38CE6.3060901@sw.ru>
Date: Fri, 03 Feb 2006 20:03:34 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Kirill Korotaev <dev@openvz.org>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, serue@us.ibm.com,
       arjan@infradead.org, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org
Subject: [RFC][PATCH 2/5] Virtualization/containers: UIDs
References: <43E38BD1.4070707@openvz.org>
In-Reply-To: <43E38BD1.4070707@openvz.org>
Content-Type: multipart/mixed;
 boundary="------------030709080700030700010102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030709080700030700010102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The simplest virtualization of UID hashes, just to demonstrate our 
approach. Each container has it's own set of uids and should simply 
allocate hash/initialize it on startup.

Kirill

--------------030709080700030700010102
Content-Type: text/plain;
 name="diff-vps-uid-hash"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-vps-uid-hash"

--- ./include/linux/vps_info.h.vps_uid_hash	2006-02-03 16:49:26.000000000 +0300
+++ ./include/linux/vps_info.h	2006-02-03 16:49:51.000000000 +0300
@@ -5,11 +5,14 @@
 #include <asm/atomic.h>
 
 struct task_struct;
+struct list_head;
 
 struct vps_info {
 	u32 id;
 	struct task_struct *init_task;
 	atomic_t refcnt;
+
+	struct list_head *vps_uid_hash;
 };
 
 extern struct vps_info host_vps_info;
--- ./kernel/user.c.vps_uid_hash	2006-02-03 16:49:08.000000000 +0300
+++ ./kernel/user.c	2006-02-03 16:49:51.000000000 +0300
@@ -14,6 +14,7 @@
 #include <linux/bitops.h>
 #include <linux/key.h>
 #include <linux/interrupt.h>
+#include <linux/vps_info.h>
 
 /*
  * UID task count cache, to get fast user lookup in "alloc_uid"
@@ -24,7 +25,8 @@
 #define UIDHASH_SZ		(1 << UIDHASH_BITS)
 #define UIDHASH_MASK		(UIDHASH_SZ - 1)
 #define __uidhashfn(uid)	(((uid >> UIDHASH_BITS) + uid) & UIDHASH_MASK)
-#define uidhashentry(uid)	(uidhash_table + __uidhashfn((uid)))
+#define uidhashentry(uid)	(current_vps()->vps_uid_hash +	\
+						__uidhashfn((uid)))
 
 static kmem_cache_t *uid_cachep;
 static struct list_head uidhash_table[UIDHASH_SZ];
@@ -200,6 +202,7 @@
 
 	/* Insert the root user immediately (init already runs as root) */
 	spin_lock_irq(&uidhash_lock);
+	host_vps_info.vps_uid_hash = uidhash_table;
 	uid_hash_insert(&root_user, uidhashentry(0));
 	spin_unlock_irq(&uidhash_lock);
 

--------------030709080700030700010102--

