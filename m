Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266091AbUAQSOp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 13:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266093AbUAQSOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 13:14:45 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:41878 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S266091AbUAQSOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 13:14:43 -0500
Date: Sat, 17 Jan 2004 18:14:39 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Thomas Molina <tmolina@cablespeed.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.1-mm4
In-Reply-To: <Pine.LNX.4.58.0401170708280.14572@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0401171805120.10403-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jan 2004, Thomas Molina wrote:

> I issued a reboot command under -mm4 and received the following oops some 
> time after the "Sending all processes the TERM signal" message.  This 
> message did not make it into syslog.  Following this oops are one 
> "sleeping function called from invalid context at 
> include/linux/rwsem.h:43" and one "bad: scheduling while atomic!" message.  
> Then I get the message "no more processes left in this runlevel", after 
> which processing stops.  Nothing further appears to happen, but I can 
> still use <SHIFT><PAGE [UP|DOWN]> to scroll screen.
> 
> I've typed this in by hand so there may be errors.  This machine is a 
> Presario 12XL325 laptop and does not have a serial port to use as a remote 
> console.  This oops is reproducable, but does not happen on every reboot.
> 
> Unable to handle kernel paging request at virtual address c778c950
>  printing eip:
> c0130555
> *pde = 0001a063
> *pte = 0778c000
> Oops: 0000 (#1]
> PREEMPT DEBUG_PAGEALLOC
> CPU:	0
> EIP:	0060:[<c0130555>]    Not tainted VLI
> EFLAGS: 00010086
> EIP is at __tasklet_schedule+0x35/0x50
> eax: c6e9c000   ebx: 00000046   ecx: 00000186   edx: c778c950
> esi: 00000000   edi: c6eb6950   ebp: c6e9de74   esp: c6e9de70
> ds: 007b   es: 007b   ss: 0068
> Process S01reboot (pid: 3322, threadinfo=c6e9c000 task=c6eb6950)
> Stack: 00000000 c6e9dea8 c012267e 00000000 00000000 c2213fc4 c6e9dec0 
> 13aaa68c
>        00895486 3f33cb49 00001640 00000000 c6e9c000 401610c8 c6e9dec0 
> c012212c
>        00000000 00000000 c2117950 c6eb6fe0 c6e9df20 c0128880 00000000 
> 01200011
> Call Trace:
> [<c012267e>] scheduler_tick+0x6e/0x6b0
> [<c012212c>] sched_fork+0xbc/0xe0
> [<c0128880>] copy_process+0x5e0/0xfe0
> [<c01292cd>] do_fork+0x4d/0x1c1
> [<c013bba7>] sigprocmask+0xf7/0x2a0
> [<c017b54a>] generic_file_llseek+0x3a/0xf0
> [<c017bc90>] sys_llseek+0xd0/0x100
> [<c0109cef>] sys_clone+0x3f/0x50
> [<c02ec24a>] sysenter_past_esp+0x43/0x65
> 
> Code: 0a 3c c0 89 10 83 0d 20 0a 3c c0 20 a3 00 0a 3c c0 b8 00 e0 ff ff 21 
> e0 f7 40 14 00 ff ff 00 75 15 8b 15 40 0b 3c c0 85 d2 74 0b <8b> 02 85 c0 
> 75 0a 90 8d 74 26 00 53 9d 5b 5d c3 89 d0 e8 b4 1a
> <6>note: S01reboot[2352] exited with preempt_count 1

I was getting something like that on reboot a few days ago, I think it
was with 2.6.1-mm2.  I had to move on before debugging it fully, but
the impression I got (maybe vile calumny, sue me Rusty) was that the
new kthread_create for 2.6.1-mm's ksoftirqd was leaving it vulnerable
to shutdown kill, whereas other things (RCU in my traces) still needed
it around and assumed its task address still valid.

Hope this helps instead of misleading,
Hugh

