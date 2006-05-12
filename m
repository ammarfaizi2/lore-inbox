Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbWELKKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWELKKV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 06:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWELKKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 06:10:21 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:65247 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751112AbWELKKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 06:10:21 -0400
Date: Fri, 12 May 2006 12:09:38 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nathan Scott <nathans@sgi.com>
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: [PATCH -mm] swsusp: support creating bigger images (rev. 2)
Message-ID: <20060512100938.GA28232@elf.ucw.cz>
References: <200605021200.37424.rjw@sisk.pl> <200605111011.23508.ncunningham@cyclades.com> <200605111520.30203.rjw@sisk.pl> <200605120945.52477.ncunningham@cyclades.com> <20060512101754.A2182805@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060512101754.A2182805@wobbly.melbourne.sgi.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Pá 12-05-06 10:17:54, Nathan Scott wrote:
> On Fri, May 12, 2006 at 09:45:48AM +1000, Nigel Cunningham wrote:
> > On Thursday 11 May 2006 23:20, Rafael J. Wysocki wrote:
> > > On Thursday 11 May 2006 02:11, Nigel Cunningham wrote:
> > > > On Thursday 11 May 2006 09:38, Andrew Morton wrote:
> > > > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > > > > On Wednesday 10 May 2006 00:27, Andrew Morton wrote:
> > > > >
> > > > > There can be situations where we won't be waiting on this IO at all.
> > > > > Network zero-copy transmit, for example.
> > > > >
> > > > > Or maybe there's some async writeback going on against pagecache -
> > > > > we'll end up looking at the page's LRU state within interrupt context
> > > > > at IO completion.  (A sync would prevent this from happening).
> > > >
> > > > I believe more than a sync is needed in at least some cases. I've seen
> > > > XFS continue to submit I/O (presumably on the sb or such like) after
> > > > everything else has been frozen and data has been synced. Freezing bdevs
> > > > addressed this.
> 
> [just came across this, missed it before, sorry]
> 
> The above is correct - sync means get current state safe ondisk, it
> doesn't mean flush all dirty metadata to its final resting place
> (subtle difference).  XFS will flush and wait on its journal on
> sync, which means theres a reconstructable state for all of the
> currently-incore-dirty-metadata ondisk, so it does not also flush
> and wait on that currently-incore-dirty-metadata.  It doesn't need
> to, it has already ensured thats written elsewhere on disk, in the
> journal.  And should the unthinkable happen, that metadata will be
> correctly recovered on the next mount when the journal is replayed.
> 
> Block device freeze, unmount and/or remount,ro will all ensure that
> all incore-dirty-metadata is also flushed and waited on.

Who does the background writing? I'd prefer not to do blockdev
freezing in swsusp (and we do not currently do it).

Simple fix is probably to put proper refrigerator support into that
particular background writing thread.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
