Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbWJJMb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbWJJMb4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 08:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965021AbWJJMb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 08:31:56 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:6616 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965162AbWJJMbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 08:31:55 -0400
Date: Tue, 10 Oct 2006 13:31:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Nick Piggin <npiggin@suse.de>,
       Hugh Dickins <hugh@veritas.com>,
       Linux Memory Management <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>, Jes Sorensen <jes@sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: ptrace and pfn mappings
Message-ID: <20061010123128.GA23775@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Nick Piggin <npiggin@suse.de>, Hugh Dickins <hugh@veritas.com>,
	Linux Memory Management <linux-mm@kvack.org>,
	Andrew Morton <akpm@osdl.org>, Jes Sorensen <jes@sgi.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>
References: <20061009140354.13840.71273.sendpatchset@linux.site> <20061009140447.13840.20975.sendpatchset@linux.site> <1160427785.7752.19.camel@localhost.localdomain> <452AEC8B.2070008@yahoo.com.au> <1160442987.32237.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160442987.32237.34.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 11:16:27AM +1000, Benjamin Herrenschmidt wrote:
> And the last of my "issues" here:
> 
> get_user_pages() can't handle pfn mappings, thus access_process_vm()
> can't, and thus ptrace can't. When they were limited to dodgy /dev/mem
> things, it was probably ok. But with more drivers needing that, like the
> DRM, sound drivers, and now with SPU problem state registers and local
> store mapped that way, it's becoming a real issues to be unable to
> access any of those mappings from gdb.
> 
> The "easy" way out I can see, but it may have all sort of bad side
> effects I haven't thought about at this point, is to switch the mm in
> access_process_vm (at least if it's hitting such a VMA).

Switching the mm is definitly no acceptable.  Too many things could
break when violating the existing assumptions.

> That do you guys think ? Any better idea ? The problem with mappings
> like what SPUfs or the DRM want is that they can change (be remapped
> between HW and backup memory, as described in previous emails), thus we
> don't want to get struct pages even if available and peek at them as
> they might not be valid anymore, same with PFNs (we could imagine
> ioremap'ing those PFN's but that would be racy too). The only way that
> is guaranteed not to be racy is to do exactly what a user do, that is do
> user accesses via the target process vm itself....

I think the best idea is to add a new ->access method to the vm_operations
that's called by access_process_vm() when it exists and VM_IO or VM_PFNMAP
are set.   ->access would take the required object locks and copy out the
data manually.  This should work both for spufs and drm.
