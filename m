Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266407AbTGEQx0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 12:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266410AbTGEQx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 12:53:26 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:23947 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S266407AbTGEQxW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 12:53:22 -0400
Date: Sat, 5 Jul 2003 18:06:32 +0100
From: Jamie Lokier <jamie@shareable.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Linus Torvalds <torvalds@osdl.org>, benh@kernel.crashing.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev@lists.linuxppc.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: [PATCH 2.5.73] Signal stack fixes #1 introduce PF_SS_ACTIVE
Message-ID: <20030705170632.GB27500@mail.jlokier.co.uk>
References: <20030704193848.GG22152@wohnheim.fh-wedel.de> <Pine.LNX.4.44.0307041259050.10035-100000@home.osdl.org> <20030704201840.GH22152@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030704201840.GH22152@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:
> > It is entirely possible that they do not do this out of signal handlers, 
> > since that has its own set of problems anyway, and one of the reasons for 
> > doing co-operative user level threading is to not need locking, and thus 
> > you never want to do any thread switching asynchronously (eg from a signal 
> > context).

longjmp() out of signal handlers has a fine tradition, not just for
threading but also code written for systems where SIGCLD doesn't
interrupt select(), to pick a real example.  Admittedly such code
doesn't have to be written that way on Linux, but it does exist and
has been run on Linux.  I doubt such code ever uses sigaltstack().

About co-operative threading: one of the points is that the locks are
cheaper, and it's possible for a thread to disable/enable pre-emption
very fast, with no system calls or locked memory cycles.  In that
environment, longjmp() or setcontext() out of timer signals makes sense.

Many years ago I looked at a paper about fixups from signal handlers,
an ML run-time environment on SunOS I think, and they decided that
longjmp() from the handler was not a reliable strategy.  What they did
instead was to change the instruction pointer in the sigcontext, and
return from the handler.  This works on Linux too, but there are two
disadvantages: 1. two system calls instead of one (which is an issue
when these are a high rate of SIGSEGVs for memory management); 2. the
code is necessarily architecture specific, whereas longjmp() from
timer signals is relatively portable.

-- Jamie
