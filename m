Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbTJTUfs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 16:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262795AbTJTUfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 16:35:48 -0400
Received: from chaos.analogic.com ([204.178.40.224]:16517 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262794AbTJTUfY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 16:35:24 -0400
Date: Mon, 20 Oct 2003 16:38:24 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Ken Foskey <foskey@optushome.com.au>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: K 2.6 test6 strange signal behaviour
In-Reply-To: <1066677998.8832.98.camel@gandalf.foskey.org>
Message-ID: <Pine.LNX.4.53.0310201631390.14662@chaos>
References: <1066654886.5930.57.camel@gandalf.foskey.org> 
 <Pine.LNX.4.53.0310200938260.13239@chaos> <1066677998.8832.98.camel@gandalf.foskey.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Oct 2003, Ken Foskey wrote:

> On Mon, 2003-10-20 at 23:48, Richard B. Johnson wrote:
> > On Mon, 20 Oct 2003, Ken Foskey wrote:
> >
> > >
> > > I have a problem with signals.
> > >
> > > I get multiple signals from a single execution of the program.  I have
> > > attached a stripped source.  Here is the critical snippet, you can see
> > > the signal handler being set before each call:
> > >
> > > 	signal( SIGSEGV,	SignalHdl );
> > > 	signal( SIGBUS,		SignalHdl );
> > > 	fprintf( stderr, "Running \n" );
> > > 	result = func( eT, p );
> > > 	fprintf( stderr, "Finished \n" );
> > > 	signal( SIGSEGV,	SIG_DFL );
> > > 	signal( SIGBUS,		SIG_DFL );
> > >
> > > When I run the code, that does 2 derefs of NULL you will see 2 instances
> > > of "Running" and the handler is not invoked at all for the second time.
> > >
> > > ./solar:
> >
> > You really didn't give enough information.
>
> I provided sample code...
>

There was no attached code when I received your email.
If the stuff above is 'sample code', then I don't know what
kind of compiler you are using because, at the very least, there
should be some curley-braces and an entry point. So, I made
some sample code. Could you please try it and tell us what
it does that is unexpected?


#include <stdio.h>
#include <unistd.h>
#include <setjmp.h>
#include <signal.h>

int function(int input, const char *cp) {
    return fprintf(stderr, cp, input);
}
jmp_buf env;
int (*funct)(int, const char *) = NULL;
void SignalHdl(int sig) {
    fprintf(stderr, "Signal received %d\n", sig);
    longjmp(env, sig);
}
int main() {
    int result;
    int times = 5;
    (void)signal(SIGSEGV, SignalHdl);
    (void)signal(SIGBUS,  SignalHdl);
    if(!setjmp(env)) {
        fprintf(stderr, "Started\n");
        result = funct(times, "Handler writes %d\n");
    }
    if(times--) {
        funct = function;
        fprintf(stderr, "Okay(%d)\n", times);
        result = funct(times, "Handler writes %d\n");
        fprintf(stderr, "Okay(%d)\n", times);
        funct = NULL;
        result = funct(1, "Handler writes %d\n");  // Segfault
    }
    return 0;
}

It all seems to work here with Linux-2.4.22, even though the
counter "times" really should not be relied upon after the
longjmp.

Started
Signal received 11
Okay(4)
Handler writes 4
Okay(4)
Signal received 11
Okay(3)
Handler writes 3
Okay(3)
Signal received 11
Okay(2)
Handler writes 2
Okay(2)
Signal received 11
Okay(1)
Handler writes 1
Okay(1)
Signal received 11
Okay(0)
Handler writes 0
Okay(0)
Signal received 11


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


