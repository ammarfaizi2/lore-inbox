Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbVEEHP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbVEEHP6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 03:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbVEEHP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 03:15:58 -0400
Received: from vaak.stack.nl ([131.155.140.140]:27396 "EHLO mailhost.stack.nl")
	by vger.kernel.org with ESMTP id S261942AbVEEHPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 03:15:49 -0400
Date: Thu, 5 May 2005 09:15:46 +0200 (CEST)
From: Serge van den Boom <svdb@stack.nl>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/$PID/mem rationale 
In-Reply-To: <200505041713.j44HDe9Y016718@turing-police.cc.vt.edu>
Message-ID: <20050504205225.W1443@toad.stack.nl>
References: <20050504170503.L89175@toad.stack.nl>
 <200505041713.j44HDe9Y016718@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 May 2005 Valdis.Kletnieks@vt.edu wrote:
> On Wed, 04 May 2005 17:40:31 +0200, Serge van den Boom said:
> > - You can only read() from this file from a process which is attached to
> >   the file's process through ptrace(). Why this requirement?
> >   The following command line could be rather useful, but the ptrace()
> >   requirement prevents this from working:
> >       dd if=/proc/$SOME_PID/mem bs=1 seek=$ADDRESS
> It's prohibited *because* it could be rather useful - to a hacker.  It's an
> issue of information leakage - there are some corner cases where the
> permissions on /proc/PID/mem would appear to allow a read, but you don't in
> fact want to allow it (for the full list, look at the ptrace() code and the
> tests it makes for things like euid != uid and so on).  There's a bunch of
> race conditions in there too.
Actually, mem_read(), the read handler for the "mem" file, calls
may_ptrace_attach(), which makes exactly the same checks as ptrace_attach().
In fact, mem_read() makes these checks each time it is called, while if
you were to use ptrace() to read data, these checks would be made only
at PTRACE_ATTACH, and not at PTRACE_PEEKDATA.
The only security that mem_read() gets from checking whether the process
is tracing the child seems to be as an indicator that some checks have
been done in the past. But these are exactly the checks that are being done
again right after this tracing check.
I don't see how that's going to affect any race conditions.


> > - You can only read() from the mem file from the process that open()ed it.
> >   Even if the ptrace() requirement were dropped, you wouldn't be able
> >   to do something like the following command because of this:
> >       dd bs=1 seek=$ADDRESS < /proc/$SOME_PID/mem
> Same reasons.  ptrace() is able to make some checks and set some bits that
> read() isn't allowed anywhere near (in particular, ptrace() can *stop* a
> process so it can't race - read() can't do that.)
This question isn't about requiring the child being traced by the reader
or not. I'm asking why the process that opens the "mem" file needs to be
the one that does the reading. There are no special checks being done
when the file is opened.

As for stopping the child process: if that's necessary, then it looks like
there's a race condition present as it is. Because as far as I can tell,
there's nothing preventing a process from sending a SIGCONT to the child
process while the mem_read() is going on.


Please CC me in replies again.

Cheers,

Serge

