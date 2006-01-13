Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161284AbWAMI2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161284AbWAMI2u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 03:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161491AbWAMI2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 03:28:50 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:18385 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161284AbWAMI2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 03:28:50 -0500
Subject: Re: [PATCH] [5/6] Handle TIF_RESTORE_SIGMASK for i386
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, drepper@redhat.com,
       dhowells@redhat.com
In-Reply-To: <1137133408.3621.6.camel@pmac.infradead.org>
References: <1136923488.3435.78.camel@localhost.localdomain>
	 <1136924357.3435.107.camel@localhost.localdomain>
	 <20060112195950.60188acf.akpm@osdl.org>
	 <1137126606.3085.44.camel@localhost.localdomain>
	 <20060112205451.392c0c5c.akpm@osdl.org>
	 <20060112221037.5dbc3dd9.akpm@osdl.org>
	 <1137133408.3621.6.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 08:28:57 +0000
Message-Id: <1137140937.2675.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-13 at 06:23 +0000, David Woodhouse wrote:
> I suspect it might be the sigset size. 

I bet this is it, although I haven't yet confirmed the theory....

Sorry, I should have tested this for myself on i386 before forwarding
the patch. Stupid bloody legacy architecture :)

--- linux-2.6.15.ppc/kernel/compat.c~	2006-01-13 04:39:54.000000000 +0000
+++ linux-2.6.15.ppc/kernel/compat.c	2006-01-13 08:23:24.000000000 +0000
@@ -873,7 +873,7 @@ asmlinkage long compat_sys_stime(compat_
 #endif /* __ARCH_WANT_COMPAT_SYS_TIME */
 
 #ifdef __ARCH_WANT_COMPAT_SYS_RT_SIGSUSPEND
-long compat_sys_rt_sigsuspend(compat_sigset_t __user *unewset, compat_size_t sigsetsize)
+asmlinkage long compat_sys_rt_sigsuspend(compat_sigset_t __user *unewset, compat_size_t sigsetsize)
 {
 	sigset_t newset;
 	compat_sigset_t newset32;
--- linux-2.6.15.ppc/kernel/signal.c~	2006-01-13 04:39:54.000000000 +0000
+++ linux-2.6.15.ppc/kernel/signal.c	2006-01-13 08:23:29.000000000 +0000
@@ -2761,7 +2761,7 @@ sys_pause(void)
 #endif
 
 #ifdef __ARCH_WANT_SYS_RT_SIGSUSPEND
-long sys_rt_sigsuspend(sigset_t __user *unewset, size_t sigsetsize)
+asmlinkage long sys_rt_sigsuspend(sigset_t __user *unewset, size_t sigsetsize)
 {
 	sigset_t newset;
 

-- 
dwmw2

