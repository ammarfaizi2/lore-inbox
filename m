Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbTAMPeq>; Mon, 13 Jan 2003 10:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267387AbTAMPeq>; Mon, 13 Jan 2003 10:34:46 -0500
Received: from elin.scali.no ([62.70.89.10]:62473 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S261530AbTAMPen>;
	Mon, 13 Jan 2003 10:34:43 -0500
Subject: Re: any chance of 2.6.0-test*?
From: Terje Eggestad <terje.eggestad@scali.com>
Reply-To: /dev/null@scali.com
To: robw@optonline.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1042401817.1209.54.camel@RobsPC.RobertWilkens.com>
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com>
	 <1042400094.1208.26.camel@RobsPC.RobertWilkens.com>
	 <1042400219.1208.29.camel@RobsPC.RobertWilkens.com>
	 <20030112195347.GJ3515@louise.pinerecords.com>
	 <1042401817.1209.54.camel@RobsPC.RobertWilkens.com>
Content-Type: text/plain; charset=ISO-8859-15
Organization: Scali AS
Message-Id: <1042472605.5404.72.camel@pc-16.office.scali.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 13 Jan 2003 16:43:26 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1) newbies has made the very same "minor" suggestion before; and had
their heads summarily  chopped of. 
2) It's not a minor suggestion.
3) and more to the point, you proved your selv why it's a dumb idea to
remove them, when you had to correct you own code 2 minutes after you
posted it.

-------------------- begin quote ---------------------------------
On Sun, 2003-01-12 at 14:34, Rob Wilkens wrote:
> I would change it to something like the following (without testing the
> code through a compiler or anything to see if it's valid):
> 
>                       if (!(spin_trylock(&tty_lock.lock))){
>                               if (tsk ==tty_lock.lock_owner){
>                                       WRAN_ON(!tty_lock.lcok_count);
>                                       tty_lock.lock_count++;
>                                       return flags;
>                               }
>                       }
oops - Yes,  I forgot to add one line here (my point remains the same: 
                          spin_lock(&tty_lock.lock);
>                       WARN_ON(tty_lock.lock_owner);   
>                       <etc...>
> 
-------------------- end quote ---------------------------------

OF all the reasons to use goto, spinlocks are alone reason enough. By
omitting the very little line you did
you created a race condition. Now I'm assuming that you know what a race
condition is.
IF YOU DON'T: DO NOT ASK!   L-O-O-K    I-T   U-P !!!!

Now since races are the worst kind of problems, in that they causes
seemingly random data corruption, or of you forget a spinunlock you get
a hung machine, minimize them is of paramount importance. 

Considering that doing kernel development is hard enough, new
development is almost always done on uni processors kernels that do only
one thing at the time. Then when you base logic is OK, you move to a
SMP, which means (adding and) debugging you spin locks.

Considering that fucking up spin locks are prone to corrupting your
machine, one very simple trick to makeing fewer mistakes to to have one,
and only one, unlock for every lock. 

In order to achive that you write your function to have one entry point
(which all C functions have) and one exit point, thus one and only one
return. 

In order to do that you can either concoct a set of if-then-else-orelse
logic that is incomprehensible, or you use goto!


Now you may look at Linus's code you buggified, and point out that the
lock and unlock are not in the same function, then read Linus's original
post CAREFULLY! And UNDERSTAND how these functions are used. 



 
On søn, 2003-01-12 at 21:03, Rob Wilkens wrote:
> On Sun, 2003-01-12 at 14:53, Tomas Szepe wrote:
> > > [robw@optonline.net]
> > >
> > > Am I wrong that the above would do the same thing without generating the
> > > sphagetti code that a goto would give you.  Gotos are BAD, very very
> > > bad.
> > 
> > Whom do I pay to have this annoying clueless asshole shot?
> > OH MY GOD, I really can't take any more.
> 
> Mail filters are a wonderful thing, use them on me and you want have to
> have me shot.  We'll both be happier in the end.
> 
> What exactly is it that you can't take?  I made a minor suggestion in
> the above message, very minor, and only a suggestion -- one that was
> free to be ignorred.  There are over 300 messages a day on this list,
> why do the few ones from _me_ bother you.
> 
> -Rob
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

