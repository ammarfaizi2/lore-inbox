Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261990AbSI3JuC>; Mon, 30 Sep 2002 05:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261991AbSI3JuC>; Mon, 30 Sep 2002 05:50:02 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:15884
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S261990AbSI3JuB>; Mon, 30 Sep 2002 05:50:01 -0400
Date: Mon, 30 Sep 2002 02:53:29 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Jens Axboe <axboe@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, james <jdickens@ameritech.net>,
       Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@pobox.com>,
       Larry Kessler <kessler@us.ibm.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       "Andrew V. Savochkin" <saw@saw.sw.com.sg>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Richard J Moore <richardj_moore@uk.ibm.com>
Subject: Re: v2.6 vs v3.0
In-Reply-To: <20020930075625.GH1014@suse.de>
Message-ID: <Pine.LNX.4.10.10209300235480.13669-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Sep 2002, Jens Axboe wrote:

> On Sun, Sep 29 2002, Alan Cox wrote:
> > On Sun, 2002-09-29 at 18:42, Linus Torvalds wrote:
> > > I can say that the IDE code is the same code that is in 2.4.x, so if 
> > > you're comfortable with 2.4.x wrt IDE, then you should be comfy with 
> > > 2.5.x too.
> > 
> > *NO*
> > 
> > The IDE code is the experimental code in 2.4-ac. It is _NOT_ the IDE
> > code in 2.4 and its a lot less tested. I don't think it has any
> > corruption bugs but it is most definitely not the base 2.4 code and has
> > plenty of non corruption bugs (PCMCIA hang, taskfile write hang, irq
> > blocking performance problems)
> 
> 2.5 at least does not have the taskfile hang, because I killed taskfile
> io.

Great :-/  Now that you have restored the "rq->wrq" aka working copy of
the request which in its past life under PIO only updated to block when
the entire request was completed.  So there are no partial completions
possible given the old method in the legacy path.

One of the issues Linus kick my can over was the "requirement" of partial
completeions.  What I need rom block is a way to know how much is
completed of the original total request.  So whatever value is the
original rq->nr_sectors assigned to "TF.2/HF.2" or nsector_offset(s),
needs to be carried in block and updated to reflect how much more is
remaining of this CDB task.

I do not care if you call it "rq->dumbass_accounting_for_andre", but
provide this dummy accounting variable in "struct request" and I will be
happy.  This has nothing to do with bio or bh segments from the kernel.
It is everything about device side accounting carried by block; whereas,
the ll_driver can use it to determine what or if there is to be another
interrupt.

Why are we getting lost interrupts?

Because there is a beautiful "data-block completion" v/s "immediate
interrupt assertion" race between the device and the kernel.  So please
provide a counter which can be used to determine where the interrupt
driven partial completion model the driver is wrt the device/request.

Jens, not asking for much.

Otherwise the ADMA/VDMA is not doable period.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

