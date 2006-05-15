Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbWEOKJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbWEOKJY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 06:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWEOKJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 06:09:24 -0400
Received: from wx-out-0102.google.com ([66.249.82.204]:42074 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751445AbWEOKJX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 06:09:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=isldia1Gg4f/vz6zR70X6K36PXPtlX6k8VLwQfSCK2Dm+UH69K5l5q4q+PgumXosQRI7MoiIftqydhHD6iLSB8Yys26+qZHZ9c1uiD332vzh8JqK9AhF906rSFFT52x86JNLlukEJ7rOO3ViZ12Mlts586Zre6zuh7w3qW1Qk1M=
Message-ID: <b0943d9e0605150309s9cfe5d3g7315c47832d12674@mail.gmail.com>
Date: Mon, 15 May 2006 11:09:22 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: [PATCH 2.6.17-rc4 1/6] Base support for kmemleak
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200605151115.28298.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060513155757.8848.11980.stgit@localhost.localdomain>
	 <p73u07t5x6f.fsf@bragg.suse.de> <4466E80F.4010907@gmail.com>
	 <200605151115.28298.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/06, Andi Kleen <ak@suse.de> wrote:
> > For example, it should be able to detect
> > leaks similar to those fixed recently by Jesper:
>
> Does it or does it not?

It does in most of the cases. Take for example
http://lkml.org/lkml/2006/5/13/145. KMemLeak detects it if the leak
happened, i.e. parse_num32 returns a non-zero value and kfree(name)
isn't present. When scanning the memory, the value of the name pointer
won't be found and therefore the block is shown as orphan.

I did similar tests to the above bug and it detected them in 90% of
the cases. However, I haven't done tests with objects reusing. I need
to write more comprehensive tests.

> > > What looks a bit dubious is how objects reuse is handled. You can't
> > > distingush an reused object from an old leaked pointer.
> >
> > The reused objects are not reported as leaks as long as the tool finds a
> > pointer to their address (or alias). The memleak_alloc hook is called in
> > kmem_cache_alloc after the object was actually allocated by
> > __cache_alloc. An object cannot be reused as long as it hasn't been
> > previously freed via kmem_cache_free (and the corresponding hook,
> > memleak_free, called). Kmemleak only reports allocated objects for which
> > there is no way to determine their address that can later be used in a
> > kmem_cache_free call.
>
> My point was that if you changed slab to be a queue and not
> reuse objects that quickly you could likely find many more leaks with
> your patch. It would make the patch more intrusive though and
> slow slab down, so it would need to be ifdefed.

I think I got it now. You mean that the value of a leaked pointer
could be found in other structures that previously used that object.
Anyway, I considered it a kernel bug if an invalid pointer remains in
a valid data structure. The latter would need to be freed as well and,
in this case, kmemleak won't scan it. I don't expect to have many
cases like this but, well, I haven't read the whole source.

> Another possibly less intrusive approach would be to use ioremap()
> for all slab objects and hack __pa/__va to resolve it. Then you
> would get unique addresses. You might need to increase the vmalloc
> space on 32bit though. And ioremap again would need to be changed
> to cycle through the address space, not reuse quickly (but it is
> much simpler than slab and wouldn't be very difficult)
>
> Using ioremap like this also has the advantage that use-after-free can
> be easily detected.

That's indeed an interesting idea. It has some difficulties as well
since you can only remap at the page level and a lot of virtual space
would be used (some way to compact consecutive blocks in one remapped
page would be needed).

Another improvement (but not enough) would be to zero the pointer
passed to kmem_cache_free (detecting at compilation time if it is
non-constant).

The tool can also be extended to track where the allocated blocks are
referred from and check whether those values are still in valid
structures after the blocks were freed.

Thanks for suggestions. They are really useful.

-- 
Catalin
