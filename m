Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbWFGGtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWFGGtQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 02:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbWFGGtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 02:49:16 -0400
Received: from ozlabs.org ([203.10.76.45]:39642 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751041AbWFGGtP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 02:49:15 -0400
Subject: Re: sparsemem panic in 2.6.17-rc5-mm1 and -mm2
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: kamezawa.hiroyu@jp.fujitsu.com, y-goto@jp.fujitsu.com, mbligh@google.com,
       apw@shadowen.org, linux-kernel@vger.kernel.org,
       76306.1226@compuserve.com, mingo@elte.hu, arjan@infradead.org,
       kraxel@suse.de, zach@vmware.com
In-Reply-To: <20060606225009.ae587661.akpm@osdl.org>
References: <20060605200727.374cbf05.akpm@osdl.org>
	 <20060606141922.c5fb16ad.kamezawa.hiroyu@jp.fujitsu.com>
	 <20060606142347.2AF2.Y-GOTO@jp.fujitsu.com>
	 <20060606002758.631118da.akpm@osdl.org>
	 <20060607094355.b77ed883.kamezawa.hiroyu@jp.fujitsu.com>
	 <20060606215813.9bfe07af.akpm@osdl.org>
	 <1149658586.5183.217.camel@localhost.localdomain>
	 <20060606225009.ae587661.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 07 Jun 2006 16:49:06 +1000
Message-Id: <1149662946.5183.261.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-06 at 22:50 -0700, Andrew Morton wrote:
> On Wed, 07 Jun 2006 15:36:25 +1000
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> > 	You now have 1 page more memory available in your system.
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
 ccontrol: http://ccontrol.ozlabs.org

