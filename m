Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318945AbSH1QD3>; Wed, 28 Aug 2002 12:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318946AbSH1QD3>; Wed, 28 Aug 2002 12:03:29 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:46842 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S318945AbSH1QD2>; Wed, 28 Aug 2002 12:03:28 -0400
Date: Wed, 28 Aug 2002 12:07:46 -0400
From: Doug Ledford <dledford@redhat.com>
To: Juergen Sawinski <juergen.sawinski@mpimf-heidelberg.mpg.de>
Cc: "linux-kernel@vger" <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.20-pre4-ac1: i810_audio broken
Message-ID: <20020828120746.D30777@redhat.com>
Mail-Followup-To: Juergen Sawinski <juergen.sawinski@mpimf-heidelberg.mpg.de>,
	"linux-kernel@vger" <linux-kernel@vger.kernel.org>
References: <200208271253.12192.pavenis@latnet.lv> <200208281004.07891.pavenis@latnet.lv> <1030539078.1454.8.camel@voyager> <200208281622.30303.pavenis@latnet.lv> <20020828112133.C30777@redhat.com> <1030549658.16619.20.camel@volans>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1030549658.16619.20.camel@volans>; from juergen.sawinski@mpimf-heidelberg.mpg.de on Wed, Aug 28, 2002 at 05:47:38PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2002 at 05:47:38PM +0200, Juergen Sawinski wrote:
> I'll check the CIV read-only thing with ICH4 tonight (maybe I've
> overseen some doc errata or the manual is just lying). On the other
> hand, the CIV register is set to zero on reset (AFAICS), maybe a DMA
> engine reset sets CIV to 0 implicitly on ICH4.

It'e entirely possible that a DMA engine reset could reasonably set CIV to 
any of 0 (CIV = 0, offset 0), beginning of next SG segment (CIV + 1, 
offset = 0), beginning of current SG segment (CIV unchanged, offset = 0).  
I wasn't bothering to try and figure it out on each chip that we support, 
instead I was just calling a reset to make the hardware stop everything 
and get back to a sane state, then I would set the actual value to where 
ever we wanted it to be.  In most cases, that was either CIV + 1, offset = 
0 or CIV = 0, offset = 0.  However, that was really only a convenience, 
not a requirement.

> But if CIV is really RO, I could add a CAP_CIV_RO define to the card_cap
> struct. Then I'd only have to set LVI appropialty to CIV... hmmm....
> *sigh*

No, I wouldn't do this.  If there are some chips now that have a read only 
CIV, then no big deal.  We change the DMA engine to treat all chips as 
having a read only CIV and then we don't bother needing to know which ones 
have which capability and we only need one DMA engine to drive all chips, 
problem solved.

> BTW, sound is working perfectly on my machine (ICH4).

Well, that could just be luck ;-)  The particular sound problem that 
Andris is seeing is related to DMA start and stop operations.  If you 
happen to be using an artsd or esd daemon that is configured to DMA 
silence when there isn't anything else going on, then DMA on your machine 
would *not* be starting and stopping and you wouldn't see this problem.  
That's why my standard battery of tests includes using play from the 
command line without X running at all since it actually starts and stops 
the DMA with each operation and does lots of drain_dac() calls.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
