Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264018AbUCZLNc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 06:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264016AbUCZLNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 06:13:32 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:35007 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S264018AbUCZLNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 06:13:31 -0500
Date: Fri, 26 Mar 2004 11:06:19 +0000
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, mpm@selenic.com,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: potential /dev/urandom scalability improvement
Message-ID: <20040326110619.GA25210@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, davidm@hpl.hp.com,
	davidm@napali.hpl.hp.com, mpm@selenic.com,
	linux-kernel@vger.kernel.org
References: <20040325141923.7080c6f0.akpm@osdl.org> <20040325224726.GB8366@waste.org> <16483.35656.864787.827149@napali.hpl.hp.com> <20040325180014.29e40b65.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040325180014.29e40b65.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2004 at 06:00:14PM -0800, Andrew Morton wrote:

 > +static inline void prefetch_range(void *addr, size_t len)
 > +{
 > +#ifdef ARCH_HAS_PREFETCH
 > +	char *cp;
 > +	char *end = addr + len;
 > +
 > +	for (cp = addr; cp < end; cp += PREFETCH_STRIDE)
 > +		prefetch(cp);
 > +#endif
 > +}
 > +
 >  #endif

I think this may be dangerous on some CPUs, if may prefetch past
the end of the buffer. Ie, if PREFETCH_STRIDE was 32, and len
was 65, we'd end up prefetching 65->97. As well as being
wasteful to cachelines, this can crash if theres for eg
nothing mapped after the next page boundary.

		Dave

