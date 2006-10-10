Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964913AbWJJDln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbWJJDln (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 23:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbWJJDln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 23:41:43 -0400
Received: from gate.crashing.org ([63.228.1.57]:52431 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964913AbWJJDln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 23:41:43 -0400
Subject: Re: ptrace and pfn mappings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       Linux Memory Management <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>, Jes Sorensen <jes@sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20061010025821.GE15822@wotan.suse.de>
References: <20061009140354.13840.71273.sendpatchset@linux.site>
	 <20061009140447.13840.20975.sendpatchset@linux.site>
	 <1160427785.7752.19.camel@localhost.localdomain>
	 <452AEC8B.2070008@yahoo.com.au>
	 <1160442987.32237.34.camel@localhost.localdomain>
	 <20061010022310.GC15822@wotan.suse.de>
	 <1160448466.32237.59.camel@localhost.localdomain>
	 <20061010025821.GE15822@wotan.suse.de>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 13:40:56 +1000
Message-Id: <1160451656.32237.83.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-10 at 04:58 +0200, Nick Piggin wrote:
> On Tue, Oct 10, 2006 at 12:47:46PM +1000, Benjamin Herrenschmidt wrote:
> > 
> > > Switch the mm and do a copy_from_user? (rather than the GUP).
> > > Sounds pretty ugly :P
> > > 
> > > Can you do a get_user_pfns, and do a copy_from_user on the pfn
> > > addresses? In other words, is the memory / mmio at the end of a
> > > given address the same from the perspective of any process? It
> > > is for physical memory of course, which is why get_user_pages
> > > works...
> > 
> > Doesn't help with the racyness.
> 
> I don't understand what the racyness is that you can solve by accessing
> it from the target process's mm?

You get a struct page or a pfn, you race with the migration, and access
something that isn't the "current" one. Doing an actual access goes
through the normal mmu path which guarantees that after the migration
has finished its unmap_mapping_ranges(), no access via those old PTEs is
possible (tlbs have been flushed etc...). We don't get such guarantee if
we get a struct page or a pfn and go peek at it.

> > > What if you hold your per-object lock over the operation? (I guess
> > > it would have to nest *inside* mmap_sem, but that should be OK).
> > 
> > Over the ptrace operation ? how so ?
> 
> You just have to hold it over access_process_vm, AFAIKS. Once it
> is copied into the kernel buffer that's done. Maybe I misunderstood
> what the race is?

But since when ptrace knows about various private locks of objects that
are backing vma's ?

Ben.


