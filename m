Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315168AbSFTPe2>; Thu, 20 Jun 2002 11:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315120AbSFTPe1>; Thu, 20 Jun 2002 11:34:27 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44549 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S312498AbSFTPeZ>; Thu, 20 Jun 2002 11:34:25 -0400
Date: Thu, 20 Jun 2002 08:34:40 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kurt Garloff <garloff@suse.de>
cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] /proc/scsi/map
In-Reply-To: <20020620112543.GD26376@gum01m.etpnet.phys.tue.nl>
Message-ID: <Pine.LNX.4.44.0206200816380.8012-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Jun 2002, Kurt Garloff wrote:
> >
> > I really despise this.
>
> Thanks for your feedback.

You're too polite for your own good ;)

> Actually, I think you want to address a different problem than I want to.
>
> I do believe that the scsi subsystem does not expose enough information for
> many things.
>
> Look at /proc/scsi/scsi: The information is useful for the reader who wants
> to know what devices he has and were found by the SCSI subsystem.

I would rephrase that as "the information is only useful to find devices
found by the SCSI midlayer".

And my point is that you don't make it any better. Your patch perpetuates
this lopsided world-view that people should care. THAT is the fundamental
part that I don't like, because it drags us down for the future.

And in the end, if that is the case, it doesn't _help_ if it is "useful"
or not from a maintenance standpoint. From a maintenance standpoint, a
SCSI-only interface is a total horror.

I will bet you that there are more IDE CD-RW's out there than there are
SCSI devices. The fact that people use ide-scsi to write to them is a
hopefully very temporary situation, and the command interface is going
to move to a higher layer.

At which point your SCSI-centric world-view now became a total failure, as
it no longer shows up most of the devices that can write CD's or DVD's any
more.

Sure, it will still continue to show "what devices were found by the SCSI
midlayer". But user applications will have to scan other stuff, and find
the IDE-specific stuff, and then whatever else is out there.

See the problem?

If, on the other hand, you try to take the bull by the horns and realize
that the notion of "searching for devices" has nothing to do with SCSI at
_all_, you may find yourself with more work on your hands, but on the
other hand, wouldn't it be just so _nice_ to be able to do

	find /devices -name cd-rw

to find all cd-rw's in the system? Does it work that way now? Absolutely
not. But most of the infrastructure is actually there today. Wouldn't it
be _nice_ if after the CD-writing app has found all cd-rw's, it just opens
them, and the kernel will automatically open the right device (whether it
is a scsi-generic one or a IDE one)?

(No, I'm not serious about the "cd-rw" name itself, I'm just making a
simple example).

> And completely useless for any program that wants to find a scanner,
> CD-Writer, ... as there is no connection to the high-level drivers attached
> to them.

I'm not disputing that.

However, I _am_ disputing that this should be done in some SCSI-centric
way that works for SCSI but nothing else.

When I want to find a CD-ROM, I don't want to worry about whether it is
IDE or SCSI. I would

> But I still think the SCSI subsystem should report which SCSI (low-level)
> device is mapped to what high-level driver.
> Would you accept a patch that adds a line like
>
> Host: scsi3 Channel: 00 Id: 12 Lun: 00
>   Vendor: IBM      Model: DPSS-336950N     Rev: S84D
>   Type:   Direct-Access                    ANSI SCSI revision: 03
>   Attached drivers: sg12(c:15:0c) sdf(b:08:50)
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> to /proc/scsi/scsi ?

That would be less offensive to me if only because it doesn't introduce a
_new_ interface that is SCSI-only, it only extends on an old one. It makes
no _technical_ difference, but I'd rather extend an old broken interface
than introduce a totally new broken interface.

> >  - is limited to a (arbitrary) subset of the disks in your system
>
> You mean all disks driven by the SCSI subsystem, right?

Yes. In particular, you miss the great majority of disks that way (IDE),
and you even miss SCSI disks that are behind controllers where the driver
writer refused to use the mid-layer.

For CD burning, you may be of the opinion that everything - including IDE
- _has_ to be SCSI layer anyway (because that is how it is right now), but
that is not going to be the case all that much longer, I hope.

> >  - has completely bogus information about "location" that has nothing to
> >    do with real life, yet pruports to be an "address" even though it
> >    obviously isn't.
>
> The CBTU tuple uniquely addresses a SCSI device in a running system.

Yes, but that's not enough. Other people are still asking for physical
location, so let's try to fix two things with _one_ generic interface that
is at least agnostic to how a device is connected to the kernel..

		Linus

