Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281863AbRLWWJv>; Sun, 23 Dec 2001 17:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282081AbRLWWJl>; Sun, 23 Dec 2001 17:09:41 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:59141
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S281863AbRLWWJ1>; Sun, 23 Dec 2001 17:09:27 -0500
Date: Sun, 23 Dec 2001 14:08:26 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Daniel Stodden <stodden@in.tum.de>, linux-kernel@vger.kernel.org
Subject: Re: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
In-Reply-To: <E16I8j1-0000ah-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10112231200500.12646-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Dec 2001, Alan Cox wrote:

> > I am just waiting to rip somebody's lunch who disagrees with me on the
> > importance of data-recovery and relocation upon media failures.  Any
> > points claiming it is not important because the predictive nature of
> > device failure is unknown, should maybe ask an expert in the industry to
> > get you the answer.  So lets have some fun and light off a really good
> > flame war!
> 
> Why do you want to pass it up to the file system, when the fs probably
> doesn't know what to do about it ? I can see why you want to pass it back
> as far up as you can until someone claims it.

Well that is a design flaw in the general FS models from the beginning,
and it should be fixed.  I recall everyone drum banging SCSI because it
could hand this problem, and surprize it fails too.  So it come back to
the FS being responsible to force the completetion of it requests
regardless of the overhead.

> Or are you assuming in most cases file systems would have an "io_failure"
> function that reissues the request a few times then marks the fs read only
> and screams ?

Now that is a sensible solution, but I do not know if it would work in all
cases or how best it should be handled.  Regardless, the responsiblity of
the content is primarily the FS.  Should an APP close a file but it is
still in buffer_cache, there is no way to notify the app or the user or
anything associated with the creation/closing of that file, if a write
error occurs.

So we have user-space believing it is success.
FS doing an initial ACK of success.
BLOCK generating the request to the low_level.
LOW_LEVEL goes OH CRAP, I am having a problem and can not complete.

LOW_LEVEL goes, HEY BLOCK we have a problem.
BLOCK, that is nice whatever ....

This is a bad model, an worse is

LOW_LEVEL goes, HEY BLOCK we have a problem.
BLOCK goes, HEY FS we have an annoying LOW_LEVEL asking for reissue.
FS, duh which way did the rabbit go ...

So what is the right answer, 'cause blackholing the file is wrong, and I
do not see a way for it to be reissued.  We should note the kernel now
owns the responsiblity of completion in this case; regardless, what other
think.

> Incidentally the EVMS IBM volume manager code does support bad block
> remapping in some situations.

Well managing badblock can be a major pain, but it is the right thing to
do.  Now what is the cost, since there is surge in journaling FS's that
have logs.  The cost is coming up w/ a sane way to manage the mess.
Even before we get to managing the mess, we have to be able to reissue the
request to a reallocated location, and make all kinds of noise that we are
doing heroic attempts to save the data.  These may include --

	periodic message bombing the open terminals.
	clearing all outstanding requests, and making RO (caution /)

The issue is we are doing nothing to address the point, and it is arrogant
for the maintainers of the various storage classes and the supported upper
layers not willing to address this issue.

This reply may seem a little fragmented because I had to answer it is
stages between distractions.

Regards,

Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project

