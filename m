Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267001AbSLQTTm>; Tue, 17 Dec 2002 14:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266998AbSLQTTm>; Tue, 17 Dec 2002 14:19:42 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10758 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266993AbSLQTTi>; Tue, 17 Dec 2002 14:19:38 -0500
Date: Tue, 17 Dec 2002 11:28:09 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ulrich Drepper <drepper@redhat.com>
cc: Matti Aarnio <matti.aarnio@zmailer.org>, Hugh Dickins <hugh@veritas.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       <linux-kernel@vger.kernel.org>, <hpa@transmeta.com>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <Pine.LNX.4.44.0212171050470.1095-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0212171115450.1095-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Dec 2002, Linus Torvalds wrote:
>
> Hmm.. Which system calls have all six parameters? I'll have to see if I
> can find any way to make those use the new interface too.

The only ones I found from a quick grep are
 - sys_recvfrom
 - sys_sendto
 - sys_mmap2()
 - sys_ipc()

and none of them are of a kind where the system call entry itself is the
biggest performance issue (and sys_ipc() is deprecated anyway), so it's
probably acceptable to just use the old interface for them.

One other alternative is to change the calling convention for the
new-style system call, and not have arguments in registers at all. We
could make the interface something like

 - %eax contains system call number
 - %edx contains pointer to argument block
 - call *syscallptr	// trashes all registers

and then the old "compatibility" function would be something like

	movl 0(%edx),%ebx
	movl 4(%edx),%ecx
	movl 12(%edx),%esi
	movl 16(%edx),%edi
	movl 20(%edx),%ebp
	movl 8(%edx),%edx
	int $0x80
	ret

while the "sysenter" interface would do the loads from kernel space.

That would make some things easier, but the problem with this approach is
that if you have a single-argument system call, and you just pass in the
stack pointer offset in %edx directly, then the system call stubs will
always load 6 arguments, and if we're just at the end of the stack it
won't actually _work_. So part of the calling convention would have to be
the guarantee that there is stack-space available (should always be true
in practice, of course).

			Linus

