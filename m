Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318992AbSHFF2J>; Tue, 6 Aug 2002 01:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318993AbSHFF2J>; Tue, 6 Aug 2002 01:28:09 -0400
Received: from mark.mielke.cc ([216.209.85.42]:17415 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S318992AbSHFF2J>;
	Tue, 6 Aug 2002 01:28:09 -0400
Date: Tue, 6 Aug 2002 01:31:12 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user mode linux]
Message-ID: <20020806013112.A3228@mark.mielke.cc>
References: <1028294887.18635.71.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0208031332120.7531-100000@localhost.localdomain> <m3u1mb5df3.fsf@averell.firstfloor.org> <ail2qh$bf0$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <ail2qh$bf0$1@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Aug 05, 2002 at 05:35:13AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2002 at 05:35:13AM +0000, Linus Torvalds wrote:
> And yes, this signal handler thing is clearly visible on benchmarks. 
> MUCH too clearly visible.  I just didn't see any safe alternatives
> (and I still don't ;( )

To some degree, the original approach taken by Intel may be an alternative...

That is, the signal handler is responsible for saving state of all CPU
resources that it intends to use, and restoring state before returning
control to the caller. (the 'interupt' qualifier from C)

I could see this offered as a GCC optimization, but without the compiler
smarts to detect what is needed and what is not, it would be very difficult
to add this support in a seamless manner.

For example:

    typedef void (*__fastsighandler_t) (int) __attribute__ ((signal_handler));

    #define signal(number, handler) \
        (__attribute_enabled__((handler, signal_handler)) \
            ? __signal_fast(number, handler) \
            : __signal(number, handler))

    void handle_sigint (int) __attribute__ ((signal_handler))
    {
        sigint_received++;
    }



mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

