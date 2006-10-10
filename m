Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964967AbWJJSHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbWJJSHz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 14:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWJJSHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 14:07:55 -0400
Received: from excu-mxob-1.symantec.com ([198.6.49.12]:43149 "EHLO
	excu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S964967AbWJJSHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 14:07:54 -0400
Date: Tue, 10 Oct 2006 19:06:32 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Christoph Hellwig <hch@infradead.org>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>, Jes Sorensen <jes@sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: ptrace and pfn mappings
In-Reply-To: <20061010123128.GA23775@infradead.org>
Message-ID: <Pine.LNX.4.64.0610101827130.14815@blonde.wat.veritas.com>
References: <20061009140354.13840.71273.sendpatchset@linux.site>
 <20061009140447.13840.20975.sendpatchset@linux.site>
 <1160427785.7752.19.camel@localhost.localdomain> <452AEC8B.2070008@yahoo.com.au>
 <1160442987.32237.34.camel@localhost.localdomain> <20061010123128.GA23775@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Oct 2006 18:06:19.0830 (UTC) FILETIME=[C99B8560:01C6EC96]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006, Christoph Hellwig wrote:
> On Tue, Oct 10, 2006 at 11:16:27AM +1000, Benjamin Herrenschmidt wrote:
> > 
> > The "easy" way out I can see, but it may have all sort of bad side
> > effects I haven't thought about at this point, is to switch the mm in
> > access_process_vm (at least if it's hitting such a VMA).
> 
> Switching the mm is definitly no acceptable.  Too many things could
> break when violating the existing assumptions.

I disagree.  Ben's switch-mm approach deserves deeper examination than
that.  It's both simple and powerful.  And it's already done by AIO's
use_mm - the big differences being, of course, that the kthread has
no original mm of its own, and it's limited in what it gets up to.

What would be the actual problems with ptrace temporarily adopting
another's mm?  What are our existing assumptions?

We do already have the minor issue that expand_stack uses the wrong
task's rlimits (there was a patch for that, perhaps Nick's fault
struct would help make it less intrusive to fix - I was put off
it by having to pass an additional arg down so many levels).

> I think the best idea is to add a new ->access method to the vm_operations
> that's called by access_process_vm() when it exists and VM_IO or VM_PFNMAP
> are set.   ->access would take the required object locks and copy out the
> data manually.  This should work both for spufs and drm.

I find Ben's idea more appealing; but agree it _may_ prove unworkable.

Hugh
