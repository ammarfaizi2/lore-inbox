Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317908AbSGKUnr>; Thu, 11 Jul 2002 16:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317909AbSGKUnp>; Thu, 11 Jul 2002 16:43:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27146 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317908AbSGKUnj>;
	Thu, 11 Jul 2002 16:43:39 -0400
Message-ID: <3D2DEE2E.9D1FFEF@zip.com.au>
Date: Thu, 11 Jul 2002 13:44:30 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jussi Laako <jussi.laako@kolumbus.fi>
CC: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: [CRASH] in tulip driver?
References: <3D2CFCE0.3452F960@zip.com.au> <1026419920.1859.7.camel@vaarlahti.uworld>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jussi Laako wrote:
> 
> ...
> >
> > --- 2.4.19-pre6/drivers/char/random.c~low-latency       Fri Apr  5 12:11:17 2002
> > +++ 2.4.19-pre6-akpm/drivers/char/random.c      Fri Apr  5 12:11:17 2002
> > @@ -1369,6 +1369,11 @@ static ssize_t extract_entropy(struct en
> >                 buf += i;
> >                 ret += i;
> >                 add_timer_randomness(&extract_timer_state, nbytes);
> > +#if LOWLATENCY_NEEDED
> > +               /* This can happen in softirq's, but that's what we want */
> > +               if (conditional_schedule_needed())
> > +                       break;
> > +#endif
> >         }
> >
> >         /* Wipe data just returned from memory */
> >
> > So it's a bit of a mystery.  It seems to think that it has
> > EXTRACT_ENTROPY_USER.
> 
> Whoops, thanks, I found the bug. My fault...
> 
> That "break;" breaks some (apparently broken) programs that don't expect
> read of /dev/urandom to return early. For security resons (to get
> identical behaviour compared to the original kernel) I made a fix that
> someone proposed. That fix is apparently broken on some rare situations
> which seem to be difficult to trigger (requires high overall irq rates
> with network load). Now I'm going to remove that part completely and see
> what happens next...
> 

Yes, just delete that chunk.  I took it out of the ll patch a few
weeks ago because of the /dev/urandom thing.

The random driver only causes a 1-2 milliseocnd blip @500MHz anyway.

-
