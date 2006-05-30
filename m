Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWE3JHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWE3JHM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 05:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWE3JHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 05:07:12 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:31791 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932193AbWE3JHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 05:07:10 -0400
Date: Tue, 30 May 2006 11:05:49 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mason@suse.com, andrea@suse.de, hugh@veritas.com,
       torvalds@osdl.org
Subject: Re: [rfc][patch] remove racy sync_page?
Message-ID: <20060530090549.GF4199@suse.de>
References: <447AC011.8050708@yahoo.com.au> <20060529121556.349863b8.akpm@osdl.org> <447B8CE6.5000208@yahoo.com.au> <20060529183201.0e8173bc.akpm@osdl.org> <447BB3FD.1070707@yahoo.com.au> <20060529201444.cd89e0d8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529201444.cd89e0d8.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29 2006, Andrew Morton wrote:
> On Tue, 30 May 2006 12:54:53 +1000
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> > Andrew Morton wrote:
> > 
> > >On Tue, 30 May 2006 10:08:06 +1000
> > >Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> > >
> > >
> > >>Which is what I want to know. I don't exactly have an interesting
> > >>disk setup.
> > >>
> > >
> > >You don't need one - just a single disk should show up such problems.  I
> > >forget which workloads though.  Perhaps just a linear read (readahead
> > >queues the I/O but doesn't unplug, subsequent lock_page() sulks).
> > >
> > 
> > I guess so. Is plugging still needed now that the IO layer should
> > get larger requests? Disabling it might result in a small initial
> > request (although even that may be good for pipelining)...
> 
> Mysterious question, that.  A few years ago I think Jens tried pulling
> unplugging out, but some devices still want it (magneto-optical
> storage iirc).  And I think we did try removing it, and it caused
> hurt.

I did, back when we had problems due to the blk_plug_lock being a global
one. I first wanted to investigate if plugging still made a difference,
otherwise we could've just ripped it out back than and the problem would
be solved. But it did get us about a 10% boost on normal SCSI drives
(don't think I tested MO drives at all), so it was fixed up.

> > sync_page wants to get either the current mapping, or a NULL one.
> > The sync_page methods must then be able to handle running into a
> > NULL mapping.
> > 
> > With splice, the mapping can change, so you can have the wrong
> > sync_page callback run against the page.
> 
> Oh.

Maybe I'm being dense, but I don't see a problem there. You _should_
call the new mapping sync page if it has been migrated.

> > >>Well yes, writing to a page would be the main reason to set it dirty.
> > >>Is splice broken as well? I'm not sure that it always has a ref on the
> > >>inode when stealing a page.
> > >>
> > >
> > >Whereabouts?
> > >
> > 
> > The ->pin() calls in pipe_to_file and pipe_to_sendpage?
> 
> One for Jens...

splice never incs/decs any inode related reference counts, so if it
needs to then yes it's broken. Any references to kernel code that deals
with that?

-- 
Jens Axboe

