Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWEBKpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWEBKpH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 06:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWEBKpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 06:45:07 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:910 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932155AbWEBKpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 06:45:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=D8FVG360g3IGbF/L2+aEdv1gDNwgOgjRnvBvp48dp/rN5lyCQpOnBxgBLeqUN8EKQyd4/UhkOxC3FvJgyRyQXo6cxMALPeGtw4UU0/tfiDory2mYT2jwJN6kOagmu4RwZSaClr7dDfMAEgD2ikzFeBP9SZw/KmlE9dRfxe71t8I=  ;
Message-ID: <4456D7B8.2000004@yahoo.com.au>
Date: Tue, 02 May 2006 13:53:28 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: blaisorblade@yahoo.it
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [patch 11/14] remap_file_pages protection support: pte_present
 should not trigger on PTE_FILE PROTNONE ptes
References: <20060430172953.409399000@zion.home.lan> <20060430173025.752423000@zion.home.lan>
In-Reply-To: <20060430173025.752423000@zion.home.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

blaisorblade@yahoo.it wrote:
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> pte_present(pte) implies that pte_pfn(pte) is valid. Normally even with a
> _PAGE_PROTNONE pte this holds, but not when such a PTE is installed by
> the new install_file_pte; previously it didn't store protections, only file
> offsets, with the patches it also stores protections, and can set
> _PAGE_PROTNONE|_PAGE_FILE.

Why is this combination useful? Can't you just drop the _PAGE_FILE from
_PAGE_PROTNONE ptes?

> 
> zap_pte_range, when acting on such a pte, calls vm_normal_page and gets
> &mem_map[0], does page_remove_rmap, and we're easily in trouble, because it
> happens to find a page with mapcount == 0. And it BUGs on this!
> 
> I've seen this trigger easily and repeatably on UML on 2.6.16-rc3. This was
> likely avoided in the past by the PageReserved test - page 0 *had* to be
> reserved on i386 (dunno on UML).
> 
> Implementation follows for UML and i386.
> 
> To avoid additional overhead, I also considered adding likely() for
> _PAGE_PRESENT and unlikely() for the rest, but I'm uncertain about validity of
> possible [un]likely(pte_present()) occurrences.

Not present pages are likely to be pretty common when unmapping.

I don't like this patch much.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
