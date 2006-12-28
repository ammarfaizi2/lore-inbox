Return-Path: <linux-kernel-owner+w=401wt.eu-S964838AbWL1APn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWL1APn (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 19:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbWL1APn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 19:15:43 -0500
Received: from nz-out-0506.google.com ([64.233.162.238]:63125 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964838AbWL1APm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 19:15:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Kq6nQ9p7x6SWpEoK49L3EjBr0cXFyxOkhNX3H24TpTNIiK4pNGaRmCvd7xjoTdkdU22zCUlSvy6L9M+o6nspxEuBle7ZPhvgwcZTMqm6lVDgqYVe6EgTuTiyImEApfK0a5z49Qtc4eGjFhZ19y5qTflTdWNsPHTOI7TgJzO1Ebs=
Message-ID: <b0943d9e0612271615r42c7f6abt38f36bbd9c94319f@mail.gmail.com>
Date: Thu, 28 Dec 2006 00:15:41 +0000
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [PATCH 2.6.20-rc1 00/10] Kernel memory leak detector 0.13
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061227173013.GA17560@elte.hu>
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
	 <b0943d9e0612270552n4a612103u5a5dafabeaec7ae5@mail.gmail.com>
	 <20061227150815.GA27828@elte.hu> <20061227173013.GA17560@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/12/06, Ingo Molnar <mingo@elte.hu> wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> > The pure per-CPU design would have to embedd the CPU ID the object is
> > attached to into the allocated object. If that is not feasible then
> > only the global hash remains i think.
>
> embedding the info shouldnt be /that/ hard in case of the SLAB: if the
> memleak info is at a negative offset from the allocated pointer. I.e.
> that if kmalloc() returns 'ptr', the memleak info could be at
> ptr-sizeof(memleak_info). That way you dont have to know the size of the
> object beforehand and there's absolutely no need for a global hash of
> any sort.

It would probably need to be just a pointer embedded in the allocated
block. With the current design, the memleak objects have a lifetime
longer than the tracked block. This is mainly to avoid long locking
during memory scanning and reporting.

> (it gets a bit more complex for page aligned allocations for the buddy
> and for vmalloc - but that could be solved by adding one extra pointer
> into struct page. [...]

This still leaves the issue of marking objects as not being leaks or
being of a different type. This is done by calling memleak_* functions
at the allocation point (outside allocator) where only the pointer is
known. In the vmalloc case, it would need to call find_vm_area. This
might not be a big problem, only that memory resources are no longer
treated in a unified way by kmemleak (and might not be trivial to add
support for new allocators).

> [...] That is a far more preferable cost than the
> locking/cache overhead of a global hash.)

A global hash would need to be re-built for every scan (and destroyed
afterwards), making this operation longer since the pointer values
together with their aliases (resulted from using container_of) are
added to the hash.

I understand the benefits but I personally favor simplicity over
performance, especially for code used as a debugging tool. DEBUG_SLAB
already introduces an overhead by poisoning the allocated blocks.
Generating the backtrace and filling in the memleak objects for every
allocation is another overhead. Global structures are indeed a
scalability problem but for a reasonable number of CPUs their overhead
might not be that big. Anyway, I can't be sure without some
benchmarking and this is probably highly dependent on the system
(caches, snoop control unit etc.).

-- 
Catalin
