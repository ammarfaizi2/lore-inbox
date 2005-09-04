Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbVIDLgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbVIDLgq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 07:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbVIDLgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 07:36:46 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:8355 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750751AbVIDLgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 07:36:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=oFgW9IXTVEYta01WFFHnnn7NuZ1hBrYXt0YYCK6jCcWfyXZGVsxTtZEueIfCB3IFoPjKwJgjno8YpDUjm4/CfHJKBIPXNj2/cT09KwM48fSbOztCVzVYa72ANnXZe//wvHG5DJkw7OLnXBJFSzw6iIIpJFGqNE2Ulfc54DPd044=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [patch 1/3] uml: share page bits handling between 2 and 3 level pagetables
Date: Sun, 4 Sep 2005 13:33:30 +0200
User-Agent: KMail/1.8.1
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org
References: <20050728185655.9C6ADA3@zion.home.lan> <200508102137.28414.blaisorblade@yahoo.it> <20050902201749.GA9104@ccure.user-mode-linux.org>
In-Reply-To: <20050902201749.GA9104@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509041333.30466.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 September 2005 22:17, Jeff Dike wrote:
> On Wed, Aug 10, 2005 at 09:37:28PM +0200, Blaisorblade wrote:
> > Also look, on the "set_pte" theme, at the attached patch.

> +       WARN_ON(!pte_young(*pte) || pte_write(*pte) && !pte_dirty(*pte));

> This one has been firing on me, and I decided to figure out why.  The
> culprit is this code in do_no_page:

> 	if (pte_none(*page_table)) {
> 		if (!PageReserved(new_page))
> 			inc_mm_counter(mm, rss);
>
> 		flush_icache_page(vma, new_page);
> 		entry = mk_pte(new_page, vma->vm_page_prot);
> 		if (write_access)
> 			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
> 		set_pte_at(mm, address, page_table, entry);
>
> The first mk_pte immediately sets the pte to the protection limits of
> the VMA, regardless of the access type.

> So, if it's a read access on 
> a writeable page, we get a writeable, but not dirty pte, since the
> mkdirty never happens.  The exercises the warning you added.
Thanks for noticing - I had really this doubt when writing some code (in the 
patch, I've added a dirty PTEs on read accesses because I was unsure, and 
even because of my warning).

> This seems somewhat bogus to me.  If we set the pte protection to its
> limits, then the maybe_mkwrite is unneccesary.

> This doesn't seem to harm our dirty bit emulation.  fix_range_common
> checks the dirty and accessed bits and disables read and write
> protection as appropriate.

> So, it seems like the warning could be dropped, or perhaps made more
> selective, like checking for is_write == 0 and VM_WRITE, but then the
> test is getting complicated.

No, just replace pte_write() with is_write, as below. They might not coincide, 
but if on a write fault we return with a clean PTE, we'll loop indefinitely 
(experienced while hacking on remap_f_p), so the warning above is definitely 
correct.

       WARN_ON(!pte_young(*pte) || is_write && !pte_dirty(*pte));
> 				Heff

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.beta.messenger.yahoo.com
