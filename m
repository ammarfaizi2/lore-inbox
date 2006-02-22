Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbWBVStY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbWBVStY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 13:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWBVStY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 13:49:24 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:63375 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751390AbWBVStX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 13:49:23 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Wed, 22 Feb 2006 19:49:31 +0100
User-Agent: KMail/1.9.1
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Andreas Happe <andreashappe@snikt.net>, linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602220038.18054.rjw@sisk.pl> <200602220947.44506.ncunningham@cyclades.com>
In-Reply-To: <200602220947.44506.ncunningham@cyclades.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602221949.31933.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 February 2006 00:47, Nigel Cunningham wrote:
> On Wednesday 22 February 2006 09:38, Rafael J. Wysocki wrote:
> > On Tuesday 21 February 2006 22:00, Nigel Cunningham wrote:
> > > On Wednesday 22 February 2006 06:40, Rafael J. Wysocki wrote:
> > > > On Tuesday 21 February 2006 05:19, Dmitry Torokhov wrote:
> > > > > On Monday 20 February 2006 21:57, Nigel Cunningham wrote:
> > > > > > For the record, my thinking went: swsusp uses n (12?) bytes of meta
> > > > > > data for every page you save, where as using bitmaps makes that
> > > > > > much closer to a constant value (a small variable amount for
> > > > > > recording where the image will be stored in extents). 12 bytes per
> > > > > > page is 3MB/1GB. If swsusp was to add support for multiple swap
> > > > > > partitions or writing to files, those requirements might be closer
> > > > > > to 5MB/GB.
> > > > >
> > > > > 5MB/GB amounts to 0.5% overhead, I don't think you should be
> > > > > concerned here. Much more important IMHO is that IIRC swsusp requires
> > > > > to be able to free 1/2 of the physical memory whuch is hard on low
> > > > > memory boxes.
> > > >
> > > > I see another point in using bitmaps: we could avoid modifying page
> > > > flags and use bitmaps to store all of the temporary information.  I
> > > > thought about it for some time and I think it's doable.
> > >
> > > It is doable - I'm doing it now, but am thinking about reverting part of
> > > the code to use pbes again. If you're going to look at using bitmaps in
> > > place of pbes, me changing would be a waste of time. Do you want me to
> > > hold off for a while? (I'll happily do that, as I have far more than
> > > enough to keep me occupied at the moment anyway).
> >
> > Well, I'd say so. :-)
> 
> Ok.
> 
> > Frankly, I didn't think of dropping PBEs right now, but in the long run
> > that's worth considering, IMO.  The advantage of PBEs is that they are easy
> > to handle in the assembly parts, but apart from this they are a bit
> > wasteful (not very much, though).
> 
> Fully agree. That's why I've sought to keep the copying in c - it makes it 
> simpler to read and maintain (although at the expense of a little bit of 
> ugliness with that if in the stack page allocation

Well, that's a bit too much ugliness for me, sorry.

> or (old way) working hard to make the C not use stack).

I'd rather not get rid of the assembly parts.  Instead, I'd modify them to
handle bitmaps.  I'm not going to drop them.

> > The fact that we use page flags to store some suspend/resume-related
> > information is a big disadvantage in my view, and I'd like to get rid of
> > that in the future.  In principle we could use a bitmap, or rather two of
> > them, to store the same information independently of the page flags, and if
> > we use bitmaps for this purpose, we can use them also instead of PBEs.
> 
> If you use the 'dynamically allocated pageflags' code (sure, pick a better 
> name if you want), these changes will be pretty trivial - you can #define 
> macros that could make the transition just a matter of switching PageNosave 
> (eg) to PageSomethingElse. (Ditto for setting and clearing flags).

I think it could be done without that code and I'd prefer to do so.  In fact,
we only need to remember:
(a) saveable pages
(b) pages used to store the data from (a)
(c) pages allocated by us that we should release eventually
(generally that may be a broader set than just (b)).
That's 3 bitmaps total and no need for using any more sophisticated stuff,
if I remember everything correctly.

> > At this point I'd have to look at your snapshot-related code and see if
> > it's suitable for snapshot.c (in -mm now) somehow.  If you could point
> > me to the specific parts of the suspend2 patch where this code is, I'd be
> > grateful.
> 
> Sure. The bulk is in kernel/power/atomic_copy.c. Arch specific routines are 
> include/asm-<arch>/suspend2.h.

OK, thanks.

Rafael
