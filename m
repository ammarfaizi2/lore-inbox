Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161395AbWHDUL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161395AbWHDUL4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 16:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161398AbWHDUL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 16:11:56 -0400
Received: from www.osadl.org ([213.239.205.134]:20660 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161395AbWHDULz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 16:11:55 -0400
Subject: Re: Futex BUG in 2.6.18rc2-git7
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andi Kleen <ak@suse.de>
Cc: Olaf Hering <olaf@aepfle.de>, mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <200608041036.47763.ak@suse.de>
References: <200608040917.00690.ak@suse.de>
	 <20060804082637.GA19493@aepfle.de>  <200608041036.47763.ak@suse.de>
Content-Type: text/plain
Date: Fri, 04 Aug 2006 22:12:15 +0200
Message-Id: <1154722335.5932.243.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-04 at 10:36 +0200, Andi Kleen wrote:
> On Friday 04 August 2006 10:26, Olaf Hering wrote:
> > On Fri, Aug 04, 2006 at 09:17:00AM +0200, Andi Kleen wrote:
> > > 
> > > One of my test machines (single socket core2 duo) running 2.6.18rc2-git7 over night 
> > > under moderate load threw this, followed by an endless loop of soft lockup timeouts
> > > (one exemplar appended)
> > > 
> > > I assume it is related to the new PI mutexes.
> > 
> > Maybe triggered by this, if it was from wagner.suse.de:
> 
> Yes it was that box. So it looks like the new mutex code cannot run
> the glibc test suite.

Can you retest against -rc3-current + the compat fix I sent out earlier
today (see also below) ?

Is the glibc the latest CVS version ?

	tglx


diff --git a/kernel/futex_compat.c b/kernel/futex_compat.c
index d1aab1a..c5cca3f 100644
--- a/kernel/futex_compat.c
+++ b/kernel/futex_compat.c
@@ -39,7 +39,7 @@ void compat_exit_robust_list(struct task
 {
 	struct compat_robust_list_head __user *head = curr->compat_robust_list;
 	struct robust_list __user *entry, *pending;
-	unsigned int limit = ROBUST_LIST_LIMIT, pi;
+	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip;
 	compat_uptr_t uentry, upending;
 	compat_long_t futex_offset;
 
@@ -59,10 +59,10 @@ void compat_exit_robust_list(struct task
 	 * if it exists:
 	 */
 	if (fetch_robust_entry(&upending, &pending,
-			       &head->list_op_pending, &pi))
+			       &head->list_op_pending, &pip))
 		return;
 	if (upending)
-		handle_futex_death((void *)pending + futex_offset, curr, pi);
+		handle_futex_death((void *)pending + futex_offset, curr, pip);
 
 	while (compat_ptr(uentry) != &head->list) {
 		/*


