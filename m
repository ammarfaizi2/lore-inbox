Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264547AbTDYXFq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 19:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264551AbTDYXFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 19:05:45 -0400
Received: from air-2.osdl.org ([65.172.181.6]:55983 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264547AbTDYXFl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 19:05:41 -0400
Subject: Re: [PATCH 2.5.68 2/2] i_size atomic access
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030425035727.6f107236.akpm@digeo.com>
References: <1051230056.2448.16.camel@ibm-c.pdx.osdl.net>
	 <20030424180503.2c2a8bea.akpm@digeo.com>
	 <20030425014208.GC26194@dualathlon.random>
	 <20030425035727.6f107236.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1051312669.2446.85.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 25 Apr 2003 16:17:49 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-04-25 at 03:57, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > On Thu, Apr 24, 2003 at 06:05:03PM -0700, Andrew Morton wrote:
> > > And if the race _does_ hit, what is the effect?  Assuming stat() was fixed
> > > with i_sem, I don't think the race has a very serious effect.  We won't
> > 
> > writepage needs it too to avoid returning -EIO and I doubt you want to
> > take the i_sem in writepage
> 
> Well the -EIO thing is bogus really, but yes.  The writepage will not hit
> disk *at all*.  That's a problem.
> 
> We modify i_size in very few places - an alternative might be to maintain a
> parallel unsigned long i_size>>PAGE_CACHE_SIZE in the inode and use that in
> critical places.  Sounds messy though.
> 
> Ho hum.  ugh.

It is problems like this that worry me.  Wouldn't this cause silent data
corruption?  My stat() test just shows the window is small but there.
Of course, I would also prefer that stat() always gives the right
answer.  Taking i_sem in sys_stat() would add more overhead to
sys_stat() and it would write the inode cache line.

The overhead on reading i_size is an extra 4-bytes and and 2 rmb()s
and this in only on preempt or SMP.  Also, i_size_read() only reads
the inode fields, so on SMP it does not bounce the cache lines around.

The overhead on the write side is very small with just the updates to
the sequence value.

I ran some bonnie++ tests on 2-proc machines and did not notice any
difference between 2.5.68 and 2.5.68-isize.

The i_size patch fixes the file systems that use the generic interfaces
and added i_size_write()s for ext3.  I wanted to get these changes in
before checking and fixing all the other file systems.

I'll see if I can think up a test to see the problem shows up somewhere
besides sys_stat.  Any ideas?

Any ideas on tests to run to measure the overhead of this patch?

Thanks,

-- 
Daniel McNeil <daniel@osdl.org>

