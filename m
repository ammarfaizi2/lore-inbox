Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbTEJUkM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 16:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbTEJUkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 16:40:12 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:59264 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S264500AbTEJUkL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 16:40:11 -0400
Date: Sat, 10 May 2003 21:52:51 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 uaccess to fixmap pages
Message-ID: <20030510205251.GA30275@mail.jlokier.co.uk>
References: <20030509124042.GB25569@mail.jlokier.co.uk> <Pine.LNX.4.44.0305090856500.9705-100000@home.transmeta.com> <b9hrhg$5v7$1@cesium.transmeta.com> <20030510153156.GA29271@mail.jlokier.co.uk> <3EBD51C6.8030100@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EBD51C6.8030100@zytor.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> >It doesn't need a PTE.  The vsyscall code could be _copied_ to the end
> >of the page at 0xbffff000, with the stack immediately preceding it.
> >
> 
> You don't really want that, though.  If you're doing gettimeofday() in 
> user space it's critically important that the kernel can modify all 
> these pages at once.

I think gettimeofday() is exceptional, and other system call
accelerators actually want per-task data.  For example sigprocmask()
can be done in user space, but that needs a per-task mask

For gettimeofday(), the kernel can (a) update the word in the mm of
currently running tasks on timer interrupts, (b) update the word at
context switch time, and then only when switching mm.  Ok, I'll admit
that is looking a bit messed up, and possible SMP synchronisation
problems too.

How about this: gettimeofday() in user space simply does rdtsc, and if
the number of clocks since the last jiffy update is above a threshold,
it does a syscall.  If rdtsc is not available, it always does the
syscall.

Per-mm vsyscall data is appropriate for that, and no globally shared
page is required.  (Think of the NUMA! :)

Granted, sharing the vsyscall and stack ptes is not great if the
vsyscall code expands considerably.  As it is now, it's a very small
bit of code which costs nothing to copy.

-- Jamie
