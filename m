Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbWDZK14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWDZK14 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 06:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbWDZK14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 06:27:56 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:35924 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932318AbWDZK1z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 06:27:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n7lFqh+f0IoD/eaD30Lj43LX9GPkmz8xYyqYPab4BxKfNG6lXh6l1uV/rY6tjYQ8xFn0IgbZdCoL0W1sLbERZckLm2Exbim1qo0PoE8xFyFcJz0/gqEPeUNB+Rd1IYRLj6DR/zbz6P/u5TU7zArJnk7nO8V+ywPOZhmtdvHsrCg=
Message-ID: <9a8748490604260327pe936e87yc9105868cc14557a@mail.gmail.com>
Date: Wed, 26 Apr 2006 12:27:54 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Dean Nelson" <dcn@sgi.com>
Subject: Re: [PATCH] change gen_pool allocator to not touch managed memory
Cc: "Andrew Morton" <akpm@osdl.org>, tony.luck@intel.com, jes@sgi.com,
       avolkov@varma-el.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060425155051.GA19248@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <444D1A7E.mailx85W11DZZU@aqua.americas.sgi.com>
	 <20060424181626.09966912.akpm@osdl.org>
	 <20060425155051.GA19248@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/06, Dean Nelson <dcn@sgi.com> wrote:
> The following patch modifies the gen_pool allocator (lib/genalloc.c) to
> utilize a bitmap scheme instead of the buddy scheme. The purpose of this
> change is to eliminate the touching of the actual memory being allocated.
>
> Since the change modifies the interface, a change to the uncached
> allocator (arch/ia64/kernel/uncached.c) is also required.
>
[snip]

A few small comments below.

> -unsigned long gen_pool_alloc(struct gen_pool *poolp, int size)
> +int gen_pool_add(struct gen_pool *pool, unsigned long addr, size_t size,
> +                int nid)
>  {
> -       int j, i, s, max_chunk_size;
> -       unsigned long a, flags;
> -       struct gen_pool_link *h = poolp->h;
> +       struct gen_pool_chunk *chunk;
> +       int nbits = size >> pool->min_alloc_order;
> +       int nbytes = sizeof(struct gen_pool_chunk) +
> +                               (nbits + BITS_PER_BYTE - 1) / BITS_PER_BYTE;
> +
> +       if (nbytes > PAGE_SIZE) {
> +               chunk = vmalloc_node(nbytes, nid);
> +       } else {
> +               chunk = kmalloc_node(nbytes, GFP_KERNEL, nid);
> +       }

No curly braces when not needed is usually prefered.

       if (nbytes > PAGE_SIZE)
               chunk = vmalloc_node(nbytes, nid);
       else
               chunk = kmalloc_node(nbytes, GFP_KERNEL, nid);


> +static int
> +uncached_add_chunk(struct gen_pool *pool, int nid)

Why not

 +static int uncached_add_chunk(struct gen_pool *pool, int nid)

There's room for it on one line and other functions in that file use
just one line (more grep'able)...


>  void
> -uncached_free_page(unsigned long maddr)
> +uncached_free_page(unsigned long uc_addr)

Move this to a single line perhaps?

 +void uncached_free_page(unsigned long uc_addr)


> +static int __init
> +uncached_init(void)

One line ?


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
