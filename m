Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbULWU1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbULWU1o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 15:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbULWU1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 15:27:43 -0500
Received: from news.suse.de ([195.135.220.2]:56229 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261288AbULWU1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 15:27:39 -0500
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Prezeroing V2 [0/3]: Why and When it works
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com.suse.lists.linux.kernel>
	<41C20E3E.3070209@yahoo.com.au.suse.lists.linux.kernel>
	<Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com.suse.lists.linux.kernel>
	<Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 23 Dec 2004 21:27:38 +0100
In-Reply-To: <Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com.suse.lists.linux.kernel>
Message-ID: <p73ekhgzrnp.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> writes:
>   and why other approaches have not worked.
> o Instead of zero_page(p,order) extend clear_page to take second argument
> o Update all architectures to accept second argument for clear_pages

Sorry if there was a miscommunication, but ...
> 1. Aggregating zeroing operations to only apply to pages of higher order,
> which results in many pages that will later become order 0 to be
> zeroed in one go. For that purpose the existing clear_page function is
> extended and made to take an additional argument specifying the order of
> the page to be cleared.

But if you do that you should really use a separate function that 
can use cache bypassing stores. 

Normal clear_page cannot use that because it would be a loss
when the data is soon used.

So the two changes don't really make sense.

Also I must say I'm still suspicious regarding your heuristic
to trigger gang faulting - with bad luck it could lead to a lot 
more memory usage to specific applications that do very sparse
usage of memory. 

There should be at least an madvise flag to turn it off and a sysctl 
and it would be better to trigger only on a longer sequence of 
consecutive faulted pages.


> 2. Hardware support for offloading zeroing from the cpu. This avoids
> the invalidation of the cpu caches by extensive zeroing operations.
> 
> The result is a significant increase of the page fault performance even for
> single threaded applications:
[...]

How about some numbers on i386? 


-Andi
