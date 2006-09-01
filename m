Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWIAQSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWIAQSU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 12:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWIAQST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 12:18:19 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:45006 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932158AbWIAQSS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 12:18:18 -0400
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
From: Dave Hansen <haveblue@us.ibm.com>
To: schwidefsky@de.ibm.com
Cc: Andy Whitcroft <apw@shadowen.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au,
       frankeh@watson.ibm.com
In-Reply-To: <1157126640.21733.43.camel@localhost>
References: <20060901110948.GD15684@skybase>
	 <1157122667.28577.69.camel@localhost.localdomain>
	 <1157124674.21733.13.camel@localhost>  <44F8563B.3050505@shadowen.org>
	 <1157126640.21733.43.camel@localhost>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 09:18:03 -0700
Message-Id: <1157127483.28577.117.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 18:04 +0200, Martin Schwidefsky wrote:
> 1) The page-is-discarded (PG_discarded) bit is set for pages that have
> been recognized as removed by the host. The page needs to be removed
> from the page cache while there are still page references floating
> around. To prevent multiple removals from the page cache the discarded
> bit is needed.

OK, so the page has data in it, and is in the page cache.  The
hypervisor kills the page, gives the notification to the kernel that the
page has gone away, and the kernel marks PG_discarded.  There still
might be active references to the page.

So, is the problem trying to communicate with the reference holders that
the page is no longer valid?  How is this fundamentally different from
page truncating?

> 2) The page-state-change (PG_state_change) bit is required to prevent
> that an make_stable "overtakes" a make_volatile. In order to make a page
> volatile a number of conditions are check. After this is done the state
> change will be done. The critical section is the code that performs the
> checks up to the instruction that does the state change. No make_stable
> may be done in between. The granularity is per page, to use a global
> lock like a spinlock would severly limit the scalability for large smp
> systems.

How about doing it in the NUMA node?  Or the mem_section?  Or, even a
bit in the mem_map[] for the area guarding the 'struct page' itself?
Even a hashed table of locks based on the page address.  You just need
something that allows _some_ level of concurrency.  You certainly never
have a number of CPUs which is anywhere close to the number of 'struct
page's in the system.

Let me think more about (3).

-- Dave

