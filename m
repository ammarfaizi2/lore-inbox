Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267144AbSLDXfX>; Wed, 4 Dec 2002 18:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267145AbSLDXfX>; Wed, 4 Dec 2002 18:35:23 -0500
Received: from mail.ccur.com ([208.248.32.212]:28420 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id <S267144AbSLDXfW>;
	Wed, 4 Dec 2002 18:35:22 -0500
Message-ID: <3DEE92EF.350F4F9F@ccur.com>
Date: Wed, 04 Dec 2002 18:42:39 -0500
From: Jim Houston <jim.houston@ccur.com>
Reply-To: jim.houston@ccur.com
Organization: Concurrent Computer Corp.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: george anzinger <george@mvista.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de, davidm@hpl.hp.com,
       schwidefsky@de.ibm.com, ralf@gnu.org, willy@debian.org
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
References: <Pine.LNX.4.44.0212041203230.1676-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 4 Dec 2002, george anzinger wrote:
> >
> > As a suggestion for a solution for this, is it true that
> > regs, on a system call, will ALWAYS be at the end of the
> > stack?
> 
> No. Some architectures do not save enough state on the stack by default,
> and need to do more to use do_signal(). Look at alpha, for example - the
> default kernel stack doesn't contain all tbe registers needed, and
> the alpha do_signal() calling convention is different.
> 
> If you want to handle do_signal(), then you need to do _all_ of this in
> architecture-specific files. You simply cannot do what you want to do in a
> generic way.
> 
>                 Linus

Hi Linus,

Agreed!  In my alternative version of the Posix timers patch, I avoid
calling do_signal() from clock_nanosleep by using a variant of the 
existing ERESTARTNOHAND mechanism.  The problem I ran into was that I
could not tell on entry to clock_nanosleep if it was a new call or
an old one being restarted.  I solved this by adding a new 
ERESTARTNANOSLP error code and making a small change in do_signal().
The handling of ERESTARTNANOSLP is the same as ERESTARTNOHAND but also
sets a new flag in the task_struct before restarting the system call.

This is still an architecture-specific change but atleast it is simple.

Jim Houston - Concurrent Computer Corp.
