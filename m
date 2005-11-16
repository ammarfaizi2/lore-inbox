Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161015AbVKPX13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161015AbVKPX13 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 18:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030564AbVKPX12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 18:27:28 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:23029 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S1030546AbVKPX12
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 18:27:28 -0500
Message-ID: <437BC01D.60302@mvista.com>
Date: Wed, 16 Nov 2005 15:26:21 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: paulmck@us.ibm.com, Roland McGrath <roland@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, dipankar@in.ibm.com, mingo@elte.hu,
       suzannew@cs.pdx.edu
Subject: [PATCH] sigaction should clear all signals on SIG_IGN, not just <
 32
References: <20051105013650.GA17461@us.ibm.com> <436CDEAF.E236BC40@tv-sign.ru> <20051106010004.GB20178@us.ibm.com> <436E1401.920A83EE@tv-sign.ru>
In-Reply-To: <436E1401.920A83EE@tv-sign.ru>
Content-Type: multipart/mixed;
 boundary="------------030908040405030104050400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030908040405030104050400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

While rooting aroung in the signal code trying to understand how to
fix the SIG_IGN	ploy (set sig handler to SIG_IGN and flood system with
high speed repeating timers) I came across what, I think, is a problem
in sigaction() in that when processing a SIG_IGN request it flushes
signals from 1 to SIGRTMIN and leaves the rest.  The attached patch is
an attempt to fix this.

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/


--------------030908040405030104050400
Content-Type: text/plain;
 name="sigaction-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sigaction-fix.patch"

Source: MontaVista Software, Inc.
Type: Defect Fix 
Description:
It appeares that the sigaction system call, when processing a SIG_IGN or
a SIG_DFL, is removing only signals that appear in the first mask word.

Signed-off-by: George Anzinger <george@mvista.com>

 include/linux/signal.h |   16 ++++++++++++++++
 kernel/signal.c        |   34 ++++++++++++++++++++++++++++++++--
 2 files changed, 48 insertions(+), 2 deletions(-)

Index: linux-2.6.15-rc/kernel/signal.c
===================================================================
--- linux-2.6.15-rc.orig/kernel/signal.c
+++ linux-2.6.15-rc/kernel/signal.c
@@ -633,6 +633,33 @@ void signal_wake_up(struct task_struct *
  * Returns 1 if any signals were found.
  *
  * All callers must be holding the siglock.
+ *
+ * This version takes a sigset mask and looks at all signals,
+ * not just those in the first mask word.
+ */
+static int rm_from_queue_full(sigset_t *mask, struct sigpending *s)
+{
+	struct sigqueue *q, *n;
+	sigset_t m;
+
+	sigandsets(&m, mask, &s->signal);
+	if (sigisemptyset(&m))
+		return 0;
+
+	signandsets(&s->signal, &s->signal, mask);
+	list_for_each_entry_safe(q, n, &s->list, list) {
+		if (sigismember(mask, q->info.si_signo)) {
+			list_del_init(&q->list);
+			__sigqueue_free(q);
+		}
+	}
+	return 1;
+}
+/*
+ * Remove signals in mask from the pending set and queue.
+ * Returns 1 if any signals were found.
+ *
+ * All callers must be holding the siglock.
  */
 static int rm_from_queue(unsigned long mask, struct sigpending *s)
 {
@@ -2471,6 +2498,7 @@ int
 do_sigaction(int sig, const struct k_sigaction *act, struct k_sigaction *oact)
 {
 	struct k_sigaction *k;
+	sigset_t mask;
 
 	if (!valid_signal(sig) || sig < 1 || (act && sig_kernel_only(sig)))
 		return -EINVAL;
@@ -2518,9 +2546,11 @@ do_sigaction(int sig, const struct k_sig
 			*k = *act;
 			sigdelsetmask(&k->sa.sa_mask,
 				      sigmask(SIGKILL) | sigmask(SIGSTOP));
-			rm_from_queue(sigmask(sig), &t->signal->shared_pending);
+			sigemptyset(&mask);
+			sigaddset(&mask, sig);
+			rm_from_queue_full(&mask, &t->signal->shared_pending);
 			do {
-				rm_from_queue(sigmask(sig), &t->pending);
+				rm_from_queue_full(&mask, &t->pending);
 				recalc_sigpending_tsk(t);
 				t = next_thread(t);
 			} while (t != current);
Index: linux-2.6.15-rc/include/linux/signal.h
===================================================================
--- linux-2.6.15-rc.orig/include/linux/signal.h
+++ linux-2.6.15-rc/include/linux/signal.h
@@ -82,6 +82,22 @@ static inline int sigfindinword(unsigned
 
 #endif /* __HAVE_ARCH_SIG_BITOPS */
 
+static inline int sigisemptyset(sigset_t *set)
+{
+	extern void _NSIG_WORDS_is_unsupported_size(void);
+	switch (_NSIG_WORDS) {
+	case 4:
+		return (set->sig[3] | set->sig[2] |
+			set->sig[1] | set->sig[0]) == 0;
+	case 2:
+		return (set->sig[1] | set->sig[0]) == 0;
+	case 1:
+		return set->sig[0] == 0;
+	default:
+		_NSIG_WORDS_is_unsupported_size();
+	}
+}
+
 #define sigmask(sig)	(1UL << ((sig) - 1))
 
 #ifndef __HAVE_ARCH_SIG_SETOPS

--------------030908040405030104050400--
