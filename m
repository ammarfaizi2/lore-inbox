Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279737AbRJYI1P>; Thu, 25 Oct 2001 04:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279728AbRJYI04>; Thu, 25 Oct 2001 04:26:56 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:8709 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S279726AbRJYI0h>; Thu, 25 Oct 2001 04:26:37 -0400
From: "Rob Turk" <r.turk@chello.nl>
Subject: Re: [RFC] New Driver Model for 2.5
Date: Thu, 25 Oct 2001 10:27:11 +0200
Organization: Cistron Internet Services B.V.
Message-ID: <9r8icv$ukh$1@ncc1701.cistron.net>
In-Reply-To: <20011024130408.23754@smtp.adsl.oleane.com> <Pine.LNX.4.33.0110240901350.8049-100000@penguin.transmeta.com>
X-Trace: ncc1701.cistron.net 1003998432 31377 193.78.180.30 (25 Oct 2001 08:27:12 GMT)
X-Complaints-To: abuse@cistron.nl
X-Priority: 3
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Linus Torvalds" <torvalds@transmeta.com> wrote in message
news:cistron.Pine.LNX.4.33.0110240901350.8049-100000@penguin.transmeta.com..
.
>
> On Wed, 24 Oct 2001, Benjamin Herrenschmidt wrote:
> > >
> > >So the scsi devices hang off sd, sr etc which in turn hang off scsi and
> > >the controllers hang off scsi (and or the bus layers)
> > >
> > >This one at least I think I do understand
> >
> > The problem with subsystems is that they don't fit well in the
> > power tree. They aren't "devices" in that sense that they are
> > not exposing a struct device, and they spawn over several controllers
> > which means the dependency can quickly become unmanageable, especially
> > when SCSI starts beeing layered on top of USB or FireWire.
>
> Why would you _ever_ get "sg.c" and other crap involved in the suspend
> process?
>
> The device tree is for _device_ suspend, not for "subsystem suspend". The
> SCSI subsystem is a piece of cr*p, but even if it was perfect it should
> never get involved with the act of suspension.
>
> We should not have pending IO, but that's for a totally different reason:
> the first thing the much much MUCH higher levels of suspend should be
> doing is to make sure that user apps are "quiescent". And that isn't done
> by getting involved with sg.c or anything similar, but by basically
> stopping all user apps (think of the equivalent of a "kill -STOP -1", but
> done internally in the kernel without actually using a signal).
>
> > Also, the dependency issue is made worst if you let RAID enter into
> > the dance as I beleive ultimately, nothing would prevent a volume to
> > spawn over several devices from different controllers or even different
> > controller types.
>
> Why would you get RAID involved? There is no _IO_ involved in suspending:
> we just stop doing what we're doing, and leave it at that. We don't try to
> flush state, we just freeze the machine.
>
> The act of "suspend" should basically be: shut off the SCSI controller,
> screw all devices, reset the bus on resume.
>

Doing so will create havoc on sequential devices, such as tape drives. If
your system simply suspends, then all is well. Any data that isn't flushed
yet is buffered inside the tapedrive. But when the system resumes and resets
the SCSI bus, it will cause all data in the tape drive to be lost, and for
most tape systems it will also re-position them at LBOT. Any running
tar/dump/whatever tape process would not survive such a suspend-resume
cycle.

Another more subtle issue is state information that exists between the SCSI
controller and the target devices. At some point they might have negotiated
synchronous and/or wide transfer parameters. This information must be
preserved, or you'll observe lockups, data corruption and the likes. Since
these parameters are maintained at the lowest driver level, they should know
about suspend. The low-level driver must know to re-negotiate these
parameters when it comes back to life.

Rob





