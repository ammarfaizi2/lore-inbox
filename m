Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262015AbVCHAdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbVCHAdH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 19:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261859AbVCHARw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 19:17:52 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:62853 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261804AbVCHAPh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 19:15:37 -0500
Date: Mon, 7 Mar 2005 16:15:34 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: domen@coderock.org, linux-kernel@vger.kernel.org
Subject: [UPDATE PATCH] char/hvsi: use wait_event_timeout()
Message-ID: <20050308001534.GF2778@us.ibm.com>
References: <20050306223630.55D7C1ED3D@trashy.coderock.org> <20050306193236.1dd2b3de.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050306193236.1dd2b3de.akpm@osdl.org>
X-Operating-System: Linux 2.6.11 (i686)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2005 at 07:32:36PM -0800, Andrew Morton wrote:
> domen@coderock.org wrote:
> >
> > Please consider applying. This is my first wait-queue related patch, so comments
> >  are very welcome.
> > 
> >  Use wait_event_timeout() in place of custom wait-queue code. The
> >  code is not changed in any way (I don't think), but is cleaned up quite a bit
> >  (will get expanded to almost identical code).
> > 
> > ...
> >  diff -puN drivers/char/hvsi.c~wait_event_timeout-drivers_char_hvsi drivers/char/hvsi.c
> >  --- kj/drivers/char/hvsi.c~wait_event_timeout-drivers_char_hvsi	2005-03-05 16:11:27.000000000 +0100
> >  +++ kj-domen/drivers/char/hvsi.c	2005-03-05 16:11:27.000000000 +0100

<snip>

> >  +	if(!wait_event_timeout(hp->stateq, (hp->state == state), jiffies + HVSI_TIMEOUT))
> >  +		ret = -EIO;
> 
> wait_event_timeout()'s `timeout' arg is number-of-milliseconds-to-wait,
> not an absolute time, yes?
> 
> Also, it's conventional to put a space between the `if' and the `('.
> 
> It's nice to squeeze the code into an 80-column xterm, too.

All fixed in the below patch. Would you prefer an incremental version?

Thanks,
Nish

Description: Use wait_event_timeout() in place of custom wait-queue
code. The code is not changed in any way (I don't think), but is cleaned
up quite a bit (will get expanded to almost identical code).

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.11-v/drivers/char/hvsi.c	2005-03-01 23:38:13.000000000 -0800
+++ 2.6.11/drivers/char/hvsi.c	2005-03-07 16:14:51.000000000 -0800
@@ -631,27 +631,10 @@ static int __init poll_for_state(struct 
 /* wait for irq handler to change our state */
 static int wait_for_state(struct hvsi_struct *hp, int state)
 {
-	unsigned long end_jiffies = jiffies + HVSI_TIMEOUT;
-	unsigned long timeout;
 	int ret = 0;
 
-	DECLARE_WAITQUEUE(myself, current);
-	set_current_state(TASK_INTERRUPTIBLE);
-	add_wait_queue(&hp->stateq, &myself);
-
-	for (;;) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		if (hp->state == state)
-			break;
-		timeout = end_jiffies - jiffies;
-		if (time_after(jiffies, end_jiffies)) {
-			ret = -EIO;
-			break;
-		}
-		schedule_timeout(timeout);
-	}
-	remove_wait_queue(&hp->stateq, &myself);
-	set_current_state(TASK_RUNNING);
+	if (!wait_event_timeout(hp->stateq, (hp->state == state), HVSI_TIMEOUT))
+		ret = -EIO;
 
 	return ret;
 }
@@ -868,24 +851,7 @@ static int hvsi_open(struct tty_struct *
 /* wait for hvsi_write_worker to empty hp->outbuf */
 static void hvsi_flush_output(struct hvsi_struct *hp)
 {
-	unsigned long end_jiffies = jiffies + HVSI_TIMEOUT;
-	unsigned long timeout;
-
-	DECLARE_WAITQUEUE(myself, current);
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	add_wait_queue(&hp->emptyq, &myself);
-
-	for (;;) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		if (hp->n_outbuf <= 0)
-			break;
-		timeout = end_jiffies - jiffies;
-		if (time_after(jiffies, end_jiffies))
-			break;
-		schedule_timeout(timeout);
-	}
-	remove_wait_queue(&hp->emptyq, &myself);
-	set_current_state(TASK_RUNNING);
+	wait_event_timeout(hp->emptyq, (hp->n_outbuf <= 0), HVSI_TIMEOUT);
 
 	/* 'writer' could still be pending if it didn't see n_outbuf = 0 yet */
 	cancel_delayed_work(&hp->writer);
