Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946526AbWKJMGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946526AbWKJMGS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 07:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946529AbWKJMGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 07:06:18 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:41138 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1946526AbWKJMGR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 07:06:17 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Date: Fri, 10 Nov 2006 13:03:32 +0100
User-Agent: KMail/1.9.1
Cc: Alasdair G Kergon <agk@redhat.com>, Eric Sandeen <sandeen@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com, Srinivasa DS <srinivasa@in.ibm.com>,
       Nigel Cunningham <nigel@suspend2.net>, David Chinner <dgc@sgi.com>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <20061109232438.GS30653@agk.surrey.redhat.com> <20061109233258.GH2616@elf.ucw.cz>
In-Reply-To: <20061109233258.GH2616@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611101303.33685.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 10 November 2006 00:32, Pavel Machek wrote:
> Hi!
> 
> > On Fri, Nov 10, 2006 at 12:11:46AM +0100, Pavel Machek wrote:
> > > ? Not sure if I quite understand, but if dm breaks sync... something
> > > is teribly wrong with dm. And we do simple sys_sync()... so I do not
> > > think we have a problem.
> >  
> > If you want to handle arbitrary kernel state, you might have a device-mapper
> > device somewhere lower down the stack of devices that is queueing any I/O
> > that reaches it.  So anything waiting for I/O completion will wait until 
> > the dm process that suspended that device has finished whatever it is doing
> > - and that might be a quick thing carried out by a userspace lvm tool, or
> > a long thing carried out by an administrator using dmsetup.
> > 
> > I'm guessing you need a way of detecting such state lower down the stack
> > then optionally either aborting the operation telling the user it can't be
> > done at present; waiting for however long it takes (perhaps for ever if
> > the admin disappeared); or more probably skipping those devices on a 
> > 'best endeavours' basis.
> 
> Okay, so you claim that sys_sync can stall, waiting for administator?
> 
> In such case we can simply do one sys_sync() before we start freezing
> userspace... or just more the only sys_sync() there. That way, admin
> has chance to unlock his system.

Well, this is a different story.

My point is that if we call sys_sync() _anyway_ before calling
freeze_filesystems(), then freeze_filesystems() is _safe_ (either the
sys_sync() blocks, or it doesn't in which case freeze_filesystems() won't
block either).

This means, however, that we can leave the patch as is (well, with the minor
fix I have already posted), for now, because it doesn't make things worse a
bit, but:
(a) it prevents xfs from being corrupted and
(b) it prevents journaling filesystems in general from replaying journals
after a failing resume.

Still, there is a problem with the possibility of potential lock-up - either
with the bdevs-freezing patch or without it - due to a suspended dm device
down the stack and solving that is a _separate_ issue.

Now if we use the userland suspend, there's no problem at all, I think,
because s2disk calls sync() before it goes to suspend_system(), so the
admin will have a chance to unclock the system and everything is fine and
dandy (although it should be documented somewhere, IMHO).

However, if the built-in swsusp is used, then well ... <looks> ... we can put
a call to sys_sync() before prepare_processes() in pm_suspend_disk().

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
