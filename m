Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbWHBBrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWHBBrf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 21:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbWHBBrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 21:47:35 -0400
Received: from ozlabs.org ([203.10.76.45]:40119 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750972AbWHBBrf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 21:47:35 -0400
Subject: Re: [PATCH 7 of 13] Make __FIXADDR_TOP variable to allow it to
	make space for a hypervisor
From: Rusty Russell <rusty@rustcorp.com.au>
To: Chris Wright <chrisw@sous-sol.org>
Cc: Andrew Morton <akpm@osdl.org>, jeremy@xensource.com,
       linux-kernel@vger.kernel.org, Christian.Limpach@cl.cam.ac.uk,
       clameter@sgi.com, ebiederm@xmission.com, kraxel@suse.de,
       hollisb@us.ibm.com, ian.pratt@xensource.com, zach@vmware.com
In-Reply-To: <20060801213751.GA11244@sequoia.sous-sol.org>
References: <patchbomb.1154421371@ezr.goop.org>
	 <b6c100bb5ca5e2839ac8.1154421378@ezr.goop.org>
	 <20060801090330.GC2654@sequoia.sous-sol.org>
	 <20060801073428.f543ba9f.akpm@osdl.org>
	 <20060801213751.GA11244@sequoia.sous-sol.org>
Content-Type: text/plain
Date: Wed, 02 Aug 2006 11:47:30 +1000
Message-Id: <1154483250.2570.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-01 at 14:37 -0700, Chris Wright wrote:
> * Andrew Morton (akpm@osdl.org) wrote:
> > On Tue, 1 Aug 2006 02:03:30 -0700
> > Chris Wright <chrisw@sous-sol.org> wrote:
> > 
> > > * Jeremy Fitzhardinge (jeremy@xensource.com) wrote:
> > > > -#define MAXMEM			(-__PAGE_OFFSET-__VMALLOC_RESERVE)
> > > > +#define MAXMEM			(__FIXADDR_TOP-__PAGE_OFFSET-__VMALLOC_RESERVE)
> > > 
> > > In the native case we lose one page of lowmem now.
> > 
> > erm, isn't this the hunk which gave one of my machines a 4kb highmem zone?
> > I have memories of reverting it.
> 
> Yes, that does sound quite familiar.  I couldn't find the thread, do you
> recall any of the details?  I expect it's the same issue as the off by one
> page I mentioned above.

Good catch Andrew.  I did say we'd fix this.  Will frob this patch
further...

Here's my final reply from my archives:

                           Subject: 
Re: sparsemem panic in 2.6.17-rc5-mm1 and -mm2
                              Date: 
Wed, 07 Jun 2006 16:49:12 +1000

On Tue, 2006-06-06 at 22:50 -0700, Andrew Morton wrote:
> On Wed, 07 Jun 2006 15:36:25 +1000
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> >     You now have 1 page more memory available in your system.
> 
> The kernel has differing opinions about that:
> 
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 0000000038000000 (usable)
>  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>  BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
> 0MB HIGHMEM available.
> 896MB LOWMEM available.

Sure, the pages are reserved, but we still map them into the kernel
address space.

> > I'm sure Gerd will slap me if I'm wrong on this.  Here's the patch
> > fragment:
> > 
> > -#define MAXMEM                 (-__PAGE_OFFSET-__VMALLOC_RESERVE)
> > +#define MAXMEM                 (__FIXADDR_TOP-__PAGE_OFFSET-__VMALLOC_RESERVE)
> 
> Well.  Applying this with `patch -R' would presumably restore the situation.
> But not having a clue why this change was made, I didn't bother trying it.

Actually, the comment above __VMALLOC_RESERVE already says "This much
address space is reserved for vmalloc() and iomap() as well as fixmap
mappings.", so it should have already been taken into account there.

So, please revert this.  When we introduce an actual CONFIG_MEMORY hole,
we'll patch in an explicit "-MEMHOLE_SIZE" or something here.

> From what you're saying, it appears that this patch is an unrelated change,
> to fix the off-by-one?  And that if this machine had anything other than
> exactly 7*128MB of physical memory, I wouldn't have noticed?

You wouldn't have noticed, yes.  But I'm not convinced the "fix" was
right anyway.

Thanks for chasing this!
Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

