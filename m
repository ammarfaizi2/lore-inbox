Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160999AbWJDReV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160999AbWJDReV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964919AbWJDReU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:34:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41902 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964920AbWJDReU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:34:20 -0400
Date: Wed, 4 Oct 2006 10:34:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: tim.c.chen@linux.intel.com
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, herbert@gondor.apana.org.au,
       linux-kernel@vger.kernel.org, leonid.i.ananiev@intel.com
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
Message-Id: <20061004103408.1a38b8ad.akpm@osdl.org>
In-Reply-To: <1159978929.8035.109.camel@localhost.localdomain>
References: <1159916644.8035.35.camel@localhost.localdomain>
	<4522FB04.1080001@goop.org>
	<1159919263.8035.65.camel@localhost.localdomain>
	<45233B1E.3010100@goop.org>
	<1159968095.8035.76.camel@localhost.localdomain>
	<20061004093025.ab235eaa.akpm@osdl.org>
	<1159978929.8035.109.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Oct 2006 09:22:09 -0700
Tim Chen <tim.c.chen@linux.intel.com> wrote:

> On Wed, 2006-10-04 at 09:30 -0700, Andrew Morton wrote:
> 
> > > I have measured the cache miss with tool.  So it is not just my theory.
> > > 
> > 
> > And what did that tool tell you?
> 
> I am using emon.  Measuring a 20 second stretch of tbench run saw the L2
> cache miss go from 14 million to 25 million on each of the cpu core.
> > 
> > Please don't just ignore my questions.  *why* are we getting a cache miss
> > rate on that integer which is causing measurable performance changes?  If
> > we're reading it that frequently then the variable should be in cache(!).
> > 
> 
> The point is valid, __warn_once should be in cache, unless something
> evicts it. What I have found so far is with patch by Andrew and Leonid
> that avoid looking up the __warn_once integer, the cache miss rate is
> reduced to the level before.  
> 
> > Again: do you know which callsite is causing the problem?  I assume one of
> > the ones in softirq.c?  Do you know what the cache miss frequency is?  etc.
> > 
> Unfortunately emon does not directly give the callsite.  Oprofile data
> shows a marked increase in time spent in do_softirq and local_bh_enable.
> What I could do is to individually turn off WARN_ON_ONCE at these sites
> and see if they are responsible for the cache miss.  Will let you know
> what I found.

I see, thanks.  How very peculiar.

I wonder if we just got unlucky and that particular benchmark with that
particular kernel build just happens to reach the cache system's
associativity threshold, and this one extra cacheline took it over the
edge.  Or something.

But if that was the case, one would expect even a small change to the
kernel (say, a different compiler version, or different config) would
improve things a lot, or would worsen things a lot.

I think the change is right.  But, again, I worry that any teeny change we
make in there in the future will bring the problem back.

