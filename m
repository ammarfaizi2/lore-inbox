Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263043AbREWKu4>; Wed, 23 May 2001 06:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263044AbREWKuq>; Wed, 23 May 2001 06:50:46 -0400
Received: from t2.redhat.com ([199.183.24.243]:22777 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S263043AbREWKud>; Wed, 23 May 2001 06:50:33 -0400
To: Blesson Paul <blessonpaul@usa.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Re: __asm__ ] 
In-Reply-To: Your message of "23 May 2001 03:00:46 MDT."
             <20010523090046.13756.qmail@nw177.netaddress.usa.net> 
Date: Wed, 23 May 2001 11:50:30 +0100
Message-ID: <20987.990615030@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay,

"current" is a macro on i386 that expands to "get_current()". This gets the
task_struct for the task currently running on the CPU executing the code.

It does this by masking out the bottom bits of its kernel stack pointer.

For example, assuming that some running process has the following task record
stored in an 8KB-aligned 8KB block.

	0xD520BFFF	+---------------+
			|		|
			| kernel stack  |
			|		|
	0xD520B498	+---- TOS ------+  <-- stack pointer: %esp
			|		|
			| empty space	|
			|		|
			+---------------+
			|		|
			| task_struct	|
			|		|
	0xD520A000	+---------------+  <-- get_current()

get_current() can work out where the base of this block is because the kernel
(1) stack pointer is always within it, (2) it's aligned in memory with respect
to its size:

	get_current() { return %esp       & ~8191; }
	get_current() { return 0xD520B498 & 0xFFFFE000; }
	get_current() = 0xD520A000

So "current->fs" is a structure that holds the current task's idea of its root
filesystem (chroot), current working directory (chdir) and current umask.

And so "current->fs->root" is the task's filesystem root dentry.

David
