Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268397AbUIMPRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268397AbUIMPRI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 11:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268464AbUIMPQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 11:16:28 -0400
Received: from asplinux.ru ([195.133.213.194]:11783 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S267683AbUIMPJO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 11:09:14 -0400
Message-ID: <4145BACE.8090005@sw.ru>
Date: Mon, 13 Sep 2004 19:20:46 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm5
References: <20040913015003.5406abae.akpm@osdl.org>
In-Reply-To: <20040913015003.5406abae.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------030307090000020703050802"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030307090000020703050802
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello Andrew,

Please replace patch next_thread-bug-fixes.patch in -mm5 tree with the 
last diff-next_thread I sent to you.

And it looks like thread loop in do_task_stat() doesn't require siglock 
lock, so you can add the patch attached to reduce lock area.

Kirill

--------------030307090000020703050802
Content-Type: text/plain;
 name="diff-task_stat-mm5"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-task_stat-mm5"

--- ./fs/proc/array.c.nt	2004-09-13 18:56:17.000000000 +0400
+++ ./fs/proc/array.c	2004-09-13 19:13:03.749684712 +0400
@@ -338,6 +338,7 @@ static int do_task_stat(struct task_stru
 		spin_lock_irq(&task->sighand->siglock);
 		num_threads = atomic_read(&task->signal->count);
 		collect_sigign_sigcatch(task, &sigign, &sigcatch);
+		spin_unlock_irq(&task->sighand->siglock);
 
 		/* add up live thread stats at the group level */
 		if (whole) {
@@ -350,8 +351,6 @@ static int do_task_stat(struct task_stru
 				t = next_thread(t);
 			} while (t != task);
 		}
-
-		spin_unlock_irq(&task->sighand->siglock);
 	}
 	if (task->signal) {
 		if (task->signal->tty) {

--------------030307090000020703050802--

