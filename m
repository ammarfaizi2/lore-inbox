Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbULXS5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbULXS5s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 13:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbULXS5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 13:57:48 -0500
Received: from canuck.infradead.org ([205.233.218.70]:23057 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261421AbULXS5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 13:57:43 -0500
Subject: Re: Prezeroing V2 [0/3]: Why and When it works
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, Christoph Lameter <clameter@sgi.com>,
       Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       linux-mm@kvack.org, Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0412241018430.2654@ppc970.osdl.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com>
	 <41C20E3E.3070209@yahoo.com.au>
	 <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com>
	 <16843.13418.630413.64809@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.58.0412231325420.2654@ppc970.osdl.org>
	 <1103879668.4131.15.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0412241018430.2654@ppc970.osdl.org>
Content-Type: text/plain
Date: Fri, 24 Dec 2004 19:57:28 +0100
Message-Id: <1103914648.4131.29.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-24 at 10:21 -0800, Linus Torvalds wrote:
> 
> On Fri, 24 Dec 2004, Arjan van de Ven wrote:
> > 
> > problem is.. will it buy you anything if you use the page again
> > anyway... since such pages will be cold cached now. So for sure some of
> > it is only shifting latency from kernel side to userspace side, but
> > readprofile doesn't measure the later so it *looks* better...
> 
> Absolutely. I would want to see some real benchmarks before we do this.  
> Not just some microbenchmark of "how many page faults can we take without
> _using_ the page at all".
> 
> I agree 100% with you that we shouldn't shift the costs around. Having a
> hice hot-spot that we know about is a good thing, and it means that
> performance profiles show what the time is really spent on. Often getting
> rid of the hotspot just smears out the work over a wider area, making
> other optimizations (like trying to make the memory footprint _smaller_
> and removing the work entirely that way) totally impossible because now
> the performance profile just has a constant background noise and you can't 
> tell what the real problem is.

I suspect it's even worse.
Think about it; you can spew 4k of zeroes into your L1 cache really fast
(assuming your cpu is smart enough to avoid write-allocate for rep
stosl; not sure which cpus are). I suspect you can do that faster than a
cachemiss or two. And at that point the page is cache hot... so reads
don't miss either.

all this makes me wonder if there is any scenario where this thing will
be a gain, other than cpus that aren't smart enough to avoid the write-
allocate.


