Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271503AbRHTR1V>; Mon, 20 Aug 2001 13:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271473AbRHTR1M>; Mon, 20 Aug 2001 13:27:12 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:45303 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S271478AbRHTR1B>; Mon, 20 Aug 2001 13:27:01 -0400
Message-ID: <3B81350C.E48FCF11@mvista.com>
Date: Mon, 20 Aug 2001 09:04:28 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: chuckw@ieee.org
CC: linux-kernel@vger.kernel.org
Subject: Re: Looking for comments on Bottom-Half/Tasklet/SoftIRQ
In-Reply-To: <20010818231704.A2388@ieee.org> <3B7FF06A.4090606@fugmann.dhs.org> <20010819013508.B2388@ieee.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chuckw@ieee.org wrote:
> 
> Thanks.
> 
>         So, Bottom halves don't need to be re-entrant as do tasklets.  SoftIRQ's
> need to be re-entrant.  The advantage of tasklets is that each tasklet can
> be farmed out to different CPU's AND they don't need to be re-entrant
> because only one instance is allowed at a time.  I think I got it.
> 
>         Could you direct me to some code in the kernel which uses tasklets
> so I can see the inner workings?
> 
> Thanks much,
> Chuck
> 
> On Sun, Aug 19, 2001 at 06:59:22PM +0200, Anders Peter Fugmann wrote:
> >
> > chuckw@ieee.org wrote:
> > > Greetings,
> > >     I was reading the unreliable guide to kernel hacking and was looking for
> > > a little clarification on something.  2 Bottom halves cannot run at the same
> > > time, why?
> >
> > Per linux definition of bottom halves, there can only run one buttom
> > half at one system wide. But dont use those - They are old and waists
> > resources. Try tasklets instead. Multible tasklets can run in parrallel
> > (but not the same tasklet)
> >
> > >     Also, could someone give me an example of a service which is a bottom half/
> > > tasklet/SoftIRQ?
> > Simple.
> >
> > Imagine some hardware that generates interrupts.
> > Now we want to write a driver that keeps the hardware busy, so we
> > implement a top half handler (IRQ-handler), and let it retrieve som data
> > from the hardware. Instead of processing it right away, we shedule a
> > tasklet to do that job. This way we can handle more interrupts/sec from
> > the card, and the hardware is kept busy.
> >
> >
> > To summerize.
> > Buttom halves are the strictest (only one at a time.)
> > Takslets can run in parralel, but still no need to worry about reentrant
> > code.
> > SoftIrq give no guarrentee at all, and should be used with great care
> > (code need to be reentrant).
> >
> > Also try to readLinux device drivers by  A. Rubini:
> > http://www.xml.com/ldd/chapter/book/index.html
> >
> > Hope it helps.
> > Anders Fugmann
> >
> > >

A simple example is the ../kernel/timer.c code.  The "run_task_list()"
function is called from a tasklet.  "do_timer()" is called from
interrupt and "mark_bh(TIMER_BH)" puts the tasklet in the queue. 
"timer_bh()" (old names die hard) is the tasklet.

George
