Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278319AbRJMPow>; Sat, 13 Oct 2001 11:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278320AbRJMPom>; Sat, 13 Oct 2001 11:44:42 -0400
Received: from [212.21.93.146] ([212.21.93.146]:42883 "EHLO
	kushida.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S278319AbRJMPo2>; Sat, 13 Oct 2001 11:44:28 -0400
Date: Sat, 13 Oct 2001 17:44:27 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Paul Menage <pmenage@ensim.com>
Cc: Christoph Rohland <cr@sap.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Pollable /proc/<pid>/ - avoid SIGCHLD/poll() races
Message-ID: <20011013174427.D20499@kushida.jlokier.co.uk>
In-Reply-To: <m34rpfpyqs.fsf@linux.local> <E15p4qy-0000yf-00@pmenage-dt.ensim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15p4qy-0000yf-00@pmenage-dt.ensim.com>; from pmenage@ensim.com on Thu, Oct 04, 2001 at 02:31:40AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Menage wrote:
> >or use sigsetjmp/siglongjmp
> 
> Yes, that would probably solve the situation in question, provided that
> siglongjmp() is portably safe.

siglongjmp() or longjmp() should be safe on all unix systems, though not
others.

You have to be careful: if you receive a SIGCHLD _while_ handling a
SIGINT (or another signal), you must not siglongjmp() out of the inner
handler.

The simplest way get this right is to make sure that the other signal
handlers mask out SIGCHLD while they are running.  You will need to use
sigaction() for this, and that isn't as portable as siglongjmp().

> (A comment on LKML in the past suggested that it's not safe on
> cygwin, for example.)

I wrote that comment.  At least two versions of cygwin crash when you
call siglongjmp() from a signal handler inside select().  Unfortunately
I did not distill a reliable test for this, to check later versions of
cygwin.

However, given that that _should_ work, I don't think you can rely
write() working under these conditions in cygwin either.  So don't
choose a pipe just for this reason.

> >Both would be portable and not special to child handling.
> 
> One advantage of the pollable /proc/<pid>, (when combined with
> do_notify_parent() waking tsk->exit_chldwait) is that any process can
> check for the exit of any other process (not just direct children) in a
> select()/poll() call. 

Well, pollable /proc/<pid> is not portable at all.  If you are going to
use something linux specific, you may as well use pselect() which is
portable to a number of modern unix systems.

enjoy,
-- Jamie
