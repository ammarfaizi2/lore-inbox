Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264815AbUFLO0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264815AbUFLO0D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 10:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264819AbUFLO0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 10:26:03 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:38863 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S264815AbUFLOZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 10:25:59 -0400
Subject: Re: timer + fpu stuff locks up computer
From: Alexander Nyberg <alexn@telia.com>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       stian@nixia.no
In-Reply-To: <20040612134413.GA3396@sirius.home>
References: <20040612134413.GA3396@sirius.home>
Content-Type: text/plain
Message-Id: <1087050351.707.5.camel@boxen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 12 Jun 2004 16:25:51 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-12 at 15:44, Sergey Vlasov wrote:
> On Fri, 11 Jun 2004 23:50:25 -0400, Rik van Riel wrote:
> 
> > On Fri, 11 Jun 2004, Rik van Riel wrote:
> > 
> >> Reproduced here, on my test system running a 2.6 kernel.
> >> I did get a kernel backtrace over serial console, though ;)
> > 
> > Now I'm not sure if the process is actually stuck in kernel
> > space or if it's looping tightly through both kernel and
> > user space...
> 
> --- linux-2.6.6/include/asm-i386/i387.h.fp-lockup	2004-05-10 06:33:06 +0400
> +++ linux-2.6.6/include/asm-i386/i387.h	2004-06-12 17:25:56 +0400
> @@ -51,7 +51,6 @@
>  #define __clear_fpu( tsk )					\
>  do {								\
>  	if ((tsk)->thread_info->status & TS_USEDFPU) {		\
> -		asm volatile("fwait");				\
>  		(tsk)->thread_info->status &= ~TS_USEDFPU;	\
>  		stts();						\
>  	}							\

Sorry for this extremely informative mail but, doesn't work.

Looks like the problem is only being delayed:

Pid: 431, comm:                 sshd
EIP: 0060:[<c0119f98>] CPU: 0
EIP is at force_sig_info+0x48/0x80
 EFLAGS: 00000286    Not tainted  (2.6.7-rc3-mm1)
EAX: 00000000 EBX: de96d7d0 ECX: 00000007 EDX: 00000008
ESI: 00000008 EDI: 00000286 EBP: de9e3dd4 DS: 007b ES: 007b
CR0: 8005003b CR2: 080b2664 CR3: 1f48f000 CR4: 000002d0
 [<c0105560>] do_coprocessor_error+0x0/0x20
 [<c01054f2>] math_error+0xb2/0x120
 [<c01d2bb8>] fast_clear_page+0x8/0x50
 [<c0105de3>] do_IRQ+0x113/0x150
 [<c0105de3>] do_IRQ+0x113/0x150
 [<c0105de3>] do_IRQ+0x113/0x150
 [<c0104398>] common_interrupt+0x18/0x20
 [<c0109ed5>] restore_fpu+0x15/0x20
 [<c0104435>] error_code+0x2d/0x38
 [<c01d2bb8>] fast_clear_page+0x8/0x50
 [<c013286e>] do_anonymous_page+0x8e/0x140
 [<c0132979>] do_no_page+0x59/0x290
 [<c0132d5e>] handle_mm_fault+0xbe/0x120
 [<c010e5b4>] do_page_fault+0x134/0x506
 [<c010fd90>] default_wake_function+0x0/0x10
 [<c01f4f6a>] tty_read+0xaa/0xf0
 [<c014dd3d>] sys_select+0x22d/0x490
 [<c013e583>] vfs_read+0xc3/0x100
 [<c011b0ac>] sigprocmask+0x4c/0xb0
 [<c010e480>] do_page_fault+0x0/0x506
 [<c0104435>] error_code+0x2d/0x38

