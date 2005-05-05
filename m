Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbVEEMZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbVEEMZh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 08:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbVEEMZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 08:25:37 -0400
Received: from alog0174.analogic.com ([208.224.220.189]:37769 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262071AbVEEMZQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 08:25:16 -0400
Date: Thu, 5 May 2005 08:24:54 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Daniel Jacobowitz <dan@debian.org>
cc: Olivier Croquette <ocroquette@free.fr>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler: SIGSTOP on multi threaded processes
In-Reply-To: <Pine.LNX.4.61.0505042031120.22323@chaos.analogic.com>
Message-ID: <Pine.LNX.4.61.0505050814340.24130@chaos.analogic.com>
References: <4279084C.9030908@free.fr> <Pine.LNX.4.61.0505041403310.21458@chaos.analogic.com>
 <20050504191604.GA29730@nevyn.them.org> <Pine.LNX.4.61.0505042031120.22323@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I don't think the kernel handler gets a chance to do anything
because SYS-V init installs its own handler(s). There are comments
about Linux misbehavior in the code. It turns out that I was
right about SIGSTOP and SIGCONT...


Source-code header..... Current init version is 2.85 but I can't find
the source. This is 2.62

/*
  * Init		A System-V Init Clone.
  *
  * Usage:	/sbin/init
  *		     init [0123456SsQqAaBbCc]
  *		  telinit [0123456SsQqAaBbCc]
  *
  * Version:	@(#)init.c  2.62  29-May-1996  MvS
  *
  *		This file is part of the sysvinit suite,

[SNIPPED...]

/*
  * Linux ignores all signals sent to init when the
  * SIG_DFL handler is installed. Therefore we must catch SIGTSTP
  * and SIGCONT, or else they won't work....
  *
  * The SIGCONT handler
  */
void cont_handler()
{
   got_cont = 1;
}

/*
  * The SIGSTOP & SIGTSTP handler
  */
void stop_handler()
{
   got_cont = 0;
   while(!got_cont) pause();
   got_cont = 0;
}


Now, if POSIX threads signals were implimented within the kernel,
without first purging the universe of all copies of the SYS-V init
that was distributed with early copies of RedHat and others (don't
know about current copies, a very long search failed to find the
source), then whatever you do in the kernel is wasted.

On Wed, 4 May 2005, Richard B. Johnson wrote:
> On Wed, 4 May 2005, Daniel Jacobowitz wrote:
>
>> On Wed, May 04, 2005 at 02:16:24PM -0400, Richard B. Johnson wrote:
>>> The kernel doesn't do SIGSTOP or SIGCONT. Within init, there is
>>> a SIGSTOP and SIGCONT handler. These can be inherited by others
>>> unless changed, perhaps by a 'C' runtime library. Basically,
>>> the SIGSTOP handler executes pause() until the SIGCONT signal
>>> is received.
>>> 
>>> Any delay in stopping is the time necessary for the signal to
>>> be delivered. It is possible that the section of code that
>>> contains the STOP/CONT handler was paged out and needs to be
>>> paged in before the signal can be delivered.
>>> 
>>> You might quicken this up by installing your own handler for
>>> SIGSTOP and SIGCONT....
>> 
>> I don't know what RTOSes you've been working with recently, but none of
>> the above is true for Linux.  I don't think it ever has been.
>> 
>> -- 
>> Daniel Jacobowitz
>> CodeSourcery, LLC
>> 
>
> Grab a copy of your favorite init source. SIGSTOP and SIGCONT are
> signals. They are handled by signal handlers, always have been
> on Unix and Unix clones like Linux.
>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
> Notice : All mail here is now cached for review by Dictator Bush.
>                 98.36% of all statistics are fiction.
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
