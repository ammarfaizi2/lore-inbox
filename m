Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269744AbUJAKi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269744AbUJAKi2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 06:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269751AbUJAKi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 06:38:28 -0400
Received: from asplinux.ru ([195.133.213.194]:31501 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S269744AbUJAKiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 06:38:24 -0400
Message-ID: <415D36AA.3000907@sw.ru>
Date: Fri, 01 Oct 2004 14:51:22 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Fix of stack dump in {SOFT|HARD}IRQs
Content-Type: multipart/mixed;
 boundary="------------050702060803020203030609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050702060803020203030609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes incorrect check for stack ptr in 
show_trace()->valid_stack_ptr(). When called from hardirq/softirq 
show_trace() prints "Stack pointer is garbage, not printing trace" 
message instead of call traces.

Signed-Off-By: Kirill Korotaev <dev@sw.ru>

Kirill

--------------050702060803020203030609
Content-Type: text/plain;
 name="diff-dumpstack"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-dumpstack"

--- ./arch/i386/kernel/traps.c.dumpstack	2004-10-01 14:21:40.000000000 +0400
+++ ./arch/i386/kernel/traps.c	2004-10-01 14:30:10.109733400 +0400
@@ -95,11 +95,16 @@ static int kstack_depth_to_print = 24;
 
 static int valid_stack_ptr(struct task_struct *task, void *p)
 {
-	if (p <= (void *)task->thread_info)
-		return 0;
-	if (kstack_end(p))
-		return 0;
-	return 1;
+	extern int is_irq_stack_ptr(struct task_struct *, void *);
+
+	if (is_irq_stack_ptr(task, p))
+		return 1;
+	if (p >= (void *)task->thread_info &&
+	    p < (void *)task->thread_info + THREAD_SIZE &&
+	    !kstack_end(p))
+		return 1;
+
+	return 0;
 }
 
 #ifdef CONFIG_FRAME_POINTER
--- ./arch/i386/kernel/irq.c.dumpstack	2004-09-20 14:14:58.000000000 +0400
+++ ./arch/i386/kernel/irq.c	2004-10-01 14:28:15.806110192 +0400
@@ -1126,6 +1126,21 @@ void init_irq_proc (void)
 static char softirq_stack[NR_CPUS * THREAD_SIZE]  __attribute__((__aligned__(THREAD_SIZE)));
 static char hardirq_stack[NR_CPUS * THREAD_SIZE]  __attribute__((__aligned__(THREAD_SIZE)));
 
+int is_irq_stack_ptr(struct task_struct *task, void *p)
+{
+	unsigned long off;
+
+	off = task->thread_info->cpu * THREAD_SIZE;
+	if (p >= (void *)hardirq_stack + off &&
+	    p < (void *)hardirq_stack + off + THREAD_SIZE)
+		return 1;
+	if (p >= (void *)softirq_stack + off &&
+	    p < (void *)softirq_stack + off + THREAD_SIZE)
+		return 1;
+
+	return 0;
+}
+
 /*
  * allocate per-cpu stacks for hardirq and for softirq processing
  */

--------------050702060803020203030609--

