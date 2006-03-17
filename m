Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbWCQRMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbWCQRMu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 12:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbWCQRMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 12:12:50 -0500
Received: from gold.veritas.com ([143.127.12.110]:44631 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1030210AbWCQRMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 12:12:49 -0500
X-IronPort-AV: i="4.03,105,1141632000"; 
   d="scan'208"; a="57336749:sNHT34991864"
Date: Fri, 17 Mar 2006 17:13:16 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Roland Dreier <rdreier@cisco.com>
cc: Andrew Morton <akpm@osdl.org>, "Bryan O'Sullivan" <bos@pathscale.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org,
       hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Remapping pages mapped to userspace (was: [PATCH 10 of 20] ipath
 - support for userspace apps using core driver)
In-Reply-To: <adad5gmne20.fsf_-_@cisco.com>
Message-ID: <Pine.LNX.4.61.0603171631240.32660@goblin.wat.veritas.com>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
 <ada4q27fban.fsf@cisco.com> <1141948516.10693.55.camel@serpentine.pathscale.com>
 <ada1wxbdv7a.fsf@cisco.com> <1141949262.10693.69.camel@serpentine.pathscale.com>
 <20060309163740.0b589ea4.akpm@osdl.org> <1142470579.6994.78.camel@localhost.localdomain>
 <ada3bhjuph2.fsf@cisco.com> <1142475069.6994.114.camel@localhost.localdomain>
 <adaslpjt8rg.fsf@cisco.com> <1142477579.6994.124.camel@localhost.localdomain>
 <20060315192813.71a5d31a.akpm@osdl.org> <1142485103.25297.13.camel@camp4.serpentine.com>
 <20060315213813.747b5967.akpm@osdl.org> <Pine.LNX.4.61.0603161332090.21570@goblin.wat.veritas.com>
 <adad5gmne20.fsf_-_@cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 17 Mar 2006 17:12:49.0197 (UTC) FILETIME=[04698DD0:01C649E6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2006, Roland Dreier wrote:

> Anyway, I'd like to hijack this thread slightly, since we are close to
> a subject that I've been thinking about lately, and I'd like to take
> advantage of the expert's attention...

I look over my shoulder, ah yes, you're speaking to Alan, who's given
you a good reply.  But he's looking at it from a bus/driver perspective,
which I can't comment on, so I'll return to your original mail.

> My mthca driver (drivers/infiniband/hw/mthca) supports mapping some
> MMIO registers into userspace via io_remap_pfn_range() in a .mmap
> method.  I think I have that pretty well under control.
> 
> However, on a hot unplug event, when the underlying PCI device is
> going away, I would like to replace that mapping with a mapping (with
> a mapping to the zero page?), so that userspace accesses after the
> device is gone don't explode.  What's the "right" way to do that?

Nobody has asked for that before (so far as I know; or maybe I'm just
not looking at your question from the right angle), so I don't have
any canned right answer.

Sounds a reasonable thing to ask for, especially from the hotplug world.
But it's not how we've proceeded until now: things stay open until the
last user goes away, only then can the driver go away.

Thus a file remains open, and its filesystem busily mounted, until
the last user unmaps or closes it.

You seem to be asking to "revoke" an mmap: not unreasonable, but
we've never provided a revoke method before, and I fear there
might be gotchas.  Perhaps there's a different, more familiar
model I can feel more comfortable with...

Shall we look at it, instead, as like truncating a file?  You could
use vmtruncate, but you'll have nothing cached, so maybe just use
unmap_mapping_range (see mm/memory.c for args), which is also exported.
Only one caller on the inode(mapping) at once, please (on a regular
file, inode->i_sem is held; but that won't quite work with a device).

So far as I can see, that should work nicely (even, fortuitously,
despite Linus' special adjustment of vm_pgoff on VM_PFNMAP areas).
Though it looks like subsequent userspace accesses will then go to
do_anonymous_page, giving ZERO_PAGE to read faults or a fresh anon
page to write faults: I think I'd prefer it if pte_none accesses in
a VM_PFNMAP area gave SIGBUS, but unsure if we can change that now.

> Presumably it would be something like zeromap_page_range(), but that's
> not exported to modules.  Exporting that would be one option, but in a
> way that's overkill for me: I only have a single page to deal with, so
> I could also do something like
> 
> 	vm_insert_page(vma, addr, ZERO_PAGE(addr));
> 
> But do I have to do anything to kill the old mapping coming from
> remap_pfn_range()?  What's the exported API to do that?

vm_insert_page will fail with -EBUSY if there's something there
already; and though it looks as if it'll do the right thing with
ZERO_PAGE(addr) if the mapping was read-only, it'll very nastily
give write access to it if the mapping was read-write.

But I see no point in inserting pages there anyway: the important
part is removing the old ptes, which unmap_mapping_range should do.

> I can keep a list of vmas that have registers mapped to userspace and
> iterate through it on hot unplug.  The only question is what to do
> with those vmas.

unmap_mapping_range will work its own way through the prio_tree of
all vmas mapping your device: so I think it'll spare you some effort.

But it hasn't been used in this way before: I may be missing things.

Hugh
