Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287447AbRL3QGx>; Sun, 30 Dec 2001 11:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287446AbRL3QGn>; Sun, 30 Dec 2001 11:06:43 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:50953 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S287443AbRL3QGX>; Sun, 30 Dec 2001 11:06:23 -0500
Date: Sun, 30 Dec 2001 11:06:23 -0500
From: Lennert Buytenhek <buytenh@gnu.org>
To: linux-kernel@vger.kernel.org
Cc: jdike@karaya.com
Subject: [PATCH][RFC] global errno considered harmful
Message-ID: <20011230110623.A17083@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Is there any particular reason we need a global errno in the kernel
at all? (which, by the way, doesn't seem to be subject to any kind of
locking)  It makes life for User Mode Linux somewhat more complicated than
it could be, and it generally just seems a bad idea.  Half a dozen places
in the kernel call syscalls from kernel space (the asm/unistd.h
__KERNEL_SYSCALLS__ stubs), but it sounds way better to change that limited
number to check the syscall return code instead of errno.

It appears that only one syscall stub caller checks syscall return value
anyway (exec_usermodehelper in kernel/kmod.c), so removing errno is quite
painless.  Referenced patch deletes all mention of a global errno from the
kernel, and fixes up callers where necessary.  I had to change definition
of _syscallX in various asm/unistd.h's not to use errno which might break
some userland, but userland shouldn't be touching these anyway.

Only tested on i386.  Feedback appreciated, particularly experiences on
non-i386.

	http://www.math.leidenuniv.nl/~buytenh/errno_ectomy-1.diff   (33kb)


cheers,
Lennert
