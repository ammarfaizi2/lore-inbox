Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269590AbUI3WZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269590AbUI3WZn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 18:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269558AbUI3WZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 18:25:43 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:19719 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S269590AbUI3WZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 18:25:20 -0400
Message-ID: <415C87CF.1040908@superbug.co.uk>
Date: Thu, 30 Sep 2004 23:25:19 +0100
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: BUG in spinlock debug code. was: Re: 2.6.9-rc2 oops due to UDP packet.
References: <41576E68.2010200@superbug.co.uk>
In-Reply-To: <41576E68.2010200@superbug.co.uk>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This problem has been tracked to a bug in the spinlock debugging code. 
With spinlock debugging switched off, everything is fine.
I don't have time to fix it right now, but it would take about 5 seconds 
to fix.
Summary: #define SPINLOCK_MAGIC is given various different values 
throughout the kernel, so the debug if (lock->magic != SPINLOCK_MAGIC) 
tends to fail.
To Fix: define SPINLOCK_MAGIC in one place in the kernel, so all paths 
of the code use the same value.

Output from "grep -ri SPINLOCK_MAGIC *"
include/asm/spinlock.h:#define SPINLOCK_MAGIC   0xdead4ead
include/linux/spinlock.h:#define SPINLOCK_MAGIC 0x1D244B3C
include/asm-i386/spinlock.h:#define SPINLOCK_MAGIC      0xdead4ead
include/asm-parisc/spinlock.h:#define SPINLOCK_MAGIC    0x1D244B3C

James


James Courtier-Dutton wrote:
> I attach an oops that causes my SMP Pentium 4 system to hang, requiring 
> me to press the reset button.
> 
> It seems to be due to an error in the processing of a UDP packet.
> It happens quite rarely, about once every few days, but it is certainly 
> annoying.
> 
> Could anyone help me track this bug down?
> 
> James
> 
> 
> ------------------------------------------------------------------------
> 
> new login: ------------[ cut here ]------------
> kernel BUG at include/asm/spinlock.h:90!
> invalid operand: 0000 [#1]
> PREEMPT SMP DEBUG_PAGEALLOC
> Modules linked in: md5 ipv6 ide_cd cdrom lp parport usbhid uhci_hcd usbcore e1000
> CPU:    1
> EIP:    0060:[<c02fecc0>]    Not tainted VLI
> EFLAGS: 00010202   (2.6.9-rc2) 
> EIP is at _spin_unlock+0x36/0x46
> eax: 00000001   ebx: f1e8ef00   ecx: 00000002   edx: f33aa93c
> esi: f33aa800   edi: f33aa93c   ebp: c213bbb4   esp: c213bbb4
> ds: 007b   es: 007b   ss: 0068
> Process hotwayd (pid: 13950, threadinfo=c213a000 task=db25caa0)
> Stack: c213bbd4 c0298e81 f33aa800 f1e8ef00 00000000 f6dc10e4 f6dc10fc d12aae08 
>        c213bc0c c02aea71 c3951f54 d12aae24 c213bc10 c02afe71 d12aae44 c213bea0 
>        00000000 f6dc10d0 c3951f54 c213bc48 c3951f54 d34daf04 c213bc58 c02b0cfe 
> Call Trace:
>  [<c01050e7>] show_stack+0x80/0x96
>  [<c010527a>] show_registers+0x15d/0x1d6
>  [<c01054a8>] die+0x112/0x19d
>  [<c01059a9>] do_invalid_op+0xee/0x10a
>  [<c0104d01>] error_code+0x2d/0x38
>  [<c0298e81>] dev_queue_xmit+0x23b/0x2d4
>  [<c02aea71>] ip_finish_output+0xda/0x24c
>  [<c02b0cfe>] ip_push_pending_frames+0x266/0x49a
>  [<c02ce758>] udp_push_pending_frames+0x12f/0x25a
>  [<c02cef22>] udp_sendmsg+0x661/0x7a9
>  [<c028f99f>] sock_sendmsg+0xbf/0xe3
>  [<c0290f7c>] sys_sendto+0xe8/0x107
>  [<c0290fd1>] sys_send+0x36/0x38
>  [<c029184d>] sys_socketcall+0x141/0x234
>  [<c0104277>] syscall_call+0x7/0xb
> Code: e5 75 1e 0f b6 02 84 c0 7f 21 c6 02 01 b8 00 e0 ff ff 21 e0 83 68 14 01 8b 40 08 a8 08 75 16 5d c3 0f 0b 59 00 80 05 31 c0 eb d8 <0f> 0b 5a 00 80 05 31 c0 eb d5 5d e9 c6 f5 ff ff 55 89 e5 f0 81 
>  <0>Kernel panic - not syncing: Fatal exception in interrupt
>  

