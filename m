Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261549AbSJITbz>; Wed, 9 Oct 2002 15:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261527AbSJITby>; Wed, 9 Oct 2002 15:31:54 -0400
Received: from crack.them.org ([65.125.64.184]:16645 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S261518AbSJITbv>;
	Wed, 9 Oct 2002 15:31:51 -0400
Date: Wed, 9 Oct 2002 15:37:38 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: george anzinger <george@mvista.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linus <torvalds@transmeta.com>,
       LKML <linux-kernel@vger.kernel.org>, Jeff Dike <jdike@karaya.com>
Subject: Re: [PATCH] make do_signal static on i386
Message-ID: <20021009193738.GA15232@nevyn.them.org>
Mail-Followup-To: george anzinger <george@mvista.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Linus <torvalds@transmeta.com>, LKML <linux-kernel@vger.kernel.org>,
	Jeff Dike <jdike@karaya.com>
References: <20021009181003.022da660.sfr@canb.auug.org.au> <3DA46A17.447B2C59@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DA46A17.447B2C59@mvista.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2002 at 10:40:39AM -0700, george anzinger wrote:
> This will cause problems for nano_sleep and
> clock_nanosleep.  These system calls need to call
> do_signal() in order to meet the POSIX standard which states
> that they are interrupted only by signals that are delivered
> to user code.  Other signals are not to interrupt the
> sleep.  This is why do_signal() returns this information to
> the caller.
> 
> I suppose one could argue that such functions should be in
> signal.c, but save for this signal issue the code is
> common.  Seems a waste to support the same code in N
> platforms.

IMO, calling the architecture's do_signal function to handle that is
entirely the wrong way to go.  They don't even all have the same
arguments, and the wrappers hi-res-timers put around sys_nanosleep are
hideous.

All of this should be handled correctly in kernel/signal.c, and things
like triggering the debugger should be done from there, not duplicated
in each platform's signal delivery code.

Ideally we should even trigger the debugger without necessarily
knocking the sleeping process out of sleep.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
