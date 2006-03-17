Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752577AbWCQJQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577AbWCQJQF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 04:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbWCQJQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 04:16:05 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:42447 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1752577AbWCQJQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 04:16:02 -0500
Date: Fri, 17 Mar 2006 10:13:47 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>, ck@vds.kolivas.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] -mm: Small schedule() optimization
Message-ID: <20060317091347.GD13387@elte.hu>
References: <20060308175450.GA28763@rhlx01.fht-esslingen.de> <200603111200.27557.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603111200.27557.kernel@kolivas.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Con Kolivas <kernel@kolivas.org> wrote:

> > -	if (likely(!current->exit_state)) {
> > -		if (unlikely(in_atomic())) {
> > +	if (unlikely(in_atomic())) {
> > +		if (likely(!current->exit_state)) {
> 
> I suspect that once we're in_atomic() then we're no longer likely to 
> be !current->exit_state
> 
> Probably better to just
> 	if (unlikely(in_atomic())) {
> 		if (!current->exit_state) {
> 
> Ingo?

yeah. There's not much point in nesting likely/unlikely. In fact we can 
just merge the two conditions, as per updated patch below.

	Ingo

---
From: Andreas Mohr <andi@lisas.de>

small schedule() microoptimization.

Signed-off-by: Andreas Mohr <andi@lisas.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -2873,13 +2873,11 @@ asmlinkage void __sched schedule(void)
 	 * schedule() atomically, we ignore that path for now.
 	 * Otherwise, whine if we are scheduling when we should not be.
 	 */
-	if (likely(!current->exit_state)) {
-		if (unlikely(in_atomic())) {
-			printk(KERN_ERR "scheduling while atomic: "
-				"%s/0x%08x/%d\n",
-				current->comm, preempt_count(), current->pid);
-			dump_stack();
-		}
+	if (unlikely(in_atomic() && !current->exit_state)) {
+		printk(KERN_ERR "scheduling while atomic: "
+			"%s/0x%08x/%d\n",
+			current->comm, preempt_count(), current->pid);
+		dump_stack();
 	}
 	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
 
