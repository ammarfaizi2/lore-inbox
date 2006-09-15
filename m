Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbWIOVf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWIOVf4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 17:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWIOVf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 17:35:56 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:31962 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932291AbWIOVfz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 17:35:55 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] page fault retry with NOPAGE_RETRY
Date: Fri, 15 Sep 2006 23:35:39 +0200
User-Agent: KMail/1.9.1
Cc: linux-mm@kvack.org, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
References: <1158274508.14473.88.camel@localhost.localdomain>
In-Reply-To: <1158274508.14473.88.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609152335.39960.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Friday 15 September 2006 00:55 schrieb Benjamin Herrenschmidt:
> Somebody pointed to me that this might also be used to shoot another
> bird, though I have not really though about it and wether it's good or
> bad, which is the old problem of needing struct page for things that can
> be mmap'ed. Using that trick, a driver could do the set_pte() itself in
> the no_page handler and return NOPAGE_RETRY. I'm not sure about
> advertising that feature though as I like all  callers of things like
> set_pte() to be in well known locations, as there are various issues
> related to manipulating the page tables that driver writers might not
> get right. Though I suppose that if we consider the approach good, we
> can provide a helper that "does the right thing" as well (like calling
> update_mmu_cache(), flush_tlb_whatever(), etc...).

One more point where it can help: When the backing store for the spufs
mem file changes between vmalloc memory backed and pointing to a physical
spu, we need to change vm_page_prot between (_PAGE_NO_CACHE | _PAGE_GUARDED)
and the opposite. While all my investigations (with help from Hugh Dickins
and Christoph Hellwig) show that it should be safe to do in the current
code, the idea is still scary. When the nopage function for that file
can simply return NOPAGE_RETRY after setting up the page tables,
we don't need to worry about vm_page_prot any more.

	Arnd <><
