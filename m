Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263733AbUCXOrJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 09:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263735AbUCXOrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 09:47:09 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:64142
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263733AbUCXOrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 09:47:06 -0500
Date: Wed, 24 Mar 2004 15:47:58 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: nonlinear swapping w/o pte_chains [Re: VMA_MERGING_FIXUP and patch]
Message-ID: <20040324144758.GE2065@dualathlon.random>
References: <Pine.LNX.4.44.0403240931430.7474-100000@localhost.localdomain> <Pine.LNX.4.44.0403241214220.7669-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403241214220.7669-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2004 at 12:18:12PM +0000, Hugh Dickins wrote:
> This subtlety in try_to_unmap_nonlinear_pte:
> 
> 	page_map_lock(page);
> 	/* check that we're not in between set_pte and page_add_rmap */
> 	if (page_mapped(page)) {
> 		unmap_pte_page(page, vma, address + offset, ptep);
> 
> Harmless, but isn't our acquisition of the page_table_lock guaranteeing
> that it cannot be in between set_pte and page_add_rmap?

I find that fragile, see the way I implemented do_anonymous_page, other
places always do page_add_rmap under the page_table_lock, but there's no
reason to require that, the swapout code already checks explicitly for
page_mapped after taking the page_map_lock, it has to do that anyways,
so I find it nicer to do it like the above and in do_anonymous_page.
