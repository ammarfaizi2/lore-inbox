Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264128AbUDBT3n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 14:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264159AbUDBT3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 14:29:43 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:16279
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264128AbUDBT3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 14:29:41 -0500
Date: Fri, 2 Apr 2004 21:29:41 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       hugh@veritas.com, vrajesh@umich.edu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040402192941.GP21341@dualathlon.random>
References: <20040402001535.GG18585@dualathlon.random> <Pine.LNX.4.44.0404020145490.2423-100000@localhost.localdomain> <20040402011627.GK18585@dualathlon.random> <20040401173649.22f734cd.akpm@osdl.org> <20040402020022.GN18585@dualathlon.random> <20040402104334.A871@infradead.org> <20040402164634.GF21341@dualathlon.random> <20040402195927.A6659@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040402195927.A6659@infradead.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2004 at 07:59:28PM +0100, Christoph Hellwig wrote:
> On Fri, Apr 02, 2004 at 06:46:34PM +0200, Andrea Arcangeli wrote:
> > it's not clear why this triggered, bad_page only shows the "master"
> > compound page and not the contents of the slave page that triggered the
> > bad_page. Can you try again with this incremental patch applied?
> 
> Bad page state at destroy_compound_page (in process 'swapper', page c0772380)
> flags:0x00080008 mapping:00000000 mapped:0 count:134217728 private:0xc07721ff

PageCompound and PageUpdodate are set.

mapping/mapped is null.

page->count is 0x8000000, that looks weird.

page->private indicates:

>>> (0xc0772380L-0xc07721ffL)/32
12L

that's the 12th page in the array.

can you check in the asm (you should look at address c0048c7c) if it's
the first bug that triggers?

	if (page[1].index != order)
		bad_page(__FUNCTION__, page);


the whole compound thing is very screwed in the above scenario.

Do you have CONFIG_DEBUG_PAGEALLOC enabled?

could be compound never worked right on ppc, dunno. You could try to
backout the patch gfp-no-compound and to recompile with hugetlbfs
enabled (can you enable it on PPC?).

In the meantime it seem swap resume got broken by some other change and
that the VM side is ok now [rc3-aa2 showed some harmless warning that
I've fixed in the patch you just tried] (I backed out the other non-VM
changes and resume works better now, though I cannot be 100% sure since
aic7xxx cannot resume totally, confirmed by Pavel, I need somebody with
suspend-capable-hardware to verify).

I also started the mprotect merging and it should be really quick to add
it.

Plus I'm doing a microscalability optimization in the fremap.c, the
previous code was right taking the page_table_lock after calculating the
pgd_offset.

> Backtrace:
> Call trace:
>  [c000b5c8] dump_stack+0x18/0x28
>  [c0048b64] bad_page+0x74/0xbc
>  [c0048c7c] destroy_compound_page+0x80/0xb8
>  [c0048ed0] free_pages_bulk+0x21c/0x220
>  [c0049030] __free_pages_ok+0x15c/0x188
>  [c004d520] slab_destroy+0x140/0x234
>  [c00505f0] reap_timer_fnc+0x1e4/0x2b8
>  [c002feac] run_timer_softirq+0x134/0x1fc
>  [c002abd0] do_softirq+0x140/0x144
>  [c0009e5c] timer_interrupt+0x2d0/0x300
>  [c0007cac] ret_from_except+0x0/0x14
>  [c000381c] ppc6xx_idle+0xe4/0xf0
>  [c0009b7c] cpu_idle+0x28/0x38
>  [c00038c4] rest_init+0x50/0x60
>  [c0364784] start_kernel+0x198/0x1d8
