Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285134AbRLLKJn>; Wed, 12 Dec 2001 05:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285143AbRLLKJd>; Wed, 12 Dec 2001 05:09:33 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:11832 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S285134AbRLLKJT>; Wed, 12 Dec 2001 05:09:19 -0500
Date: Wed, 12 Dec 2001 11:09:42 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andrew Morton <akpm@zip.com.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 & OOM killer screw up (fwd)
Message-ID: <20011212110942.X4801@athlon.random>
In-Reply-To: <20011212102141.Q4801@athlon.random> <Pine.LNX.4.33L.0112120739380.20576-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.33L.0112120739380.20576-100000@imladris.surriel.com>; from riel@conectiva.com.br on Wed, Dec 12, 2001 at 07:45:45AM -0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2001 at 07:45:45AM -0200, Rik van Riel wrote:
> On Wed, 12 Dec 2001, Andrea Arcangeli wrote:
> > On Wed, Dec 12, 2001 at 12:44:17AM -0800, Andrew Morton wrote:
> > > Oh.  Maybe the core design (whatever it is :)) is not finished,
> > > because it retains the bone-headed, dumb-to-the-point-of-astonishing
> > > misfeature which Linux VM has always had:
> > >
> > > If someone is linearly writing (or reading) a gigabyte file on a 64
> > > megabyte box they *don't* want the VM to evict every last little scrap
> > > of cache on behalf of data which they *obviously* do not want
> > > cached.
> >
> > The current design tries to detect this, at least much much better than
> > 2.2. This is why I disagree with Rik's patch of yesterday.  detecting
> > cache pollution is good also on the lowmem boxes (not only for DB).
> 
> Oh, absolutely. The problem just is that the current design
> has even worse problems where it doesn't put any pressure on
> pages which were touched twice an hour ago.

it does. See the refill_inactive pass.

> This leads to the situation that applications get OOM-killed
> to preserve buffer cache memory which hasn't been touched
> since bootup time.

It doesn't happen here.

At the very least the fix is the two liner from Andrew that forces a
nr_pages refile from active list, that will guarantee that whatever
happens we always roll the active list too, but the oom killing you are
experiencing is a problem of mainline, it definitely doesn't happen here
and the refill_inactive(0) cannot be the culprit because the active list
grows always to a relevant size and if during oom a few pages stays
untouched into the active list that's fine, those two pages couldn't
save us anyways so they'd better stay there so we don't trash.

> 
> There are ways to both have good behaviour on bulk IO and
> flush out old data which was in active use but no longer is.
> I believe these are called page aging and drop-behind.
> I've been thinking about achieving the wanted behaviour
> without these two, but haven't been able to come up with
> any algorithm which doesn't have some very bad side effects.
> 
> If you know a way of doing bulk IO properly and flushing out
> an old working set correctly, please let us know.
> 
> regards,
> 
> Rik
> -- 
> Shortwave goes a long way:  irc.starchat.net  #swl
> 
> http://www.surriel.com/		http://distro.conectiva.com/


Andrea
