Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267893AbUGaCCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267893AbUGaCCw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 22:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267895AbUGaCCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 22:02:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59883 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267893AbUGaCCu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 22:02:50 -0400
Date: Fri, 30 Jul 2004 23:01:27 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: kladit@t-online.de, linux-kernel@vger.kernel.org
Subject: Re: dentry cache leak? Re: rsync out of memory 2.6.8-rc2
Message-ID: <20040731020127.GC4798@logos.cnet>
References: <20040726150615.GA1119@xeon2.local.here> <20040729140743.170acb3e.akpm@osdl.org> <20040730163007.GA2931@logos.cnet> <20040730124744.0eb11f63.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040730124744.0eb11f63.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2004 at 12:47:44PM -0700, Andrew Morton wrote:
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> >
> > On Thu, Jul 29, 2004 at 02:07:43PM -0700, Andrew Morton wrote:
> > > kladit@t-online.de (Klaus Dittrich) wrote:
> > > >
> > > > >Can you narrow the onset of the problem down to any particular kernel
> > > > >snapshot?
> > > > 
> > > > Did it and here is the answer.
> > > > 
> > > > kernel-2.6.7 and bk's up to 2.6.7-bk7 survived a du -s,
> > > > kernels starting with 2.6.7-bk8 did not.
> > > 
> > > I can reproduce this oom btw.  Am (very, very slowly) working out what's
> > > causing it.  It's unrelated to the vfs-cache-pressure patch.  I'd hope to
> > > have it fixed up for 2.6.8. 
> > 
> > Odd, because the only thing I can see which affects dcache related code
> > between -bk7 and -bk8 is the vfs-cache-pressure patch.
> 
> It can be triggered with that patch reverted.
> 
> > What are the exact steps you're using to reproduce the leak?
> 
> Just a `du -s' over zillions of files on a 2G machine.
> 
> > And where do you think the problem lies?
> 
> Seems that we reach a state where lowmem pagecache get reclaimed faster
> than dcache/icache.  This causes the number of pages scanned for lowmem
> allocations to fall.  This causes less scanning of the slab and the whole
> thing repeats.  I expect changing nr_used_zone_pages() to ignore highmem
> will fix it, and might be the long-term fix, too.

I'll try making that change to nr_used_zone_pages() tomorrow morning and see 
what happens. 

But, why does Klaus claim he can't trigger the bug with -bk7 and only -bk8 ? 
