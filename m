Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288878AbSAUFps>; Mon, 21 Jan 2002 00:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289014AbSAUFpj>; Mon, 21 Jan 2002 00:45:39 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:43535
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S288878AbSAUFpa>; Mon, 21 Jan 2002 00:45:30 -0500
Date: Sun, 20 Jan 2002 20:40:07 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.3-pre1-aia1
Message-ID: <Pine.LNX.4.10.10201202038460.12376-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vger eats another one :-(
---------- Forwarded message ----------
Date: Sun, 20 Jan 2002 16:12:36 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Jens Axboe <axboe@suse.de>, Anton Altaparmakov <aia21@cam.ac.uk>,
     Linus Torvalds <torvalds@transmeta.com>,
     lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1

On Sun, 20 Jan 2002, Davide Libenzi wrote:

> On Sun, 20 Jan 2002, Jens Axboe wrote:
> 
> > On Sat, Jan 19 2002, Andre Hedrick wrote:
> > > > On Sat, Jan 19 2002, Andre Hedrick wrote:
> > > > > On Sat, 19 Jan 2002, Jens Axboe wrote:
> > > > >
> > > > > > On Fri, Jan 18 2002, Davide Libenzi wrote:
> > > > > > > Guys, instead of requiring an -m8 to every user that is observing this
> > > > > > > problem, isn't it better that you limit it inside the driver until things
> > > > > > > gets fixed ?
> > > > > >
> > > > > > There is no -m8 limit, 2.5.3-pre1 + ata253p1-2 patch handles any set
> > > > > > multi mode value.
> > > > > >
> > > > > > --
> > > > > > Jens Axboe
> > > > > >
> > > > >
> > > > > And that will generate the [lost interrupt], and I have it fixed at all
> > > > > levels too now.
> > > >
> > > > How so? I don't see the problem.
> > >
> > > Unlike ATAPI which will generally send you more data than requested on
> > > itw own, ATA devices do not like enjoy or play the game.  Additionally the
> >
> > Unrelated ATAPI fodder :-)
> >
> > > current code asks for 16 sectors, but we do not do the request copy
> > > anymore, and this mean for every 4k of paging we are soliciting for 8k.
> >
> > The (now) missing copy is unrelated.
> >
> > > We only read out 4k thus the device has the the next 4k we may be wanting
> > > ready.  Look at it as a dirty prefetch, but eventally the drive is going
> > > to want to go south, thus [lost interrupt]
> >
> > Even if the drive is programmed for 16 sectors in multi mode, it still
> > must honor lower transfer sizes. The fix I did was not to limit this,
> > but rather to only setup transfers for the amount of sectors in the
> > first chunk. This is indeed necessary now that we do not have a copy of
> > the request to fool around with.

Listen and for just a second okay.

Since the set multimode command is similar to the set transfer rate, if
you program the drive to run at U100 but the host can feed only U33 you
have problems.  Much of this simple arguement is the same answer for
multimode.

Same thing here but a variation, of the operations,

> > > Basically as the Block maintainer, you pointed out I am restricted to 4k
> > > chunking in PIO.  You decided, in the interest of the block glue layer
> > > into the driver, to force early end request per Linus's requirements to
> > > return back every 4k completed to block regardless of the size of the
> > > total data requested.
> >
> > Correct. The solution I did (which was one of the two I suggested) is
> > still the cleanest, IMHO.

The "cleanest" != techincal correctness, it may be the cleanest for
current infrastructure of BLOCK, but by no means is it techincally
correct.  It is more of the darwinism of hammer a square object into a
round hole.

> > > For the above two condition to be properly satisfied, I have to adjust
> > > and apply one driver policy make the driver behave and give the desired
> > > results.  We should note this will conform with future IDEMA proposals
> > > being submitted to the T committees.
> >
> > I still don't see a description of why this would cause a lost
> > interrupt. What is the flaw in my theory and/or code?

Because you think of the OS as defining the guidelines and the reality is
the hardware defines the rules and the OS has to work around.  I am happy
to allow you to continue to modify the ISR behavor and the command
behavor, and I am willing to be proven wrong.  When the problem does not
go away, I will request we return to the rules of the hardware.  And this
may require a MEMPOOL just like SCSI.

> Guys, i'm sorry to report you bad news but i still get 'lost interrupt'
> with all applied patches ( Anton and Andre ).

Regards,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development



