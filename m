Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbWGCKUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbWGCKUM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 06:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWGCKUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 06:20:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5349 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751074AbWGCKUL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 06:20:11 -0400
Date: Mon, 3 Jul 2006 03:19:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: ak@muc.de, drepper@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Support TIF_RESTORE_SIGMASK on x86_64
Message-Id: <20060703031937.274aa506.akpm@osdl.org>
In-Reply-To: <1151919711.3000.82.camel@pmac.infradead.org>
References: <1151919711.3000.82.camel@pmac.infradead.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jul 2006 10:41:51 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

> We need TIF_RESTORE_SIGMASK in order to support ppoll() and pselect()
> system calls. This patch originally came from Andi, and was based
> heavily on David Howells' implementation of same on i386. I fixed a typo
> which was causing do_signal() to use the wrong signal mask.
> 

We struggled with these patches quite a lot when they were in Andi's tree. 
My test box would get stuck during kernel compiles and Andi could never
reproduce it.

<digs back through emails>

x:/home/akpm> ps aux|grep make
akpm      5064  0.0  0.0 40844 1112 pts/0    S+   17:30   0:00 make -j 6 CC= gcc bzImage modules
akpm      5364  0.0  0.0     0    0 pts/0    Z+   17:30   0:00 [make] <defunct>
akpm      5381  0.1  0.0     0    0 pts/0    Z+   17:30   0:00 [make] <defunct>
akpm      5451  0.0  0.0     0    0 pts/0    Z+   17:30   0:00 [make] <defunct>
akpm      5480  0.0  0.0     0    0 pts/0    Z+   17:30   0:00 [make] <defunct>
akpm      6004  0.0  0.0 41496  608 pts/1    S+   17:32   0:00 grep make

make          S ffff81017683fdc8     0  5064   5056  5364               (NOTLB)
ffff81017683fdc8 ffff81017aa7ca98 ffff81017982d4b8 ffff810178b7f810 
       0000000080168760 ffff81000705baa0 ffff81017fc0b480 ffff810179a24790 
       000000037aa7caa0 0000000000008944 
Call Trace: <ffffffff803cd4d4>{_spin_unlock+19} <ffffffff80178feb>{pipe_wait+119}
       <ffffffff8013eff9>{autoremove_wake_function+0} <ffffffff8013eff9>{autoremove_wake_function+0}
       <ffffffff8017934a>{pipe_readv+621} <ffffffff801793f1>{pipe_read+30}
       <ffffffff8016d29b>{vfs_read+175} <ffffffff8016d5fc>{sys_read+71}
       <ffffffff8010aa5e>{system_call+126}
make          X ffff810176389ed8     0  5364   5064          5381       (L-TLB)
ffff810176389ed8 ffff810176389e28 ffffffff803cd4a4 0000000000000000 
       ffff810175596850 ffff810176389ed8 0000000000000003 ffff810175596850 
       0000000300040001 000000000000c50a 
Call Trace: <ffffffff803cd4a4>{_spin_unlock_irqrestore+27}
       <ffffffff803cd4d4>{_spin_unlock+19} <ffffffff8012e5c5>{do_exit+2225}
       <ffffffff8016c00a>{sys_chdir+90} <ffffffff8012e6dc>{sys_exit_group+0}
       <ffffffff8012e6ee>{sys_exit_group+18} <ffffffff8010aa5e>{system_call+126}
make          X ffff810175199ed8     0  5381   5064          5451  5364 (L-TLB)
ffff810175199ed8 ffff810175199e28 ffffffff803cd4a4 0000000000000000 
       ffff810179a930c0 ffff810175199ed8 0000000000000002 ffff810179a930c0 
       0000000200040001 000000000000ca4c 
Call Trace: <ffffffff803cd4a4>{_spin_unlock_irqrestore+27}
       <ffffffff803cd4d4>{_spin_unlock+19} <ffffffff8012e5c5>{do_exit+2225}
       <ffffffff8016c00a>{sys_chdir+90} <ffffffff8012e6dc>{sys_exit_group+0}
       <ffffffff8012e6ee>{sys_exit_group+18} <ffffffff8010aa5e>{system_call+126}
make          X ffff810176249ed8     0  5451   5064          5480  5381 (L-TLB)
ffff810176249ed8 ffff810176249e28 ffffffff803cd4a4 0000000000000000 
       ffff8101790fe7d0 ffff810176249ed8 0000000000000001 ffff8101790fe7d0 
       0000000100040001 000000000000d408 
Call Trace: <ffffffff803cd4a4>{_spin_unlock_irqrestore+27}
       <ffffffff803cd4d4>{_spin_unlock+19} <ffffffff8012e5c5>{do_exit+2225}
       <ffffffff8016c00a>{sys_chdir+90} <ffffffff8012e6dc>{sys_exit_group+0}
       <ffffffff8012e6ee>{sys_exit_group+18} <ffffffff8010aa5e>{system_call+126}
make          X ffff810174f91ed8     0  5480   5064                5451 (L-TLB)
ffff810174f91ed8 ffff810174f91e28 ffffffff803cd4a4 0000000000000046 
       ffff810178b7f810 ffff810174f91ed8 0000000000000001 ffff810178b7f810 
       0000000100040001 00000000000106aa 
Call Trace: <ffffffff803cd4a4>{_spin_unlock_irqrestore+27}
       <ffffffff803cd4d4>{_spin_unlock+19} <ffffffff8012e5c5>{do_exit+2225}
       <ffffffff8016c00a>{sys_chdir+90} <ffffffff8012e6dc>{sys_exit_group+0}
       <ffffffff8012e6ee>{sys_exit_group+18} <ffffffff8010aa5e>{system_call+126}


It seems OK now with these patches.

Could you please describe the signal mask fix?  Is that likely to have
caused the above symptoms?

>  asmlinkage long
> -sys32_sigsuspend(int history0, int history1, old_sigset_t mask,
> -		 struct pt_regs *regs)
> +sys32_sigsuspend(int history0, int history1, old_sigset_t mask)
>  {
> -	sigset_t saveset;
> -
>  	mask &= _BLOCKABLE;
>  	spin_lock_irq(&current->sighand->siglock);
> -	saveset = current->blocked;
> +	current->saved_sigmask = current->blocked;
>  	siginitset(&current->blocked, mask);
>  	recalc_sigpending();
>  	spin_unlock_irq(&current->sighand->siglock);
>  
> -	regs->rax = -EINTR;
> -	while (1) {
> -		current->state = TASK_INTERRUPTIBLE;
> -		schedule();
> -		if (do_signal(regs, &saveset))
> -			return -EINTR;
> -	}
> +	current->state = TASK_INTERRUPTIBLE;
> +	schedule();
> +	set_thread_flag(TIF_RESTORE_SIGMASK);
> +	return -ERESTARTNOHAND;
>  }

Should we be setting TASK_INTERRUPTIBLE before releasing that lock?

