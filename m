Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263321AbTB0K0U>; Thu, 27 Feb 2003 05:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263342AbTB0K0U>; Thu, 27 Feb 2003 05:26:20 -0500
Received: from d12lmsgate-5.de.ibm.com ([194.196.100.238]:19395 "EHLO
	d12lmsgate-5.de.ibm.com") by vger.kernel.org with ESMTP
	id <S263321AbTB0K0T> convert rfc822-to-8bit; Thu, 27 Feb 2003 05:26:19 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.63 tsk->usage count.
Date: Thu, 27 Feb 2003 11:34:28 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200302271134.28229.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
while debugging a memory leak with task structures on s390
I found something related to it. If copy_process fails for some
reason the task structure created with dup_task_struct has set
p->usage to 2 but only one put_task_struct is done in the error
cleanup code. The attached patch should take care of it.

blue skies,
  Martin.

diff -urN linux-2.5/kernel/fork.c linux-2.5-fork/kernel/fork.c
--- linux-2.5/kernel/fork.c	Thu Feb 27 11:25:56 2003
+++ linux-2.5-fork/kernel/fork.c	Thu Feb 27 10:11:42 2003
@@ -1034,6 +1034,8 @@
 	atomic_dec(&p->user->processes);
 	free_uid(p->user);
 bad_fork_free:
+	/* dup_task_struct sets p->usage to 2 */
+	atomic_dec(&p->usage);
 	put_task_struct(p);
 	goto fork_out;
 }

