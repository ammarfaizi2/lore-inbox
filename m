Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289368AbSAJLTN>; Thu, 10 Jan 2002 06:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289397AbSAJLTF>; Thu, 10 Jan 2002 06:19:05 -0500
Received: from mailgate.bodgit-n-scarper.com ([62.49.233.146]:11784 "HELO
	mould.bodgit-n-scarper.com") by vger.kernel.org with SMTP
	id <S289368AbSAJLSy>; Thu, 10 Jan 2002 06:18:54 -0500
Date: Thu, 10 Jan 2002 11:28:39 +0000
From: Matt Dainty <matt@bodgit-n-scarper.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Where's all my memory going?
Message-ID: <20020110112839.A1346@mould.bodgit-n-scarper.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E16OMpF-0001pj-00@the-village.bc.nu> <Pine.LNX.4.33L.0201092034590.2985-100000@imladris.surriel.com> <20020110024520.A29045@em.ca> <20020110030537.C771@lynx.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020110030537.C771@lynx.adilger.int>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 on i686 SMP (mould)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 03:05:38AM -0700, Andreas Dilger wrote:
> On Jan 10, 2002  02:45 -0600, Bruce Guenter wrote:
> > On Wed, Jan 09, 2002 at 08:36:13PM -0200, Rik van Riel wrote:
> > > Matt's system seems to go from 900 MB free to about
> > > 300 MB (free + cache).
> > > 
> > > I doubt qmail would eat 600 MB of RAM (it might, I
> > > just doubt it) so I'm curious where the RAM is going.

I'm fairly sure we can eliminate qmail, as most of its processes are
short-lived, often invoked per-delivery, only a few processes stay running
for any length of time.

> > I am seeing the same symptoms, with similar use -- ext3 filesystems
> > running qmail.

Heh, it's your fault I'm using ext3 for the queue! :P

> Hmm, does qmail put each piece of email is in a separate file?  That
> might explain a lot about what is going on here.

Yes, in more places than one in the best setups. The queue stores each
message in separate areas as it moves through the system, the queue names
each message as the inode it resides on. (I probably haven't explained that
too well, I'm sure Bruce can elaborate :-). When the message is delivered
locally, and using djb's Maildir mailbox format, the message will be stored
as a separate file too, most commonly under ~user/Maildir/new/.

I originally thought ReiserFS would be good for this, but the benchmarks
Bruce did, showed that in fact ext3 is better, (using data=journal, and
using the syncdir library to force synchronous behaviour on open(), etc.,
similar to chattr +S). I've also used 'noatime' to coax some more speed
out of it.

> > Adding up the RSS of all the processes in use gives
> > about 75MB, while free shows:
> > 
> >              total       used       free     shared    buffers     cached
> > Mem:        901068     894088       6980          0     157568     113856
> > -/+ buffers/cache:     622664     278404
> > Swap:      1028152      10468    1017684
> > 
> > This are fairly consistent numbers.  buffers hovers around 150MB and
> > cached around 110MB all day.  The server is heavy on write traffic.
> > 
> > > Matt, do you see any suspiciously high numbers in
> > > /proc/slabinfo ?

I'll have another run and see what happens...

> The other question would of course be whether we are calling into
> shrink_dcache_memory() enough, but that is an issue for Matt to
> see by testing "postal" with and without the patch, and keeping an
> eye on the slab caches.

I'll try this patch and see how it performs.

Cheers

Matt
-- 
"Phased plasma rifle in a forty-watt range?"
"Hey, just what you see, pal"
