Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318962AbSIJBgU>; Mon, 9 Sep 2002 21:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318968AbSIJBgU>; Mon, 9 Sep 2002 21:36:20 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60167 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318962AbSIJBgR>; Mon, 9 Sep 2002 21:36:17 -0400
Date: Mon, 9 Sep 2002 18:41:06 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Greg KH <greg@kroah.com>, <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
In-Reply-To: <1031618439.31787.20.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0209091832160.1714-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10 Sep 2002, Alan Cox wrote:
> 
> I'd have thought you may well want the reverse. If the user didnt pick
> the kernel debugging, don't die on software check option you want to
> blow up.

No, thanks. If it's fatal, it's a BUG(), and you blow regardless.

If it isn't fatal, there is no excuse for blowing up. EVER.  That's
_especially_ true for some random user who didn't ask for, and can't
handle debugging. If it's useful information that the developer believes
he wants, it shouldn't be conditional at all.

> If they are debugging or its < 2.6.0-rc1 you want it to show
> the stack and keep going

You definitely want to keep going regardless. A BUG() that takes out the
machine is just not useful, because users who aren't ready to debug it
can't even make any reports except "it stops" (which this one did if you
were under X - the machine was just _dead_).

Basically, with the amount of locking we have, a BUG() or a blow-up just 
about anywhere is lethal. Most sequences (especially in drivers, but 
inside filesystems etc too) tend to hold spinlocks etc that just makes it 
a bad idea to BUG() out unless you really really have to, since the 
machine is not likely to survive and be able to write good reports to disk 
etc at pretty much any point.

(It used to be that you could take a fault just about anywhere except for
in interrupt handlers, and Linux would try its damndest to clean up and
continue as if nothing had happened. Those days are sadly gone, and
trapping and depending on killing the process seldom works well any more).

On the whole, it's a lot better to just print out a message (and call
traces are often very useful) and continue. That's not always possible, of
course, and a lot of BUG() and BUG_ON() cases are perfectly valid simply
because sometimes there isn't anything you can do except kill the machine
and try to inform the user.

I think the historical kernel behaviour ("trap and kill and continue"  
historically worked so fine for _both_ major bugs and for "random sanity
test" cases) has caused us to be a bit lazy about this sometimes.

			Linus

