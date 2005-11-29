Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbVK2FSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbVK2FSV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 00:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbVK2FSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 00:18:21 -0500
Received: from mail-gw1.turkuamk.fi ([195.148.208.125]:2756 "EHLO
	mail-gw1.turkuamk.fi") by vger.kernel.org with ESMTP
	id S1750778AbVK2FSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 00:18:20 -0500
Message-ID: <438BE48B.9060908@kolumbus.fi>
Date: Tue, 29 Nov 2005 07:18:03 +0200
From: =?ISO-8859-15?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, drepper@redhat.com, linuxppc-dev@ozlabs.org,
       akpm@osdl.org
Subject: Re: [PATCH] 3/3 Generic sys_rt_sigsuspend
References: <1133225007.31573.86.camel@baythorne.infradead.org> <1133225852.31573.115.camel@baythorne.infradead.org>
In-Reply-To: <1133225852.31573.115.camel@baythorne.infradead.org>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release
 6.5.4FP1|June 19, 2005) at 29.11.2005 07:18:08,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP1|June
 19, 2005) at 29.11.2005 07:18:11,
	Serialize complete at 29.11.2005 07:18:11
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:

>The TIF_RESTORE_SIGMASK flag allows us to have a generic implementation
>of sys_rt_sigsuspend() instead of duplicating it for each architecture.
>This provides such an implementation and makes arch/powerpc use it.
>
>It also tidies up the ppc32 sys_sigsuspend() to use TIF_RESTORE_SIGMASK.
>
>Signed-off-by: David Woodhouse <dwmw2@infradead.org>
>  
>
> 
>+#ifdef __ARCH_WANT_SYS_RT_SIGSUSPEND
>+long sys_rt_sigsuspend(sigset_t __user *unewset, size_t sigsetsize)
>+{
>+	sigset_t saveset, newset;
>+
>+	/* XXX: Don't preclude handling different sized sigset_t's.  */
>+	if (sigsetsize != sizeof(sigset_t))
>+		return -EINVAL;
>+
>+	if (copy_from_user(&newset, unewset, sizeof(newset)))
>+		return -EFAULT;
>+	sigdelsetmask(&newset, sigmask(SIGKILL)|sigmask(SIGSTOP));
>+
>+	spin_lock_irq(&current->sighand->siglock);
>+	saveset = current->blocked;
>+	current->blocked = newset;
>+	recalc_sigpending();
>+	spin_unlock_irq(&current->sighand->siglock);
>+
>+	current->state = TASK_INTERRUPTIBLE;
>+	schedule();
>+	set_thread_flag(TIF_RESTORE_SIGMASK);
>+	return -ERESTARTNOHAND;
>+}
>+#endif /* __ARCH_WANT_SYS_RT_SIGSUSPEND */
>+
>  
>
You are not setting saved_sigmask here. And shouldn't it return -EINTR?

Thanks,
Mika

