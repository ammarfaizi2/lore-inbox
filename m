Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262780AbTHZRBf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 13:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262785AbTHZRBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 13:01:35 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:29864 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S262780AbTHZRBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 13:01:32 -0400
Date: Tue, 26 Aug 2003 18:03:14 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Jaroslav Kysela <perex@suse.cz>
cc: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Strange memory usage reporting
In-Reply-To: <Pine.LNX.4.44.0308261550240.1958-100000@pnote.perex-int.cz>
Message-ID: <Pine.LNX.4.44.0308261756570.1632-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Aug 2003, Jaroslav Kysela wrote:
> 
> Yes, it seems so. The do_no_page() function in mm/memory.c does accounting 
> for reserved pages (++mm->rss), but in zap_pte_range() there is a check 
> preventing increase the count of freed pages.
> 
> Here is a patch for VM gurus to review (for 2.4 kernel, but it should 
> apply to 2.6 as well):
> 
> ===== mm/memory.c 1.57 vs edited =====
> --- 1.57/mm/memory.c	Fri Jun 13 18:26:23 2003
> +++ edited/mm/memory.c	Tue Aug 26 15:33:28 2003
> @@ -1306,7 +1306,8 @@
>  	 */
>  	/* Only go through if we didn't race with anybody else... */
>  	if (pte_none(*page_table)) {
> -		++mm->rss;
> +		if (!PageReserved(new_page))
> +			++mm->rss;
>  		flush_page_to_ram(new_page);
>  		flush_icache_page(vma, new_page);
>  		entry = mk_pte(new_page, vma->vm_page_prot);

You're right (but please rediff against 2.4.22 when you send Marcelo).

You may wonder how this has taken so long to show up: because usually
drivers which mmap Reserved pages use remap_page_range on them,
and so never fault to do_no_page.

Which is the driver involved?  Though it's not wrong to give do_no_page
a Reserved page, beware of the the page->count accounting: while it's
Reserved, get_page or page_cache_get raises the count, but put_page
or page_cache_release does not decrement it - very easy to end up
with the page never freed.

Hugh

