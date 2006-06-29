Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWF2UwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWF2UwJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 16:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWF2UwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 16:52:09 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:54754 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751299AbWF2UwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 16:52:06 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: nigel@suspend2.net
Subject: Re: [Suspend2][ 0/9] Extents support.
Date: Thu, 29 Jun 2006 22:52:18 +0200
User-Agent: KMail/1.9.3
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net> <200606290035.12177.rjw@sisk.pl> <200606290927.02181.nigel@suspend2.net>
In-Reply-To: <200606290927.02181.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606292252.18833.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 29 June 2006 01:26, Nigel Cunningham wrote:
> On Thursday 29 June 2006 08:35, Rafael J. Wysocki wrote:
> > On Wednesday 28 June 2006 01:47, Nigel Cunningham wrote:
> > > On Wednesday 28 June 2006 08:19, Rafael J. Wysocki wrote:
> > > > On Tuesday 27 June 2006 11:35, Nigel Cunningham wrote:
> > > > > On Tuesday 27 June 2006 19:26, Rafael J. Wysocki wrote:
> > > > > > > > Now I haven't followed the suspend2 vs swsusp debate very
> > > > > > > > closely, but it seems to me that your biggest problem with
> > > > > > > > getting this merged is getting consensus on where exactly this
> > > > > > > > is going. Nobody wants two different suspend modules in the
> > > > > > > > kernel. So there are two options - suspend2 is deemed the way
> > > > > > > > to go, and it gets merged and replaces swsusp. Or the other way
> > > > > > > > around - people like swsusp more, and you are doomed to
> > > > > > > > maintain suspend2 outside the tree.
> > > > > > >
> > > > > > > Generally, I agree, although my understanding of Rafael and
> > > > > > > Pavel's mindset is that swsusp is a dead dog and uswsusp is the
> > > > > > > way they want to see things go. swsusp is only staying for
> > > > > > > backwards compatability. If that's the case, perhaps we can just
> > > > > > > replace swsusp with Suspend2 and let them have their existing
> > > > > > > interface for uswsusp. Still not ideal, I agree, but it would be
> > > > > > > progress.
> > > > > >
> > > > > > Well, ususpend needs some core functionality to be provided by the
> > > > > > kernel, like freezing/thawing processes (this is also used by the
> > > > > > STR), snapshotting the system memory.  These should be shared with
> > > > > > the in-kernel suspend, be it swsusp or suspend2.
> > > > >
> > > > > If I modify suspend2 so that from now on it replaces swsusp, using
> > > > > noresume, resume= and echo disk > /sys/power/state in a way that's
> > > > > backward compatible with swsusp and doesn't interfere with uswsusp
> > > > > support, would you be happy? IIRC, Pavel has said in the past he
> > > > > wishes I'd just do that, but he's not you of course.
> > > >
> > > > That depends on how it's done.  For sure, I wouldn't like it to be done
> > > > in the "everything at once" manner.
> > >
> > > I'm not sure I get what you're saying. Do you mean you'd prefer them to
> > > coexist for a time in mainline? If so, I'd point out that suspend2 uses
> > > different parameters at the moment precisely so they can coexist, so that
> > > wouldn't be any change.
> >
> > No, I'd like it to be done in small steps.  Actually as small as possible,
> > so that it's always clear what we are going to do and why.
> >
> > If you want to start right now, please submit a bdevs freezing patch
> > without any non-essential additions.
> 
> Well, I admit that I'd far prefer to work with you than Pavel, but aren't we 
> still just going to reach a point where you say "But that should be done in 
> userspace" and I say "But I disagree that userspace is the right place for 
> suspend to disk" and we stalemate? What then? It seems that I've already 
> wasted a lot of effort listening to requests to split Suspend2 up into 
> digestable chunks for review, only to find that they're not the digestable 
> chunks people wanted to digest. I don't want to spent my time slicing and 
> dicing in another way, only to find that the customer doesn't like that meal 
> presentation either.

I haven't said anything about the userspace, so far.  I'm just talking about
what in my opinion can be done to merge some parts of your code early,
which may also help you, because once it gets merged you'll have less code
to maintain.

Now the freezer is the part we must share, so it's better if we start from it,
IMO, and it's quite clear to me that the freezing of bdevs will help fix the
XFS test case.  [It may also be helpful in other ways, but that's not obvious
right now.]  However it is not clear to me that the other changes to the
freezer that you currently have in your patch are correct, so it's better
to consider them separately.

> Can't we instead do what we started to do with the pageflags support? That is, 
> look at the files one at a time, beginning with those that implement the more 
> primitive functions, such as pageflags and extents and the like, verifying 
> that they're implemented ok. Then progress to the higher level functions and 
> check that they combine the primitives together okay, and so on. Or (if you 
> prefer), do the reverse, beginning with suspend.c and progressing down into 
> the details?

We could do a review the way you describe, although I think that the low-level
thing should be considered along with the high-level parts where they are
used, but I see two problems here.

First, it would take a lot of time and the kernel is being developed
continuously, so there's the danger that the code reviewed at the beginning
will have to be redone to reflect the changes in the kernel and it would have
to be reviewed once again.  For this reason it would be more efficient to try
to merge the code as soon as it's been reviewed and we are comfortable
with it.

Second, there may be something in the code that happens to be unmergeable,
whatever the reason (eg. someone violently opposes it etc.).  Then, we'd have
to drop it and that may affect the code that has already been reviewed, so
this code will have to be redone etc.  We can avoid this issue if the patches
are arranged so that we can merge relatively small chunks of them as soon as
everyone is comfortable with them.

As I said before, I think the freezer changes should go first.  The next thing
to try is the "dynamic pageflags" or generally using bitmaps for page
management as it would give us a clear advantage over the current
implementation as far as the utilisation of memory is concerned.

> I guess the other question is, at the end of this, do you have to understand 
> perfectly and completely how Suspend2 works? If not, are there things I could 
> do to help? (Straight off, it occurs to me that I should get around to 
> completing and updating the Documentation - it might help you a lot).

I think I know the general idea well enough and the details are in the code.
I'll ask if I have any doubts. :-)

Greetings,
Rafael
