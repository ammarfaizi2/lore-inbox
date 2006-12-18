Return-Path: <linux-kernel-owner+w=401wt.eu-S1753737AbWLRK2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753737AbWLRK2p (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 05:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753733AbWLRK2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 05:28:45 -0500
Received: from py-out-1112.google.com ([64.233.166.180]:47361 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753734AbWLRK2o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 05:28:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wp4cvFs7p/Ql1hIPk2eN4H8G0qWdJgmtG02ZNv805L3xPOlCEGmksZLzTvJt5ryc4/ycpoBQo3Kf9Q5BIrkV7+ck+u0mmeT+/Y5mnlS76cJIURwZ5nx7L4zUFqmMuWJGFba47kwXCeLs+barxUaG7EZnz1A0QYBDdwak8mMdiII=
Message-ID: <b0943d9e0612180228w142a7375obf33a0f42d1982ae@mail.gmail.com>
Date: Mon, 18 Dec 2006 10:28:43 +0000
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [PATCH 2.6.20-rc1 00/10] Kernel memory leak detector 0.13
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061218072932.GA5624@elte.hu>
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/12/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Catalin Marinas <catalin.marinas@gmail.com> wrote:
> > I could also use a simple allocator based on alloc_pages since
> > kmemleak doesn't track pages. [...]
>
> actually, i'm quite sure we want to track pages later on too, any reason
> why kmemleak shouldnt cover them?

It could track them but I'm not sure how efficient it would be since
you have different ways to get the page addresses like pfn, struct
page. The pfn would actually introduce a lot of false negatives.

This needs some investigation and it can probably be done but I'll
first focus on the slab allocator.

> > [...] It could be so simple that it would never need to free any
> > pages, just grow the size as required and reuse the freed memleak
> > objects from a list.
>
> sounds good to me. Please make it a per-CPU pool.

Isn't there a risk for the pools to become imbalanced? A lot of
allocations would initially happen on the first CPU.

> [...] (Add a memleak_object->cpu pointer so that freeing can be
> done on any other CPU as well.)

We could add the freed objects to the CPU pool where they were freed
and not use a memleak_object->cpu pointer.

> We'll have to fix the
> locking too, to be per-CPU - memleak_lock is quite a scalability problem
> right now.

The memleak_lock is indeed too coarse (but it was easier to track the
locking dependencies). With a new allocator, however, I could do a
finer grain locking. It probably still needs a (rw)lock for the hash
table. Having per-CPU hash tables is inefficient as we would have to
look up all the tables at every freeing or scanning for the
corresponding memleak_object.

There is a global object_list as well covered by memleak_lock (only
for insertions/deletions as traversing is RCU). Since modifications to
this list happen at the same time with the hash table modifications,
the memleak_lock is held anyway so we probably don't need to do
per-CPU object lists (they would also need some locking if freeing
would happen on a different CPU). List insertion/deletion is very
small compared to the hash-table look-up and it wouldn't introduce a
scalability problem.

-- 
Catalin
