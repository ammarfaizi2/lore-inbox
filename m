Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbUKOXm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbUKOXm2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 18:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbUKOXkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 18:40:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:56766 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261648AbUKOXjf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 18:39:35 -0500
Date: Mon, 15 Nov 2004 15:43:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] -mm check_rlimit oops on p->signal
Message-Id: <20041115154346.33089c0b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0411152043250.4131-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0411152043250.4131-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> +	if (likely(p->signal && p->exit_state < EXIT_ZOMBIE)) {

Worried.  This places an ordering interpretation on TASK_* and EXIT_* which
AFAIK hadn't been there beforehand.  If someone later comes along and adds

#define TASK_DOODLING 64

then we lose.

I wonder if for clarity and future-safety we should do something like:

--- 25/include/linux/sched.h~task-exit_state-clarity	Mon Nov 15 15:40:24 2004
+++ 25-akpm/include/linux/sched.h	Mon Nov 15 15:42:40 2004
@@ -105,13 +105,20 @@ extern unsigned long nr_iowait(void);
 
 #include <asm/processor.h>
 
+/*
+ * Tasks whose exit_state is less that TASK_EXIT_MARKER are considered to
+ * be still running.  Tasks whose exit_state is greater than TASK_EXIT_MARKER
+ * are in the process of exitting.  TASK_EXIT_MARKER is never actually set in
+ * task_struct.exit_state.
+ */
 #define TASK_RUNNING		0
 #define TASK_INTERRUPTIBLE	1
 #define TASK_UNINTERRUPTIBLE	2
 #define TASK_STOPPED		4
 #define TASK_TRACED		8
-#define EXIT_ZOMBIE		16
-#define EXIT_DEAD		32
+#define TASK_EXIT_MARKER	16	
+#define EXIT_ZOMBIE		32
+#define EXIT_DEAD		64
 
 #define __set_task_state(tsk, state_value)		\
 	do { (tsk)->state = (state_value); } while (0)
_

It seems a bit dorky for some reason...
