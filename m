Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318862AbSH1PRS>; Wed, 28 Aug 2002 11:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318864AbSH1PRS>; Wed, 28 Aug 2002 11:17:18 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:39644 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S318862AbSH1PRR>; Wed, 28 Aug 2002 11:17:17 -0400
Date: Wed, 28 Aug 2002 11:21:33 -0400
From: Doug Ledford <dledford@redhat.com>
To: Andris Pavenis <pavenis@latnet.lv>
Cc: Juergen Sawinski <juergen.sawinski@mpimf-heidelberg.mpg.de>,
       "linux-kernel@vger" <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.20-pre4-ac1: i810_audio broken
Message-ID: <20020828112133.C30777@redhat.com>
Mail-Followup-To: Andris Pavenis <pavenis@latnet.lv>,
	Juergen Sawinski <juergen.sawinski@mpimf-heidelberg.mpg.de>,
	"linux-kernel@vger" <linux-kernel@vger.kernel.org>
References: <200208271253.12192.pavenis@latnet.lv> <200208281004.07891.pavenis@latnet.lv> <1030539078.1454.8.camel@voyager> <200208281622.30303.pavenis@latnet.lv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208281622.30303.pavenis@latnet.lv>; from pavenis@latnet.lv on Wed, Aug 28, 2002 at 04:22:30PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2002 at 04:22:30PM +0300, Andris Pavenis wrote:
> On Wednesday 28 August 2002 15:51, Juergen Sawinski wrote:
> > Can you drop in the old (working) source into the new tree and see if
> > that works? If that works I'll try making a step by step patch series,
> > to see what breaks it.
> 
> Today's tests were done in that way (I only replaced i810_audio.c,
> removed i810_audio.o, run 'make modules' and 'make modules_install' and tested 
> the results). As I wrote earlier it seems that Dough's patch (to 
> 2.4.20-pre1-ac2) broke driver

(In an email Juergen sent to me privately he mentioned that on the ICH4 
the CIV register is now read-only where as on previous ICH chips it was 
read-write, which is something I missed as far as changes to the chip are 
concerned)

Now, given the tidbit of information above, I would expect ICH4 chipsets 
to break with the driver.  We currently rely upon the ability to set the 
CIV register to what we want in order to start the DMA where we want.  If 
that's now readonly, I'll have to rethink how I reset the DMA hardware and 
how I will have to start recording the new DMA position instead of setting 
the new DMA position.  The one thing about this though, I would expect 
this issue to cause previously non-working ICH4 chips to work poorly with 
my patch instead of previously working ICH4 chips to now start working 
poorly since my patch didn't change the (/me stops mid-sentence and 
realizes that "yes, in fact there is a change in my patch to base DMA 
operations that could cause this").  Hmmm...backup....try backing out my 
changes to stop_dac and stop_adc (the part where I change how we do a DMA 
engine reset every time we stop the dac and adc) and see if that solves 
your problem.  The changes to __stop_dac() and __stop_adc() are localized 
actually and you should be able to safely leave all of those hunks out 
without effecting the rest of the patch.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
