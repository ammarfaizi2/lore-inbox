Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315427AbSHISrD>; Fri, 9 Aug 2002 14:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315454AbSHISrD>; Fri, 9 Aug 2002 14:47:03 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:63226 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S315427AbSHISrC>;
	Fri, 9 Aug 2002 14:47:02 -0400
Message-ID: <3D540ED3.58F200F6@mvista.com>
Date: Fri, 09 Aug 2002 11:49:55 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Leah Cunningham <leahc@us.ibm.com>,
       wilhelm.nuesser@sap.com, paramjit@us.ibm.com, msw@redhat.com
Subject: Re: [PATCH] tsc-disable_B9
References: <1028771615.22918.188.camel@cog> 
		<1028812663.28883.32.camel@irongate.swansea.linux.org.uk> 
		<1028860246.1117.34.camel@cog> 
		<1028884665.28882.173.camel@irongate.swansea.linux.org.uk> <1028915214.1117.46.camel@cog>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> 
> On Fri, 2002-08-09 at 02:17, Alan Cox wrote:
> > On Fri, 2002-08-09 at 03:30, john stultz wrote:
> > > Not sure I followed that, do you mean per-cpu TSC management for
> > > gettimeofday?
> >
> > We have some x86 setups where people plug say a 300MHhz and a 450MHz
> > celeron into the same board. This works because they are same FSB,
> > different multiplier (works and intel certify being two different
> > things)
> 
> Oh yes, with the old NUMAQ hardware here, one can mix nodes of different
> speed cpus. Once I get a chance, I'm going to begin working on this
> issue for 2.5. My plan right now is to keep per-cpu last_tsc_low and
> fast_gettimeoffset_quotient values, then round robin the timer
> interrupt.
> 
An interesting approach, however, could you take a look at
the high-res-timers patch (see signature).  In that code (in
the TSC version), we use the TSC to update jiffies and
_sub_jiffie (which is TSC counts into the next jiffie).  We
also want to be able to "grab" a new TSC and figure the time
quickly, without updating either jiffies or _sub_jiffie. 
Your approach would, I think, mean that both jiffies and
_sub_jiffie would be per cpu values, not impossible, but,
well, hard.

On the other hand, the high-res-timers patch also allows one
to use the ACPI pm timer, and ignore TSC completely :)

-g
> 
> > Needless to say tsc does not work well on such boxes. Thats why I don't
> > trust the tsc at all in such cases. Since you'll have the nice cyclone
> > timer for the Summit it seems best not to trust it, and on the summit to
> > use the cyclone for udelay as well ?
> >
> > I agree dodgy_tsc needs to change name. Perhaps we actually want
> >
> >       int tsc = select_tsc();
> >
> >       switch(tsc)
> >       {
> >               case TSC_CYCLONE:
> >               case TSC_PROCESSOR:
> >               case TSC_NONE:
> >               ..
> >       }
> 
> Sounds good. I'll re-work my patch and resubmit.
> 
> thanks!
> -john
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
