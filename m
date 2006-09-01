Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbWIAQEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWIAQEJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 12:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWIAQEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 12:04:08 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:50622 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP id S932391AbWIAQED
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 12:04:03 -0400
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Andy Whitcroft <apw@shadowen.org>
Cc: Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au,
       frankeh@watson.ibm.com
In-Reply-To: <44F8563B.3050505@shadowen.org>
References: <20060901110948.GD15684@skybase>
	 <1157122667.28577.69.camel@localhost.localdomain>
	 <1157124674.21733.13.camel@localhost>  <44F8563B.3050505@shadowen.org>
Content-Type: text/plain
Organization: IBM Corporation
Date: Fri, 01 Sep 2006 18:04:00 +0200
Message-Id: <1157126640.21733.43.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 16:48 +0100, Andy Whitcroft wrote:
> >> I know that there are 32-bit s390 kernels, but would this be a
> >> reasonable feature to restrict to only 64-bit kernels?  That might be a
> >> decent compromise.
> > 
> > Yes, it is definitly an option to make this a 64-bit only features. In
> > particular because the ESSA instruction that is used on s390 is only
> > available in zarch mode (=64 bit).
> 
> Wow.  Well there are only 7 extra bits available in 64 bit mode (the
> FIELDS area is larger on 64bit machines).  Do we really, really need
> three new bits.  What are they being used for here.

I have though about alternatives for the page bits hard and long and I
could not find a way how to do it without the bits. Their use is:
1) The page-is-discarded (PG_discarded) bit is set for pages that have
been recognized as removed by the host. The page needs to be removed
from the page cache while there are still page references floating
around. To prevent multiple removals from the page cache the discarded
bit is needed.
2) The page-state-change (PG_state_change) bit is required to prevent
that an make_stable "overtakes" a make_volatile. In order to make a page
volatile a number of conditions are check. After this is done the state
change will be done. The critical section is the code that performs the
checks up to the instruction that does the state change. No make_stable
may be done in between. The granularity is per page, to use a global
lock like a spinlock would severly limit the scalability for large smp
systems.
3) The page-has-a-writable-mapping (PG_writable) bit is set when the
first writable pte for a page is established. The page needs to have a
different state if a writable pte exists compared to a read-only page.
The alternative without the page bit would be to do the state change
every time a writable pte is established or to search all ptes of a
given page. Both have performance implications. 

Overall I fear that the code really needs three additional bits.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


