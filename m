Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbTH2UWX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 16:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262364AbTH2UWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 16:22:08 -0400
Received: from web12807.mail.yahoo.com ([216.136.174.42]:15450 "HELO
	web12807.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262296AbTH2UUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 16:20:04 -0400
Message-ID: <20030829202001.38031.qmail@web12807.mail.yahoo.com>
Date: Fri, 29 Aug 2003 13:20:01 -0700 (PDT)
From: Shantanu Goel <sgoel01@yahoo.com>
Subject: Re: [VM PATCH] Faster reclamation of dirty pages and unused inode/dcache entries in 2.4.22
To: Andrea Arcangeli <andrea@suse.de>
Cc: Antonio Vargas <wind@cocodriloo.com>, linux-kernel@vger.kernel.org,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
In-Reply-To: <20030829195543.GD24409@dualathlon.random>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the pointer to the benchmarks.

The patch I posted only helps the mmap case so it
won't help (or hurt hopefully ;-) any program that
primarily does read/write instead of mmap.  The
extreme case where I observed this was a perl script
that created a gigantic hash and tried to populate it.
 The perl in question uses mmap for malloc.  The
difference in execution time between stock 2.4.22 and
one with the patch was insignificant because it is
primarily I/O bound, however the other apps I was
running, Mozilla and several xterm's, were paged out
much less frequently in the latter case.  The machine
has 256MB of memory and perl grew to about 1 GB.

I have written another patch that more aggresively
tries to free pages with dirty buffers which should
help with the buffer I/O case.  It essentially changes
try_to_free_buffers() so it immediately starts and
waits for I/O to complete if the gfp_mask allows it. 
It does not do any clustering so its performance is
questionable at the moment.

--- Andrea Arcangeli <andrea@suse.de> wrote:
> On Fri, Aug 29, 2003 at 12:46:36PM -0700, Shantanu
> Goel wrote:
> > Andrea,
> > 
> > I'll test and submit a patch against -aa.  Also,
> is
> > there a common benchmark that you use to test for
> > regression?
> 
> bonnie,tiobench,dbench would be a very good start
> for the basics (note:
> dbench can be misleading, but at the same fariness
> levels, it's
> interesting too, it's just that dbench doesn't
> measure the fariness
> level itself [like tiobench started doing relatively
> recently]).
> 
> (I'm assuming the patch makes difference not only
> for mmapped dirty
> pages, in such case the above would be non
> interesting)
> 
> thanks,
> 
> Andrea


__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
