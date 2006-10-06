Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbWJFOXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbWJFOXb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 10:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWJFOXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 10:23:31 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:51939 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932362AbWJFOXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 10:23:30 -0400
Date: Fri, 6 Oct 2006 10:23:19 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: "Frank Ch. Eigler" <fche@redhat.com>
cc: Vara Prasad <prasadav@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Ingo Molnar <mingo@elte.hu>, Paul Mundt <lethal@linux-sh.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       systemtap <systemtap@sourceware.org>
Subject: Re: tracepoint maintainance models
In-Reply-To: <20061006130156.GA3566@redhat.com>
Message-ID: <Pine.LNX.4.58.0610061015140.13066@gandalf.stny.rr.com>
References: <20060918150231.GA8197@elte.hu> <1158594491.6069.125.camel@localhost.localdomain>
 <20060918152230.GA12631@elte.hu> <1158596341.6069.130.camel@localhost.localdomain>
 <20060918161526.GL3951@redhat.com> <1158598927.6069.141.camel@localhost.localdomain>
 <450EEF2E.3090302@us.ibm.com> <1158608981.6069.167.camel@localhost.localdomain>
 <450F0180.1040606@us.ibm.com> <1160112791.30146.12.camel@localhost.localdomain>
 <20061006130156.GA3566@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Oct 2006, Frank Ch. Eigler wrote:

> Hi -
>
> On Fri, Oct 06, 2006 at 01:33:11AM -0400, Steven Rostedt wrote:
> > Coming into this really late, and I'm still behind in reading this and
> > related threads, but I want to throw this idea out, and it's getting
> > late.
> > [...]
> > #define MARK(label, var)			\
> > 	asm ("debug_" #label ":\n"		\
> > 	     ".section .data\n"			\
> > 	     #label "_" #var ": xor %0,%0\n"	\
> > 	     ".previous" : : "r"(var))
> > [...]
> > $ gcc -O2 -o mark mark.c
> > $ ./mark
> > func y is in reg B at 0x80483ce
> > [...]
>
> Clever.
>
> > Now the question is, isn't MARK() in this code a non intrusive marker?
>
> Not quite.  The assembly code forces gcc to materialize the data that
> it might already have inlined, and to borrow a register for the
> duration.  It's still a neat idea though.

Thanks!

You're right, it is intrusive in a way that it does modify the way gcc can
optimize that section of code.  But what I like about this idea, is that
it allows for us to tell gcc that we want this variable inside a register,
and then gcc can do that for us and still optimize around that. We put no
more constraints on the code, except that we want some value in a
register at some given point of execution.  This should only be done for
local variables that are not easily captured in a probe.

Of course with i386's limit on registers, it can put a little strain if we
want more than one variable. But x86_64 will soon be the norm, and the
added registers should help out a lot.

-- Steve
