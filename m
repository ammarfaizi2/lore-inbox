Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310120AbSCGOPX>; Thu, 7 Mar 2002 09:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310335AbSCGOPO>; Thu, 7 Mar 2002 09:15:14 -0500
Received: from elin.scali.no ([62.70.89.10]:16395 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S310120AbSCGOPD>;
	Thu, 7 Mar 2002 09:15:03 -0500
Subject: Re: a faster way to gettimeofday? rdtsc strangeness
From: Terje Eggestad <terje.eggestad@scali.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Ben Greear <greearb@candelatech.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0203052024540.1475-100000@blue1.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.44.0203052024540.1475-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 07 Mar 2002 15:14:56 +0100
Message-Id: <1015510496.4373.58.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One word of caution.

If you have a CPU that begin throttling it usually cut the CPU clock in
half and the rdtsc counter count half a fast.

You *should* actually call gettimeofday every few seconds (> 10) to
correct offset.

If you have a SMP system with impropper cooling you actually get into
trouble since you may have one CPU throttling alot and the other don't.
Then the rdtsc of the two CPU's may be quite different.
Have actually seen machines where sleep 1 took 1.2-1.4 secs!

TJ

On Wed, 2002-03-06 at 05:31, Davide Libenzi wrote:
> On Tue, 5 Mar 2002, Ben Greear wrote:
> 
> >
> >
> > Davide Libenzi wrote:
> >
> > > On Tue, 5 Mar 2002, Ben Greear wrote:
> > >
> > >
> > >>I have a program that I very often need to calculate the current
> > >>time, with milisecond accuracy.  I've been using gettimeofday(),
> > >>but gprof shows it's taking a significant (10% or so) amount of
> > >>time.  Is there a faster (and perhaps less portable?) way to get
> > >>the time information on x86?  My program runs as root, so should
> > >>have any permissions it needs to use some backdoor hack if that
> > >>helps!
> > >>
> > >
> > > If you're on x86 you can use collect rdtsc samples and convert them to ms.
> > > You'll get even more then ms accuracy.
> >
> >
> > Can I do this from user space?  If so, any examples or docs
> > you can point me to?
> >
> > Also, I'm looking primarily for a speed increase, not an accuracy
> > increase.
> 
> 
>     #include <linux/timex.h>
> 
> 
>     unsigned long long mscurr;
>     cycles_t cys, cye, mscycles;
>     struct timespec ts1, ts2;
> 
>     clock_gettime(CLOCK_REALTIME, &ts1);
>     cys = get_cycles();
>     sleep(1);
>     clock_gettime(CLOCK_REALTIME, &ts2);
>     cye = get_cycles();
>     mscycles = (cye - cys) / ((ts2.tv_sec - ts1.tv_sec) * 1000 +
> 		(ts2.tv_nsec - ts1.tv_nsec) / 1000000);
> 
> 
> 
>     mscurr = ts2.tv_sec * 1000 + ts2.tv_nsec * 1000000 + (get_cycles() - cye) / mscycles;
> 
> 
> 
> 
> 
> - Davide
> 
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

