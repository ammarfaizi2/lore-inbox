Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbWCIMO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbWCIMO4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 07:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbWCIMO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 07:14:56 -0500
Received: from ozlabs.org ([203.10.76.45]:53701 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932473AbWCIMOz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 07:14:55 -0500
Date: Thu, 9 Mar 2006 23:14:16 +1100
From: "'David Gibson'" <david@gibson.dropbear.id.au>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: wli@holomorphy.com, "'Andrew Morton'" <akpm@osdl.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] hugetlb strict commit accounting
Message-ID: <20060309121416.GD9479@localhost.localdomain>
Mail-Followup-To: 'David Gibson' <david@gibson.dropbear.id.au>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>, wli@holomorphy.com,
	'Andrew Morton' <akpm@osdl.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
References: <20060309112635.GB9479@localhost.localdomain> <200603091202.k29C24g19696@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603091202.k29C24g19696@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 04:02:06AM -0800, Chen, Kenneth W wrote:
> David Gibson wrote on Thursday, March 09, 2006 3:27 AM
> > Again, there are no changes to the fault handler.  Including the
> > promised changes which would mean my instantiation serialization path
> > isn't necessary ;-).
> 
> This is the major portion that I omitted in the first patch and is the
> real kicker that fulfills the promise of guaranteed available hugetlb
> page for shared mapping.
> 
> You can shower me all over on the lock protection :-) yes, this is not
> perfect and was the reason I did not post it earlier, but I want to give
> you the concept on how I envision this route would work.
> 
> Again PRIVATE mapping is busted, you can't count them from inode.  You
> would have to count them via mm_struct (I think).

I don't think there's any sane way to reserve for PRIVATE mappings.
To do it strictly you'd have to reaccount the whole block on every
fork(), and that would mean that any process using >0.5 of the
system's hugepages could never fork(), even if the child was just
going to exec().

Given that, it's simplest just to allow free overcommit for PRIVATE
mappings.  *But* you can ensure that PRIVATE allocations (i.e. COW
faults) don't mess with any previously reserved SHARED mappings.

> Note: definition of "reservation" in earlier patch is total hugetlb pages
> needed for that file, including the one that is already faulted in.  Maybe
> that throw you off a bit because I'm guessing your definition is "needed
> in the future" and probably you are looking for a decrement of the counter
> in the fault path?

No, I realised that distinction.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
