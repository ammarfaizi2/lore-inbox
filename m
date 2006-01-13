Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422641AbWAMMZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422641AbWAMMZG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 07:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422644AbWAMMZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 07:25:05 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:35733 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1422641AbWAMMZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 07:25:04 -0500
Date: Fri, 13 Jan 2006 13:24:21 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: show_task oops fix
Message-ID: <20060113122421.GB8268@osiris.boeblingen.de.ibm.com>
References: <20060112171516.GF16629@skybase.boeblingen.de.ibm.com> <20060112165826.5843e34c.akpm@osdl.org> <1137141942.6192.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137141942.6192.5.camel@localhost.localdomain>
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Use new stack page accessors as pointed out by Andrew Morton.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/kernel/process.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff -urN a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
--- a/arch/s390/kernel/process.c	2006-01-13 12:15:44.000000000 +0100
+++ b/arch/s390/kernel/process.c	2006-01-13 12:43:32.000000000 +0100
@@ -60,11 +60,10 @@
 {
 	struct stack_frame *sf, *low, *high;
 
-	if (!tsk || !tsk->thread_info)
+	if (!tsk || !task_stack_page(tsk))
 		return 0;
-	low = (struct stack_frame *) tsk->thread_info;
-	high = (struct stack_frame *)
-		((unsigned long) tsk->thread_info + THREAD_SIZE) - 1;
+	low = task_stack_page(tsk);
+	high = (struct stack_frame *) task_pt_regs(tsk);
 	sf = (struct stack_frame *) (tsk->thread.ksp & PSW_ADDR_INSN);
 	if (sf <= low || sf > high)
 		return 0;
