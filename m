Return-Path: <linux-kernel-owner+w=401wt.eu-S1750997AbWLRBXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWLRBXM (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 20:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbWLRBXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 20:23:12 -0500
Received: from smtp.osdl.org ([65.172.181.25]:46634 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750994AbWLRBXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 20:23:11 -0500
Date: Sun, 17 Dec 2006 17:22:57 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
In-Reply-To: <20061217154026.219b294f.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612171716510.3479@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost> <20061217040620.91dac272.akpm@osdl.org>
 <1166362772.8593.2.camel@localhost> <20061217154026.219b294f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 17 Dec 2006, Andrew Morton wrote:
> 
> From my quick reading, all callers of try_to_free_buffers() have already
> unmapped the page from pagetables, and given that the reported ext3 corruption
> happens on uniprocessor, non-preempt kernels, I doubt if this patch will fix
> things.

Hmm. One possible explanation: maybe the page actually _did_ get unmapped 
from the page tables, but got added back?

I don't think we lock the page when faulting it in (we want it to be 
uptodate, but not necessarily locked). So assuming the pageout sequence 
always _does_ follow the rule that it only does try_to_free_buffers() on 
pages that aren't mapped, what actually protects them from not becoming 
mapped (and dirtied) during that sequence?

So we should probably do a "wait_for_page()" in do_no_page()?

Or maybe only do it for write accesses (since we don't really care about 
getting mapped readably)? If so, we need to do it in the write case of 
do_no_page() _and_ in the do_wp_page() case. Hmm?

		Linus
