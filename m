Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270161AbUJSXbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270161AbUJSXbb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270116AbUJSX0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:26:12 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:18850
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S270180AbUJSWqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:54 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U7
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1098212697.12223.1006.camel@thomas>
References: <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
	 <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
	 <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>
	 <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>
	 <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu>
	 <20041019180059.GA23113@elte.hu>  <1098212697.12223.1006.camel@thomas>
Content-Type: multipart/mixed; boundary="=-zRWn9h24u/i5lioer6op"
Organization: linutronix
Message-Id: <1098225530.12223.1047.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 00:38:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zRWn9h24u/i5lioer6op
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2004-10-19 at 21:04, Thomas Gleixner wrote:
> On Tue, 2004-10-19 at 20:00, Ingo Molnar wrote:
> > i have released the -U7 Real-Time Preemption patch:
> 
> Another simple fix.

Another one using wait_for_completion_timeout(). No problems so far.

tglx



--=-zRWn9h24u/i5lioer6op
Content-Disposition: attachment; filename=clntlock.c.diff
Content-Type: text/x-patch; name=clntlock.c.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

diff -urN 2.6.9-rc4-mm1-RT-U7/fs/lockd/clntlock.c 2.6.9-rc4-mm1-RT-U7-work/fs/lockd/clntlock.c
--- 2.6.9-rc4-mm1-RT-U7/fs/lockd/clntlock.c	2004-10-12 09:32:10.000000000 +0200
+++ 2.6.9-rc4-mm1-RT-U7-work/fs/lockd/clntlock.c	2004-10-19 21:26:14.000000000 +0200
@@ -6,6 +6,7 @@
  * Copyright (C) 1996, Olaf Kirch <okir@monad.swb.de>
  */
 
+#include <linux/completion.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/time.h>
@@ -32,7 +33,7 @@
  */
 struct nlm_wait {
 	struct nlm_wait *	b_next;		/* linked list */
-	wait_queue_head_t	b_wait;		/* where to wait on */
+	struct completion	b_wait;		/* where to wait on */
 	struct nlm_host *	b_host;
 	struct file_lock *	b_lock;		/* local file lock */
 	unsigned short		b_reclaim;	/* got to reclaim lock */
@@ -53,7 +54,7 @@
 
 	block.b_host   = host;
 	block.b_lock   = fl;
-	init_waitqueue_head(&block.b_wait);
+	init_completion(&block.b_wait);
 	block.b_status = NLM_LCK_BLOCKED;
 	block.b_next   = nlm_blocked;
 	nlm_blocked    = &block;
@@ -69,7 +70,8 @@
 	 * a 1 minute timeout would do. See the comment before
 	 * nlmclnt_lock for an explanation.
 	 */
-	sleep_on_timeout(&block.b_wait, 30*HZ);
+	
+	wait_for_completion_timeout(&block.b_wait, 30*HZ);
 
 	for (head = &nlm_blocked; *head; head = &(*head)->b_next) {
 		if (*head == &block) {
@@ -118,7 +120,7 @@
 	 * wake up the caller.
 	 */
 	block->b_status = NLM_LCK_GRANTED;
-	wake_up(&block->b_wait);
+	complete(&block->b_wait);
 
 	return nlm_granted;
 }
@@ -233,7 +235,7 @@
 	for (block = nlm_blocked; block; block = block->b_next) {
 		if (block->b_host == host) {
 			block->b_status = NLM_LCK_DENIED_GRACE_PERIOD;
-			wake_up(&block->b_wait);
+			complete(&block->b_wait);
 		}
 	}
 

--=-zRWn9h24u/i5lioer6op--

