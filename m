Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262000AbVATA2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbVATA2f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 19:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbVATA0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 19:26:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22441 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262009AbVATA03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 19:26:29 -0500
Date: Wed, 19 Jan 2005 16:26:15 -0800
Message-Id: <200501200026.j0K0QFst021029@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cputime_t patches broke RLIMIT_CPU
In-Reply-To: Linus Torvalds's message of  Wednesday, 19 January 2005 16:09:58 -0800 <Pine.LNX.4.58.0501191605380.8178@ppc970.osdl.org>
X-Fcc: ~/Mail/linus
Emacs: more than just a Lisp interpreter, a text editor as well!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So would it not be nicer to just keep everything in seconds instead? 

Yes, that's how it was done before.  The patch I just posted was intended
to fix the apparent typo without getting any deeper.  Below is an untested
alternate patch to restore the old behavior under the new macro regime.

> Alternatively, seriously fix "secs_to_cputime()" to do the proper thing?
> Or did I miss a patch and you already did that?

I wasn't really on a cputime-cleanup rampage, just fixing the obvious bugs
I saw.  I hope Martin would like to do some cleanup.


Thanks,
Roland


--- linux-2.6/kernel/sched.c
+++ linux-2.6/kernel/sched.c
@@ -2299,17 +2325,17 @@ static void account_it_prof(struct task_
 static void check_rlimit(struct task_struct *p, cputime_t cputime)
 {
 	cputime_t total, tmp;
+	unsigned long secs;
 
 	total = cputime_add(p->utime, p->stime);
-	tmp = jiffies_to_cputime(p->signal->rlim[RLIMIT_CPU].rlim_cur);
-	if (unlikely(cputime_gt(total, tmp))) {
+	secs = cputime_to_secs(total);
+	if (unlikely(secs >= p->signal->rlim[RLIMIT_CPU].rlim_cur)) {
 		/* Send SIGXCPU every second. */
 		tmp = cputime_sub(total, cputime);
-		if (cputime_to_secs(tmp) < cputime_to_secs(total))
+		if (cputime_to_secs(tmp) < secs)
 			send_sig(SIGXCPU, p, 1);
 		/* and SIGKILL when we go over max.. */
-		tmp = jiffies_to_cputime(p->signal->rlim[RLIMIT_CPU].rlim_max);
-		if (cputime_gt(total, tmp))
+		if (secs >= p->signal->rlim[RLIMIT_CPU].rlim_max)
 			send_sig(SIGKILL, p, 1);
 	}
 }
