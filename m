Return-Path: <linux-kernel-owner+w=401wt.eu-S932663AbWLSJgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663AbWLSJgP (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 04:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932715AbWLSJgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 04:36:15 -0500
Received: from nz-out-0506.google.com ([64.233.162.239]:52422 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932663AbWLSJgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 04:36:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B8lGEswCDPZPaFGiL9Om512X/UyIy08XBr81SYFiCWzca3uP6mKVUfejhug8t9NqFmzJ0R5B8dHM86Y+pAMVIBFCuYMQwPNN3O8+/Jq0+OtYVe0Ghk6o2qQo8FsyMQRLrNDoYzrfR6sA0n918ikhVALuiodFXtsks9i0goYdPKE=
Message-ID: <b0943d9e0612190136x16ed4ffes37f2c023bb168b17@mail.gmail.com>
Date: Tue, 19 Dec 2006 09:36:13 +0000
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [PATCH 2.6.20-rc1 00/10] Kernel memory leak detector 0.13
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061218195604.GA32112@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061216153346.18200.51408.stgit@localhost.localdomain>
	 <20061216165738.GA5165@elte.hu>
	 <b0943d9e0612161539s50fd6086v9246d6b0ffac949a@mail.gmail.com>
	 <20061217085859.GB2938@elte.hu>
	 <b0943d9e0612171505l6dfe19c6h6391b08f41243b1@mail.gmail.com>
	 <20061218072932.GA5624@elte.hu>
	 <b0943d9e0612180228w142a7375obf33a0f42d1982ae@mail.gmail.com>
	 <20061218112120.GA7599@elte.hu>
	 <b0943d9e0612180426m3f320a3ah86631d1852a6b15@mail.gmail.com>
	 <20061218195604.GA32112@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/12/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Catalin Marinas <catalin.marinas@gmail.com> wrote:
>
> > >at freeing we only have to look up the tree belonging to object->cpu.
> >
> > At freeing, kmemleak only gets a pointer value which has to be looked
> > up in the hash table for the corresponding memleak_object. Only after
> > that, we can know memleak_object->cpu. That's why I think we only need
> > to have a global hash table. The hash table look-up can be RCU.
> > [...]
>
> hmm ... nasty. Would it be feasible to embedd the memleak info into the
> allocated object itself? That would remove quite some runtime overhead,
> besides eliminating the global hash.

I thought about this but would be more difficult for page allocations
and even impossible if we later want to track ioremap'ed regions (or
any other resource that has a unique id). The vmalloc'ed regions are
page aligned, though not sure there is any code that makes use of this
assumption. It also makes it too dependent on the allocator itself
(maybe not a big problem). Being less intrusive makes this easier to
maintain, especially if you want to use a different allocator.

Another option would be to store kmemleak info in the slab management
structures, vm_area (for vmalloc) or page structures but this breaks
the kmemleak functions for marking the false positives (which is done
outside the allocator).

Is there any scalability/performance impact of just
acquiring/releasing a lock or this is only affected by the contention
situations? If it's the latter, there can be a lock per hash-table
entry and drastically reduce the contention. The drawback is the
doubling of the hash table size, maybe with some impact on caches and
TLBs.

-- 
Catalin
