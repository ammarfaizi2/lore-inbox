Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317232AbSILUac>; Thu, 12 Sep 2002 16:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317253AbSILUa3>; Thu, 12 Sep 2002 16:30:29 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:13837
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S317232AbSILUa1>; Thu, 12 Sep 2002 16:30:27 -0400
Subject: [PATCH] kernel BUG at sched.c:944! only with CONFIG_PREEMPT=y]
From: Robert Love <rml@tech9.net>
To: Steven Cole <elenstev@mesatop.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@digeo.com>, Ingo Molnar <mingo@elte.hu>,
       Steven Cole <scole@lanl.gov>
In-Reply-To: <1031862049.2799.402.camel@spc9.esa.lanl.gov>
References: <3D80EF3F.D82B9CB9@digeo.com> 
	<1031862049.2799.402.camel@spc9.esa.lanl.gov>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 12 Sep 2002 16:35:13 -0400
Message-Id: <1031862919.3770.103.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-12 at 16:20, Steven Cole wrote:

> Yes.  Sorry, didn't catch this reply until now.
> I backed out Changeset 1.606 which Linus did to kernel/sched.c did this:
> 
> -       if (unlikely(in_interrupt()))
> +       if (unlikely(in_atomic()))
> 
> and 2.5.34-mm2 was able to boot with CONFIG_PREEMPT=y.
> 
> As I said in a response to myself on lkml, I know this isn't a fix,
> it just shows there is a problem somewhere with preempt.

No, there is not a problem in preempt... what this change does is BUG()
out if schedule() is called while being in any way non-atomic.

While this sounds like a great debugging check, it is not useful in
general since we surely have some bad code that calls schedule() with
locks held.  Further, since the atomic accounting only includes locks if
CONFIG_PREEMPT is set, you only see this with kernel preemption enabled.

Linus, please back this out... attached patch is against current BK.

Yeah, I know we can change the BUG() to a show_stack() ... but I still
think it will be too much and just deter people from using kernel
preemption which is the opposite of what I want.

	Robert Love

diff -urN linux-2.5.34/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.34/kernel/sched.c	Thu Sep 12 16:26:23 2002
+++ linux/kernel/sched.c	Thu Sep 12 16:30:22 2002
@@ -940,8 +940,7 @@
 	struct list_head *queue;
 	int idx;
 
-	if (unlikely(in_atomic()))
-		BUG();
+	BUG_ON(in_interrupt());
 
 #if CONFIG_DEBUG_HIGHMEM
 	check_highmem_ptes();


