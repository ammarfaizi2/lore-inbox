Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267220AbUBMVNr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 16:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267221AbUBMVNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 16:13:47 -0500
Received: from [63.107.13.101] ([63.107.13.101]:642 "EHLO mail.metavize.com")
	by vger.kernel.org with ESMTP id S267220AbUBMVNf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 16:13:35 -0500
Message-ID: <402D3DFF.4040609@metavize.com>
Date: Fri, 13 Feb 2004 13:13:35 -0800
From: Dirk Morris <dmorris@metavize.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.6.2] Badness in futex_wait revisited 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In reference to this previous post:
http://www.ussg.iu.edu/hypermail/linux/kernel/0401.1/1966.html

I also get:
Feb 13 11:43:52 timmy kernel: Call Trace:
Feb 13 11:43:52 timmy kernel:  [<c01387e1>] futex_wait+0x191/0x1a0
Feb 13 11:43:52 timmy kernel:  [<c011e9e0>] default_wake_function+0x0/0x20
Feb 13 11:43:52 timmy kernel:  [<c011e9e0>] default_wake_function+0x0/0x20
Feb 13 11:43:52 timmy kernel:  [<c0138abb>] do_futex+0x6b/0x80
Feb 13 11:43:52 timmy kernel:  [<c0138be6>] sys_futex+0x116/0x130
Feb 13 11:43:52 timmy kernel:  [<c010959f>] syscall_call+0x7/0xb

I get this in 2.6.1 and 2.6.2.
In userland a call to sem_wait returns with -1, and errno = -EINTR

I have been unable to write a simple test case that shows this behavior, 
but I
can replicate it consistently in a fairly complicated manner.

Interestingly, I can *not* get this to happen in debian stable:
~ # dpkg -l | grep ' libc6 | gcc '
ii  gcc            2.95.4-14      The GNU C compiler.
ii  libc6          2.2.5-11.5     GNU C Library: Shared libraries and 
Timezone

But it happens everytime in debian testing (same kernel, same machine):
~ # dpkg -l | grep ' libc6 | gcc '
ii  gcc            3.3.2-2        The GNU C compiler
ii  libc6          2.3.2.ds1-11   GNU C Library: Shared libraries and 
Timezone

I have tried this on two machines (both athlons), both show the same 
behavior.

I also tried to apply the patch previously posted by Andrew to 2.6.2,
and it gives me:

Feb 13 10:00:29 timmy kernel: Badness in try_to_wake_up at 
kernel/sched.c:662
Feb 13 10:00:29 timmy kernel: Call Trace:
Feb 13 10:00:29 timmy kernel:  [<c011d3d8>] try_to_wake_up+0x298/0x2a0
Feb 13 10:00:29 timmy kernel:  [<c011ed4a>] __wake_up_common+0x3a/0x60
Feb 13 10:00:29 timmy kernel:  [<c011edaf>] __wake_up+0x3f/0x70
Feb 13 10:00:29 timmy kernel:  [<c0138fb0>] wake_futex+0x30/0x60
Feb 13 10:00:29 timmy kernel:  [<c01390d3>] futex_wake+0xf3/0x110
Feb 13 10:00:29 timmy kernel:  [<c012d040>] do_timer+0xc0/0xd0
Feb 13 10:00:29 timmy kernel:  [<c013995e>] do_futex+0x7e/0x80
Feb 13 10:00:29 timmy kernel:  [<c0139a84>] sys_futex+0x124/0x140
Feb 13 10:00:29 timmy kernel:  [<c0127767>] sys_gettimeofday+0x67/0xe0
Feb 13 10:00:29 timmy kernel:  [<c010962b>] syscall_call+0x7/0xb
Feb 13 10:00:29 timmy kernel:

The patch didnt cleanly fit 2.6.2, so I might have applied it incorrectly.

Please let me know if I can give anymore information, or try another patch.
Thanks,

-Dirk Morris


