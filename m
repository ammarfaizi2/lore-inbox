Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288158AbSATKtW>; Sun, 20 Jan 2002 05:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288159AbSATKtM>; Sun, 20 Jan 2002 05:49:12 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:30475 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S288158AbSATKtI>;
	Sun, 20 Jan 2002 05:49:08 -0500
Date: Sun, 20 Jan 2002 11:48:50 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
Message-ID: <20020120114850.J27835@suse.de>
In-Reply-To: <20020119164503.H27835@suse.de> <Pine.LNX.4.10.10201191220060.7770-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10201191220060.7770-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19 2002, Andre Hedrick wrote:
> > On Sat, Jan 19 2002, Andre Hedrick wrote:
> > > On Sat, 19 Jan 2002, Jens Axboe wrote:
> > > 
> > > > On Fri, Jan 18 2002, Davide Libenzi wrote:
> > > > > Guys, instead of requiring an -m8 to every user that is observing this
> > > > > problem, isn't it better that you limit it inside the driver until things
> > > > > gets fixed ?
> > > > 
> > > > There is no -m8 limit, 2.5.3-pre1 + ata253p1-2 patch handles any set
> > > > multi mode value.
> > > > 
> > > > -- 
> > > > Jens Axboe
> > > > 
> > > 
> > > And that will generate the [lost interrupt], and I have it fixed at all
> > > levels too now.
> > 
> > How so? I don't see the problem.
> 
> Unlike ATAPI which will generally send you more data than requested on
> itw own, ATA devices do not like enjoy or play the game.  Additionally the

Unrelated ATAPI fodder :-)

> current code asks for 16 sectors, but we do not do the request copy
> anymore, and this mean for every 4k of paging we are soliciting for 8k.

The (now) missing copy is unrelated.

> We only read out 4k thus the device has the the next 4k we may be wanting
> ready.  Look at it as a dirty prefetch, but eventally the drive is going
> to want to go south, thus [lost interrupt]

Even if the drive is programmed for 16 sectors in multi mode, it still
must honor lower transfer sizes. The fix I did was not to limit this,
but rather to only setup transfers for the amount of sectors in the
first chunk. This is indeed necessary now that we do not have a copy of
the request to fool around with.

> Basically as the Block maintainer, you pointed out I am restricted to 4k
> chunking in PIO.  You decided, in the interest of the block glue layer
> into the driver, to force early end request per Linus's requirements to
> return back every 4k completed to block regardless of the size of the
> total data requested.

Correct. The solution I did (which was one of the two I suggested) is
still the cleanest, IMHO.

> For the above two condition to be properly satisfied, I have to adjust
> and apply one driver policy make the driver behave and give the desired
> results.  We should note this will conform with future IDEMA proposals
> being submitted to the T committees.

I still don't see a description of why this would cause a lost
interrupt. What is the flaw in my theory and/or code?

-- 
Jens Axboe

