Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965076AbWDNATj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965076AbWDNATj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 20:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965070AbWDNATi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 20:19:38 -0400
Received: from ns1.siteground.net ([207.218.208.2]:44684 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S965067AbWDNATh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 20:19:37 -0400
Date: Thu, 13 Apr 2006 17:20:35 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Christoph Lameter <clameter@sgi.com>, akpm@osdl.org,
       Laurent Vivier <Laurent.Vivier@bull.net>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] Re: [RFC][PATCH 0/3] ext3 percpu counter fixes to suppport for ext3 unsigned long type free blocks counter
Message-ID: <20060414002035.GA9248@localhost.localdomain>
References: <1144691929.3964.53.camel@dyn9047017067.beaverton.ibm.com> <Pine.LNX.4.64.0604111007230.564@schroedinger.engr.sgi.com> <1144782073.3986.15.camel@dyn9047017067.beaverton.ibm.com> <20060411222012.GA5007@localhost.localdomain> <1144877315.3722.26.camel@dyn9047017067.beaverton.ibm.com> <20060413190214.GA4172@localhost.localdomain> <1144967139.3763.29.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1144967139.3763.29.camel@dyn9047017067.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 03:25:39PM -0700, Mingming Cao wrote:
> On Thu, 2006-04-13 at 12:02 -0700, Ravikiran G Thirumalai wrote:
> > ...
> > Yes, but the global counter is modified with a lock in the SMP case, and the
> > local counters are modified by their respective cpus only,  Although there 
> > might be more subtle issues ..... 
> > 
> Hmm, I was worried about the read to the 64 bit global counter, there is
> no lock to protect it from getting an half updated 64 bit counter. But I
> think the window is probably small, and with what Andreas suggested
> (keep the local per cpu counter as 32 bit value), we would avoid this
> non-atomic math in most cases.
> 
> Well,anyway this counter is just an approximate value, and currently
> (with 32 bit global counter) we could still read an old global counter
> value while it's being updated since no lock is required while read it.

Yup, and percpu_counter_exceeds should take care of the race in global
counter reads where it matters.


> > 
> > I thought the solution to this was to have a global unsigned counter, and
> > signed local counter, and defer updates to the global if it is going to be a 
> > large value due to the case above. This way the global counter remains an up 
> > counter no?
> > 
> 
> I think that will work, and we could get rid of the cheating
> percpu_counter_read_positive() totally;)
> 
> So I think we could combine these two together: make the global counter
> an unsigned 64 bit (u64) and keep the per cpu counter still signed 32
> bit type, and also, defer updates the global counter to the global if
> the end result is larger that before. This way we could have remove the
> need for percpu_counter_read_positive(), and also allow the counter
> being used for 64 bit accounting on 32 bit arch.
> 
> Comments?

Sounds OK to me.

Thanks,
Kiran

