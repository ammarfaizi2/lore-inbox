Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267079AbTBHTWR>; Sat, 8 Feb 2003 14:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267083AbTBHTWR>; Sat, 8 Feb 2003 14:22:17 -0500
Received: from bjl1.jlokier.co.uk ([81.29.64.88]:22225 "EHLO
	bjl1.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S267079AbTBHTWQ>; Sat, 8 Feb 2003 14:22:16 -0500
Date: Sat, 8 Feb 2003 19:31:49 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Andi Kleen <ak@suse.de>
Cc: Pavel Machek <pavel@suse.cz>, Kevin Lawton <kevinlawton2001@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Possible bug in arch/i386/kernel/process.c for reloading of debug registers (DRx)?
Message-ID: <20030208193149.GA9720@bjl1.jlokier.co.uk>
References: <20030203235140.10443.qmail@web80304.mail.yahoo.com.suse.lists.linux.kernel> <p7365s0ri9c.fsf@oldwotan.suse.de> <20030207163301.GH345@elf.ucw.cz> <20030208172204.GA24577@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030208172204.GA24577@wotan.suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> > What if DRx contains sensitive data? ...Its probably pretty
> > unlikely. Still it allows for example easy communication between tasks
> > that should not be able to communicate.
> 
> The user never sees the stale value, it is eaten by the kernel's do_debug
> handler.

DR6 isn't cleared.  Here is a nice security exploit for you:

	- Task A sets DR0 and DR7 to enable a watchpoint (or breakpoint).
	- It also clears DR6.
	- Task A wakes up task B, which has DR7 clear.
	- Task A then communicates with "sshd" or some other sensitive task.

	- Because of lazy DR7 clearing, sshd inherits the watchpoints.
	- If sshd reads the memory address mentioned in DR0, it will
	  call do_debug in the kernel, which clears DR7 and continues.
	- However, DR6 bit B0 is now set.

	- Eventually task B is scheduled.  It inherits the value of DR6
	  from sshd, and therefore knows if sshd read from a particular
	  memory location.

	- Task A and task B cooperate to analyse what values sshd is
	  examining in its lookup tables, and therefore retrieve the
	  server key or something.  (Hand waving at this point).

-- Jamie
