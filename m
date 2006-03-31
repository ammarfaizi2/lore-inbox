Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbWCaNwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWCaNwu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 08:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWCaNwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 08:52:49 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:10120 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751297AbWCaNwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 08:52:49 -0500
Message-ID: <442D3596.9090905@openvz.org>
Date: Fri, 31 Mar 2006 17:58:46 +0400
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, xemul@sw.ru,
       Mishin Dmitry <dim@openvz.org>
Subject: [PATCH] wrong error path in dup_fd() leading to oopses in RCU
Content-Type: multipart/mixed;
 boundary="------------060501060203050801030102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060501060203050801030102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Wrong error path in dup_fd() - it should return NULL on error,
not an address of already freed memory :/

Triggered by OpenVZ stress test suite.

What is interesting is that it was causing different oopses in RCU like 
below:
Call Trace:
   [<c013492c>] rcu_do_batch+0x2c/0x80
   [<c0134bdd>] rcu_process_callbacks+0x3d/0x70
   [<c0126cf3>] tasklet_action+0x73/0xe0
   [<c01269aa>] __do_softirq+0x10a/0x130
   [<c01058ff>] do_softirq+0x4f/0x60
   =======================
   [<c0113817>] smp_apic_timer_interrupt+0x77/0x110
   [<c0103b54>] apic_timer_interrupt+0x1c/0x24
  Code:  Bad EIP value.
   <0>Kernel panic - not syncing: Fatal exception in interrupt

Signed-Off-By: Pavel Emelianov <xemul@sw.ru>
Signed-Off-By: Dmitry Mishin <dim@openvz.org>
Signed-Off-By: Kirill Korotaev <dev@openvz.org>

Thanks,
Kirill

--------------060501060203050801030102
Content-Type: text/plain;
 name="diff-ms-files-fix-20060329"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-ms-files-fix-20060329"

--- ./kernel/fork.c.fsfix	2006-03-29 11:42:01.000000000 +0400
+++ ./kernel/fork.c	2006-03-29 19:20:18.000000000 +0400
@@ -758,7 +758,7 @@ out_release:
 	free_fdset (new_fdt->open_fds, new_fdt->max_fdset);
 	free_fd_array(new_fdt->fd, new_fdt->max_fds);
 	kmem_cache_free(files_cachep, newf);
-	goto out;
+	return NULL;
 }
 
 static int copy_files(unsigned long clone_flags, struct task_struct * tsk)


--------------060501060203050801030102--

