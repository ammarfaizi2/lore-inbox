Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbUCNUrM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 15:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUCNUrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 15:47:12 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:5077 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261601AbUCNUrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 15:47:09 -0500
Date: Sun, 14 Mar 2004 21:47:01 +0100
From: Jens Axboe <axboe@suse.de>
To: Chris Mason <mason@suse.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: [PATCH] per-backing dev unplugging #2
Message-ID: <20040314204701.GA2649@suse.de>
References: <20040311083619.GH6955@suse.de> <1079121113.4181.189.camel@watt.suse.com> <20040312120322.0108a437.akpm@osdl.org> <20040312200253.GA16880@suse.de> <1079123647.4186.211.camel@watt.suse.com> <20040312203452.GD16880@suse.de> <1079124097.4187.216.camel@watt.suse.com> <20040312205104.GE16880@suse.de> <1079297032.4185.277.camel@watt.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079297032.4185.277.camel@watt.suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14 2004, Chris Mason wrote:
> On Fri, 2004-03-12 at 15:51, Jens Axboe wrote:
> > On Fri, Mar 12 2004, Chris Mason wrote:
> > > On Fri, 2004-03-12 at 15:34, Jens Axboe wrote:
> > > 
> > > > 
> > > > I don't see how this can make too much of a difference, aside of perhaps
> > > > just moving the window a little. If page->mapping can disappear here,
> > > > that's still a possibility.
> > > 
> > > As Andrew pointed out, the mapping struct won't disappear, but
> > > page->mapping may go null.  So the idea is to use barriers to get a
> > > trusted copy of page->mapping, and use the copy everywhere.
> > 
> > So trusting an atomic assignment of mapping = page->mapping, it should
> > work. It feels a bit icky, though.
> 
> I reproduced on 2.6.4-mm1 + backing dev, but 2.6.4-mm1 alone ran fine. 
> To make a long story short, the swap address space and backing dev don't
> define an unplug_io_fn.  I was able to reproduce quickly with a swap
> heavy workload.  The patch below should fix the oops, but probably isn't
> correct solution since no queues will get unplugged while waiting on
> swap pages.

Duh of course, that's pretty silly actually. So the question is if we
want to keep assigning a dummy unplug_io_fn (default_backing_dev already
has it), or just keep the check. I propose to check like Chris added,
and just kill the default_unplug_io_fn() from readahead.c

Thanks for fixing this Chris, I wonder why your back trace from this
oops was so screwy (->unplug_io_fn() for the swap space was zero-filled,
no?)

-- 
Jens Axboe

