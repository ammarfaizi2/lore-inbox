Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWELASr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWELASr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 20:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWELASr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 20:18:47 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:25238 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750713AbWELASq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 20:18:46 -0400
Date: Fri, 12 May 2006 10:17:54 +1000
From: Nathan Scott <nathans@sgi.com>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, pavel@suse.cz
Subject: Re: [PATCH -mm] swsusp: support creating bigger images (rev. 2)
Message-ID: <20060512101754.A2182805@wobbly.melbourne.sgi.com>
References: <200605021200.37424.rjw@sisk.pl> <200605111011.23508.ncunningham@cyclades.com> <200605111520.30203.rjw@sisk.pl> <200605120945.52477.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200605120945.52477.ncunningham@cyclades.com>; from ncunningham@cyclades.com on Fri, May 12, 2006 at 09:45:48AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2006 at 09:45:48AM +1000, Nigel Cunningham wrote:
> On Thursday 11 May 2006 23:20, Rafael J. Wysocki wrote:
> > On Thursday 11 May 2006 02:11, Nigel Cunningham wrote:
> > > On Thursday 11 May 2006 09:38, Andrew Morton wrote:
> > > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > > > On Wednesday 10 May 2006 00:27, Andrew Morton wrote:
> > > >
> > > > There can be situations where we won't be waiting on this IO at all.
> > > > Network zero-copy transmit, for example.
> > > >
> > > > Or maybe there's some async writeback going on against pagecache -
> > > > we'll end up looking at the page's LRU state within interrupt context
> > > > at IO completion.  (A sync would prevent this from happening).
> > >
> > > I believe more than a sync is needed in at least some cases. I've seen
> > > XFS continue to submit I/O (presumably on the sb or such like) after
> > > everything else has been frozen and data has been synced. Freezing bdevs
> > > addressed this.

[just came across this, missed it before, sorry]

The above is correct - sync means get current state safe ondisk, it
doesn't mean flush all dirty metadata to its final resting place
(subtle difference).  XFS will flush and wait on its journal on
sync, which means theres a reconstructable state for all of the
currently-incore-dirty-metadata ondisk, so it does not also flush
and wait on that currently-incore-dirty-metadata.  It doesn't need
to, it has already ensured thats written elsewhere on disk, in the
journal.  And should the unthinkable happen, that metadata will be
correctly recovered on the next mount when the journal is replayed.

Block device freeze, unmount and/or remount,ro will all ensure that
all incore-dirty-metadata is also flushed and waited on.

cheers.

-- 
Nathan
