Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751476AbWF1Rlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbWF1Rlq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 13:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWF1Rlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 13:41:46 -0400
Received: from gold.veritas.com ([143.127.12.110]:34073 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751476AbWF1Rlp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 13:41:45 -0400
X-IronPort-AV: i="4.06,189,1149490800"; 
   d="scan'208"; a="61006059:sNHT30620048"
Date: Wed, 28 Jun 2006 18:41:21 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/5] mm: tracking shared dirty pages
In-Reply-To: <20060627182814.20891.36856.sendpatchset@lappy>
Message-ID: <Pine.LNX.4.64.0606281810370.16318@blonde.wat.veritas.com>
References: <20060627182801.20891.11456.sendpatchset@lappy>
 <20060627182814.20891.36856.sendpatchset@lappy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 28 Jun 2006 17:41:45.0002 (UTC) FILETIME=[1F94A0A0:01C69ADA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2006, Peter Zijlstra wrote:
> @@ -796,6 +797,44 @@ struct shrinker;
>  extern struct shrinker *set_shrinker(int, shrinker_t);
>  extern void remove_shrinker(struct shrinker *shrinker);
>  
> +#define VM_NOTIFY_NO_PROT	0x01
> +#define VM_NOTIFY_NO_MKWRITE	0x02
> +
> +/*
> + * Some shared mappigns will want the pages marked read-only
> + * to track write events. If so, we'll downgrade vm_page_prot
> + * to the private version (using protection_map[] without the
> + * VM_SHARED bit).
> + */
> +static inline int vma_wants_writenotify(struct vm_area_struct *vma, int flags)
> +{
> +	unsigned int vm_flags = vma->vm_flags;
> +
> +	/* If it was private or non-writable, the write bit is already clear */
> +	if ((vm_flags & (VM_WRITE|VM_SHARED)) != ((VM_WRITE|VM_SHARED)))
> +		return 0;
> +
> +	/* The backer wishes to know when pages are first written to? */
> +	if (!(flags & VM_NOTIFY_NO_MKWRITE) &&
> +			vma->vm_ops && vma->vm_ops->page_mkwrite)
> +		return 1;
> +
> +	/* The open routine did something to the protections already? */
> +	if (!(flags & VM_NOTIFY_NO_PROT) &&
> +			pgprot_val(vma->vm_page_prot) !=
> +			pgprot_val(protection_map[vm_flags &
> +				(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]))
> +		return 0;

Sorry to be such a bore, but this is far from an improvement.

Try to resist adding flags to condition how a function behaves:
there are a million places where it's necessary or accepted, but
avoid it if you reasonably can.  And negative flags are particularly
hard to understand ("SKIP" would have been easier than "NO").

Just separate out the pgprot_val check from vma_wants_writenotify,
making that additional test in the case of do_mmap_pgoff.  Or if
you prefer, go back to how you had it before, with mprotect_fixup
making sure that that test will succeed.

In the case of page_mkclean, I see no need for vma_wants_writenotify
at all: you're overdesigning for some imaginary use of page_mkclean.
Just apply to the VM_SHARED vmas, with page_mkclean_one saying
	if (!pte_dirty(*pte) && !pte_write(*pte))
		goto unlock;

Hugh
