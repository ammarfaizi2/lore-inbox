Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbVCYQEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVCYQEd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 11:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbVCYQEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 11:04:33 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:62138 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261682AbVCYQEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 11:04:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=T6Ln6jrU8t/mKXNZJogdFyqB4tr2G4Cmr00rODpxJ0uKyJWQbHDElTQJZb53Y1q4XX7InM1JlnjdcnVLVuGZpPi3hn8cBPBTWaeEsATjncDDwf2JefSlLH529H67LR+wcywrzIxalYGY13zqWRQezW499EbhWBysonavoto0X3E=
Message-ID: <d120d5000503250804176343f9@mail.gmail.com>
Date: Fri, 25 Mar 2005 11:04:24 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Pavel Machek <pavel@suse.cz>
Subject: Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Cc: Stefan Seyfried <seife@suse.de>, Andy Isaacson <adi@hexapodia.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <20050325154237.GB3738@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050323184919.GA23486@hexapodia.org>
	 <20050324181059.GA18490@hexapodia.org> <4243252D.6090206@suse.de>
	 <20050324235439.GA27902@hexapodia.org> <4243D854.2010506@suse.de>
	 <20050325101344.GA1297@elf.ucw.cz>
	 <d120d500050325061963fb13db@mail.gmail.com>
	 <20050325142414.GF23602@elf.ucw.cz>
	 <d120d50005032506526f6b9304@mail.gmail.com>
	 <20050325154237.GB3738@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Mar 2005 16:42:37 +0100, Pavel Machek <pavel@suse.cz> wrote:
> Hi!
> 
> > > > This is more of a general swsusp problem I believe - the second phase
> > > > when it blindly resumes entire system. Resume of a device can fail
> > > > (any reason whatsoever) and it will attempt to clean up after itself,
> > > > but userspace is dead and hotplug never completes. While I am
> > > > interested to know why ALPS does not want to resume on ANdy's laptop
> > > > the issue will never be completely resolved from within the input
> > > > system.
> > >
> > > When device fails to resume, what should I do? I think I could
> > >
> > >        if (error)
> > >                panic("Device resume failed\n");
> > >
> > > , but... that does not look like what you want.
> >
> > Oh, always panic-happy Pavel ;). It really depends on what kind of
> > device has faled to resume. If the device is really needed for writing
> > image then panic is the only recourse, but if it some other device you
> > resuming just ignore it, who cares...
> 
> You are right, for resume-during-suspend, we may as well risk it. We
> have consistent state, and if we happen to write it on disk,
> everything is okay.
> 
> For resume-during-resume, I don't really know how we can handle
> that. Running with some devices non-working seems dangerous to me.
>

I think it again varies, and the driver would have to decide what to
do if it can not resume hardware. Take for example USB - i believe USB
guys are shooting at being able to disconnect device while the box is
suspended and have it removed from the system when resuming. In
Probably every driver that has even a slighest notion of
hot-pluggability should just properly clean up after itself and not
signal error to the core.
 
> > Btw, I dont think that doing selective resume (as opposed to selective
> > suspend and Nigel's partial device trees) would be so much
> > complicated. You'd always resume sysdevs and then, when iterating over
> > "normal" devices, just skip ones not in resume path. It can all be
> > contained in driver core I believe (sorry but no patch, for now at
> > least).
> 
> :-) I think we can simply make device freeze/unfreeze fast enough.
> [We do not need to do full suspend/resume; freeze is enough].

It is not suspend/freeze here that gets us but resume and with resume
the driver (at least for now) does not have any idea if it is
"unfreeze" or "full-resume". I mean I could have serio just ignore
"unfreeze" requests (as I doubt anyone would ever try to suspend over
PS/2 port ;) ) but I think it should be really handled by the core.

-- 
Dmitry
