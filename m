Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752112AbWJXH6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112AbWJXH6f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 03:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752116AbWJXH6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 03:58:34 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:48581 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1752112AbWJXH6e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 03:58:34 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
Date: Tue, 24 Oct 2006 09:57:38 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
References: <1161576735.3466.7.camel@nigel.suspend2.net> <200610232119.25373.rjw@sisk.pl> <1161643965.7033.12.camel@nigel.suspend2.net>
In-Reply-To: <1161643965.7033.12.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610240957.38965.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday, 24 October 2006 00:52, Nigel Cunningham wrote:
> Hi.
> 
> On Mon, 2006-10-23 at 21:19 +0200, Rafael J. Wysocki wrote:
> > On Monday, 23 October 2006 19:50, Andrew Morton wrote:
> > > > On Mon, 23 Oct 2006 19:14:50 +0200 Pavel Machek <pavel@ucw.cz> wrote:
> > > > On Mon 2006-10-23 09:55:22, Andrew Morton wrote:
> > > > > > On Mon, 23 Oct 2006 16:07:16 +0200 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > > > > > I'm trying to prepare the patches to make swsusp into suspend2.
> > > > > > 
> > > > > > Oh, I see.  Please don't do that.
> > > > > 
> > > > > Why not?
> > 
> > Generally, we already do many things that suspend2 just duplicates and there's
> > one thing in suspend2 I really don't like, which is the use of LRU pages as
> > temporary storage.
> 
> The duplicated things obviously won't be merged (unless they're doing it
> better somehow), so there's no issue there.

OK (as long as there are no doubts the new code is doing things better ;-))

> As to the use of LRU pages, this can be disabled with a simple sysfs
> setting, so it doesn't need to be a big issue.

I'm sorry, but I don't think it can be merged at all as long as we are not
100% sure it's safe.  Currently, we aren't.

> > > > Last time I checked, suspend2 was 15000 lines of code, including its
> > > > own plugin system and special user-kernel protocol for drawing
> > > > progress bar (netlink based). It also did parts of user interface from
> > > 
> > > That's different.
> > > 
> > > I don't know where these patches are leading, but thus far they look like
> > > reasonable cleanups and generalisations.  So I suggest we just take them
> > > one at a time.
> > 
> > Well, the patch for the freezeing of bdevs contains a memory leak that I have
> > already pointed to Nigel for three times, it leads to some problems in the
> > error paths, AFAICT, and "solves" a problem that doesn't really exist in the
> > current code.
> 
> There's no memory leak. In Suspend2 (and I believe swsusp, but will
> admit I haven't carefully checked), every call to freeze processes has a
> matching call to thaw them. The thaw call will invoke make_fses_rw,
> which will free the memory that was allocated. If there's an issue, it's
> that in the failure path thaw_bdev can be called when freeze_bdev was
> never invoked. Having just realised that, I've just fixed it.

I was talking about the leak in the error path, where you exit the function
without freeing the already allocated objects.

> Regarding the problem not existing, I'll try to find time to reproduce
> it later in the day. Maybe the XFS guys have fixed it since I last
> checked, but I do know there was a real issue (even if you haven't seen
> it). That said, yesterday was my Red Hat day, so I'm not promising that
> I'll be quick.

Of course if you are able to show there is a problem, I won't be against this
patch.

> > Some time ago I posted a very similar patch and we discussed it with the XFS
> > people.  In conclusion we decided not to apply it.
> > 
> > The patch that causes kernel threads to be thawed temporarily before we
> > attempt to free some memory doesn't look bad, but it's not needed for the
> > reason given by Nigel.  It may be needed for another reason, but I think we
> > should know why we apply it before we do so.
> 
> I'll seek to address this too.
> 
> > I have no specific objections with respect to the other patches except I'd
> > like to understand the patch that adds extents for the handling of swap before
> > I say I like it or not.
> > 
> > > > OTOH, that was half a year ago, but given that uswsusp can now do most
> > > > of the stuff suspend2 does (and without that 15000 lines of code), I
> > > > do not think we want to do complete rewrite of swsusp now.
> > > 
> > > uswsusp seems like a bad idea to me.
> > 
> > Could you please explain why exactly?
> > 
> > > We'd be better off concentrating on a simple, clean in-kernel thing which
> > > *works*. 
> > 
> > This depends on the point of view.  I test both swsusp and uswsusp on a regular
> > basis on 5 different boxes and they both work flawlessly (except when some
> > rogue patch breaks them, but that's a different story).
> > 
> > > Right now the main problems with swsusp are that it's slow and that there
> > > are driver problems.  (Actually these are both driver problems).
> > 
> > Well, suspend2 is not about drivers.  It's all about the "core", ie. memory
> > management, saving/restoring the image etc.
> > 
> > As far as the drivers are concerned, we (I, Pavel, Nigel and even you) can't
> > fix all of them and it really is a challenge to do something that will cause
> > them to be fixed.
> > 
> > In the meantime we fix some things that _we_ can address, like the handling
> > of highmem, the PAE-related issue on i386 etc.
> 
> Agreed.
> 
> > > Fiddling with the top-level interfaces doesn't address either of these core
> > > problems.
> > 
> > No, it doesn't, but for example it's the correct way of handling the resume
> > from an initrd image, IMHO.
> > 
> > > Apparently uswsusp has gained support for S3 while the in-kernel driver
> > > does not support S3.  That's disappointing.
> > 
> > The problem with that is on _many_ boxes we have to handle the video in a
> > special way before and after S3, and it is only possible from the user
> > space.  This was one of the reasons why we decided to develop the userland
> > suspend.
> 
> But that's a different issue - uswsusp is suspend to disk. Your s2ram
> thing is suspend to ram (although I guess you're somehow invoking it as
> a library or something for suspend to disk + ram).

Yes, we support the suspend to disk+RAM which also needs the video-related
black magic.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
