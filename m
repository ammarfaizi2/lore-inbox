Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264776AbSJORRF>; Tue, 15 Oct 2002 13:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264777AbSJORRF>; Tue, 15 Oct 2002 13:17:05 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:3962 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S264776AbSJORRD>; Tue, 15 Oct 2002 13:17:03 -0400
To: colpatch@us.ibm.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       LSE <lse-tech@lists.sourceforge.net>, Andrew Morton <akpm@zip.com.au>,
       Martin Bligh <mjbligh@us.ibm.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [rfc][patch] Memory Binding API v0.3 2.5.41
References: <3DA4D3E4.6080401@us.ibm.com> <m165w6m12t.fsf@frodo.biederman.org>
	<3DAB5DF2.5000002@us.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 15 Oct 2002 11:21:26 -0600
In-Reply-To: <3DAB5DF2.5000002@us.ibm.com>
Message-ID: <m1y98z39ex.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson <colpatch@us.ibm.com> writes:

> Eric W. Biederman wrote:
> > Matthew Dobson <colpatch@us.ibm.com> writes:
> >>Greetings & Salutations,
> >>	Here's a wonderful patch that I know you're all dying for...  Memory
> >>Binding!  It works just like CPU Affinity (binding) except that it binds a
> >>processes memory allocations (just buddy allocator for now) to specific memory
> 
> >>blocks.
> > Due we want this per numa area or simply per zone?  My suspicion is that
> > internally at least we want this per zone.
> I think that per memory block is better. 
[snip]
> I'm not fanatically
> opposed to per zone binding, though, and if there is a general agreement that it
> would be better that way, I don't think it would be unreasonably difficult to
> change it.

My only feeling with zones is that it could be useful in the non numa cases,
if it was per zone. 

But unless this API becomes is a pure hint we need at least one specifier that 
says writing to swap is o.k.

> > The API doesn't make much sense at the moment.
> Hmm..  That is unfortunate, I'd aimed to make it as simple as possible.

Simple is good only if the proper pieces are connected.
 
> > 1) You are operating on tasks and not mm's, or preferably vmas.
> Correct.  There are plans (somewhere inside my cranium) to allow binding at that
> 
> granularity.  For now, per task seemed an appropriate level.

It makes it terribly unpredictable.  If you have two threads each bound
to a different location there are race conditions which area the memory
is allocated from.  

> > 2) sys_mem_setbinding does not move the mm to the new binding.
> Also correct.  A task may wish to allocate several large data structures from
> one memory area, rebind, do more allocations, rebind, ad nauseum. There are
> plans to have a flag that, if set, would force relocation of all currently
> allocated memory.

Actually the bindings need to stick to the vma or to the struct address_space.
Otherwise you are talking about an allocation hint, as swapping can trivially
undue it and nothing happens when the actual call is made.  A hint is a very
different thing from a binding.

And if we stick this to struct address_space for the non anonymous cases
having a fmem_setbinding(struct fd) that works on files would be a useful
thing as well.

> > 5) mprotect is the more natural model rather than set_cpu_affinity.
> Well, I think that may be true for the API you are imagining (per zone, per
> mm/vma, etc), not the one that I've written.

For a binding with respect to memory I imagine things like mlock().  For
anything else you are talking a future hint to the memory allocators, which
feels less much useful.

Eric
