Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284970AbSAUFra>; Mon, 21 Jan 2002 00:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289050AbSAUFrR>; Mon, 21 Jan 2002 00:47:17 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:43535
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S284970AbSAUFqx>; Mon, 21 Jan 2002 00:46:53 -0500
Date: Sun, 20 Jan 2002 17:48:29 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Jens Axboe <axboe@suse.de>
cc: Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
In-Reply-To: <20020120114850.J27835@suse.de>
Message-ID: <Pine.LNX.4.10.10201201717570.12376-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jan 2002, Jens Axboe wrote:

> On Sat, Jan 19 2002, Andre Hedrick wrote:
> > > On Sat, Jan 19 2002, Andre Hedrick wrote:
> > > > On Sat, 19 Jan 2002, Jens Axboe wrote:
> > > > 
> > > > > On Fri, Jan 18 2002, Davide Libenzi wrote:
> > > > > > Guys, instead of requiring an -m8 to every user that is observing this
> > > > > > problem, isn't it better that you limit it inside the driver until things
> > > > > > gets fixed ?
> > > > > 
> > > > > There is no -m8 limit, 2.5.3-pre1 + ata253p1-2 patch handles any set
> > > > > multi mode value.
> > > > > 
> > > > > -- 
> > > > > Jens Axboe
> > > > > 
> > > > 
> > > > And that will generate the [lost interrupt], and I have it fixed at all
> > > > levels too now.
> > > 
> > > How so? I don't see the problem.
> > 
> > Unlike ATAPI which will generally send you more data than requested on
> > itw own, ATA devices do not like enjoy or play the game.  Additionally the
> 
> Unrelated ATAPI fodder :-)
> 
> > current code asks for 16 sectors, but we do not do the request copy
> > anymore, and this mean for every 4k of paging we are soliciting for 8k.
> 
> The (now) missing copy is unrelated.
> 
> > We only read out 4k thus the device has the the next 4k we may be wanting
> > ready.  Look at it as a dirty prefetch, but eventally the drive is going
> > to want to go south, thus [lost interrupt]
> 
> Even if the drive is programmed for 16 sectors in multi mode, it still
> must honor lower transfer sizes. The fix I did was not to limit this,
> but rather to only setup transfers for the amount of sectors in the
> first chunk. This is indeed necessary now that we do not have a copy of
> the request to fool around with.
> 
> > Basically as the Block maintainer, you pointed out I am restricted to 4k
> > chunking in PIO.  You decided, in the interest of the block glue layer
> > into the driver, to force early end request per Linus's requirements to
> > return back every 4k completed to block regardless of the size of the
> > total data requested.
> 
> Correct. The solution I did (which was one of the two I suggested) is
> still the cleanest, IMHO.
> 
> > For the above two condition to be properly satisfied, I have to adjust
> > and apply one driver policy make the driver behave and give the desired
> > results.  We should note this will conform with future IDEMA proposals
> > being submitted to the T committees.
> 
> I still don't see a description of why this would cause a lost
> interrupt. What is the flaw in my theory and/or code?

We issue a setmultimode command and the driver defaults to maximum or 16
sectors in most cases.  This means the drive is expecting 16 sectors, and
your design is to issue only 8 sectors or less.  The issuing of 8 sectors
or less in the sector_count, while the device is expecting 16 is a setup
for problems.

The effective operations your changes have created without addressing all
the variables is to terminate the command in process.  Therefore, the
decision made by you was to restrict the transfers to be process to the
count in rq->current_nr_sectors.  There is no bounds checking based on the
command executed.

*****************************
The questions to ask "How would the host terminate a command in progress, 
since BSY=1 (or DRQ=1) at this point?   Is that done via a DEVICE_RESET or
SRST write?"

Let me quote "Hale Landis" (one of the Fathers of ATA).

On an ATA device a H/W Reset or S/W reset is required to terminate a
command in progress. Writing to the Command register while BSY=1 or
BSY=0:DRQ=1 is illegal.

On an ATAPI device a H/W Reset or S/W reset or DEVICE RESET is
required to terminate a command in progress (and that includes PACKET
commands). Writing a value other than 08H (DEVICE RESET) to the
Command register while BSY=1 or BSY=0:DRQ=1 is illegal.
*****************************

Now what you have created is an illegal operation.

If the device is expecting a fixed amount of data and you stop it in
mid-stream and do not reset the device and issue a second command for
transfer, expect the device to go south.

If we are going to operate in this mode of brokeness, then let me finish
the change to of the command structure to make the driver work in that
environment.

Regards,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development


