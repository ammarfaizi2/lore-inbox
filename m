Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264188AbTGBRdE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 13:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264201AbTGBRdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 13:33:04 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:4069
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264188AbTGBRdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 13:33:02 -0400
Date: Wed, 2 Jul 2003 19:47:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <20030702174700.GJ23578@dualathlon.random>
References: <Pine.LNX.4.53.0307010238210.22576@skynet> <20030701022516.GL3040@dualathlon.random> <Pine.LNX.4.53.0307021641560.11264@skynet> <20030702171159.GG23578@dualathlon.random> <461030000.1057165809@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <461030000.1057165809@flay>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 10:10:09AM -0700, Martin J. Bligh wrote:
> Maybe I'm just taking this out of context, and it's twisting my brain,
> but as far as I know, the nonlinear vma's *are* backed by pte_chains.
> That was the whole problem with objrmap having to do conversions, etc.
> 
> Am I just confused for some reason? I was pretty sure that was right ...

you're right:

int install_page(struct mm_struct *mm, struct vm_area_struct *vma,
		unsigned long addr, struct page *page, pgprot_t prot)
[..]
	flush_icache_page(vma, page);
	set_pte(pte, mk_pte(page, prot));
	pte_chain = page_add_rmap(page, pte, pte_chain);
	pte_unmap(pte);
[..]

(this make me understand better some of the arguments in the previous
emails too ;)

So ether we declare 32bit archs obsolete in production with 2.6, or we
drop rmap behind remap_file_pages.

actually other more invasive ways could be to move rmap into highmem.
Also the page clustering could also hide part of the mem overhead by
assuming the pagetables to be contiguos, but page clustering isn't part
of mainline yet either.

Something has to change since IMHO in the current 2.5.73 remap_file_pages
is nearly useless.

Andrea
