Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319003AbSIJCoQ>; Mon, 9 Sep 2002 22:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319014AbSIJCoQ>; Mon, 9 Sep 2002 22:44:16 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1035 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319003AbSIJCoP>; Mon, 9 Sep 2002 22:44:15 -0400
Date: Mon, 9 Sep 2002 19:49:11 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
cc: Greg KH <greg@kroah.com>, <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] USB changes for 2.5.34
In-Reply-To: <20020909190709.E16183@one-eyed-alien.net>
Message-ID: <Pine.LNX.4.44.0209091926320.1911-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Short and sweet:

  If I have a BUG() that I need to remove and replace with a printk()  
  (which I did) in order to even be able to debug the dang thing, then
  that BUG()  is a mistake. No ifs, buts or maybe's accepted. The one and 
  _only_ point of BUG() is to help debugging, and if it doesn't, then it
  should not be there.

Longer:

On Mon, 9 Sep 2002, Matthew Dharm wrote:
> 
> (3) Given that we think we've fixed all of these bad initiators, the BUG()
> really is something that should never happen.

You can't have it both ways.

Either it really never happens.

Or it _does_ happen, in which case you want sane debuggable output.

In the latter case, BUG() is the wrong thing to do, exactly because it
tends to bring the system down.  In the first case it obviously doesn't 
matter and isn't even relevant, and the best thing to do would be to 
remove it altogether. In neither case is BUG() useful.

I'm personally in X 99% of the time except for the reasonably rare case
when I'm chasing down some bug I know I can reproduce and I want the
kernel to have access to the console.

And I doubt I'm alone in that. I suspect most people who use Linux in any
interesting situation (and no, I don't think servers are very interesting
from most standpoints) tend to do this. Agreed?

That means that the BUG() output won't even be _visible_ to 99% of all 
cases. And if it causes the machine to hang, it is now not only invisible, 
it cannot even be gotten hold of some other way.

Which basically means that a driver that uses BUG() for something that
isn't certain to be fatal anyway is a BUGGY driver.

If my X session is hung, that's already bad (most people will give up at
that point). If I can't even log in remotely, that's _disastrous_, since
now the BUG() causes me to not to be able to debug it at all. The BUG() 
basically made itself irrlevant.

The fact is, BUG() is almost always the wrong thing to do. And it's
almost _guaranteed_ to be the wrong thing to do in a driver, since a 
driver won't know what locks the rest of the kernel is holding, _and_ 
since it's almost always possible for a driver to try to return an error 
code instead.

In short:
 
  Either you want debugging (in which case BUG() is the wrong thing to
  do), or you don't want debugging (in which case BUG() is the wrong thing
  to do). You can choose either, but in neither case is BUG() acceptable.

  BUG() is fine for _fundamental_ problems, where you don't have any other 
  choice, and where the machine really is effectively dead anyway. If the 
  VM notices that it's lists are corrupt, that's a BUG() thing. We don't 
  have much choice. If the scheduler notices that it's running on another 
  CPU than it thought it was running on, that's a BUG() thing.

Now, the kernel problem may be that BUG() is a bit too easy to use, and 
the alternatives are not. We should fix that. But we shouldn't fix it by 
using BUG() in places where it definitely doesn't belong.

		Linus

