Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267397AbUIARkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267397AbUIARkN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 13:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267235AbUIARhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 13:37:47 -0400
Received: from holomorphy.com ([207.189.100.168]:63174 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267383AbUIARfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 13:35:34 -0400
Date: Wed, 1 Sep 2004 10:35:29 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Kirill Korotaev <kksx@mail.ru>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [6/7] back out renaming of ->pid_chain
Message-ID: <20040901173529.GJ5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Kirill Korotaev <kksx@mail.ru>, akpm@osdl.org, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <E1C2TZ1-000JZr-00.kksx-mail-ru@f7.mail.ru> <20040901153624.GA5492@holomorphy.com> <20040901165808.GD5492@holomorphy.com> <20040901172710.GE5492@holomorphy.com> <20040901172839.GF5492@holomorphy.com> <20040901173027.GG5492@holomorphy.com> <20040901173218.GH5492@holomorphy.com> <20040901173327.GI5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040901173327.GI5492@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 10:33:27AM -0700, William Lee Irwin III wrote:
> The renaming of struct pid was spurious; the following patch backs out
> this renaming.

The renaming of ->pid_chain was spurious; the following patch backs it out.


Index: kirill-2.6.9-rc1-mm2/include/linux/pid.h
===================================================================
--- kirill-2.6.9-rc1-mm2.orig/include/linux/pid.h	2004-09-01 09:28:48.595832976 -0700
+++ kirill-2.6.9-rc1-mm2/include/linux/pid.h	2004-09-01 10:13:28.949357304 -0700
@@ -12,9 +12,9 @@
 
 struct pid
 {
-	/* Try to keep hash_list in the same cacheline as nr for find_pid */
+	/* Try to keep pid_chain in the same cacheline as nr for find_pid */
 	int nr;
-	struct hlist_node hash_list;
+	struct hlist_node pid_chain;
 	/* list of pids with the same nr, only one of them is in the hash */
 	struct list_head pid_list;
 };
Index: kirill-2.6.9-rc1-mm2/kernel/pid.c
===================================================================
--- kirill-2.6.9-rc1-mm2.orig/kernel/pid.c	2004-09-01 09:31:25.972908024 -0700
+++ kirill-2.6.9-rc1-mm2/kernel/pid.c	2004-09-01 10:16:27.524209800 -0700
@@ -154,7 +154,7 @@
 	struct pid *pid;
 
 	hlist_for_each_entry(pid, elem,
-			&pid_hash[type][pid_hashfn(nr)], hash_list) {
+			&pid_hash[type][pid_hashfn(nr)], pid_chain) {
 		if (pid->nr == nr)
 			return pid;
 	}
@@ -168,11 +168,11 @@
 	task_pid = &task->pids[type];
 	pid = find_pid(type, nr);
 	if (pid == NULL) {
-		hlist_add_head(&task_pid->hash_list,
+		hlist_add_head(&task_pid->pid_chain,
 				&pid_hash[type][pid_hashfn(nr)]);
 		INIT_LIST_HEAD(&task_pid->pid_list);
 	} else {
-		INIT_HLIST_NODE(&task_pid->hash_list);
+		INIT_HLIST_NODE(&task_pid->pid_chain);
 		list_add_tail(&task_pid->pid_list, &pid->pid_list);
 	}
 	task_pid->nr = nr;
@@ -186,13 +186,13 @@
 	int nr;
 
 	pid = &task->pids[type];
-	if (!hlist_unhashed(&pid->hash_list)) {
-		hlist_del(&pid->hash_list);
+	if (!hlist_unhashed(&pid->pid_chain)) {
+		hlist_del(&pid->pid_chain);
 		if (!list_empty(&pid->pid_list)) {
 			pid_next = list_entry(pid->pid_list.next,
 						struct pid, pid_list);
 			/* insert next pid from pid_list to hash */
-			hlist_add_head(&pid_next->hash_list,
+			hlist_add_head(&pid_next->pid_chain,
 				&pid_hash[type][pid_hashfn(pid_next->nr)]);
 		}
 	}
