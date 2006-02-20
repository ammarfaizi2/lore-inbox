Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161127AbWBTUYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161127AbWBTUYA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 15:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161134AbWBTUYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 15:24:00 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:43155 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161127AbWBTUX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 15:23:59 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Olivier Galibert <galibert@pobox.com>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Mon, 20 Feb 2006 21:24:29 +0100
User-Agent: KMail/1.9.1
Cc: kernel list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602201816.56232.rjw@sisk.pl> <20060220181657.GD33155@dspnet.fr.eu.org>
In-Reply-To: <20060220181657.GD33155@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200602202124.30237.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 February 2006 19:16, Olivier Galibert wrote:
> On Mon, Feb 20, 2006 at 06:16:55PM +0100, Rafael J. Wysocki wrote:
> > On Monday 20 February 2006 16:39, Olivier Galibert wrote:
> > > On Mon, Feb 20, 2006 at 03:13:23PM +0100, Rafael J. Wysocki wrote:
}-- snip --{
> Now try another point of view.  STD as currently in the kernel is
> unreliable,

It works for me 100% of the time, as of 2.6.16-rc4, so this statement is
too general, I think.

Besides, some important fixes are in -mm waiting for the 2.6.17 merging
window.

> and don't get me started about STR.  Assume that you are 
> the suspend maintainer for the kernel (you are the co-maintainer at
> that point in practice).  As such, you should want STD/STR to be
> reliable.  As an engineer, tell me if you think uswsusp has a chance
> to make STD/STR more reliable than the current situation.

Of course it doesn't, but the same applies to suspend2.  It's not about
fixing driver problems etc.  It's all about checkpointing the system and
saving the image (w/ some fancy transformations like encryption/compression).

[The suspend2 patch does contain driver fixes, but they really should be
posted separately or forwarded to the respective driver maintainers
(it's already happened, AFAICT).  Please do not count the driver fixes as an
advantage of suspend2.]

Now there are two differences that may cause suspend2 to work where swsusp
doesn't: (1) suspend2 is able to free more memory during suspend, and
(2) suspend2 contains some code for freezing processes that is not
present in the mainline swsusp.

Let's consider (2) first.  The freezing of processes in swsusp has recently
been improved so that it can freeze processes under _heavy_ load
and it's been done in much simpler way than suspend2 does it (this
patch is now in -mm).  This code may be further improved by
porting the freezing of bdevs from suspend2, but that's not critical in
my view.  OTOH this part of suspend2 contains at least one thing
that was rejected about 1 year ago and not by me or Pavel.

Now as far as (1) is concerned, there is a question if the way in which
that is done in suspend2 is really optimal.  That will have to be considered
for a while and by people who know the kernel internals much better than I do.

> > No, it doesn't.  By the same token you could say writing another mail
> > client is redoing Mozilla Thunderbird.
> 
> You have, say, xmh.  You start working to make it look and act like
> Thunderbird.  Isn't that redoing Thunderbird, whatever the
> implementation looks like at the end?

Well, I don't want it to look and act like suspend2.  I'd like it to provide
comparable functionality, in a different way.

}-- snip --{
> If the memory usage of your userland part is not severely bounded you
> may have annoying issues.  Libraries inmy experience tend to be quite
> liberal in their allocations.

It isn't all that bad, apparently.  So far I haven't experienced any problems
related to that.

}-- snip --{ 
> > Functionality-wise, your right.  The problem is how it's done, I think, and
> > that is not so obvious.
> 
> Heh.  It obviously has been way too long out of mainline.  Pavel's
> reviews being 90% "you should do all that in userspace" are a little
> tiring after a while though.

Well, I can't speak for Pavel.

> > >    The constraints on userland suspend code are rather close to RT kernel
> > >    code, so  technically it would be a much better base.
> > 
> > Can you please tell me why do you think so?
> 
> Well, from what I see (I can be very wrong mind you), the constraints are:
> - no fs access at all
> - careful with memory, you don't want to push things into swap once
>   the image is done

The second one should be safe, I think (the image reflects the state of swap
from before the "atomic snapshot" operation, so what happens to the
swap afterwards doesn't really matter).

> That's very RT-ish.  And all that essentially without the kernel
> protecting you from your errors.

You're not so time-constrained, though, and there are no other threads
to worry about. :-)

Greetings,
Rafael
