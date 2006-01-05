Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWAESBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWAESBG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 13:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWAESBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 13:01:06 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:52403 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932125AbWAESBF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 13:01:05 -0500
Message-ID: <43BD70AD.21FC6862@tv-sign.ru>
Date: Thu, 05 Jan 2006 22:17:01 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       Shai Fultheim <shai@scalex86.org>, Nippun Goel <nippung@calsoftinc.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [rfc][patch] Avoid taking global tasklist_lock for single 
 threadedprocess at getrusage()
References: <43AD8AF6.387B357A@tv-sign.ru> <Pine.LNX.4.62.0512271220380.27174@schroedinger.engr.sgi.com> <43B2874F.F41A9299@tv-sign.ru> <20051228183345.GA3755@localhost.localdomain> <20051228225752.GB3755@localhost.localdomain> <43B57515.967F53E3@tv-sign.ru> <20060104231600.GA3664@localhost.localdomain>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai wrote:
>
> +       need_lock = (p == current && thread_group_empty(p));

This should be

	need_lock = !(p == current && thread_group_empty(p));


I think we should cleanup k_getrusage() first, see the patch below.

Do you agree with that patch? If yes, could you make the new one on
top of it? (please send them both to Andrew).

Note that after this cleanup we don't have code duplication.


[PATCH] simplify k_getrusage()

Factor out common code for different RUSAGE_xxx cases.

Don't take ->sighand->siglock in RUSAGE_SELF case, suggested
by Ravikiran G Thirumalai.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- K/kernel/sys.c~	2006-01-03 21:15:58.000000000 +0300
+++ K/kernel/sys.c	2006-01-06 00:40:34.000000000 +0300
@@ -1687,7 +1687,10 @@ static void k_getrusage(struct task_stru
 	if (unlikely(!p->signal))
 		return;
 
+	utime = stime = cputime_zero;
+
 	switch (who) {
+		case RUSAGE_BOTH:
 		case RUSAGE_CHILDREN:
 			spin_lock_irqsave(&p->sighand->siglock, flags);
 			utime = p->signal->cutime;
@@ -1697,22 +1700,11 @@ static void k_getrusage(struct task_stru
 			r->ru_minflt = p->signal->cmin_flt;
 			r->ru_majflt = p->signal->cmaj_flt;
 			spin_unlock_irqrestore(&p->sighand->siglock, flags);
-			cputime_to_timeval(utime, &r->ru_utime);
-			cputime_to_timeval(stime, &r->ru_stime);
-			break;
+
+			if (who == RUSAGE_CHILDREN)
+				break;
+
 		case RUSAGE_SELF:
-			spin_lock_irqsave(&p->sighand->siglock, flags);
-			utime = stime = cputime_zero;
-			goto sum_group;
-		case RUSAGE_BOTH:
-			spin_lock_irqsave(&p->sighand->siglock, flags);
-			utime = p->signal->cutime;
-			stime = p->signal->cstime;
-			r->ru_nvcsw = p->signal->cnvcsw;
-			r->ru_nivcsw = p->signal->cnivcsw;
-			r->ru_minflt = p->signal->cmin_flt;
-			r->ru_majflt = p->signal->cmaj_flt;
-		sum_group:
 			utime = cputime_add(utime, p->signal->utime);
 			stime = cputime_add(stime, p->signal->stime);
 			r->ru_nvcsw += p->signal->nvcsw;
@@ -1729,13 +1721,14 @@ static void k_getrusage(struct task_stru
 				r->ru_majflt += t->maj_flt;
 				t = next_thread(t);
 			} while (t != p);
-			spin_unlock_irqrestore(&p->sighand->siglock, flags);
-			cputime_to_timeval(utime, &r->ru_utime);
-			cputime_to_timeval(stime, &r->ru_stime);
 			break;
+
 		default:
 			BUG();
 	}
+
+	cputime_to_timeval(utime, &r->ru_utime);
+	cputime_to_timeval(stime, &r->ru_stime);
 }
 
 int getrusage(struct task_struct *p, int who, struct rusage __user *ru)
