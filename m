Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266154AbUGOO3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266154AbUGOO3b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 10:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266163AbUGOO3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 10:29:31 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:44141 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266154AbUGOOX5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 10:23:57 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Chris Wright <chrisw@osdl.org>
Subject: Re: [RFC] Lock free fd lookup
Date: Thu, 15 Jul 2004 10:22:53 -0400
User-Agent: KMail/1.6.2
Cc: Ravikiran G Thirumalai <kiran@in.ibm.com>, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com
References: <20040714045345.GA1220@obelix.in.ibm.com> <20040714045640.GB1220@obelix.in.ibm.com> <20040714081737.N1973@build.pdx.osdl.net>
In-Reply-To: <20040714081737.N1973@build.pdx.osdl.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407151022.53084.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, July 14, 2004 11:17 am, Chris Wright wrote:
> * Ravikiran G Thirumalai (kiran@in.ibm.com) wrote:
> > This makes use of the lockfree refcounting infrastructure (see earlier
> > posting today) to make files_struct.fd[] lookup lockfree. This is
> > carrying forward work done by Maneesh and Dipankar earlier.
> >
> > With the lockfree fd lookup patch, tiobench performance increases by 13%
> > for sequential reads, 21 % for random reads on a 4 processor pIII xeon.
>
> I'm curious, how much of the performance improvement is from RCU usage
> vs. making the basic syncronization primitive aware of a reader and
> writer distinction?  Do you have benchmark for simply moving to rwlock_t?

That's a good point.  Also, even though the implementation may be 'lockless', 
there are still a lot of cachelines bouncing around, whether due to atomic 
counters or cmpxchg (in fact the latter will be worse than simple atomics).

It seems to me that RCU is basically rwlocks on steroids, which means that 
using it requires the same care to avoid starvation and/or other scalability 
problems (i.e. we'd better be really sure that a given codepath really should 
be using rwlocks before we change it).

Jesse
