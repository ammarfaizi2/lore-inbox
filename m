Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270038AbVBEUGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270038AbVBEUGl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 15:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269845AbVBEUGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 15:06:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21132 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S273737AbVBEUDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 15:03:14 -0500
Date: Sat, 5 Feb 2005 20:03:10 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Laurent Riffard <laurent.riffard@free.fr>, linux-kernel@vger.kernel.org,
       Matt Mackall <mpm@selenic.com>
Subject: Re: 2.6.11-rc3-mm1 : can't insmod dm-mod
Message-ID: <20050205200310.GN8859@parcelfarce.linux.theplanet.co.uk>
References: <20050204103350.241a907a.akpm@osdl.org> <4204880A.3010703@free.fr> <20050205032605.764eedac.akpm@osdl.org> <20050205162945.GA3928@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050205162945.GA3928@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2005 at 04:29:45PM +0000, Christoph Hellwig wrote:
> On Sat, Feb 05, 2005 at 03:26:05AM -0800, Andrew Morton wrote:
> > You've enabled CONFIG_BASE_SMALL and so the major_names[] hashtable has
> > just one element.  device-mapper uses dynamic major allocation, the range
> > of which is limited to the size of the top-level major_names[] array.  You
> > ran out of slots and register_blkdev() failed.
> > 
> > So for now I guess we must drop base-small-shrink-major_names-hash.patch.
> > 
> > Al, that code looks rather crappy.  Shouldn't we be using an idr tree or
> > something?
> 
> It'd be nice to see major_names just gone completely.  It's only used
> for /proc/devices output, and with the infrastucture for easily sharing
> majors that one is completely misleading..

ACK.  Moreover, dynamic registration of *majors* makes very little sense
these days - about as much as setting lower limit on IP block registration
to /12.

IMO we should put a large part of device number space for dynamic allocations
(current static ones barely scratch the surface - we could easily leave
upper half and nobody'd noticed) and use e.g. buddy allocator within it.
With allocation requests taking size of area as argument (rounded up to
power of 2, which it normally would be anyway).

Any objections to that?  Hell, we can even have register_blkdev() without
a fixed major calling blkdev_allocate(name, 1<<20) and then eliminate the
callers in favour of saner-sized requests.  Then kill register_blkdev()
completely...
