Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264974AbTLZHk3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 02:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265066AbTLZHk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 02:40:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:38342 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264974AbTLZHk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 02:40:27 -0500
Date: Thu, 25 Dec 2003 23:40:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, riel@surriel.com
Subject: Re: Page aging broken in 2.6
Message-Id: <20031225234023.20396cbc.akpm@osdl.org>
In-Reply-To: <1072423739.15458.62.camel@gaston>
References: <1072423739.15458.62.camel@gaston>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> HI !
> 
> I don't know if x86 is affected (I suspect not) but ppc and ppc64
> definitely are.
> 
> in mm/rmap.c, in page_referenced(), we do that twice:
> 
>                 if (ptep_test_and_clear_young(pte))
>                         referenced++;
> 
> And we never flush the TLB entry. 
> 
> I don't know if x86 (or other archs really using page tables) will
> actually set the referenced bit again in the PTE if it's already set
> in the TLB, if not, then x86 needs a flush too.

x86 needs a flush_tlb_page(), yes.

> ppc and ppc64 need a flush to evict the entry from the hash table or
> we'll never set the _PAGE_ACCESSED bit anymore.
> 
> On the other hand, I'd like to propose a semantic change here, by
> changing ptep_test_and_clear_dirty() as well so that the flush is done
> by the arch function and not explicitely by the generic code in both
> cases. (I'm not sure if it's worth adding an mm parameter to the call
> or if the arch will figure it out, we don't have it at hand in
> page_referenced()).
> 
> That way, arch that don't need the flush (if any) can avoid it, and
> in the case of ptep_test_and_clear_dirty, I may have a better way of
> implementing it without a flush in mind.

I don't feel particularly strongly either way, but the core mm code is
sprinkled with flushes anyway; it would probably be more consistent to
open-code it in rmap.c now.

