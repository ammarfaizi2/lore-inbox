Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271144AbUJVAtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271144AbUJVAtq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 20:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271137AbUJVArN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 20:47:13 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:26521 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S271160AbUJVAlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 20:41:14 -0400
Date: Fri, 22 Oct 2004 02:41:59 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: shaggy@austin.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] zap_pte_range should not mark non-uptodate pages dirty
Message-ID: <20041022004159.GB14325@dualathlon.random>
References: <1098393346.7157.112.camel@localhost> <20041021144531.22dd0d54.akpm@osdl.org> <20041021223613.GA8756@dualathlon.random> <20041021160233.68a84971.akpm@osdl.org> <20041021232059.GE8756@dualathlon.random> <20041021164245.4abec5d2.akpm@osdl.org> <20041021171558.3214cea4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041021171558.3214cea4.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 05:15:58PM -0700, Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> > I don't get it.  invalidate has the pageframe.  All it need to do is to
> > lock the page, examine mapcount and if it's non-zero, do the shootdown. 
> 
> unmap_mapping_range() will do that - can call it one page at a time, or
> batch up runs of pages.  It's not fast, but presumably not frequent either.

That would shootdown the ptes to add completely coherency to the mmaps, right.

Still we could shootdown the ptes after clearing the uptodate bitflag,
allowing the mapped page to be not uptodate for a short while, since it
makes sense and it's harmless. The pte shootdown from my point of view
is just an additional coherency feature, but it cannot provide full
coherency anyways, since the invalidate arrives after the I/O hit the
disk, so the page will be out of sync with the disk if it's dirty, and
no coherency can be provided anyways, because no locking happens to get
max scalability.

> The bigger problem is shooting down the buffer_heads.  It's certainly the
> case that mpage_readpage() will call block_read_full_page() which will then
> bring the page uptodate without performing any I/O.

yes, this is actually the only bug I can see in this whole affair
(besdies the BUG that goes away with the patch already posted, and that
patch still makes perfect sense to me since we could use it even for a
more relaxed pte shootdown as described above, plus it doesn't worth to
mark not-uptodate pages as dirty, that is really what makes no sense and
needs fixing).

> And invalidating the buffer_heads in invalidate_inode_pages2() is tricky -
> we need to enter the filesystem and I'm not sure that either
> ->invalidatepage() or ->releasepage() are quite suitable.  For a start,
> they're best-effort and may fail.  If we just go and mark the buffers not
> uptodate we'll probably give ext3 a heart attack, so careful work would be
> needed there.
> 
> Let's go back to why we needed all of this.  Was it just for the NFS
> something-changed-on-the-server code?  If so, would it be sufficient to add
> a new invalidate_inode_pages3() just for NFS, which clears the uptodate
> bit?  Or something along those lines?

nfs is a case here too. But this is mostly needed for O_DIRECT write
happening on a file that is mmapped and read in buffered mode at the
same time. The API totally ignores the mapping, but we must guarantee
buffered read to see the written data on disk, and in turn the uptodate
bitflag must be clared because the page is not uptodate anymore. This 
just describes what has happened on disk and it tells to _future_ page
faults (or buffered read syscalls) they've to re-read from disk. The
only issue seems to be the bhs. Peraphs te bhs requires a new bitflag if
the fs risks an hearth attack, but the VM can do the natural thing of
clearing the uptodate bitflag reflecting the fact the cache is
out-of-date, since the VM can deal with that just fine.
