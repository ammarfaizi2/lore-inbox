Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbUKCPNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbUKCPNx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 10:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbUKCPNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 10:13:53 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:42503 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261625AbUKCPNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 10:13:49 -0500
Date: Wed, 3 Nov 2004 15:13:41 +0000
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com,
       linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: Re: [PATCH 9/14] FRV: CONFIG_MMU fixes
Message-ID: <20041103151341.GA20481@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, torvalds@osdl.org,
	akpm@osdl.org, davidm@snapgear.com, linux-kernel@vger.kernel.org,
	uclinux-dev@uclinux.org
References: <20041102094336.GC5841@infradead.org> <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com> <200411011930.iA1JULvA023219@warthog.cambridge.redhat.com> <19027.1099494404@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19027.1099494404@redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 03:06:44PM +0000, David Howells wrote:
> 
> > > +++ linux-2.6.10-rc1-bk10-frv/fs/proc/kcore.c	2004-11-01 11:47:04.872656796 +0000
> > > @@ -344,6 +344,7 @@
> > >  		if (m == NULL) {
> > >  			if (clear_user(buffer, tsz))
> > >  				return -EFAULT;
> > > +#ifdef CONFIG_MMU
> >  		} else if ((start >= VMALLOC_START) && (start < VMALLOC_END)) {
> > ...
> > > +#endif
> > 
> > move this into a helper function that can be compiled away for the !MMU case
> 
> That won't work. The else-if clause has to be within the context of the parent
> function in which it now resides.

but you can still have the body of the if clause a noop for !MMU

> It might actually be better to make /proc/kcore conditional on CONFIG_MMU.

Yupp.  In fact I'm pretty sure it can't be selected for m68knommu currently.

> > > +#ifdef CONFIG_MMU
> > >  static struct vmalloc_info get_vmalloc_info(void)
> > ...
> > > +#endif
> > 
> > move the whole function to a CONFIG_MMU-only file
> 
> No. The compiler can, if it wishes, inline this function as it is now. Putting
> it in a separate file removes that option.

Who cares?  This is absolutley not a fastpath.

> > add a small helper for this.  In fact it's the only caller of
> > get_vmalloc_info, so that could be merged into the helper, ala:
> 
> No. The compiler, if it inlines get_vmalloc_info() can avoid allocating a
> whole struct vmalloc_info if it wishes in the current scheme of things, and
> can generate better code by inserting the constants when it needs them.

Dito.

> > I's day just move this out of line into a MMU-only file.
> > ...
> > or at least keep a single MMU ifdef block per file
> 
> I think, perhaps, some of linux/mm.h should perhaps be split out into separate
> MMU and !MMU header files, which then get included as appropriate by
> linux/mm.h.

Probably makes sense.

> > provide stubs please.  pgtable_cache_init is a per-arch things anyway.
> 
> *sigh*. I'm trying to keep the time things take to boot and the amount of
> space the kernel image occupies down, and you're trying to push both back
> up. All these empty stubs consume time and space.

Since when does a noop macro or inline take up space in the kernel image.

> > just move the whole systctl registration into a MMU-only file
> 
> How's that going to help? A few of the VM options may still apply to !MMU.

I meant the registration of the sysctls not relevant for MMU-less systems.

