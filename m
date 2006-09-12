Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030412AbWILUaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030412AbWILUaR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 16:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030419AbWILUaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 16:30:17 -0400
Received: from waste.org ([66.93.16.53]:55943 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030412AbWILUaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 16:30:15 -0400
Date: Tue, 12 Sep 2006 15:28:26 -0500
From: Matt Mackall <mpm@selenic.com>
To: David Howells <dhowells@redhat.com>
Cc: Aubrey <aubreylee@gmail.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org, davidm@snapgear.com, gerg@snapgear.com
Subject: Re: kernel BUGs when removing largish files with the SLOB allocator
Message-ID: <20060912202826.GC19707@waste.org>
References: <20060912174339.GA19707@waste.org> <6d6a94c50609032356t47950e40lbf77f15136e67bc5@mail.gmail.com> <17162.1157365295@warthog.cambridge.redhat.com> <6d6a94c50609042052n4c1803eey4f4412f6153c4a2b@mail.gmail.com> <3551.1157448903@warthog.cambridge.redhat.com> <6d6a94c50609051935m607f976j942263dd1ac9c4fb@mail.gmail.com> <44FE4222.3080106@yahoo.com.au> <6d6a94c50609120107w1942a8d8j368dd57a271d0250@mail.gmail.com> <24525.1158089104@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24525.1158089104@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 08:25:04PM +0100, David Howells wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> 
> > Looking through all the users of kobjsize, it seems we always know
> > what the type is (and it's usually a VMA). I instead propose we use
> > ksize on objects we know to be SLAB/SLOB-allocated and add a new
> > function (kpagesize?) to size other objects where nommu needs it.
> 
> It sounds like we'd need an op in the VMA to do the per-type size thing (the
> VMA itself not the VMA ops table).

Not sure yet. There's only one user in nommu.c that shouldn't just be
changed to ksize() that I can see, and that's the one in
show_process_blocks(). That could test for VM_MAPPED_COPY and keep its
hands off otherwise. 

I can imagine situations where ->mmap returns pointers to something
that's statically allocated anyway (XIP?), where kobjsize doesn't
really make sense.

Also, looks like the WARN_ON_SLACK code has rotten, result isn't
defined in that function. Change it to base, perhaps?

-- 
Mathematics is the supreme nostalgia of our time.
