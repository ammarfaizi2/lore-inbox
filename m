Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbTJTT1G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 15:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbTJTT1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 15:27:06 -0400
Received: from mail002.syd.optusnet.com.au ([211.29.132.32]:23700 "EHLO
	mail002.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262694AbTJTT1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 15:27:01 -0400
Subject: Re: K 2.6 test6 strange signal behaviour
From: Ken Foskey <foskey@optushome.com.au>
To: root@chaos.analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0310200938260.13239@chaos>
References: <1066654886.5930.57.camel@gandalf.foskey.org>
	 <Pine.LNX.4.53.0310200938260.13239@chaos>
Content-Type: text/plain
Message-Id: <1066677998.8832.98.camel@gandalf.foskey.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 21 Oct 2003 05:26:38 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-10-20 at 23:48, Richard B. Johnson wrote:
> On Mon, 20 Oct 2003, Ken Foskey wrote:
> 
> >
> > I have a problem with signals.
> >
> > I get multiple signals from a single execution of the program.  I have
> > attached a stripped source.  Here is the critical snippet, you can see
> > the signal handler being set before each call:
> >
> > 	signal( SIGSEGV,	SignalHdl );
> > 	signal( SIGBUS,		SignalHdl );
> > 	fprintf( stderr, "Running \n" );
> > 	result = func( eT, p );
> > 	fprintf( stderr, "Finished \n" );
> > 	signal( SIGSEGV,	SIG_DFL );
> > 	signal( SIGBUS,		SIG_DFL );
> >
> > When I run the code, that does 2 derefs of NULL you will see 2 instances
> > of "Running" and the handler is not invoked at all for the second time.
> >
> > ./solar:
> 
> You really didn't give enough information.

I provided sample code...

> , but I think your
> signal() is not set up as BSD signals as you expect. I encountered
> such a problem several years ago and reported it to the people
> who wrote the 'C' runtime library. They were kind enough to respond
> with the usual "you are an idiot..." response, but buried in the
> response was the information that I needed. You can bypass all
> those problems by using sigaction(). You can set the flags to
> give the required response. I think you want SA_RESTART in the
> flags to give you the response you expect.

The SA_RESTART option looks interesting.  Will tinker with this.  The
important thing that the K 2.6 developers must be aware if this code
works under K 2.4. This has changed between K 2.4 and K 2.6.  This has
lead to mysterious failures of existing programs, mine at least.

> Also, if you have a longjmp() in your handler code, you can
> trash your local variables in the main-line code. You want
> to try to perform whatever it is that you are doing without
> setjmp()/longjmp() or sigsetjmp()/siglongjmp().

The code works correctly on K 2.4. The signal function is called before
EVERY invocation just before the "Running" text and the output shows
that "Running" was output and yet signal( SIGSEGV, SignalHdl) does not
fire.

Here is the output again:

Getting from NULL
Setting Jump
Running
Signal 11 caught
After jump
Setting to NULL
Setting Jump
Running
Segmentation fault

I was looking for another error in the code, like longjmp trashing
variables however the code does not show problems (or crash) with that,
it simply does not honour the signal function.  The fact that there is
other "issues" with the code does not cover that fact however longjmp
may have some indirect bearing.

This is behaving differently from K 2.4.  either K 2.4 has a bug that
existing software does rely on like mine or K 2.6 has a bug.  If it is a
correction of a K 2.4 bug we need to ensure that people know about it.

-- 
Thanks
KenF
OpenOffice.org developer

