Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264119AbUCZSuJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 13:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264120AbUCZSuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 13:50:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:40105 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264119AbUCZSuC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 13:50:02 -0500
Date: Fri, 26 Mar 2004 10:49:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, davej@redhat.com, mpm@selenic.com,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: potential /dev/urandom scalability improvement
Message-Id: <20040326104904.59f7a156.akpm@osdl.org>
In-Reply-To: <16484.29095.842735.102236@napali.hpl.hp.com>
References: <20040325141923.7080c6f0.akpm@osdl.org>
	<20040325224726.GB8366@waste.org>
	<16483.35656.864787.827149@napali.hpl.hp.com>
	<20040325180014.29e40b65.akpm@osdl.org>
	<20040326110619.GA25210@redhat.com>
	<16484.29095.842735.102236@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger <davidm@napali.hpl.hp.com> wrote:
>
> >>>>> On Fri, 26 Mar 2004 11:06:19 +0000, Dave Jones <davej@redhat.com> said:
> 
>   Dave> On Thu, Mar 25, 2004 at 06:00:14PM -0800, Andrew Morton wrote:
>   >> +static inline void prefetch_range(void *addr, size_t len) +{
>   >> +#ifdef ARCH_HAS_PREFETCH + char *cp; + char *end = addr + len; +
>   >> + for (cp = addr; cp < end; cp += PREFETCH_STRIDE) +
>   >> prefetch(cp); +#endif +} + #endif
> 
>   Dave> I think this may be dangerous on some CPUs, if may prefetch
>   Dave> past the end of the buffer. Ie, if PREFETCH_STRIDE was 32, and
>   Dave> len was 65, we'd end up prefetching 65->97. As well as being
>   Dave> wasteful to cachelines, this can crash if theres for eg
>   Dave> nothing mapped after the next page boundary.
> 
> Huh?  It only ever prefetches addresses that are _within_ the
> specified buffer.  Of course it will prefetch entire cachelines, but I
> hope you're not worried about cachlines crossing page-boundaries! ;-))
> 

But the start address which is fed into prefetch_range() may not be
cacheline-aligned.  So if appropriately abused, a prefetch_range() could
wander off the end of the user's buffer and into a new page.

I think this gets it right, but I probably screwed something up.

static inline void prefetch_range(void *addr, size_t len)
{
#ifdef ARCH_HAS_PREFETCH
	char *cp;
	unsigned long end;

	end = ((unsigned long)addr + len + PREFETCH_STRIDE - 1);
	end &= ~(PREFETCH_STRIDE - 1);

	for (cp = addr; cp < (char *)end; cp += PREFETCH_STRIDE)
		prefetch(cp);
#endif
}

