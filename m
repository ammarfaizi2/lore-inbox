Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270271AbTHQOwg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 10:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270272AbTHQOwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 10:52:36 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:26598
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S270271AbTHQOwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 10:52:34 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] O16.2int
Date: Mon, 18 Aug 2003 00:59:07 +1000
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <200308161902.52337.kernel@kolivas.org> <20030817004013.14c399da.akpm@osdl.org>
In-Reply-To: <20030817004013.14c399da.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_7g5P/4fzrFzUNpA"
Message-Id: <200308180059.07813.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_7g5P/4fzrFzUNpA
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sun, 17 Aug 2003 17:40, Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> > Much simpler
>
> But broken.
>
> The machine runs about 100x slower than normal.  The screensaver cut in
> halfway through the initscripts ;) That's on 2-way.  The same kernel works
> OK on uniprocessor.

Reverting the !in_interrupt nonsense should be enough to avoid the dreaded 
screensaver at boottime I hope. Does this fix it?

Starvation will be approached differently.

Change:
Make preemption occur as vanilla again except for now not preempting same 
priority tasks with less timeslice.

Con

--Boundary-00=_7g5P/4fzrFzUNpA
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch-O16.2-O16.3int"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="patch-O16.2-O16.3int"

--- linux-2.6.0-test3-mm2-O16.2/kernel/sched.c	2003-08-18 00:03:53.000000000 +1000
+++ linux-2.6.0-test3-mm2-O16.3/kernel/sched.c	2003-08-18 00:44:20.000000000 +1000
@@ -609,9 +609,8 @@ repeat_lock_task:
 				__activate_task(p, rq);
 			else {
 				activate_task(p, rq);
-				if (TASK_PREEMPTS_CURR(p, rq) &&
-					(in_interrupt() || !p->mm))
-						resched_task(rq->curr);
+				if (TASK_PREEMPTS_CURR(p, rq))
+					resched_task(rq->curr);
 			}
 			success = 1;
 		}

--Boundary-00=_7g5P/4fzrFzUNpA--

