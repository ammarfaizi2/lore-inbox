Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318896AbSH1PoS>; Wed, 28 Aug 2002 11:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318879AbSH1Pmv>; Wed, 28 Aug 2002 11:42:51 -0400
Received: from sun0.mpimf-heidelberg.mpg.de ([149.217.50.120]:39141 "EHLO
	sun0.mpimf-heidelberg.mpg.de") by vger.kernel.org with ESMTP
	id <S318882AbSH1PmU>; Wed, 28 Aug 2002 11:42:20 -0400
Subject: Re: Linux-2.4.20-pre4-ac1: i810_audio broken
From: Juergen Sawinski <juergen.sawinski@mpimf-heidelberg.mpg.de>
To: Doug Ledford <dledford@redhat.com>
Cc: "linux-kernel@vger" <linux-kernel@vger.kernel.org>
In-Reply-To: <20020828112133.C30777@redhat.com>
References: <200208271253.12192.pavenis@latnet.lv>
	<200208281004.07891.pavenis@latnet.lv> <1030539078.1454.8.camel@voyager>
	<200208281622.30303.pavenis@latnet.lv>  <20020828112133.C30777@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 28 Aug 2002 17:47:38 +0200
Message-Id: <1030549658.16619.20.camel@volans>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll check the CIV read-only thing with ICH4 tonight (maybe I've
overseen some doc errata or the manual is just lying). On the other
hand, the CIV register is set to zero on reset (AFAICS), maybe a DMA
engine reset sets CIV to 0 implicitly on ICH4.

But if CIV is really RO, I could add a CAP_CIV_RO define to the card_cap
struct. Then I'd only have to set LVI appropialty to CIV... hmmm....
*sigh*

BTW, sound is working perfectly on my machine (ICH4).

George

On Wed, 2002-08-28 at 17:21, Doug Ledford wrote:
> On Wed, Aug 28, 2002 at 04:22:30PM +0300, Andris Pavenis wrote:
> > On Wednesday 28 August 2002 15:51, Juergen Sawinski wrote:
> > > Can you drop in the old (working) source into the new tree and see if
> > > that works? If that works I'll try making a step by step patch series,
> > > to see what breaks it.
> > 
> > Today's tests were done in that way (I only replaced i810_audio.c,
> > removed i810_audio.o, run 'make modules' and 'make modules_install' and tested 
> > the results). As I wrote earlier it seems that Dough's patch (to 
> > 2.4.20-pre1-ac2) broke driver
> 
> (In an email Juergen sent to me privately he mentioned that on the ICH4 
> the CIV register is now read-only where as on previous ICH chips it was 
> read-write, which is something I missed as far as changes to the chip are 
> concerned)
> 
> Now, given the tidbit of information above, I would expect ICH4 chipsets 
> to break with the driver.  We currently rely upon the ability to set the 
> CIV register to what we want in order to start the DMA where we want.  If 
> that's now readonly, I'll have to rethink how I reset the DMA hardware and 
> how I will have to start recording the new DMA position instead of setting 
> the new DMA position.  The one thing about this though, I would expect 
> this issue to cause previously non-working ICH4 chips to work poorly with 
> my patch instead of previously working ICH4 chips to now start working 
> poorly since my patch didn't change the (/me stops mid-sentence and 
> realizes that "yes, in fact there is a change in my patch to base DMA 
> operations that could cause this").  Hmmm...backup....try backing out my 
> changes to stop_dac and stop_adc (the part where I change how we do a DMA 
> engine reset every time we stop the dac and adc) and see if that solves 
> your problem.  The changes to __stop_dac() and __stop_adc() are localized 
> actually and you should be able to safely leave all of those hunks out 
> without effecting the rest of the patch.
> 
> -- 
>   Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
>          Red Hat, Inc. 
>          1801 Varsity Dr.
>          Raleigh, NC 27606
>   
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Juergen "George" Sawinski
Max-Planck Institute for Medical Research
Dept. of Biomedical Optics
Jahnstr. 29
D-69120 Heidelberg
Germany

Phone:  +49-6221-486-308
Fax:    +49-6221-486-325

priv.
Phone:  +49-6221-418 858
Mobile: +49-171-532 5302


