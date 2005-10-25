Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbVJYKMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbVJYKMt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 06:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbVJYKMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 06:12:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30630 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932127AbVJYKMs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 06:12:48 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.61.0510241938100.6142@goblin.wat.veritas.com> 
References: <Pine.LNX.4.61.0510241938100.6142@goblin.wat.veritas.com>  <1130168619.19518.43.camel@imp.csi.cam.ac.uk> <1130167005.19518.35.camel@imp.csi.cam.ac.uk> <Pine.LNX.4.61.0502091357001.6086@goblin.wat.veritas.com> <7872.1130167591@warthog.cambridge.redhat.com> <9792.1130171024@warthog.cambridge.redhat.com> 
To: Hugh Dickins <hugh@veritas.com>
Cc: David Howells <dhowells@redhat.com>, Anton Altaparmakov <aia21@cam.ac.uk>,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add notification of page becoming writable to VMA ops 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Tue, 25 Oct 2005 11:12:19 +0100
Message-ID: <8619.1130235139@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:

> > +			if (vma->vm_ops->page_mkwrite &&
> > +			    vma->vm_ops->page_mkwrite(vma, new_page) < 0)
> > +				return VM_FAULT_SIGBUS;
> > +		}
> >  	}
> 
> This isn't necessarily wrong, and may be exactly how it was before,
> I don't remember.  But it implies that when page_mkwrite fails,
> it page_cache_releases the page.  Is that desirable?  Or should
> that be left to the caller?

You're right. I've added a release. That may explain a memory leak I was
seeing that I couldn't find.

> > @@ -1945,7 +1998,7 @@ static int do_file_page(struct mm_struct
> 
> Drop all those changes to do_file_page (which I added), they're no
> longer necessary.  A case appeared which made it clear that we cannot
> rely on resolving this issue for get_user_pages in a single call to
> handle_mm_fault, and that's why the VM_FAULT_WRITE stuff got added. 

I take it then that:

 (1) the write_access parameter to do_file_page() is there purely so that
     handle_pte_fault() can jump to it rather than calling it since they have
     the same parameter set and return value;

 (2) and that do_file_page() always installs a read-only PTE so that
     do_wp_page() will be called subsequently on a write attempt.

David
