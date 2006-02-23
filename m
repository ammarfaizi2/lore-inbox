Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751683AbWBWJrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683AbWBWJrp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 04:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751685AbWBWJrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 04:47:45 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:54475 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1751682AbWBWJrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 04:47:45 -0500
Subject: Re: [Patch 1/3] prefetch the mmap_sem in the fault path
From: Arjan van de Ven <arjan@intel.linux.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <200602231039.36338.ak@suse.de>
References: <1140686152.2972.25.camel@laptopd505.fenrus.org>
	 <1140687007.4672.6.camel@laptopd505.fenrus.org>
	 <200602231039.36338.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 23 Feb 2006 10:47:38 +0100
Message-Id: <1140688058.4672.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-23 at 10:39 +0100, Andi Kleen wrote:
> On Thursday 23 February 2006 10:30, Arjan van de Ven wrote:
> > In a micro-benchmark that stresses the pagefault path, the down_read_trylock
> > on the mmap_sem showed up quite high on the profile. Turns out this lock is
> > bouncing between cpus quite a bit and thus is cache-cold a lot. This patch
> > prefetches the lock (for write) as early as possible (and before some other
> > somewhat expensive operations). With this patch, the down_read_trylock
> > basically fell out of the top of profile.
> 
> It is hard to believe because you effectively didn't do the prefetch
> very early

all you need is a few dozen cycles though; there's a cr2 move and the
entire notifier inbetween.... neither of those is really cheap.


(and after patch 3/3 also a page allocation/clear)

