Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270680AbTGUTjA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 15:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270682AbTGUTjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 15:39:00 -0400
Received: from janus.zeusinc.com ([205.242.242.161]:54832 "EHLO
	zso-proxy.zeusinc.com") by vger.kernel.org with ESMTP
	id S270680AbTGUTi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 15:38:58 -0400
Subject: Re: [BUG REPORT 2.6.0] cisco airo_cs scheduling while atomic
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Georg Nikodym <georgn@somanetworks.com>
Cc: svenud@ozemail.com.au, Andrew Morton <akpm@osdl.org>,
       breed@users.sourceforge.net, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030721131547.45241e2e.georgn@somanetworks.com>
References: <1058619536.752.19.camel@localhost>
	 <20030721131547.45241e2e.georgn@somanetworks.com>
Content-Type: text/plain
Message-Id: <1058817132.1904.42.camel@iso-8590-lx.zeusinc.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 Jul 2003 15:52:13 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-07-21 at 13:15, Georg Nikodym wrote:
> On 19 Jul 2003 22:58:57 +1000
> Sven Dowideit <svenud@ozemail.com.au> wrote:
> 
> > @@ -4838,7 +4850,7 @@
> >         readCapabilityRid(local, &cap_rid);
> >  
> >         dwrq->length = sizeof(struct iw_range);
> > -       memset(range, 0, sizeof(*range));
> > +       memset(range, 0, sizeof(range));
> >         range->min_nwid = 0x0000;
> >         range->max_nwid = 0x0000;
> >         range->num_channels = 14;
> 
> I suspect that this part of the patch to airo.c is incorrect.  The
> intent seems to be to clear a section of memory pointed to by range that
> contains (or will soon contain) a struct iw_range.  The sizeof(*range)
> is equivalent of the sizeof(struct iw_range) above.  The patch reduces
> the size of the memset to the size of the pointer (which I'm assuming is
> smaller than the structure [/me goes and looks]).
> 
> Of course, the range pointer is derived from the char *extra
> parameter...  this could mean that we're actually getting a pre-filled
> iw_range and the memset is only supposed to clear the first member.  If
> that's the case, I would hope that the author could come up with a
> cleaner way of expressing that.

This has already been pointed out in a previous email.  I had been
maintaining my own patch for 2.5 for several months now that basically
included fixes from the official CVS 2.4 airo driver, scheduling fixes
to make the driver at least work, ref counting fixes, and several other
minor fixes.  Most of these were patches I collected off of LKML and
with my own forward port of a few fixes from CVS.

The current CVS version of the driver at airo-linux.sourceforge.net use
the sizeof(range) so somehow that managed to sneak into one of the
patches I sent out.  It wasn't intended to be part of the patch.

Most of these seperate fixes have since made their way into the -mm
kernels and I personally like Daniel's fixes much better as, for me at
least, the code is easier to follow without all the semaphore locking
all over the place.  As of this weekend I've moved all of my aironet
systems to using Daniels driver and they are working great.  I do
understand the issues of the driver possibly holding a spinlock for an
extended period of time using these patches, but my understanding is
that there are only a few commands that are very slow, and they're
typically only run for card setup (I could be wrong about that).  For
me, a solid driver is far more important that some spinlocks being held
for a couple hundred milliseconds during card initialization.

Anyway, I'm no longer maintaining my patches as most of the fixes are
now in the kernel tree.  I was mainly keeping them for my own use and
occasionally sent them out to people who were hitting bugs.

Later,
Tom


