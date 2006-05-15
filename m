Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWEOJPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWEOJPd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 05:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWEOJPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 05:15:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:31127 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751345AbWEOJPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 05:15:33 -0400
From: Andi Kleen <ak@suse.de>
To: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2.6.17-rc4 1/6] Base support for kmemleak
Date: Mon, 15 May 2006 11:15:28 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060513155757.8848.11980.stgit@localhost.localdomain> <p73u07t5x6f.fsf@bragg.suse.de> <4466E80F.4010907@gmail.com>
In-Reply-To: <4466E80F.4010907@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200605151115.28298.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For example, it should be able to detect
> leaks similar to those fixed recently by Jesper:

Does it or does it not?

> > What looks a bit dubious is how objects reuse is handled. You can't
> > distingush an reused object from an old leaked pointer.
> 
> The reused objects are not reported as leaks as long as the tool finds a
> pointer to their address (or alias). The memleak_alloc hook is called in
> kmem_cache_alloc after the object was actually allocated by
> __cache_alloc. An object cannot be reused as long as it hasn't been
> previously freed via kmem_cache_free (and the corresponding hook,
> memleak_free, called). Kmemleak only reports allocated objects for which
> there is no way to determine their address that can later be used in a
> kmem_cache_free call.

My point was that if you changed slab to be a queue and not
reuse objects that quickly you could likely find many more leaks with 
your patch. It would make the patch more intrusive though and
slow slab down, so it would need to be ifdefed.

Another possibly less intrusive approach would be to use ioremap()
for all slab objects and hack __pa/__va to resolve it. Then you
would get unique addresses. You might need to increase the vmalloc
space on 32bit though. And ioremap again would need to be changed
to cycle through the address space, not reuse quickly (but it is
much simpler than slab and wouldn't be very difficult)

Using ioremap like this also has the advantage that use-after-free can 
be easily detected.

-Andi
