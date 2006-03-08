Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751792AbWCHRyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792AbWCHRyw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 12:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751808AbWCHRyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 12:54:52 -0500
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:52679 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751792AbWCHRyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 12:54:51 -0500
Date: Wed, 8 Mar 2006 18:54:50 +0100
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org
Subject: [PATCH] -mm: Small schedule() optimization
Message-ID: <20060308175450.GA28763@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I found that there's a possible small optimization right at the very
beginning of schedule():

        if (likely(!current->exit_state)) {
                if (unlikely(in_atomic())) {

can be reversed into

        if (unlikely(in_atomic())) {
                if (likely(!current->exit_state)) {

This is a Good Thing since it avoids having to evaluate both checks,
and both use current_thread_info() which has an inherent AGI stall risk on
x86 CPUs if it cannot be inter-mingled with other unrelated opcodes.

I'm a bit puzzled that this has not been done like that before.
Probably since the exit_state check got added as an after-thought...
Or did I miss some important reason here? (branch prediction??)

Patch against 2.6.16-rc5-mm3.

Thanks!

Signed-off-by: Andreas Mohr <andi@lisas.de>


--- linux-2.6.16-rc5-mm3/kernel/sched.c.orig	2006-03-08 18:36:58.000000000 +0100
+++ linux-2.6.16-rc5-mm3/kernel/sched.c	2006-03-08 18:39:55.000000000 +0100
@@ -3022,8 +3022,8 @@
 	 * schedule() atomically, we ignore that path for now.
 	 * Otherwise, whine if we are scheduling when we should not be.
 	 */
-	if (likely(!current->exit_state)) {
-		if (unlikely(in_atomic())) {
+	if (unlikely(in_atomic())) {
+		if (likely(!current->exit_state)) {
 			printk(KERN_ERR "BUG: scheduling while atomic: "
 				"%s/0x%08x/%d\n",
 				current->comm, preempt_count(), current->pid);

-- 
No programming skills!? Why not help translate many Linux applications! 
https://launchpad.ubuntu.com/rosetta
