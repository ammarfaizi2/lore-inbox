Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbWHHKVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWHHKVP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 06:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbWHHKVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 06:21:15 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:49298 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964775AbWHHKVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 06:21:14 -0400
Message-ID: <44D865FD.1040806@sw.ru>
Date: Tue, 08 Aug 2006 14:22:53 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] sys_getppid oopses on debug kernel
Content-Type: multipart/mixed;
 boundary="------------060209080109050207040001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060209080109050207040001
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

sys_getppid() optimization can access a freed memory.
On kernels with DEBUG_SLAB turned ON, this results in
Oops.

Signed-Off-By: Kirill Korotaev <dev@openvz.org>


--------------060209080109050207040001
Content-Type: text/plain;
 name="diff-get-ppid-with-slab-debug"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-get-ppid-with-slab-debug"

--- ./kernel/timer.c.ppiddbg	2006-07-14 19:11:06.000000000 +0400
+++ ./kernel/timer.c	2006-08-08 14:19:24.000000000 +0400
@@ -1342,6 +1342,7 @@ asmlinkage long sys_getpid(void)
 asmlinkage long sys_getppid(void)
 {
 	int pid;
+#ifndef CONFIG_DEBUG_SLAB
 	struct task_struct *me = current;
 	struct task_struct *parent;
 
@@ -1364,6 +1365,16 @@ asmlinkage long sys_getppid(void)
 #endif
 		break;
 	}
+#else
+	/*
+	 * ->real_parent could be released before dereference and
+	 * we accessed freed kernel memory, which faults with debugging on.
+	 * Keep it simple and stupid.
+	 */
+	read_lock(&tasklist_lock);
+	pid = current->group_leader->real_parent->tgid;
+	read_unlock(&tasklist_lock);
+#endif
 	return pid;
 }
 

--------------060209080109050207040001--
