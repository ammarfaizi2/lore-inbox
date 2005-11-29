Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbVK2KmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbVK2KmM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 05:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbVK2KmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 05:42:11 -0500
Received: from baythorne.infradead.org ([81.187.2.161]:37080 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S1751043AbVK2KmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 05:42:10 -0500
Subject: Re: [PATCH] 3/3 Generic sys_rt_sigsuspend
From: David Woodhouse <dwmw2@infradead.org>
To: Mika =?ISO-8859-1?Q?Penttil=E4?= <mika.penttila@kolumbus.fi>
Cc: linux-kernel@vger.kernel.org, drepper@redhat.com, linuxppc-dev@ozlabs.org,
       akpm@osdl.org
In-Reply-To: <438BE48B.9060908@kolumbus.fi>
References: <1133225007.31573.86.camel@baythorne.infradead.org>
	 <1133225852.31573.115.camel@baythorne.infradead.org>
	 <438BE48B.9060908@kolumbus.fi>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Nov 2005 10:42:03 +0000
Message-Id: <1133260923.31573.131.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-29 at 07:18 +0200, Mika Penttilä wrote:
> You are not setting saved_sigmask here. 

Oops; well spotted. Thanks.

> And shouldn't it return -EINTR?

I believe not. The previous versions would loop until do_signal()
returned non-zero; i.e. until a signal was actually delivered.
By returning -ERESTARTNOHAND we achieve the same effect. If there's a
signal delivered, that gets magically converted to -EINTR, but if
there's no signal delivered, the syscall gets restarted.

diff -u b/kernel/compat.c b/kernel/compat.c
--- b/kernel/compat.c
+++ b/kernel/compat.c
@@ -859,7 +859,7 @@
 #ifdef __ARCH_WANT_COMPAT_SYS_RT_SIGSUSPEND
 long compat_sys_rt_sigsuspend(compat_sigset_t __user *unewset, compat_size_t sigsetsize)
 {
-	sigset_t saveset, newset;
+	sigset_t newset;
 	compat_sigset_t newset32;
 
 	/* XXX: Don't preclude handling different sized sigset_t's.  */
@@ -872,7 +872,7 @@
 	sigdelsetmask(&newset, sigmask(SIGKILL)|sigmask(SIGSTOP));
 
 	spin_lock_irq(&current->sighand->siglock);
-	saveset = current->blocked;
+	current->saved_sigmask = current->blocked;
 	current->blocked = newset;
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
diff -u b/kernel/signal.c b/kernel/signal.c
--- b/kernel/signal.c
+++ b/kernel/signal.c
@@ -2626,7 +2626,7 @@
 #ifdef __ARCH_WANT_SYS_RT_SIGSUSPEND
 long sys_rt_sigsuspend(sigset_t __user *unewset, size_t sigsetsize)
 {
-	sigset_t saveset, newset;
+	sigset_t newset;
 
 	/* XXX: Don't preclude handling different sized sigset_t's.  */
 	if (sigsetsize != sizeof(sigset_t))
@@ -2637,7 +2637,7 @@
 	sigdelsetmask(&newset, sigmask(SIGKILL)|sigmask(SIGSTOP));
 
 	spin_lock_irq(&current->sighand->siglock);
-	saveset = current->blocked;
+	current->saved_sigmask = current->blocked;
 	current->blocked = newset;
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);


-- 
dwmw2


