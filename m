Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263463AbTDSUum (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 16:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263464AbTDSUum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 16:50:42 -0400
Received: from [12.47.58.203] ([12.47.58.203]:57042 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263463AbTDSUuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 16:50:40 -0400
Date: Sat, 19 Apr 2003 14:02:42 -0700
From: Andrew Morton <akpm@digeo.com>
To: Arador <diegocg@teleline.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.67-mm4
Message-Id: <20030419140242.350dd5bf.akpm@digeo.com>
In-Reply-To: <20030419202802.15d79547.diegocg@teleline.es>
References: <20030418014536.79d16076.akpm@digeo.com>
	<20030419202802.15d79547.diegocg@teleline.es>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Apr 2003 21:02:33.0571 (UTC) FILETIME=[FF6DDB30:01C306B6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arador <diegocg@teleline.es> wrote:
>
> On Fri, 18 Apr 2003 01:45:36 -0700
> Andrew Morton <akpm@digeo.com> wrote:
> 
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.67/2.5.67-mm4/
> 
> 
> I got this oops while loading xchat2:
> Unable to handle kernel paging request at virtual address 6b6b6bf7
>  printing eip:
> c0107643
> *pde = 00000000
> Oops: 0000 [#1]
> CPU:    1
> EIP:    0060:[<c0107643>]    Not tainted VLI
> EFLAGS: 00210202
> EIP is at release_thread+0x13/0x60
> eax: 6b6b6b6b   ebx: ce9a2060   ecx: 00000000   edx: 00200296
> esi: c2a90000   edi: ce9a265c   ebp: c2a91efc   esp: c2a91ee8
> ds: 007b   es: 007b   ss: 0068
> Process xchat (pid: 1389, threadinfo=c2a90000 task=ca36b310)
> Stack: cffe77e8 c03573a0 ce9a2060 c2a90000 ce9a2060 c2a91f1c c012400a ce9a2060 
>        00000000 c68a7df4 ce9a2060 00000586 bfffdc14 c2a91f48 c0125fe0 ce9a2060 
>        fffffe00 ca36b310 00000000 c03571c0 c2a9007b ce9a2104 ce9a2060 ca36b310 
> Call Trace:
>  [<c012400a>] release_task+0x1ba/0x270
>  [<c0125fe0>] wait_task_zombie+0x170/0x1d0
>  [<c01264f7>] sys_wait4+0x267/0x2b0
>  [<c0131011>] sys_rt_sigaction+0xd1/0x100
>  [<c011d590>] default_wake_function+0x0/0x20
>  [<c011d590>] default_wake_function+0x0/0x20
>  [<c0109a5f>] syscall_call+0x7/0xb

OK, we died in release_thread:

266                     if (dead_task->mm->context.size) {

the `mm' has been returned to slab.

Something is wrong with the task_struct refcounting, there is
no doubt about that.  Several people have reported instances where
the slab use-after-free detector has detected task_struct.usage
being decremented against a freed task_struct.   Probably this
is the same bug, detected by other means.

It has been seen on uniprocessor too.  We don't know what is causing it.
