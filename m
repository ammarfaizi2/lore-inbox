Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbVC2XXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbVC2XXu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 18:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbVC2XWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 18:22:07 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:26292 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261635AbVC2XVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 18:21:38 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: dtor_core@ameritech.net
Subject: Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Date: Wed, 30 Mar 2005 01:19:00 +0200
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@suse.cz>, Stefan Seyfried <seife@suse.de>,
       Andy Isaacson <adi@hexapodia.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
References: <20050323184919.GA23486@hexapodia.org> <20050325154237.GB3738@elf.ucw.cz> <d120d5000503250804176343f9@mail.gmail.com>
In-Reply-To: <d120d5000503250804176343f9@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200503300119.01015.rjw@sisk.pl>
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday, 25 of March 2005 17:04, Dmitry Torokhov wrote:
> On Fri, 25 Mar 2005 16:42:37 +0100, Pavel Machek <pavel@suse.cz> wrote:
> > Hi!
> > 
> > > > > This is more of a general swsusp problem I believe - the second phase
> > > > > when it blindly resumes entire system. Resume of a device can fail
> > > > > (any reason whatsoever) and it will attempt to clean up after itself,
> > > > > but userspace is dead and hotplug never completes. While I am
> > > > > interested to know why ALPS does not want to resume on ANdy's laptop
> > > > > the issue will never be completely resolved from within the input
> > > > > system.
> > > >
> > > > When device fails to resume, what should I do? I think I could
> > > >
> > > >        if (error)
> > > >                panic("Device resume failed\n");
> > > >
> > > > , but... that does not look like what you want.
> > >
> > > Oh, always panic-happy Pavel ;). It really depends on what kind of
> > > device has faled to resume. If the device is really needed for writing
> > > image then panic is the only recourse, but if it some other device you
> > > resuming just ignore it, who cares...
> > 
> > You are right, for resume-during-suspend, we may as well risk it. We
> > have consistent state, and if we happen to write it on disk,
> > everything is okay.
> > 
> > For resume-during-resume, I don't really know how we can handle
> > that. Running with some devices non-working seems dangerous to me.
> >
> 
> I think it again varies, and the driver would have to decide what to
> do if it can not resume hardware.

Well, I don't think that the driver would be able to state that its failure
is "serious enough", for example, to panic().  This is only known to the
higher-level code that calls the driver's _resume() routine.  IMO the driver
should not make any assumptions of its importance (eg a SCSI driver
that panic()s, because it's unable to resume a disk which does not
even contain a mounted partition is not a good idea ;-)).

> Take for example USB - i believe USB 
> guys are shooting at being able to disconnect device while the box is
> suspended and have it removed from the system when resuming. In
> Probably every driver that has even a slighest notion of
> hot-pluggability should just properly clean up after itself and not
> signal error to the core.

Unless, for instance, one of its devices contains the root filesystem.
  
> > > Btw, I dont think that doing selective resume (as opposed to selective
> > > suspend and Nigel's partial device trees) would be so much
> > > complicated. You'd always resume sysdevs and then, when iterating over
> > > "normal" devices, just skip ones not in resume path. It can all be
> > > contained in driver core I believe (sorry but no patch, for now at
> > > least).
> > 
> > :-) I think we can simply make device freeze/unfreeze fast enough.
> > [We do not need to do full suspend/resume; freeze is enough].

If the driver is compiled as a module, its devices may be uninitialized
when its _resume() routine is called (eg in the resume-during-resume).
Hence, IMHO, we can forget the "unfreeze" thing until we can differentiate
the resume-during-suspend from the resume-during-resume etc. ...

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
