Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932644AbWBYAU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644AbWBYAU7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 19:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932647AbWBYAU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 19:20:59 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:28576 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932644AbWBYAU6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 19:20:58 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Sat, 25 Feb 2006 01:20:39 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Dmitry Torokhov <dtor_core@ameritech.net>,
       Andreas Happe <andreashappe@snikt.net>, linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602242122.53763.rjw@sisk.pl> <200602250911.54850.ncunningham@cyclades.com>
In-Reply-To: <200602250911.54850.ncunningham@cyclades.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602250120.39936.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday 25 February 2006 00:11, Nigel Cunningham wrote:
> On Saturday 25 February 2006 06:22, Rafael J. Wysocki wrote:
> > On Friday 24 February 2006 14:12, Pavel Machek wrote:
> > > On Pá 24-02-06 11:58:07, Rafael J. Wysocki wrote:
}-- snip --{
> > > > Well, if all of the pages that Nigel saves before snapshot are freeable
> > > > in theory, there evidently is something wrong with freeing in swsusp,
> > > > as we have a testcase in which the user was unable to suspend with
> > > > swsusp due to the lack of memory and could suspend with suspend2.
> > > >
> > > > However, the only thing in swsusp_shrink_memory() that may be wrong
> > > > is we return -ENOMEM as soon as shrink_all_memory() returns 0.
> > > > Namely, if shrink_all_memory() can return 0 prematurely (ie. "there
> > > > still are some freeable pages, but they could not be freed in _this_
> > > > call"), we should continue until it returns 0 twice in a row (or
> > > > something like that).  If this doesn't help, we'll have to fix
> > > > shrink_all_memory() I'm afraid.
> > >
> > > I did try shrink_all_memory() five times, with .5 second delay between
> > > them, and it freed more memory at later tries.
> >
> > I wonder if the delays are essential or if so, whether they may be shorter
> > than .5 sec.
> >
> > > Sometimes it even freed 0 pages at the first try.
> > >
> > > I did not push the patch because
> > >
> > > 1) it was way too ugly
> >
> > I think I can do something like that in swsusp_shrink_memory() and it
> > won't be very ugly.
> >
> > > 2) shrink_all_memory() should be fixed. It should not really return if
> > > there are more pages freeable.
> >
> > Well, that would be a long-run solution.  However, until it's fixed we can
> > use a workaround IMHO. ;-)
> 
> Isn't trying to free as much memory as you can the wrong solution anyway?

No, it isn't.  There are situations in which we would like to suspend "whatever
it takes" and then we should be able to free as much memory as _really_
possible.

Besides, it is supposed to work, and it doesn't, so it needs fixing.

> I mean, that only means that the poor system has more pages to fault back in at 
> resume time, before the user can even begin to think about doing anything 
> useful.

Well, that's not the only possibility.  After we fix the memory freeing issue
we can use the observation that page cache pages need not be saved
to disk during suspend, because they already are in a storage.  We only
need to create a map of these pages during suspend with the information
on where to get them from and prefetch them into memory during resume
independently of the page fault mechanism.

This way we won't have to actually save anything before we snapshot the
system and the system should be reasonably responsive after resume.

Greetings,
Rafael
