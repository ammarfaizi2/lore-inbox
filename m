Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264915AbTAONuP>; Wed, 15 Jan 2003 08:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266417AbTAONuP>; Wed, 15 Jan 2003 08:50:15 -0500
Received: from chaos.analogic.com ([204.178.40.224]:57223 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S264915AbTAONuO>; Wed, 15 Jan 2003 08:50:14 -0500
Date: Wed, 15 Jan 2003 09:00:36 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Mark Mielke <mark@mark.mielke.cc>
cc: DervishD <raul@pleyades.net>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Changing argv[0] under Linux.
In-Reply-To: <20030114212113.GF15412@mark.mielke.cc>
Message-ID: <Pine.LNX.3.95.1030115085049.17316A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2003, Mark Mielke wrote:

> On Tue, Jan 14, 2003 at 03:28:23PM -0500, Richard B. Johnson wrote:
> > On Tue, 14 Jan 2003, Mark Mielke wrote:
> > > On Tue, Jan 14, 2003 at 02:56:35PM -0500, Richard B. Johnson wrote:
> > > > Well I just grepped through usr/include/bits/posix1_lim.h and it
> > > > shows 255 (with this 'C' library) so you are probably right.
> > > > In any event, a "whole line of text" isn't going to overrun it. 
> > > Looking at the code, it looks to me as if argv[0] can be any size up to
> > > _SC_ARG_MAX, with the restraining factor being that the environment
> > > variables and the other arguments must fit in the same space.
> > > Is this not correct?
> > Don't think so. In my headers _SC_ARG_MAX is an enumerated type
> > that is numerically equal to 0. It's in confname.h, the first
> > element in the enumerated list.
> 
> _SC_ARG_MAX is one of the identifiers that are used with sysconf() to
> lookup a system-wide configuration value:
> 
>     $ perl -MPOSIX -e 'print sysconf(_SC_ARG_MAX), "\n"'
>     131072
> 
> The environment size for a program invoked using exec() can be up to
> 131072 bytes long (my configuration). This environment holds the
> command arguments as well as the environment.
> 
> On my system, _SC_ARG_MAX is telling me that it is possible to have
> argv[0] be just under 131072 bytes long.
> 
> mark
> 

The following program shows why it's not "safe" to do anything
with argv[0].

#include <stdio.h>
int main(int c, char *argv[], char *env[])
{
   int i;
   i = 0;
   printf("Stack is at %p\n", &i);
   while(argv[i])
   {
       printf("Pointer at %p = %s\n", argv[i], argv[i]);
       i++; 
   }
   i = 0;
   while(env[i])
   {
       printf("Pointer at %p = %s\n", env[i], env[i]);
       i++; 
   }
   return 0;
}

Everything is lined-up, sitting on the stack, and all variable-
length.

I looked at sendmail and it just does:

	strcpy(argv[0] ,"sendmail:accepting connections");

But sendmail doesn't use the environment so if it gets trashed
it doesn't make any difference. It looks as though, if the
environment was small, i.e., only "TERM=vt100", sendmail might
have problems if main() ever returns to _start. The stack
will be trashed. But, most 'C' code doesn't do "return N;" from
main, certainly not a daemon, most call exit().

Anyway, overwriting argv[0] is done, but it's not "safe".

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


