Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWFLRg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWFLRg4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 13:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWFLRg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 13:36:56 -0400
Received: from smtp-out.google.com ([216.239.45.12]:16496 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750769AbWFLRgy (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 13:36:54 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=FH78ifDbiR0vVaDzGom0+I7NsbF6AsnDRmAlc9BdGY8howjjs23CMTgWB3XRs+db5
	ophEO8kPzzz6YpkGqmIkQ==
Subject: Re: [PATCH]: Adding a counter in vma to indicate the number
	of	physical pages backing it
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Linux-mm@kvack.org,
       Linux-kernel@vger.kernel.org
In-Reply-To: <448A762F.7000105@yahoo.com.au>
References: <1149903235.31417.84.camel@galaxy.corp.google.com>
	 <448A762F.7000105@yahoo.com.au>
Content-Type: text/plain
Organization: Google Inc
Date: Mon, 12 Jun 2006 10:36:34 -0700
Message-Id: <1150133795.9576.19.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-10 at 17:35 +1000, Nick Piggin wrote:
> Rohit Seth wrote:
> > Below is a patch that adds number of physical pages that each vma is
> > using in a process.  Exporting this information to user space
> > using /proc/<pid>/maps interface.
> > 
> > There is currently /proc/<pid>/smaps that prints the detailed
> > information about the usage of physical pages but that is a very
> > expensive operation as it traverses all the PTs (for some one who is
> > just interested in getting that data for each vma).
> 
> Yet more cacheline footprint in the page fault and unmap paths...
> 

Not necessarily.  If I'm doing calculation right then vm_struct is
currently 176 bytes (without the addition of nphys) on my x86_64 box. So
in this case addition would not result in bigger cache foot print of
page fulats. Also currently two adjacent vmas share a cache line.  So
there is already that much of cache line ping pong going on. 

Though I agree that we should try to not extend this size beyond
absolutely necessary.

> What is this used for and why do we want it? Could you do some
> smaps-like interface that can work on ranges of memory, and
> continue to walk pagetables instead?
> 

It is just the price of those walks that makes smaps not an attractive
solution for monitoring purposes.

I'm thinking if it is possible to extend current interfaces (possibly
having a new system call) in such a way that a user land process can
give some hints/preferences to kernel in terms of <pid, virtual_range>
to remove/inactivate.  This can help in keeping the current kernel
behavior for vmscans but at the same time provide little bit of
non-symmetry for user land applications.  Thoughts?

-rohit

