Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272455AbTG3BE2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 21:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272495AbTG3BE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 21:04:28 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:35507
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272455AbTG3BE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 21:04:26 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O11int for interactivity
Date: Wed, 30 Jul 2003 11:08:53 +1000
User-Agent: KMail/1.5.2
Cc: Andrew Morton <akpm@osdl.org>
References: <200307301038.49869.kernel@kolivas.org> <200307301055.23950.kernel@kolivas.org>
In-Reply-To: <200307301055.23950.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307301108.53904.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jul 2003 10:55, Con Kolivas wrote:
> On Wed, 30 Jul 2003 10:38, Con Kolivas wrote:
> > Update to the interactivity patches. Not a massive improvement but
> > more smoothing of the corners.
>
> Woops my bad. Seems putting things even at the start of the expired array
> can induce a corner case. Will post an O11.1 in a few mins to back out that
> part.

Here is O11.1int which backs out that part. This was only of minor help
anyway so backing it out still makes the other O11 changes worthwhile.

A full O11.1 patch against 2.6.0-test2 is available on my website.

--- linux-2.6.0-test2-mm1/kernel/sched.c	2003-07-30 10:54:54.000000000 +1000
+++ linux-2.6.0-test2mm1O11/kernel/sched.c	2003-07-30 10:46:43.000000000 +1000
@@ -310,14 +310,6 @@ static inline void enqueue_task(struct t
 	p->array = array;
 }
 
-static inline void enqueue_head_task(struct task_struct *p, prio_array_t *array)
-{
-	list_add(&p->run_list, array->queue + p->prio);
-	__set_bit(p->prio, array->bitmap);
-	array->nr_active++;
-	p->array = array;
-}
-
 /*
  * effective_prio - return the priority that is based on the static
  * priority but is modified by bonuses/penalties.
@@ -1305,13 +1297,10 @@ void scheduler_tick(int user_ticks, int 
 			 * run out of sleep_avg to be expired, and when they
 			 * do they are put at the start of the expired array
 			 */
-			if (unlikely(p->interactive_credit)){
-				if (p->sleep_avg){
-					enqueue_task(p, rq->active);
-					goto out_unlock;
-				}
-				enqueue_head_task(p, rq->expired);
-			} else
+			if (unlikely(p->interactive_credit && p->sleep_avg)){
+				enqueue_task(p, rq->active);
+				goto out_unlock;
+			}
 				enqueue_task(p, rq->expired);
 		} else
 			enqueue_task(p, rq->active);

