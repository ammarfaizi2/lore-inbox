Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWHMPrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWHMPrX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 11:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWHMPrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 11:47:23 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:2700 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1751286AbWHMPrW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 11:47:22 -0400
Date: Mon, 14 Aug 2006 00:11:10 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH] elf_core_dump: don't take tasklist_lock
Message-ID: <20060813201110.GA156@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

do_each_thread() is rcu-safe, and all tasks which use this ->mm must
sleep in wait_for_completion(&mm->core_done) at this point, so we can
use RCU locks.

Also, remove unneeded INIT_LIST_HEAD(new) before list_add(new, head).

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.18-rc3/fs/binfmt_elf.c~elf	2006-07-16 01:53:08.000000000 +0400
+++ 2.6.18-rc3/fs/binfmt_elf.c	2006-08-13 23:42:24.000000000 +0400
@@ -1480,20 +1480,19 @@ static int elf_core_dump(long signr, str
 
 	if (signr) {
 		struct elf_thread_status *tmp;
-		read_lock(&tasklist_lock);
+		rcu_read_lock();
 		do_each_thread(g,p)
 			if (current->mm == p->mm && current != p) {
 				tmp = kzalloc(sizeof(*tmp), GFP_ATOMIC);
 				if (!tmp) {
-					read_unlock(&tasklist_lock);
+					rcu_read_unlock();
 					goto cleanup;
 				}
-				INIT_LIST_HEAD(&tmp->list);
 				tmp->thread = p;
 				list_add(&tmp->list, &thread_list);
 			}
 		while_each_thread(g,p);
-		read_unlock(&tasklist_lock);
+		rcu_read_unlock();
 		list_for_each(t, &thread_list) {
 			struct elf_thread_status *tmp;
 			int sz;

