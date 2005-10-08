Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932614AbVJHDEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614AbVJHDEp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 23:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932672AbVJHDEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 23:04:45 -0400
Received: from xenotime.net ([66.160.160.81]:45015 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932614AbVJHDEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 23:04:45 -0400
Date: Fri, 7 Oct 2005 20:04:43 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Joshua Hudson <joshudson@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to interpret a kernel bug output from dmesg?
Message-Id: <20051007200443.691b7392.rdunlap@xenotime.net>
In-Reply-To: <bda6d13a0510071753h80ed0fdoa35f3b39a3079ef1@mail.gmail.com>
References: <bda6d13a0510071753h80ed0fdoa35f3b39a3079ef1@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Oct 2005 17:53:34 -0700 Joshua Hudson wrote:

> I got this. Probably I caused it. Kernel is 2.6.13, slightly modified
> (weird new psuedo filesystem).
> Problem is I don't know how to read it.  I wouldn't recommend looking
> for it yourself: I doubt
> you will find anything.
> Yes, I compiled with DEBUG_DCACHE (or something similar, uncommented the
> debug define at the top of dcache.c). I ran dmesg -c just before the ls that
> crashed, and dmesg right afterwards. Nothing else present.

Begin by looking at Documentation/oops-tracing.txt in the kernel tree.

> ------------[ cut here ]------------
> kernel BUG at include/linux/dcache.h:294!
* Kernel did a BUG_ON() at that spot. ~~~~~

> invalid operand: 0000 [#1]
* That's what BUG_ON() causes.

> PREEMPT
* A few of the kernel config options are listed here...

> Modules linked in:
* You have no loadable modules loaded (or you edited this part :).

> CPU:    0
* processor ID

> EIP:    0060:[<c0160723>]    Not tainted VLI
* instruction pointer (selector:offset)  + kernel is not tainted and
  instructions use Variable Length Instructions.

> EFLAGS: 00010246   (2.6.13c1)
* processor eflags register + kernel version

> EIP is at __link_path_walk+0xd03/0xe60
* Code that called the inline dget() that did the BUG_ON() is here.

> eax: 00000000   ebx: ce054014   ecx: 00000001   edx: cdd392fc
> esi: ce1b7000   edi: ce1ffecc   ebp: ce1b7f10   esp: ce1b7e24
* processor "general purpose" registers

> ds: 007b   es: 007b   ss: 0068
* processor selector registers

> Process ls (pid: 258, threadinfo=ce1b7000 task=ce2eaae0)
* current process

> Stack: 00000001 ce1b7e50 ce1b7e48 cdd392fc ce1b7e5c ce1b7e54 c02ac704 00000000
>        00000000 cfee48c0 ce1ffecc 00017c88 00000002 ce054012 c0169a73 ce1b7f10
>        ce1b7f50 ce1b7ebc ce1b7e7c c01608c7 ce00b294 ce054000 ce00b294 cfee48c0
* raw kernel stack at time of trap

> Call Trace:
>  [<c0169a73>] dput+0x33/0x280
>  [<c01608c7>] link_path_walk+0x47/0xe0
>  [<c0160c1c>] path_lookup+0x8c/0x160
>  [<c0160eb3>] __user_walk+0x33/0x60
>  [<c015ae9c>] vfs_lstat+0x1c/0x60
>  [<c015b5cb>] sys_lstat64+0x1b/0x40
>  [<c016416d>] sys_fcntl+0x2d/0x60
>  [<c0102ab5>] syscall_call+0x7/0xb
* call stack at time of trap (this is just a lookup of raw stack addresses
  into kernel symbols)

> Code: 2a ff 02 89 55 00 b8 01 00 00 00 e8 78 de fa ff 8b 46 08 a8 08
> 75 0d 89 3c 24 e8 29 93 00 00 e9 75 ff ff ff e8 8f 22 11 00 eb ec <0f>
> 0b 26 01 8e e6 27 c0 eb cc e8 7e 22 11 00 e9 97 fe ff ff 8b
* Next instructions that would be executed (i.e., where EIP points to).

>  <6>note: ls[258] exited with preempt_count 1
* This is usually not good.  The preempt logic should balance
number of entries/exits but something has mucked it up.

---
~Randy
