Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbWFGFun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbWFGFun (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 01:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbWFGFum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 01:50:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24520 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750855AbWFGFum (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 01:50:42 -0400
Date: Tue, 6 Jun 2006 22:50:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kamezawa.hiroyu@jp.fujitsu.com, y-goto@jp.fujitsu.com, mbligh@google.com,
       apw@shadowen.org, linux-kernel@vger.kernel.org,
       76306.1226@compuserve.com, mingo@elte.hu, arjan@infradead.org,
       kraxel@suse.de, zach@vmware.com
Subject: Re: sparsemem panic in 2.6.17-rc5-mm1 and -mm2
Message-Id: <20060606225009.ae587661.akpm@osdl.org>
In-Reply-To: <1149658586.5183.217.camel@localhost.localdomain>
References: <20060605200727.374cbf05.akpm@osdl.org>
	<20060606141922.c5fb16ad.kamezawa.hiroyu@jp.fujitsu.com>
	<20060606142347.2AF2.Y-GOTO@jp.fujitsu.com>
	<20060606002758.631118da.akpm@osdl.org>
	<20060607094355.b77ed883.kamezawa.hiroyu@jp.fujitsu.com>
	<20060606215813.9bfe07af.akpm@osdl.org>
	<1149658586.5183.217.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Jun 2006 15:36:25 +1000
Rusty Russell <rusty@rustcorp.com.au> wrote:

> On Tue, 2006-06-06 at 21:58 -0700, Andrew Morton wrote:
> > On Wed, 7 Jun 2006 09:43:55 +0900
> > KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
> > 
> > > On Tue, 6 Jun 2006 00:27:58 -0700
> > > Andrew Morton <akpm@osdl.org> wrote:
> > > 
> > > > 
> > > > I tried sparsemem on my little x86 box here.  Boots OK, after fixing up the
> > > > kswapd_init() patch (below).
> > > > 
> > > > I'm wondering why I have 4k of highmem:
> > > > 
> > > 
> > > Could you show /proc/iomem of your 4k HIGHMEM box ?
> > > Does 4k HIGHMEM exist only when SPARSEMEM is selected ?
> > 
> > Turns out that my 4 kbyte highmem zone (at least, as reported in
> > /proc/meminfo) is due to
> > 
> > vdso-randomize-the-i386-vdso-by-moving-it-into-a-vma.patch
> 
> Thanks for this report, Andrew!
> 
> 	Yes, MAXMEM is reduced by one page in the patch, taking into account
> that kernel memory tops out at __FIXADDR_TOP, not 0xFFFFFFFF.  AFAICT
> this is in fact a bugfix, which becomes more important when
> __FIXADDR_TOP can be moved to create a larger memory hole (as for
> hypervisors).
> 
> 	You now have 1 page more memory available in your system.

The kernel has differing opinions about that:

 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000038000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
896MB LOWMEM available.

>  Use it
> wisely.


> I'm sure Gerd will slap me if I'm wrong on this.  Here's the patch
> fragment:
> 
> -#define MAXMEM                 (-__PAGE_OFFSET-__VMALLOC_RESERVE)
> +#define MAXMEM                 (__FIXADDR_TOP-__PAGE_OFFSET-__VMALLOC_RESERVE)

Well.  Applying this with `patch -R' would presumably restore the situation.
But not having a clue why this change was made, I didn't bother trying it.

>From what you're saying, it appears that this patch is an unrelated change,
to fix the off-by-one?  And that if this machine had anything other than
exactly 7*128MB of physical memory, I wouldn't have noticed?
