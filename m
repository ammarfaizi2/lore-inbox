Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWBCNq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWBCNq0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 08:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWBCNq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 08:46:26 -0500
Received: from uproxy.gmail.com ([66.249.92.207]:53740 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750782AbWBCNqZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 08:46:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=azCeYutd0ef8WwqL/2jRuAIiPkQGAOkTS+R3XLCh/S47rqD3Dx2psFF9fLid5ufS1h3ZtTOMF+dU81iulJrH5XdUnylG2QSUEop+P/Y9pEMZbGK3NaG3oQYH5FnMtdLYxUDLUfQ52yj3277tNc72m/oIDTwVyOAURVwQzWZZmD4=
Message-ID: <58cb370e0602030546q2ea4b70bq1dc66306d5ef1b12@mail.gmail.com>
Date: Fri, 3 Feb 2006 14:46:19 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ 00/10] [Suspend2] Modules support.
Cc: Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       nigel@suspend2.net, torvalds@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060203113543.GA3056@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	 <20060202115907.GH1884@elf.ucw.cz>
	 <200602022214.52752.nigel@suspend2.net> <20060202152316.GC8944@ucw.cz>
	 <20060202132708.62881af6.akpm@osdl.org>
	 <1138916079.15691.130.camel@mindpipe>
	 <20060202142323.088a585c.akpm@osdl.org>
	 <20060203105100.GD2830@elf.ucw.cz>
	 <58cb370e0602030322u4c2c9f9bm21a38be6d35d2ea6@mail.gmail.com>
	 <20060203113543.GA3056@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/06, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> > > Video problems seem to be broken for suspend2ram, not swsusp.
> > >
> > > Not that we don't have swsusp drivers problems, but they tend to be
> > > randomly, all over the map, mostly over drivers I never heard about.
> > >
> > > suspend2ram is different fish, video and ATA are real problems
> > > there. At least there are solutions on ATA being worked on.
> >
> > What PATA problems are you talking about?
> >
> > In kernel bugzilla there are 2 bugs related to suspend/resume:
> >
> > * #5257 for 2.6.13.1 (seem to be fixed in 2.6.15.2)
> > * #5673 for 2.6.14.3 (not enough information to start debugging)
> >
> > and I don't recall any problems being reported to linux-ide ML
> > or linux-kernel ML recently.
>
> We were not calling some ACPI methods to awake IDE correctly. It did
> not properly work with disk passwords or something like that.

Ah, ACPI support, it is being worked on but ATA ACPI should be
used as last resort.  Why?  We want IDE/libata drivers to have
correct knowledge about state of controller and devices.

There are specific cases when ACPI support is required (WRT disk
passwords we can and should support this without need for ACPI)
but most of systems should work just fine without it.  Also ACPI
support can just hide bugs in core code and host drivers which still
needs to be fixed (which i.e. happened for VIA IDE bug)...

> ...ahha, have it (should be reachable from outside...):
>
> https://bugzilla.novell.com/show_bug.cgi?id=145591

Jens' question is quite important here.

> (and linked:
>
> http://bugzilla.kernel.org/show_bug.cgi?id=2039 and

VIA IDE driver had bug in tuning code which prevented
resume from working, it was fixed ages ago.

[ commented into bug entry with request for retesting
  with latest kernel ]

> http://bugzilla.kernel.org/show_bug.cgi?id=5604

ide-generic is being used instead of piix (sigh)

Any other bugreports?


While at it let me explain some confusion which I've seen
cut'n'pasted into three bugreports (RedHat bugzilla, Ubuntu
bugzilla and kernel bugzilla):

"Linux currently has no real support for setting up IDE interfaces
on resume.  Some machines are kind enough to set the IDE
interface up themselves, but on others we're doomed to failure."

This is untrue as Linux has support for setting IDE controller
and drives.  It was added by Benjamin Herrenschmidt in late
2.5.x or early 2.6.x (I don't remember exact kernel version).

> )
>
> > Most bugreports I've seen was caused by:
> > * using ide-generic instead of proper host driver
> >   (no wonder that it fails)
> > * playing with hdparm when not needed (don't do it)
> >
> > Also IIRC SATA suspend/resume support was merged into
> > mainline (?) so things should work better now.
>
> I think SATA had similar problems with ACPI methods. Patches for SATA
> seem to be in better shape in PATA side, but I don't think they are in.

They are in mainline, maybe in Jeff's git tree... still the same
comments about ACPI support not being "Holy Grail" for fixing
all ATA suspend/resume problems apply...

More general request to ACPI and PM folks - if you get bugreports
which clearly indicate that [P,S]ATA drivers to blame please narrowing
it down a bit with help of bugreporter and feel free to:

* ask on linux-ide ML about the problem
* add "me" to cc: for the bug (or asign "me" as owner)

I can't promise fixing them all but leaving bugs as they are
without _informing_ and _working_ with ATA developers is clearly
not going to help...

Thanks,
Bartlomiej
