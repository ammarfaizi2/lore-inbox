Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265045AbTLCPwI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 10:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265046AbTLCPwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 10:52:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:5030 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265045AbTLCPwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 10:52:05 -0500
Date: Wed, 3 Dec 2003 07:51:57 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhcs-devel@lists.sourceforge.net, Ingo Molnar <mingo@elte.hu>
Subject: Re: kernel BUG at kernel/exit.c:792!
In-Reply-To: <20031203153858.C14999@in.ibm.com>
Message-ID: <Pine.LNX.4.58.0312030748240.5258@home.osdl.org>
References: <20031203153858.C14999@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Dec 2003, Srivatsa Vaddagiri wrote:
>
> 	I hit a kernel BUG while running some stress tests
> on a SMP machine. Details are below:
>
> Kernel	:  2.6.0-test9-bk23  + CPU Hotplug Patch
> Machine	:  Intel 4-Way SMP box
>
> kernel BUG at kernel/exit.c:792!
> EIP is at next_thread+0x16/0x50
> Call Trace:
>  [<c0180328>] get_tid_list+0x58/0x70
>  [<c0180524>] proc_task_readdir+0xc4/0x17c
>  [<c01658dc>] vfs_readdir+0x5c/0x70
>  [<c0165be0>] filldir64+0x0/0x120
>  [<c0165d64>] sys_getdents64+0x64/0xa3
>  [<c0165be0>] filldir64+0x0/0x120
>  [<c0109291>] sysenter_past_esp+0x52/0x71
>
> I suspect this is because when read_lock call in 'get_tid_list'
> returns, the leader_task had exited already. This
> causes the NULL sighand check to fail in the subsequent call
> to 'next_thread' ?

Yup, looks right.

I think the problem is the BUG() itself, not really the caller. So I'd
prefer the fix for this to be to just entirely remove the debug tests
withing that "#ifdef CONFIG_SMP", rather than hide the threads from /proc
when this happens.

Ingo, comments?

			Linus
