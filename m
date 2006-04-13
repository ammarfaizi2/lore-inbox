Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965001AbWDMWZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbWDMWZo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 18:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbWDMWZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 18:25:44 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:44509 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932467AbWDMWZn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 18:25:43 -0400
Subject: Re: [Ext2-devel] Re: [RFC][PATCH 0/3] ext3 percpu counter fixes to
	suppport for ext3 unsigned long type free blocks counter
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Christoph Lameter <clameter@sgi.com>, akpm@osdl.org,
       Laurent Vivier <Laurent.Vivier@bull.net>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <20060413190214.GA4172@localhost.localdomain>
References: <1144691929.3964.53.camel@dyn9047017067.beaverton.ibm.com>
	 <Pine.LNX.4.64.0604111007230.564@schroedinger.engr.sgi.com>
	 <1144782073.3986.15.camel@dyn9047017067.beaverton.ibm.com>
	 <20060411222012.GA5007@localhost.localdomain>
	 <1144877315.3722.26.camel@dyn9047017067.beaverton.ibm.com>
	 <20060413190214.GA4172@localhost.localdomain>
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 13 Apr 2006 15:25:39 -0700
Message-Id: <1144967139.3763.29.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-13 at 12:02 -0700, Ravikiran G Thirumalai wrote:
> On Wed, Apr 12, 2006 at 02:28:35PM -0700, Mingming Cao wrote:
> > On Tue, 2006-04-11 at 15:20 -0700, Ravikiran G Thirumalai wrote:
> > > On Tue, Apr 11, 2006 at 12:01:13PM -0700, Mingming Cao wrote:
> > > > On Tue, 2006-04-11 at 10:09 -0700, Christoph Lameter wrote:
> > 
> > 
> > where the check for unsigned long overflow is only turned on 32 bit
> > platforms.
> > 
> > > Or make the counter s64? so that it stays 64 bit on all arches? 
> > > 
> > 
> > Well, don't we have the problem : 64 bit counter add/dec/update is not
> > always atomic on all 32 bit platforms? There are risk that we will get
> > bogus global value. 
> 
> Yes, but the global counter is modified with a lock in the SMP case, and the
> local counters are modified by their respective cpus only,  Although there 
> might be more subtle issues ..... 
> 
Hmm, I was worried about the read to the 64 bit global counter, there is
no lock to protect it from getting an half updated 64 bit counter. But I
think the window is probably small, and with what Andreas suggested
(keep the local per cpu counter as 32 bit value), we would avoid this
non-atomic math in most cases.

Well,anyway this counter is just an approximate value, and currently
(with 32 bit global counter) we could still read an old global counter
value while it's being updated since no lock is required while read it.

> > 
> > > OR
> > > why not change the global per-cpu counter type to unsigned long (as we
> > > discussed earlier), so we don't need the extra "ul" flags and interfaces, 
> > > and all arches get a standard unsigned long return type? 
> > >  We could also 
> > > do away with percpu_read_positive then no?  The applications for per-cpu 
> > > counters is going to be upcounters always methinks...
> > > 
> > 
> > yeah...I am not so happy with the extra "ul" checking flags either. But
> > as you have mentioned before, the signed global counter type is there
> > for some cases when the global counter becomes temporally negative
> > ( although the counter in real life should always positive). What should
> > we do if the global counter is a unsigned value, was initialized to 0,
> > and now we add -5 to it(-5 is from one local counter, then we will get a
> > bogus big value)?
> 
> I thought the solution to this was to have a global unsigned counter, and
> signed local counter, and defer updates to the global if it is going to be a 
> large value due to the case above. This way the global counter remains an up 
> counter no?
> 

I think that will work, and we could get rid of the cheating
percpu_counter_read_positive() totally;)

So I think we could combine these two together: make the global counter
an unsigned 64 bit (u64) and keep the per cpu counter still signed 32
bit type, and also, defer updates the global counter to the global if
the end result is larger that before. This way we could have remove the
need for percpu_counter_read_positive(), and also allow the counter
being used for 64 bit accounting on 32 bit arch.

Comments?

Mingming

> Thanks,
> Kiran

