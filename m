Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWFGFgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWFGFgc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 01:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbWFGFgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 01:36:32 -0400
Received: from ozlabs.org ([203.10.76.45]:32722 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750924AbWFGFgc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 01:36:32 -0400
Subject: Re: sparsemem panic in 2.6.17-rc5-mm1 and -mm2
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, y-goto@jp.fujitsu.com,
       mbligh@google.com, apw@shadowen.org, linux-kernel@vger.kernel.org,
       76306.1226@compuserve.com, Ingo Molnar <mingo@elte.hu>,
       Arjan van de Ven <arjan@infradead.org>, Gerd Hoffmann <kraxel@suse.de>,
       Zachary Amsden <zach@vmware.com>
In-Reply-To: <20060606215813.9bfe07af.akpm@osdl.org>
References: <20060605200727.374cbf05.akpm@osdl.org>
	 <20060606141922.c5fb16ad.kamezawa.hiroyu@jp.fujitsu.com>
	 <20060606142347.2AF2.Y-GOTO@jp.fujitsu.com>
	 <20060606002758.631118da.akpm@osdl.org>
	 <20060607094355.b77ed883.kamezawa.hiroyu@jp.fujitsu.com>
	 <20060606215813.9bfe07af.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 07 Jun 2006 15:36:25 +1000
Message-Id: <1149658586.5183.217.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-06 at 21:58 -0700, Andrew Morton wrote:
> On Wed, 7 Jun 2006 09:43:55 +0900
> KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
> 
> > On Tue, 6 Jun 2006 00:27:58 -0700
> > Andrew Morton <akpm@osdl.org> wrote:
> > 
> > > 
> > > I tried sparsemem on my little x86 box here.  Boots OK, after fixing up the
> > > kswapd_init() patch (below).
> > > 
> > > I'm wondering why I have 4k of highmem:
> > > 
> > 
> > Could you show /proc/iomem of your 4k HIGHMEM box ?
> > Does 4k HIGHMEM exist only when SPARSEMEM is selected ?
> 
> Turns out that my 4 kbyte highmem zone (at least, as reported in
> /proc/meminfo) is due to
> 
> vdso-randomize-the-i386-vdso-by-moving-it-into-a-vma.patch

Thanks for this report, Andrew!

	Yes, MAXMEM is reduced by one page in the patch, taking into account
that kernel memory tops out at __FIXADDR_TOP, not 0xFFFFFFFF.  AFAICT
this is in fact a bugfix, which becomes more important when
__FIXADDR_TOP can be moved to create a larger memory hole (as for
hypervisors).

	You now have 1 page more memory available in your system.  Use it
wisely.

I'm sure Gerd will slap me if I'm wrong on this.  Here's the patch
fragment:

-#define MAXMEM                 (-__PAGE_OFFSET-__VMALLOC_RESERVE)
+#define MAXMEM                 (__FIXADDR_TOP-__PAGE_OFFSET-__VMALLOC_RESERVE)

Cheers,
Rusty.
-- 
 ccontrol: http://ccontrol.ozlabs.org

