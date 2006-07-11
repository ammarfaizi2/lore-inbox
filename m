Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWGKISO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWGKISO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 04:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWGKISO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 04:18:14 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:11975 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750738AbWGKISN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 04:18:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nNArQ14Jz04fvVz2F6fW9HxCgBkt5VlD5C55nA/3sQnaLKoP1Wp3KtssxoQKUfSpWEvVOtVP1hJ/nC5xirXxxowPUESIA2abjbEmYGz9jasTqJudV65eVmWtvTuhmrRfHZ2z0EYfPlcwDatHyHDJVAVrm2RE28RSr4RiGjyZjA8=
Message-ID: <b0943d9e0607110118p5b9dfc28qb377b61e59ec7535@mail.gmail.com>
Date: Tue, 11 Jul 2006 09:18:12 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [PATCH 07/10] Remove some of the kmemleak false positives
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <84144f020607102349u62a59b26va0cec06c6d15e178@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060710220901.5191.66488.stgit@localhost.localdomain>
	 <20060710221037.5191.75356.stgit@localhost.localdomain>
	 <84144f020607102349u62a59b26va0cec06c6d15e178@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/06, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> On 7/11/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> > @@ -166,6 +166,9 @@ struct platform_device *platform_device_
> >         struct platform_object *pa;
> >
> >         pa = kzalloc(sizeof(struct platform_object) + strlen(name), GFP_KERNEL);
> > +       /* kmemleak cannot guess the object type because the block
> > +        * size is different from the object size */
> > +       memleak_typeid(pa, struct platform_object);
>
> AFAICT, we about 300 kmalloc and kzalloc calls in the kernel that
> would need this annotation.

Most of them wouldn't need this annotation. The problem here is that
the stored pointer is usually pointing to &pa->pdev.dev and "pa" is
accessed via two container_of macros. There might be a few more cases
like this which I didn't find but I don't expect a large number.

> If we really can't fix the detector to deal with these,

As I posted a few weeks ago, this cannot be done without introducing a
lot of false negatives.

> I would prefer we introduce another memory allocator
> function such as:
>
>     void *kzalloc_extra(size_t obj_size, size_t nr_extra, gfp_t flags);
>
> That would do the right thing for memleak too.

There is another case where extra bytes are added in front of the
structure for alignment (the function could have "before" and "after"
arguments). As I said above there aren't many places where kmemleak
needs this.

As Ingo said in the past, we could better go for precise type
identification/checking in kmalloc and both the kernel and kmemleak
would benefit from this  (but that's a pretty large patch).

-- 
Catalin
