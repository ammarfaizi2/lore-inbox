Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbWBXUWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbWBXUWu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 15:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWBXUWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 15:22:50 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:671 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932431AbWBXUWt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 15:22:49 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Fri, 24 Feb 2006 21:22:52 +0100
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Andreas Happe <andreashappe@snikt.net>, linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602241158.08306.rjw@sisk.pl> <20060224131206.GB1717@elf.ucw.cz>
In-Reply-To: <20060224131206.GB1717@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602242122.53763.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday 24 February 2006 14:12, Pavel Machek wrote:
> On Pá 24-02-06 11:58:07, Rafael J. Wysocki wrote:
> > On Friday 24 February 2006 00:44, Pavel Machek wrote:
> > > > > > > [Because pagecache is freeable, anyway, so it will be freed. Now... I
> > > > > > > have seen some problems where free_some_memory did not free enough,
> > > > > > > and schedule()/retry helped a bit... that probably should be fixed.]
> > > > > >
> > > > > > It seems I need to understand correctly what the difference between what
> > > > > > we do and what Nigel does is.  I thought the Nigel's approach was to save
> > > > > > some cache pages to disk first and use the memory occupied by them to
> > > > > > store the image data.  If so, is the page cache involved in that or
> > > > > > something else?
> > > > >
> > > > > I believe Nigel only saves pages that could have been freed anyway
> > > > > during phase1. Nigel, correct me here... suspend2 should work on same
> > > > > class of machines swsusp can, but will be able to save caches on
> > > > > machines where swsusp can not save any.
> > > > 
> > > > I'm not used to thinking in these terms :). It would be normally be right, 
> > > > except that there will be some LRU pages that will never be freed. These 
> > > > would allow suspend2 to work in some (not many) cases where swsusp can't. 
> > > > It's been ages since I did the intensive testing on the image preparation 
> > > > code, but I think that if we free as much memory as we can, we will always 
> > > > still have at least a few hundred LRU pages left. That's not much, but on 
> > > > machines with less ram, it might make the difference in a greater percentage 
> > > > of cases (compared to machines with more ram)?
> > > 
> > > Well, pages in LRU should be user pages, and therefore freeable,
> > > AFAICT. It is possible that there's something wrong with freeing in
> > > swsusp1...
> > 
> > Well, if all of the pages that Nigel saves before snapshot are freeable in
> > theory, there evidently is something wrong with freeing in swsusp, as we
> > have a testcase in which the user was unable to suspend with swsusp due
> > to the lack of memory and could suspend with suspend2.
> > 
> > However, the only thing in swsusp_shrink_memory() that may be wrong
> > is we return -ENOMEM as soon as shrink_all_memory() returns 0.
> > Namely, if shrink_all_memory() can return 0 prematurely (ie. "there still are
> > some freeable pages, but they could not be freed in _this_ call"), we should
> > continue until it returns 0 twice in a row (or something like that).  If this
> > doesn't help, we'll have to fix shrink_all_memory() I'm afraid.
> 
> I did try shrink_all_memory() five times, with .5 second delay between
> them, and it freed more memory at later tries.

I wonder if the delays are essential or if so, whether they may be shorter
than .5 sec.

> Sometimes it even freed 0 pages at the first try.
> 
> I did not push the patch because
> 
> 1) it was way too ugly

I think I can do something like that in swsusp_shrink_memory() and it
won't be very ugly.

> 2) shrink_all_memory() should be fixed. It should not really return if
> there are more pages freeable.

Well, that would be a long-run solution.  However, until it's fixed we can
use a workaround IMHO. ;-)

Greetings,
Rafael
