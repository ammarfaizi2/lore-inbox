Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280725AbRLWM0C>; Sun, 23 Dec 2001 07:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286881AbRLWMZu>; Sun, 23 Dec 2001 07:25:50 -0500
Received: from oe29.law9.hotmail.com ([64.4.8.86]:51983 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S286876AbRLWMZc>;
	Sun, 23 Dec 2001 07:25:32 -0500
X-Originating-IP: [66.108.21.174]
From: "T. A." <tkhoadfdsaf@hotmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Andrew Morton" <akpm@zip.com.au>
In-Reply-To: <87d71s7u6e.fsf@bitch.localnet> <Pine.LNX.4.10.10112222312030.8976-100000@master.linux-ide.org> <3C258D76.BE259944@zip.com.au>
Subject: Re: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Date: Sat, 22 Dec 2001 15:25:19 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <OE29Pukg3nOpj53XaDF00007a5c@hotmail.com>
X-OriginalArrivalTime: 23 Dec 2001 12:25:27.0171 (UTC) FILETIME=[E7256D30:01C18BAC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Well I would find this feature useful.  If I'm writing a file to a disk
I kind of would like the system to try its best to make sure the data get
written.  If the filesystem encounters a bad sector then by all means, mark
the block as bad and write the data over to a good area of the disk.  DOS
was able to do this, not sure about Windows, would be nice if Linux did as
well.  Also from what I've seen in the current way things are done, at least
the last time I encountered a bad sector, its pretty bad.  Many times it
isn't just one file that's lost to the wind for the system continuously
tried to write to that bad sector until you get a chance to take that disk
offline and run e2fsck with the -c option to mark off the block as bad.  And
even then the problem is even worse as sometimes a sector only fails part of
the time.  So running the -c option on a disk may not get all the errors on
one pass and if you run it again previously marked bad sectors would not get
reflagged.

    As for using fsync() you can't guarantee all programmers will use it.
As for when the bad sectors are being found many times a bad sector may not
be found until a write is attempted.  And if a bad sector is found during a
read, well its obvious the system can't restore data that has already been
lost and its time to head for the backups.  Just because you can't recover
form a read error doesn't mean you shouldn't recover from a write error if
you could.

    This feature could definitely be used for one very useful feature.  A
verify option.  This used to exist on DOS in which the system would read the
cluster after it wrote it, thus verifying that the data was written
successfully to the disk.  This feature was removed in Windows and never
existed in DOS.  Strangely enough I never had a problem of losing data when
writing to a floppy in DOS.  In both Windows and Linux I have found it quite
common to write stuff to a floppy, then try using that floppy only to find
that the floppy apparently had bad sectors and one or more files that I
thought had been written, weren't.

----- Original Message -----
From: "Andrew Morton" <akpm@zip.com.au>
To: "Andre Hedrick" <andre@linux-ide.org>
Cc: "Daniel Stodden" <stodden@in.tum.de>; <linux-kernel@vger.kernel.org>
Sent: Sunday, December 23, 2001 2:53 AM
Subject: Re: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }


> Andre Hedrick wrote:
> >
> > Daniel,
> >
> > Would it be great if Linux did not have such a lame design to handle the
> > these problems?  Just imaging if we had a properly formed
> > FS/BLOCK/MAIN-LOOP/LOW_LEVEL model; whereas, an error of this nature in
a
> > write to media failure could be passed back up the pathway to the FS and
> > request the FS to re-issue the storing of data to a new location.
> >
> > To bad the global design lacks this ablitity and I suspect that nobody
> > gives a damn, or even worse ever thought of this idea.
> >
> > Now the importance of model is not to promote the use of dying media,
but
> > to be able to secure the content in buffer-cache, from app.-space, or
> > user-space to the media and flag the UID(0) that we are in deep DOO-DOO
> > and you better start backing up the content now.
>
> For the filesystems with which I am familiar, this feature would
> be quite difficult to implement.  Quite difficult indeed.  And given
> that it only provides recovery for write errors, its value seems
> questionable.
>
> Much easier would be for those applications which really care about
> data integrity to fsync() the file before closing it.  If either of those
> calls returns an error, the *application* should take some form of
> action to preserve the data.   MTAs do this, for example.
>
> That being said, our propagation of I/O errors is a bit wobbly in places
> (and the loop device hides write IO errors completely).  But that's a
> separate issue.
>
> On this one, I would be more interested in the opinion of sophisticated
> *users* of linux rather than kernel developers, btw.  Whether this is
> a valuable feature.
>
>
> > I am just waiting to rip somebody's lunch who disagrees with me on the
> > importance of data-recovery and relocation upon media failures.  Any
> > points claiming it is not important because the predictive nature of
> > device failure is unknown, should maybe ask an expert in the industry to
> > get you the answer.  So lets have some fun and light off a really good
> > flame war!
> >
>
> umm... Daniel's error was on a read.  The data is not, by definition,
> in memory.   It's gone.
>
>
> What percentage of disk errors occur on writes, as opposed to reads?
> If errors-on-writes preponderate then maybe you're on to something.
> But I don't think they do?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
