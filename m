Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262868AbVEHOMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262868AbVEHOMk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 10:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbVEHOMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 10:12:39 -0400
Received: from one.firstfloor.org ([213.235.205.2]:19945 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262868AbVEHOMh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 10:12:37 -0400
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com
Subject: Re: 2.6.11.8 + UML/x86_64 (2.6.12-rc3+) = oops
References: <20050504191828.620C812EE7@sc8-sf-spam2.sourceforge.net>
	<1115248927.12088.52.camel@cobra> <1115392141.12197.3.camel@cobra>
	<1115483506.12131.33.camel@cobra>
From: Andi Kleen <ak@muc.de>
Date: Sun, 08 May 2005 16:12:35 +0200
In-Reply-To: <1115483506.12131.33.camel@cobra> (Antoine Martin's message of
 "Sat, 07 May 2005 17:31:46 +0100")
Message-ID: <m1ekchvmb0.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antoine Martin <antoine@nagafix.co.uk> writes:
>
> general protection fault: 0000 [1]
> CPU 0
> Pid: 26926, comm: kernel-4 Not tainted 2.6.11.8
> RIP: 0010:[<ffffffff8010ca47>] <ffffffff8010ca47>{__switch_to+311}
> RSP: 0018:ffff8100a7635d48  EFLAGS: 00010016
> RAX: 0000c8e816000002 RBX: ffff8100b895f320 RCX: 00000000c0000102
> RDX: 000000000000c8e8 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffff810090db3a00 R09: 0000000000006933
> R10: 0000000000000000 R11: 0000000000000202 R12: ffff8100a827b890
> R13: ffff8100b895f010 R14: ffff8100a827b580 R15: ffff8100a827b7f8
> FS:  000000006025212c(0000) GS:ffffffff80785a00(0000)
> knlGS:0000000000000d7e
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: 000000006880d010 CR3: 00000000a2321000 CR4: 00000000000006e0
> Process kernel-4 (pid: 26926, threadinfo ffff810060884000, task
> ffff8100a827b580)
> Stack: ffff8100dc37e180 ffff8100b895f010 ffffffff806b6d50
> ffff8100b895f010
>        000003595b049ed6 ffffffff804f4de4 ffff8100a7635de8
> 0000000000000086
>        0000007500000020 ffff8100b895f010
> Call Trace:<ffffffff804f4de4>{thread_return+0}
> <ffffffff8013cb08>{ptrace_stop+280}
>        <ffffffff8013cde6>{get_signal_to_deliver+358}
> <ffffffff8010d4e3>{do_signal+163}
>        <ffffffff8010e905>{error_exit+0}
> <ffffffff8010de67>{sys_rt_sigreturn+535}
>        <ffffffff8010dee9>{sys_rt_sigreturn+665}
> <ffffffff8010e2b6>{int_signal+18}
>
>
> Code: 0f 30 66 41 89 6c 24 2e 65 48 8b 04 25 20 00 00 00 49 89 44

That is a wrmsr to 0x00000000c0000102 (KERNEL_GS_BASE), the code 
is trying to write 0x0000c8e816000002 into it. That is a non canonical
address, which causes the GPF.

The strange thing is that the kernel should have rejected it in
the first place. The code to allow user space to set kernel gs 
checks for the address being > TASK_SIZE and TASK_SIZE is 0x800000000000.
It should have rejected it in the first place.

Are you sure you did not apply any strange UML related patches
to the host kernel? Maybe those are buggy.

-Andi

