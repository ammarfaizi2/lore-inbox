Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264937AbTLZH3m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 02:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264944AbTLZH3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 02:29:42 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:55693 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264937AbTLZH3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 02:29:41 -0500
Subject: Page aging broken in 2.6
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Rik van Riel <riel@surriel.com>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1072423739.15458.62.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 26 Dec 2003 18:28:59 +1100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI !

I don't know if x86 is affected (I suspect not) but ppc and ppc64
definitely are.

in mm/rmap.c, in page_referenced(), we do that twice:

                if (ptep_test_and_clear_young(pte))
                        referenced++;

And we never flush the TLB entry. 

I don't know if x86 (or other archs really using page tables) will
actually set the referenced bit again in the PTE if it's already set
in the TLB, if not, then x86 needs a flush too.

ppc and ppc64 need a flush to evict the entry from the hash table or
we'll never set the _PAGE_ACCESSED bit anymore.

On the other hand, I'd like to propose a semantic change here, by
changing ptep_test_and_clear_dirty() as well so that the flush is done
by the arch function and not explicitely by the generic code in both
cases. (I'm not sure if it's worth adding an mm parameter to the call
or if the arch will figure it out, we don't have it at hand in
page_referenced()).

That way, arch that don't need the flush (if any) can avoid it, and
in the case of ptep_test_and_clear_dirty, I may have a better way of
implementing it without a flush in mind.

Comments ?

Ben.


