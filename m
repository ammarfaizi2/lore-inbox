Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276445AbRJYVep>; Thu, 25 Oct 2001 17:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276444AbRJYVef>; Thu, 25 Oct 2001 17:34:35 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:34572 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S276430AbRJYVe0>; Thu, 25 Oct 2001 17:34:26 -0400
From: "Rob Turk" <r.turk@chello.nl>
Subject: Re: [RFC] New Driver Model for 2.5
Date: Thu, 25 Oct 2001 23:32:17 +0200
Organization: Cistron Internet Services B.V.
Message-ID: <9ra0i5$dj0$1@ncc1701.cistron.net>
In-Reply-To: <20011024130408.23754@smtp.adsl.oleane.com> <Pine.LNX.4.33.0110240901350.8049-100000@penguin.transmeta.com> <9r8icv$ukh$1@ncc1701.cistron.net> <20011025235935.B10358@elf.ucw.cz>
X-Trace: ncc1701.cistron.net 1004045701 13920 213.46.44.164 (25 Oct 2001 21:35:01 GMT)
X-Complaints-To: abuse@cistron.nl
X-Priority: 3
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"Pavel Machek" <pavel@suse.cz> wrote in message
news:cistron.20011025235935.B10358@elf.ucw.cz...
> Hi!
>
> > > The act of "suspend" should basically be: shut off the SCSI controller,
> > > screw all devices, reset the bus on resume.
> > >
> >
> > Doing so will create havoc on sequential devices, such as tape drives. If
> > your system simply suspends, then all is well. Any data that isn't flushed
> > yet is buffered inside the tapedrive. But when the system resumes and resets
> > the SCSI bus, it will cause all data in the tape drive to be lost, and for
> > most tape systems it will also re-position them at LBOT. Any running
> > tar/dump/whatever tape process would not survive such a suspend-resume
> > cycle.
>
> Then there's something wrong with st.
>
> Imagine EMI comes and SCSI gets reset. That should not mean tar
> failing, right? So you have st broken in first place.
> Pavel
> --
No, it's an inherant part of the SCSI spec. A SCSI bus reset will cause many, if
not all tape devices to rewind to begin of tape. The st driver can detect this
(A SCSI Unit Attention will be returned on the next SCSI command), and try to
re-position the tape to it's previous location. Doing so is not easy, and on
many tape drives even impractical. On an almost full tape, a DLT drive would
take up to two hours to get back to where it last was. Too much for most
time-out mechanisms...

On a SCSI bus reset, tape related processes are better off passing the condition
upward to user space (tar, dump, whatever). Intelligent user space programs may
be able to recover, the dumb ones will fail.

By the way, EMI is very unlikely to cause a SCSI bus reset. It may cause
repeated parity errorsto the point that a host or devices decides to reset the
bus. If there's this much EMI, then you should use a better transport (HVD SCSI,
or fibre). But this part of the discussion is probably better helt at
comp.periphs.scsi 8-)

Rob




