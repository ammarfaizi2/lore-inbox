Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264936AbUFGQzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264936AbUFGQzF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 12:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264937AbUFGQzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 12:55:04 -0400
Received: from mail.ccur.com ([208.248.32.212]:46093 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S264936AbUFGQyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 12:54:50 -0400
Date: Mon, 7 Jun 2004 12:54:46 -0400
From: Joe Korty <joe.korty@ccur.com>
To: William Lee Irwin III <wli@holomorphy.com>, Paul Jackson <pj@sgi.com>,
       mikpe@csd.uu.se, nickpiggin@yahoo.com.au, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, akpm@osdl.org, ak@muc.de,
       ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       manfred@colorfullife.com, colpatch@us.ibm.com, Simon.Derr@bull.net
Cc: linux-kernel@vger.kernel.org
Subject: fix up compat_sched_[get/set]affinity
Message-ID: <20040607165445.GA22234@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <1086313667.29381.897.camel@bach> <40BFD839.7060101@yahoo.com.au> <20040603221854.25d80f5a.pj@sgi.com> <16576.16748.771295.988065@alkaid.it.uu.se> <20040604090314.56d64f4d.pj@sgi.com> <20040604165601.GC21007@holomorphy.com> <20040604170542.576b4243.pj@sgi.com> <20040605013139.GM21007@holomorphy.com> <20040605010444.6a384e6c.pj@sgi.com> <20040605082647.GQ21007@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040605082647.GQ21007@holomorphy.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 05, 2004 at 01:26:47AM -0700, William Lee Irwin III wrote:
> On Sat, Jun 05, 2004 at 01:04:44AM -0700, Paul Jackson wrote:
> > That looks more readable.  Thanks.
> > Do you see a sensible way to pass back an odd number of u32's?  If
> > NR_CPUS is say 8, then the 32 bit user code might expect to only need
> > one compat_ulong_t, not two.  If NR_CPUS is 48, then it should only need
> > 3, not 4.   And so forth.
> > As I noted in another reply, perhaps your bitmap_to_u32_array() code
> > could be modified to handle this.
> > And I agree with Andrew's suggestion, that cpumask provide the
> > conversion, to and from kernel memory, separately from copying the
> > result to user space.
> 
> So do it in the caller, e.g..
> 
> int copy_cpus_to_user32(const u32 __user *ubuf, cpumask_t cpus)
> {
> 	int i, ret, len = ALIGN(NR_CPUS, 32)/(32/sizeof(u32));
> 	u32 *ary = kmalloc(sizeof(cpumask_t), GFP_KERNEL);
> 	if (!ary)
> 		return -ENOMEM;
> 	cpus_to_u32_array(ary, cpus);
> 	ret = copy_to_user(ubuf, ary, len);
> 	kfree(ary);
> 	return ret;
> }
> 
> int copy_cpus_from_user32(cpumask_t *cpus, const u32 __user *ubuf)
> {
> 	int i, ret, len = ALIGN(NR_CPUS, 32)/(32/sizeof(u32));
> 	u32 *ary = kmalloc(sizeof(cpumask_t), GFP_KERNEL);
> 	if (!ary)
> 		return -ENOMEM;
> 	if (!(ret = copy_from_user(ary, ubuf, len)))
> 		cpus_from_u32_array(cpus, ary);
> 	kfree(ary);
> 	return ret;
> }
> 
> or some such nonsense, or whatever someone can be arsed to consider a
> better idea. One should note such a reformatting, as a user ABI change
> in a stable series, would be unfriendly to 64-bit userspace on BE boxen.
> i.e. do this only for 32-bit target userspace on 64-bit kernels + boxen.




Possible algorithms for the support routines needed by wli's code, above.
Completely untested, hope to refine and test soon.


void bitmap_to_compat_bitmap(compat_ulong_t *dest, const ulong_t *src, int nmaskbits)
{
	ulong_t word;
	int i, j;

	for (j=0; j < nmaskbits; ) {
		word = *dest++;
		for (i=0; j < nmaskbits && i < BITS_PER_LONG; ) {
			*src++ = word >> i;
			i += BITS_PER_COMPAT_LONG;
			j += BITS_PER_COMPAT_LONG;
		}
	}
}

void compat_bitmap_to_bitmap(ulong_t *dest, const compat_ulong_t *src, int nmaskbits)
{
	ulong_t word;
	int i,j;

	for (j=0; j < nmaskbits; ) {
		word = 0;
		for (i=0; j < nmaskbits && i < BITS_PER_LONG; ) {
			word |= *src++ << i;
			i += BITS_PER_COMPAT_LONG;
			j += BITS_PER_COMPAT_LONG;
		}
		*dest++ = word;
	}
}
