Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266871AbUIJHsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266871AbUIJHsq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 03:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266173AbUIJHsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 03:48:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:7814 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266611AbUIJHrr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 03:47:47 -0400
Date: Fri, 10 Sep 2004 00:45:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: "H. J. Lu" <hjl@lucon.org>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Hanging process on SMP machines?
Message-Id: <20040910004549.2df18073.akpm@osdl.org>
In-Reply-To: <20040909201321.GA21492@lucon.org>
References: <20040909201321.GA21492@lucon.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. J. Lu" <hjl@lucon.org> wrote:
>
> I notice that a process may hang on SMP machines at random:
> 
>  http://bugzilla.kernel.org/show_bug.cgi?id=3332
> 
>  I can reliably trigger it within 15 minutes under SMP kernel on P4 HT
>  and 4-way ia64 machines. Has anyone else seen it?

It's easy to reproduce on 2-way x86, however it doesn't look like a kernel
bug.


akpm      2503  0.0  0.2  3892  640 pts/0    S    00:34   0:00  |           \_ make
akpm      2504  0.0  0.0  1368  192 pts/0    S    00:34   0:00  |               \_ time expect test.exp
akpm      2505  0.0  0.5  4776 1276 pts/0    S    00:34   0:00  |                   \_ expect test.exp
akpm      4726  0.0  0.0     0    0 ?        Z    00:35   0:00  |                       \_ [true] <defunct>

process 4726 is sleeping at the end of do_exit():


	schedule();		<<- here
	BUG();
	/* Avoid "noreturn function does return".  */
	for (;;) ;
}

So it has completely exitted and is waiting for someone to reap its exit
code and stack slot via wait4().  So what is its parent up to?


(gdb) thread 69
[Switching to thread 69 (Thread 2505)]#0  0xc01653e9 in do_select (n=5, fds=0xcc8b5fa4, 
    timeout=0xcc8b5fa0) at fs/select.c:257
257                     __timeout = schedule_timeout(__timeout);
(gdb) bt
#0  0xc01653e9 in do_select (n=5, fds=0xcc8b5fa4, timeout=0xcc8b5fa0) at fs/select.c:257
#1  0xc016579c in sys_select (n=5, inp=0x804b444, outp=0x804b4c4, exp=0x804b544, tvp=0xbfffe1d0)
    at fs/select.c:354
#2  0xc0105e39 in sysenter_past_esp () at arch/i386/kernel/semaphore.c:177

The parent is sleeping in select() rather than wait()ing for children.


(gdb) f 0
#0  0xc01653e9 in do_select (n=5, fds=0xcc8b5fa4, timeout=0xcc8b5fa0) at fs/select.c:257
257                     __timeout = schedule_timeout(__timeout);
(gdb) p __timeout
$1 = 3000000

For 3,000 seconds.


I changed your 3000 to 30 and lo, the script hangs for 30 seconds every now
and then, and then resumes.

