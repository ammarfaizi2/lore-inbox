Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbVDAIuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbVDAIuz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 03:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVDAIt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 03:49:27 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:5536 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261657AbVDAIsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 03:48:51 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: ncunningham@cyclades.com
Subject: Re: [linux-pm] Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Date: Fri, 1 Apr 2005 10:49:00 +0200
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@suse.cz>, dtor_core@ameritech.net,
       Patrick Mochel <mochel@digitalimplant.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Andy Isaacson <adi@hexapodia.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Stefan Seyfried <seife@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050329181831.GB8125@elf.ucw.cz> <20050331221814.GC1802@elf.ucw.cz> <1112308137.18871.7.camel@desktop.cunningham.myip.net.au>
In-Reply-To: <1112308137.18871.7.camel@desktop.cunningham.myip.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504011049.01540.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday, 1 of April 2005 00:28, Nigel Cunningham wrote:
> Hi.
> 
> On Fri, 2005-04-01 at 08:18, Pavel Machek wrote:
> > Hi!
> > 
> > > > > Ok, what do you think about this one?
> > > > >
> > > > > ===================================================================
> > > > >
> > > > > swsusp: disable usermodehelper after generating memory snapshot and
> > > > >         before resuming devices, so when device fails to resume we
> > > > >         won't try to call hotplug - userspace stopped anyway.
> > > > 
> > > > Hm, shouldn't we disable it before we start to freeze processes? We don't
> > > > want any more processes trying to start up after we've taken care of
> > > > them..
> > > > 
> > > 
> > > Can't a device be removed (for any reason) _while_ we are freezing
> > > processes? I think freeszing code will properly deal with it... What
> > > about suspend semantics - if suspend fails do we say the device should
> > > be operational or the system should attempt to re-initialize? I.e. we
> > > are not doing suspend after all - can we still drop messages on the
> > > floor? After all, we still have ability to run coldplug after failed
> > > suspend.
> > 
> > I believe we should freeze hotplug before processes.

I agree.  IMO user space should not be considered as available once we have
started freezing processes, so hotplug should be disabled before.  By the same
token, it should only be enabled after the processes have been restarted
during resume (or after suspend has failed).

BTW, it seems to me that the forking of new processes could be disabled
before we start to freeze the existing ones.

> > Dropping messages on the floor should not be a problem, we should just
> > call coldplug after failed suspend.
> 
> How will you know which devices to call coldplug for, post resume? (Or
> does it figure that out itself somehow?)

I think the drivers that need the hotplug to resume should defer their resume
routines until usermodehelper is enabled (it seems to me that we can use
a completion to handle this).

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
