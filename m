Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935959AbWLDLQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935959AbWLDLQG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 06:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935970AbWLDLQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 06:16:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61850 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S935959AbWLDLQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 06:16:02 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061203112706.GA12722@flint.arm.linux.org.uk>
References: <20061203112706.GA12722@flint.arm.linux.org.uk>  <20061201172149.GC3078@ftp.linux.org.uk> <1165084076.24604.56.camel@localhost.localdomain> <20061202184035.GL3078@ftp.linux.org.uk> <200612022243.58348.zippel@linux-m68k.org> <20061202215941.GN3078@ftp.linux.org.uk> <Pine.LNX.4.64.0612022306360.1867@scrub.home> <20061202224018.GO3078@ftp.linux.org.uk> <Pine.LNX.4.64.0612022345520.1867@scrub.home> <20061203102108.GA1724@elf.ucw.cz>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Pavel Machek <pavel@ucw.cz>, Roman Zippel <zippel@linux-m68k.org>,
       Al Viro <viro@ftp.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>,
       Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] timers, pointers to functions and type safety
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 04 Dec 2006 11:14:29 +0000
Message-ID: <26864.1165230869@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> There *are* times when having the additional space for storing a pointer
> is cheaper (in terms of number of bytes) than code to calculate an offset,
> and those who have read the assembly code probably know this all too well.

All it generally takes is two instances of a timer_list struct that use one
common handler function for the removal of the data member from the timer_list
to be a win on pretty much every platform.

Consider: you replace:

	struct timer_list {
		void (*func)(unsigned long data);
		unsigned long data;
	};

	void handler(unsigned long data)
	{
		struct *foo = (struct foo *) data;
		...
	}

with:

	struct timer_list {
		void (*func)(struct timer_list *timer);
		unsigned long data;
	};

	void handler(struct timer_list *timer)
	{
		struct *foo = container_of(timer, struct foo, mytimer);
		...
	}


You are removing 4 or 8 bytes (an unsigned long) from each of two structures
and replacing them with a single ADD/SUB instruction, usually with a small
immediate value - which will be at most 4 bytes on most archs - and in some
cases it'll cost less than that because the compiler can use REG+offset
addressing and so avoid the adjustment entirely.

Another way to look at it is that timers aren't generally called all that
often, but that a fair number of structures in the kernel contain timers -
though maybe second or third hand.  You can shrink all of these by one word
per timer, and that makes an immediate effect.


Furthermore, I have patches to shrink work_struct by (a) removing the timer
where it's not needed, (b) folding the single flag bit into one of the
pointers, and (c) dropping the data member in favour of using container_of()
in the handler.

In almost every case where a work_struct is used, the data argument is the
address of the structure containing the work_struct, so (c) gains.

The three reductions reduce the size of work_struct by two-thirds.  The new
delayed_struct is only a reduction of one-sixth as it still carries a timer.
However, if that timer can be shrunk by one-sixth by removing that data
argument, then the delayed_struct can exhibit a one-quarter reduction instead.

David
