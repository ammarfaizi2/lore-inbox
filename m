Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311890AbSCXKSk>; Sun, 24 Mar 2002 05:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311905AbSCXKSb>; Sun, 24 Mar 2002 05:18:31 -0500
Received: from gold.MUSKOKA.COM ([216.123.107.5]:4618 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S311890AbSCXKSS>;
	Sun, 24 Mar 2002 05:18:18 -0500
Message-ID: <3C9DA6F9.1CD32F3D@yahoo.com>
Date: Sun, 24 Mar 2002 05:14:17 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.4.18 i586)
MIME-Version: 1.0
To: Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
CC: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [PATCH] 2.4.19 do_adjtimex parameter checking
In-Reply-To: <3C9A08C2.13553.1CBE6CD@localhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay then, the bug still stands, but you want a different fix really.
The user that reported it to me was infact setting multiple bit
combos, which you indicate as taboo (but currently allowed). So 
when multiple bit combos are given, we can either do:

a) return -EINVAL if more than ADJ_OFFSET_SINGLESHOT is set
b) clear/ignore any bits above and beyond ADJ_OFFSET_SINGLESHOT.

As you are a time guru, please indicate which is preferable and I will
bounce Rusty an appropriate patch.

Thanks,
Paul.

Ulrich Windl wrote:
> 
> On 21 Mar 2002, at 8:40, Paul Gortmaker wrote to me:
> 
> > Spotted by Tajthy.Tamas @ datentechnik.hu:
> >
> > Adjtimex modes may contain other bits set in addition to
> > ADJ_OFFSET_SINGLESHOT bits, and hence tests for strict (in)equality
> > are not appropriate - must test for ADJ_OFFSET_SINGLESHOT
> > bits set in modes.  Three places in the code where this test
> > is made - oddly enough the 3rd is already correct.
> 
> Hello,
> masters of the bits,
> 
> basically no: adjtimex() is either adjtime() or ntp_adjtime or
> ntp_gettime(). While one could think to set multiple bit combinations,
> it was never intended. At the user level adjtimex() should never have
> existed. This patch would open a new incompatible use of adjtimex() by
> blessing what was illegal before IMHO.
> 
> ADJ_OFFSET_SINGLESHOT has be be used alone, specifically also to return
> the correct return value.
> 
> Regards,
> Ulrich
> 
> >
> >
> > --- linux/kernel/time.c~      Thu Feb 28 09:37:32 2002
> > +++ linux/kernel/time.c               Thu Mar 21 08:27:49 2002
> > @@ -216,7 +216,7 @@
> >
> >       /* Now we validate the data before disabling interrupts */
> >
> > -     if (txc->modes != ADJ_OFFSET_SINGLESHOT && (txc->modes & ADJ_OFFSET))
> > +     if (((txc->modes & ADJ_OFFSET_SINGLESHOT) != ADJ_OFFSET_SINGLESHOT) && (txc->modes & ADJ_OFFSET))
> >         /* adjustment Offset limited to +- .512 seconds */
> >               if (txc->offset <= - MAXPHASE || txc->offset >= MAXPHASE )
> >                       return -EINVAL;
> > @@ -275,7 +275,7 @@
> >           }
> >
> >           if (txc->modes & ADJ_OFFSET) {      /* values checked earlier */
> > -             if (txc->modes == ADJ_OFFSET_SINGLESHOT) {
> > +             if ((txc->modes & ADJ_OFFSET_SINGLESHOT) == ADJ_OFFSET_SINGLESHOT) {
> >                   /* adjtime() is independent from ntp_adjtime() */
> >                   time_adjust = txc->offset;
> >               }
> >
> >

