Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLDUSC>; Mon, 4 Dec 2000 15:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129231AbQLDURx>; Mon, 4 Dec 2000 15:17:53 -0500
Received: from mail-03-real.cdsnet.net ([63.163.68.110]:37650 "HELO
	mail-03-real.cdsnet.net") by vger.kernel.org with SMTP
	id <S129226AbQLDURm>; Mon, 4 Dec 2000 15:17:42 -0500
Message-ID: <3A2BF4A2.74BA762A@mvista.com>
Date: Mon, 04 Dec 2000 11:46:42 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.redhat.com" <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>,
        Roger Larsson <roger.larsson@norran.ne>
Subject: Re: *_trylock return on success?
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So what is a coder to do.  We need to define the pi_mutex_trylock().  If
I understand this thread, it should return 0 on success.  Is this
correct?

George


On Saturday 25 November 2000 22:05, Roger Larsson wrote: 
> On Saturday 25 November 2000 20:22, Philipp Rumpf wrote: 
> > On Sat, Nov 25, 2000 at 08:03:49PM +0100, Roger Larsson wrote: 
> > > > _trylock functions return 0 for success. 
> > > 
> > > Not spin_trylock 
> > 
> > Argh, I missed the (recent ?) change to make x86 spinlocks use 1 to mean 
> > unlocked. You're correct, and obviously this should be fixed. 

Have looked more into this now... 
tasklet_trylock is also wrong (but there are only four of them) 
Is this 2.4 only, or where there spin locks earlier too? 

My suggestion now is a few steps: 
1) to release a kernel version that has corrected _trylocks; 
    spin2_trylock and tasklet2_trylock. 
    [with corresponding updates in as many places as possible: 
      s/!spin_trylock/spin2_trylock/g 
      s/spin_trylock/!spin2_trylock/g 
      . . .] 
    (ready for spin trylock, not done for tasklet yet..., attached, 
     hope it got included OK - not fully used to kmail) 

2) This will in house only drives or compilations that in some 
    strange way uses this calls... 

3a) (DANGEROUS) global rename spin2_trylock to spin_trylock 
     [no logic change this time - only name] 
3b) (dangerous) add compatibility interface 
     #define spin_trylock(L) (!spin2_trylock(L)) 
     Probably not necessary since it can not be linked against. 
     Binary modules will contain their own compatibility code :-) 
     Probably preferred by those who maintain drivers for several 
     releases; 2.2, 2.4, ... 
3c) do not do anything more... 

Alternative: 
1b) do nothing at all - suffer later 

/RogerL
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
