Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261800AbVEJVO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbVEJVO5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 17:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbVEJVMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 17:12:47 -0400
Received: from mail.suse.de ([195.135.220.2]:46247 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261790AbVEJVLb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 17:11:31 -0400
Date: Tue, 10 May 2005 23:11:21 +0200
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, ak@suse.de,
       linux-kernel@vger.kernel.org, axboe@suse.de, alexn@dsv.su.se,
       lnxluv@yahoo.com, Christoph Lameter <christoph@lameter.com>
Subject: Re: [BUG][Resend] 2.6.12-rc3-mm3: Kernel BUG at "mm/slab.c":1219 [update]
Message-ID: <20050510211121.GO25612@wotan.suse.de>
References: <200505092239.37834.rjw@sisk.pl> <20050509145424.6ffba49a.akpm@osdl.org> <200505101443.31229.rjw@sisk.pl> <20050510112224.761f5d68.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050510112224.761f5d68.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2005 at 11:22:24AM -0700, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > > Clearly init_bio() is not passing in a NULL `name' parameter.  Maybe the
> >  > backtrace is screwed due to dopey gcc autoinlining and the bad caller is
> >  > really biovec_init_slabs().  Try removing the
> >  > __cacheline_aligned_mostly_readonly from the declaration of bvec_slabs[].
> > 
> >  Heh, it boots without the __cacheline_aligned_mostly_readonly (ie the BUG is
> >  only triggered if the __cacheline_aligned_mostly_readonly is present in the
> >  declaration of bvec_slabs[]).  I've double-checked it.  Interesting ... ;-)
> 
> oops.
> 
> +#ifdef CONFIG_X86
> +#define __cacheline_aligned_mostly_readonly		\
> +  __attribute__((__aligned__(SMP_CACHE_BYTES),		\
> +		 __section__(".data.mostly_readonly")))
> +#else
> +#define __cacheline_aligned_mostly_readonly __cacheline_aligned
> +#endif
> 
> So on x86_64 we're putting __cacheline_aligned_mostly_readonly stuff into a
> section which is not implemented anywhere.  I'm rather surprised that the
> kernel linked at all.  But I'm more surprised that it mysteriously oopsed.
> 
> Oh well, I'll change that to CONFIG_X86 && !CONFIG_X86_64, thanks.

Better just add the section to x86-64. Should be easy by copying the
change from the i386 patch.

Ideally it would be asm-generic/vmlinux.lds and cover everybody...

-Andi


> Or maybe Christoph wants to rustle up the x86_64 patch?  We really should
> patch all architectures if we're going to do this thing.
