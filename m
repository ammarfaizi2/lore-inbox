Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964962AbWECBaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbWECBaF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 21:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbWECBaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 21:30:05 -0400
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79]:35158 "HELO
	smtp010.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S964962AbWECBaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 21:30:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=tOZvE6q01Ys/BB8h1tmmEFoXlMkAtTXPKh0CBlzSayBC+5vI/05QEHCfcVcQum6zy+JiwQ74Lk1kYps40LPmBpbbfHMhDG/7ohZQ79Vj5pu+CnolufequUgV3nCXZtrD/q6AKT1vclpkexJj9XwdTTfwkPjhZi8wfZa3x7QrIVs=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch 11/14] remap_file_pages protection support: pte_present should not trigger on PTE_FILE PROTNONE ptes
Date: Wed, 3 May 2006 03:29:50 +0200
User-Agent: KMail/1.8.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Memory Management <linux-mm@kvack.org>
References: <20060430172953.409399000@zion.home.lan> <20060430173025.752423000@zion.home.lan> <4456D7B8.2000004@yahoo.com.au>
In-Reply-To: <4456D7B8.2000004@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605030329.51034.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 May 2006 05:53, Nick Piggin wrote:
> blaisorblade@yahoo.it wrote:
> > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> >
> > pte_present(pte) implies that pte_pfn(pte) is valid. Normally even with a
> > _PAGE_PROTNONE pte this holds, but not when such a PTE is installed by
> > the new install_file_pte; previously it didn't store protections, only
> > file offsets, with the patches it also stores protections, and can set
> > _PAGE_PROTNONE|_PAGE_FILE.

What could be done is to set a PTE with "no protection", use another bit 
rather than _PAGE_PROTNONE. This wastes one more bit but doable.

> Why is this combination useful? Can't you just drop the _PAGE_FILE from
> _PAGE_PROTNONE ptes?

I must think on this, but the semantics are not entirely the same between the 
two cases. You have no page attached when _PAGE_FILE is there, but a page is 
attached to the PTE with only _PAGE_PROTNONE. Testing that via VM_MANYPROTS 
is just as slow as-is (can be changed with code duplication for the linear 
and non-linear cases).

The application semantics can also be different when you remap as read/write 
that page - the app could have stored an offset there (this is less definite 
since you can't remap & keep the offset currently).

Also, this wouldn't solve the problem, it would make the solution harder: how 
do I know that there's no page to call page_remove_rmap() on, without 
_PAGE_FILE?

I thought to change _PAGE_PROTNONE: it is used to hold a page present and 
referenced but unaccessible. It seems it could be released when 
_PAGE_PROTNONE is set, but for anonymous memory it's impossible. When I've 
asked Hugh about this, he imagined the case when an application faults in a 
page in a VMA then mprotects(PROT_NONE) it; the PTE is set as PROT_NONE. We 
can avoid that in the VM_MAYSHARE case (VM_SHARED or PROT_SHARED was set but 
the file is readonly), but not when anonymous memory is present - the 
application could want it back.

> > To avoid additional overhead, I also considered adding likely() for
> > _PAGE_PRESENT and unlikely() for the rest, but I'm uncertain about
> > validity of possible [un]likely(pte_present()) occurrences.
>
> Not present pages are likely to be pretty common when unmapping.

Ok, only unlikely for test on _PAGE_PROTNONE and ! _PAGE_FILE.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
