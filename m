Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965018AbWJWTUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbWJWTUT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 15:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965054AbWJWTUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 15:20:19 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:7616 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S965048AbWJWTUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 15:20:18 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
Date: Mon, 23 Oct 2006 21:19:24 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, ncunningham@linuxmail.org,
       linux-kernel@vger.kernel.org
References: <1161576735.3466.7.camel@nigel.suspend2.net> <20061023171450.GA3766@elf.ucw.cz> <20061023105022.8b1dc75d.akpm@osdl.org>
In-Reply-To: <20061023105022.8b1dc75d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610232119.25373.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 23 October 2006 19:50, Andrew Morton wrote:
> > On Mon, 23 Oct 2006 19:14:50 +0200 Pavel Machek <pavel@ucw.cz> wrote:
> > On Mon 2006-10-23 09:55:22, Andrew Morton wrote:
> > > > On Mon, 23 Oct 2006 16:07:16 +0200 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > > > I'm trying to prepare the patches to make swsusp into suspend2.
> > > > 
> > > > Oh, I see.  Please don't do that.
> > > 
> > > Why not?

Generally, we already do many things that suspend2 just duplicates and there's
one thing in suspend2 I really don't like, which is the use of LRU pages as
temporary storage.
 
> > Last time I checked, suspend2 was 15000 lines of code, including its
> > own plugin system and special user-kernel protocol for drawing
> > progress bar (netlink based). It also did parts of user interface from
> 
> That's different.
> 
> I don't know where these patches are leading, but thus far they look like
> reasonable cleanups and generalisations.  So I suggest we just take them
> one at a time.

Well, the patch for the freezeing of bdevs contains a memory leak that I have
already pointed to Nigel for three times, it leads to some problems in the
error paths, AFAICT, and "solves" a problem that doesn't really exist in the
current code.

Some time ago I posted a very similar patch and we discussed it with the XFS
people.  In conclusion we decided not to apply it.

The patch that causes kernel threads to be thawed temporarily before we
attempt to free some memory doesn't look bad, but it's not needed for the
reason given by Nigel.  It may be needed for another reason, but I think we
should know why we apply it before we do so.

I have no specific objections with respect to the other patches except I'd
like to understand the patch that adds extents for the handling of swap before
I say I like it or not.

> > OTOH, that was half a year ago, but given that uswsusp can now do most
> > of the stuff suspend2 does (and without that 15000 lines of code), I
> > do not think we want to do complete rewrite of swsusp now.
> 
> uswsusp seems like a bad idea to me.

Could you please explain why exactly?

> We'd be better off concentrating on a simple, clean in-kernel thing which
> *works*. 

This depends on the point of view.  I test both swsusp and uswsusp on a regular
basis on 5 different boxes and they both work flawlessly (except when some
rogue patch breaks them, but that's a different story).

> Right now the main problems with swsusp are that it's slow and that there
> are driver problems.  (Actually these are both driver problems).

Well, suspend2 is not about drivers.  It's all about the "core", ie. memory
management, saving/restoring the image etc.

As far as the drivers are concerned, we (I, Pavel, Nigel and even you) can't
fix all of them and it really is a challenge to do something that will cause
them to be fixed.

In the meantime we fix some things that _we_ can address, like the handling
of highmem, the PAE-related issue on i386 etc.

> Fiddling with the top-level interfaces doesn't address either of these core
> problems.

No, it doesn't, but for example it's the correct way of handling the resume
from an initrd image, IMHO.

> Apparently uswsusp has gained support for S3 while the in-kernel driver
> does not support S3.  That's disappointing.

The problem with that is on _many_ boxes we have to handle the video in a
special way before and after S3, and it is only possible from the user
space.  This was one of the reasons why we decided to develop the userland
suspend.


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
