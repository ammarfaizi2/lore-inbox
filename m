Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261902AbUJ1RMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbUJ1RMX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 13:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbUJ1RIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 13:08:00 -0400
Received: from THUNK.ORG ([69.25.196.29]:4809 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261824AbUJ1RGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 13:06:45 -0400
Date: Thu, 28 Oct 2004 13:06:42 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Timo Sirainen <tss@iki.fi>, linux-kernel@vger.kernel.org
Subject: Re: readdir loses renamed files
Message-ID: <20041028170642.GA8220@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, Timo Sirainen <tss@iki.fi>,
	linux-kernel@vger.kernel.org
References: <431547F9-2624-11D9-8AC3-000393CC2E90@iki.fi> <20041025123722.GA5107@thunk.org> <20041028093426.GB15050@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028093426.GB15050@merlin.emma.line.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 11:34:26AM +0200, Matthias Andree wrote:
> Please - is it really necessary that application writers are offended in
> this way? Timo is investing enormous time and effort in writing a *good*
> application, and he's effectively seeking a way to *robustly* deal with
> Maildir format mail storage. Please leave it at "readdir/getdents don't
> work the way you expect and cannot for this and that reason."
> 
> Timo tries to implement a *robust* Maildir reader and has just bumped
> into the flaws of DJB's "no-locking" store.

That's true, I should also have included badly-/stupidly- designed
mailstore architectures in the list of possibilities.  :-)

Stepping back for a moment, do you really need such semantics?  After
all, when you're dealing with Maildir, even if you're not dealing with
rename(), you still have to worry about programs deleting or inserting
(or moving between Mailboxes) messages out from under you while you
are doing the readdir() scan.

Since by definition Maildir is lockless, it is expected that
applications be able to deal with such changes.  If they can't, either
the design of Maildir is busted (and I have my own opinions of DJB's
designs, which aren't worth going into here) or the application is
busted.  Take your pick.

> Just some rough thoughts:
> 
> 1. the number of open file handles (including directories seen as files
>    for a moment at least) is limited per process, and I'd think the
>    number of directories open can be lower

But directory sizes are unlimited --- they could conceivably be
hundreds of megabytes, and so it's not reasonable to require the
kernel to do the snapshot using unpageable kernel memory.

> 2. versioned information might provide what the application wants
>    without locking up the system

Not given the POSIX readdir/opendir interface!

(And if we have the freedom to redesign the readdir POSIX interface,
there are plenty of other changes I'd make along the way.  Nuking
telldir and seekdir would be near the top of the list.  If you want
an example of truly brain-damaged design, just take telldir and
seekdir... please!)

> 3. the application could be offered an interface for atomic directory
>    reads that requires the application to provide sufficient memory in a
>    single contiguous buffer (making it thread-safe in the same go).

Actually, you can do this today, if you use the underlying
sys_getdents64 system call.  But the application would have to
allocate potentially a very large amount of userspace memory.

						- Ted
