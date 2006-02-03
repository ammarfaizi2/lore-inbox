Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945941AbWBCUNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945941AbWBCUNl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 15:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945942AbWBCUNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 15:13:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25520 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1945939AbWBCUNj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 15:13:39 -0500
Date: Fri, 3 Feb 2006 12:13:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: dada1@cosmosbay.com, davem@davemloft.net, linux-kernel@vger.kernel.org,
       shai@scalex86.org, netdev@vger.kernel.org, pravins@calsoftinc.com,
       bcrl@kvack.org
Subject: Re: [patch 3/4] net: Percpufy frequently used variables --
 proto.sockets_allocated
Message-Id: <20060203121303.0f9d0249.akpm@osdl.org>
In-Reply-To: <20060203193714.GB3653@localhost.localdomain>
References: <20060126185649.GB3651@localhost.localdomain>
	<20060126190357.GE3651@localhost.localdomain>
	<43D9DFA1.9070802@cosmosbay.com>
	<20060127195227.GA3565@localhost.localdomain>
	<20060127121602.18bc3f25.akpm@osdl.org>
	<20060127224433.GB3565@localhost.localdomain>
	<20060127150106.38b9e041.akpm@osdl.org>
	<20060203030547.GB3612@localhost.localdomain>
	<20060202191600.3bf3a64a.akpm@osdl.org>
	<20060203193714.GB3653@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
>
> On Thu, Feb 02, 2006 at 07:16:00PM -0800, Andrew Morton wrote:
> > Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> > >
> > > On Fri, Jan 27, 2006 at 03:01:06PM -0800, Andrew Morton wrote:
> > > Here's an implementation which delegates tuning of batching to the user.  We
> > > don't really need local_t at all as percpu_counter_mod is not safe against
> > > interrupts and softirqs  as it is.  If we have a counter which could be
> > > modified in process context and irq/bh context, we just have to use a
> > > wrapper like percpu_counter_mod_bh which will just disable and enable bottom
> > > halves.  Reads on the counters are safe as they are atomic_reads, and the
> > > cpu local variables are always accessed by that cpu only.
> > > 
> > > (PS: the maxerr for ext2/ext3 is just guesstimate)
> > 
> > Well that's the problem.  We need to choose production-quality values for
> > use in there.
> 
> The guesstimate was loosely based on keeping the per-cpu batch at atleast 8
> on reasonably sized systems, while not letting maxerr grow too big.  I guess
> machines with cpu counts more than 128 don't use ext3 :).  And if they do,
> they can tune the counters with a higher maxerr.  I guess it might be a bit
> ugly on the user side with all the if num_possibl_cpus(), but is there a
> better alternative?
> 
> (I plan to test the counter values for ext2 and ext3 on a 16 way box, and
> change these if they turn out to be not so good)

OK, thanks.  Frankly I think I went overboard on the scalability thing when
adding percpu counters to ext2 and ext3.  I suspect they're not providing
significant benefit over per-sb-spinlock and a ulong.

> > 
> > > Comments?
> > 
> > Using num_possible_cpus() in that header file is just asking for build
> > errors.  Probably best to uninline the function rather than adding the
> > needed include of cpumask.h.
> 
> Yup,
> 
> Here it is.
> 
> Change the percpu_counter interface so that user can specify the maximum
> tolerable deviation.

OK, thanks.  I need to sit down and a) remember why we're even discussing
this and b) see what we've merged thus far and work out what it all does ;)

