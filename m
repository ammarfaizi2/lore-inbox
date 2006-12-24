Return-Path: <linux-kernel-owner+w=401wt.eu-S1752317AbWLXQ6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317AbWLXQ6V (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 11:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752394AbWLXQ6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 11:58:21 -0500
Received: from mail.parknet.jp ([210.171.160.80]:2495 "EHLO parknet.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752317AbWLXQ6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 11:58:20 -0500
X-AuthUser: hirofumi@parknet.jp
To: "Fabio Comolli" <fabio.comolli@gmail.com>
Cc: "kernel list" <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: BUG: scheduling while atomic - Linux 2.6.20-rc2-ga3d89517
References: <b637ec0b0612240553n28b252c4p4c1559da794e646c@mail.gmail.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 25 Dec 2006 01:58:09 +0900
In-Reply-To: <b637ec0b0612240553n28b252c4p4c1559da794e646c@mail.gmail.com> (Fabio Comolli's message of "Sun\, 24 Dec 2006 08\:53\:48 -0500")
Message-ID: <87psa9z0wu.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Fabio Comolli" <fabio.comolli@gmail.com> writes:

> Just found this in syslog. It was during normal activity, about 6
> minutes after resume-from-ram. I never saw this before.

It seems someone missed to check PREEMPT_ACTIVE in __resched_legal().
Could you please test the following patch?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>



Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 kernel/sched.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff -puN kernel/sched.c~__resched_legal kernel/sched.c
--- linux-2.6/kernel/sched.c~__resched_legal	2006-12-24 22:40:19.000000000 +0900
+++ linux-2.6-hirofumi/kernel/sched.c	2006-12-24 23:54:01.000000000 +0900
@@ -4619,10 +4619,11 @@ asmlinkage long sys_sched_yield(void)
 
 static inline int __resched_legal(int expected_preempt_count)
 {
-#ifdef CONFIG_PREEMPT
+#ifndef CONFIG_PREEMPT
+	expected_preempt_count = 0;
+#endif
 	if (unlikely(preempt_count() != expected_preempt_count))
 		return 0;
-#endif
 	if (unlikely(system_state != SYSTEM_RUNNING))
 		return 0;
 	return 1;
_
