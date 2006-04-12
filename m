Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbWDLV2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWDLV2j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 17:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbWDLV2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 17:28:39 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:8891 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932101AbWDLV2i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 17:28:38 -0400
Subject: Re: [Ext2-devel] Re: [RFC][PATCH 0/3] ext3 percpu counter fixes to
	suppport for ext3 unsigned long type free blocks counter
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Christoph Lameter <clameter@sgi.com>, akpm@osdl.org,
       Laurent Vivier <Laurent.Vivier@bull.net>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <20060411222012.GA5007@localhost.localdomain>
References: <1144691929.3964.53.camel@dyn9047017067.beaverton.ibm.com>
	 <Pine.LNX.4.64.0604111007230.564@schroedinger.engr.sgi.com>
	 <1144782073.3986.15.camel@dyn9047017067.beaverton.ibm.com>
	 <20060411222012.GA5007@localhost.localdomain>
Content-Type: text/plain
Organization: IBM LTC
Date: Wed, 12 Apr 2006 14:28:35 -0700
Message-Id: <1144877315.3722.26.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-11 at 15:20 -0700, Ravikiran G Thirumalai wrote:
> On Tue, Apr 11, 2006 at 12:01:13PM -0700, Mingming Cao wrote:
> > On Tue, 2006-04-11 at 10:09 -0700, Christoph Lameter wrote:
> > > On Mon, 10 Apr 2006, Mingming Cao wrote:
> > > 
> > > > Here are the proposed patches to allow the ext3 free block accounting
> > > > works with more than 8TB storage.
> > > 
> > > Umm.. This is an issue on 32 bit platforms only. 64bit platforms x86_64, 
> > > ia64 etc do not need this. Would you make it arch specific?
> > 
> > Yes, make sense. I will update my patch soon. Thanks.
> 
I was thinking something like this:

+void percpu_counter_mod_ul(struct percpu_counter *fbc, long amount)
+{
+       preempt_disable();
+       __percpu_counter_mod(fbc, amount, BITS_PER_LONG<=32);
+       preempt_enable();
+}
+EXPORT_SYMBOL(percpu_counter_mod_ul);


where the check for unsigned long overflow is only turned on 32 bit
platforms.

> Or make the counter s64? so that it stays 64 bit on all arches? 
> 

Well, don't we have the problem : 64 bit counter add/dec/update is not
always atomic on all 32 bit platforms? There are risk that we will get
bogus global value. 

> OR
> why not change the global per-cpu counter type to unsigned long (as we
> discussed earlier), so we don't need the extra "ul" flags and interfaces, 
> and all arches get a standard unsigned long return type? 
>  We could also 
> do away with percpu_read_positive then no?  The applications for per-cpu 
> counters is going to be upcounters always methinks...
> 

yeah...I am not so happy with the extra "ul" checking flags either. But
as you have mentioned before, the signed global counter type is there
for some cases when the global counter becomes temporally negative
( although the counter in real life should always positive). What should
we do if the global counter is a unsigned value, was initialized to 0,
and now we add -5 to it(-5 is from one local counter, then we will get a
bogus big value)?

ext3 free blocks counter is always initialized to a big positive value
so I doubt above concern is a real issue for ext3. Perhaps you thought
this through that it's okay to change the global counter to unsigned
long for other applications of PCP counters?

Thanks,
Mingming

