Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279788AbRKAVY2>; Thu, 1 Nov 2001 16:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279787AbRKAVYK>; Thu, 1 Nov 2001 16:24:10 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:5649 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S279786AbRKAVXt>; Thu, 1 Nov 2001 16:23:49 -0500
Message-ID: <014a01c1631b$555141e0$f5976dcf@nwfs>
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>,
        "Kai Makisara" <Kai.Makisara@kolumbus.fi>,
        "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: "Rob Turk" <r.turk@chello.nl>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0110271345110.1089-100000@kai.makisara.local> <005901c15f27$0facca30$f5976dcf@nwfs>
Subject: Re: SCSI Tape Device FATAL error on 2.4.10
Date: Thu, 1 Nov 2001 14:22:37 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kai,

I've managed to get ot the bottom of this problem, and it may be something
to annotate
your code to look for in the future.  The newer Exabyte tape drives have
enabled a
rather clever feature which provides auto-cleaning capability for certain
types of tapes.
The tapes we are using are of this type (unknown to me until we did some
checking).

These 150GB tapes have at one end of the tape a spliced section of cleaning
tape actually
spliced onto the end of the data portion of the tape.  When the drive
detects a media error,
the tape is forwarded or rewound to hit this cleaning portion and srubs the
heads of the
tape drive.   What was happening is our software was assuming this tape
section was valid,
and attempting to write to the cleaning tape portion, which for obvious
reasons, was resulting
in some very interesting errors in Linux 2.4 including a few Oops we were
able to reliably
generate in both the st module and the AIC7XXX driver. :-)

What we are doing now is disabling this feature (if enabled) on the tape
drives, and doing
a more rigorous check of the media to detect which tapes have these cleaning
segments
spliced into the data portion of the tape cassettes.  The SCSI mode page
settings command
do not seem to describe how to disble this from SCSI.  At present, we have
disabled it
on the devices so they do not rewind and retension and autoclean when an
error is detected
on the media.  What's more troublesome is detecting when you are hitting a
cleaning
section of the tape, but we have done a workaround that seems to work.

You may want to annotate this as a feature to deal with at some future date.

Jeff


----- Original Message -----
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
To: "Kai Makisara" <Kai.Makisara@kolumbus.fi>; "Jeff V. Merkey"
<jmerkey@vger.timpanogas.org>
Cc: "Rob Turk" <r.turk@chello.nl>; <linux-scsi@vger.kernel.org>
Sent: Saturday, October 27, 2001 1:36 PM
Subject: Re: SCSI Tape Device FATAL error on 2.4.10


> Thanks Kai,
>
> I will attempt to get more info on the problem.  I will confine this
thread
> to this
> list.  Please let me know what actions you wish me to take and what
specific
> information you would like for me to obtain for you.
>
> :-)
>
> Jeff
>
> ----- Original Message -----
> From: "Kai Makisara" <Kai.Makisara@kolumbus.fi>
> To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
> Cc: "Rob Turk" <r.turk@chello.nl>; <linux-scsi@vger.kernel.org>
> Sent: Saturday, October 27, 2001 5:02 AM
> Subject: Re: SCSI Tape Device FATAL error on 2.4.10

> > On Fri, 26 Oct 2001, Jeff V. Merkey wrote:
> >
> > > On Fri, Oct 26, 2001 at 02:00:56PM +0200, Rob Turk wrote:
> > > > "Jeff V. Merkey" <jmerkey@vger.timpanogas.org> wrote in message
> > > > news:cistron.20011025124036.A11885@vger.timpanogas.org...
> > > > >
> > > > >
> > > > > On a ServerWorks HE Chipset system with an Exabyte EXB-480
> > > > > Robotics Tape library we are seeing a fatal SCSI IO problem
> > > > > that results in a SCSI bus hang on the system.  This error
> > > > > is very fatal, and requires that the machine be rebooted
> > > > > to recover.   Following this error, the Linux
> > > > > Operating System is still running OK, but the affected
> > > > > SCSI bus does not respond to any commands nor do any
> > > > > devices attached to this bus.
> > > > >
> > > > > The Tape Drive is an Exabyte SCSI Tape.  The error occurs when
> > > > > the device reaches end of tape (EOT) during a write operation
> > > > > while writing to the tape.
> > > > >
> > > > > With tape programming, there really is no good way to know where
> > > > > the end of tape is while archiving data real time, so this error
> > > > > is pretty much fatal.  We are using tape partitioning, which we
> > > > > have noticed not many applications in Linux use at present, so
> > > > > these code paths may be related to the problem.  I have reviewed
> > > > > st.c but it is not readily apparent where the problem may be
> > > > > in this code, which is leading me to suspect it's related to
> > > > > some interaction between st.c and the drivers with regard to
> > > > > multiple seeks and writes between tape partitions.
> > > > >
> > > >
> > > > Jeff,
> > > >
> > > > Logical end-of-tape handling is clearly defined in Exabyte's SCSI
> reference
> > > > manual which you can download from their web page. There's nothing
> fatal
> > > > about it, your application should handle it. The SCSI Write command
> that
> > > > reaches logical end-of-tape (or end-of-partition) will end with a
> Check
> > > > condition, Sense key 0h, ASC=00h, ASCQ=00h, EOM bit = 1. Your data
> will be
> > > > written to tape just fine. There is plenty of tape left so you can
> > > > gracefully write a delimiting filemark or whatever you need to close
> the
> > > > current data set. All write commands after reaching LEOT will also
> result in
> > > > a Check Condition with the above sense information (until you really
> run out
> > > > of tape). It's a Logical end-of-tape you deal with, not a Physical
> one.
> > > >
> > > > As a side note, make sure you have the latest firmware loaded in
your
> M2
> > > > drives.
> > > >
> > > > Rob
> > > >
> > >
> > > I am using st.o and it is not handling this condition correctly under
> > > Linux.  It has nothing to do with your firmware.  I am programming
> > > the robot directly over SCSI, but I am going through the Linux tape
> support
> > > module st.c for tape drive support.  When this error occurs, the
> > > entire SCSI bus gets hosed in some of the failure cases.   Sounds like
> > > I need to submit a patch to st.c
> > >
> > I have done tests with two different tape drives (although both from HP)
> > using writes and seeks with tapes having two partitions but I have not
> > been able to duplicate any SCSI bus hangs. Another difference in my
tests
> > is that I have a SYM53C896 SCSI adapter using the kernel sym-driver.
> >
> > As Rob said, reaching EOM early warning is a common thing with tapes. If
> > the sense data has the EOM bit set, the st driver checks if the write
has
> > successfully completed or failed and sets the return value accordingly.
> >
> > Using multiple partitions does not change the code paths much because
the
> > different partitions behave like separate tapes.
> >
> > So, there is no fundamental problem that affects all configurations in
EOM
> > processing in st. Something special in your situation triggers a
problem.
> >
> > Have you looked at where the process using the tape is hanging? My guess
> > is down_wait. This probably means that the tape driver has sent a
command
> > to the middle level SCSI driver and is waiting for the command to
finish.
> > You might get some useful information if you wait until the timeout
> > triggers and see if the SCSI subsystem recovers and print some useful
> > messages. The wait can be made shorter if you adjust the timeouts (can
be
> > done with the mt commands 'mt sttimeout' and 'mt stlongtimeout'.
> >
> > Kai
> >

