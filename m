Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267799AbUG3Ttm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267799AbUG3Ttm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 15:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267815AbUG3Ttl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 15:49:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:11677 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267799AbUG3TtS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 15:49:18 -0400
Date: Fri, 30 Jul 2004 12:47:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: kladit@t-online.de, linux-kernel@vger.kernel.org
Subject: Re: dentry cache leak? Re: rsync out of memory 2.6.8-rc2
Message-Id: <20040730124744.0eb11f63.akpm@osdl.org>
In-Reply-To: <20040730163007.GA2931@logos.cnet>
References: <20040726150615.GA1119@xeon2.local.here>
	<20040729140743.170acb3e.akpm@osdl.org>
	<20040730163007.GA2931@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> On Thu, Jul 29, 2004 at 02:07:43PM -0700, Andrew Morton wrote:
> > kladit@t-online.de (Klaus Dittrich) wrote:
> > >
> > > >Can you narrow the onset of the problem down to any particular kernel
> > > >snapshot?
> > > 
> > > Did it and here is the answer.
> > > 
> > > kernel-2.6.7 and bk's up to 2.6.7-bk7 survived a du -s,
> > > kernels starting with 2.6.7-bk8 did not.
> > 
> > I can reproduce this oom btw.  Am (very, very slowly) working out what's
> > causing it.  It's unrelated to the vfs-cache-pressure patch.  I'd hope to
> > have it fixed up for 2.6.8. 
> 
> Odd, because the only thing I can see which affects dcache related code
> between -bk7 and -bk8 is the vfs-cache-pressure patch.

It can be triggered with that patch reverted.

> What are the exact steps you're using to reproduce the leak?

Just a `du -s' over zillions of files on a 2G machine.

> And where do you think the problem lies?

Seems that we reach a state where lowmem pagecache get reclaimed faster
than dcache/icache.  This causes the number of pages scanned for lowmem
allocations to fall.  This causes less scanning of the slab and the whole
thing repeats.  I expect changing nr_used_zone_pages() to ignore highmem
will fix it, and might be the long-term fix, too.

