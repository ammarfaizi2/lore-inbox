Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbVGGWBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVGGWBa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 18:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbVGGWBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 18:01:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19138 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261539AbVGGWAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 18:00:23 -0400
Date: Thu, 7 Jul 2005 14:59:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mike Richards <mrmikerich@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Swap partition vs swap file
Message-Id: <20050707145944.3ad8a1ab.akpm@osdl.org>
In-Reply-To: <516d7fa805070712506ab2094b@mail.gmail.com>
References: <516d7fa80506281757188b2fda@mail.gmail.com>
	<20050628220334.66da4656.akpm@osdl.org>
	<516d7fa805070712506ab2094b@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Richards <mrmikerich@gmail.com> wrote:
>
> > > Given this situation, is there any significant performance or
> > >  stability advantage to using a swap partition instead of a swap file?
> > 
> > In 2.6 they have the same reliability and they will have the same
> > performance unless the swapfile is badly fragmented.
> 
> Thanks for the reply -- that's been bugging me for a while now. There
> are a lot of different opinions on the net, and most of the
> conventional wisdom says use a partition instead of a file. It's nice
> to hear from an expert on the matter.
> 
> Three more short questions if you have time:
> 
> 1. You specify kernel 2.6 -- What about kernel 2.4? How less reliable
> or worse performing is a swapfile on 2.4?

2.4 is weaker: it has to allocate memory from the main page allocator when
performing swapout.  2.6 avoids that.

> 2. Is it possible for the swapfile to become fragmented over time, or
> does it just keep using the same blocks over and over? i.e. if it's
> all contiguous when you first create the swapfile, will it stay that
> way for the life of the file?

The latter.  Create the swapfile when the filesystem is young and empty,
it'll be nice and contiguous.  Once created the kernel will never add or
remove blocks.  The kernel won't let you use a sparse file for a swapfile.

> 3. Does creating the swapfile on a journaled filesystem (e.g. ext3 or
> reiser) incur a significant performance hit?

None at all.  The kernel generates a map of swap offset -> disk blocks at
swapon time and from then on uses that map to perform swap I/O directly
against the underlying disk queue, bypassing all caching, metadata and
filesystem code.
