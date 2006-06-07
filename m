Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWFGPhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWFGPhV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 11:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWFGPhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 11:37:21 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:48662 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932267AbWFGPhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 11:37:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=osy0GgJdrrenlEiUYYJv0Pw3fd3iZXKYdJ0+zf2jqpmsFkEfxG0XT15KNpjClQKjEaIt1V3xpPuBALY6D3myWgS99rWu7NgPa2sQrT1zUdfNV35D/YCiVivhLIVjbct6H/8qOvcMwimNyVxPxGY/CJxgA2cevsIRNSxE8nlHHn8=
Message-ID: <4ae3c140606070837t23182496s42edb3a754169d43@mail.gmail.com>
Date: Wed, 7 Jun 2006 11:37:18 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: Linux SLAB allocator issue
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
In-Reply-To: <84144f020606070516m4bccdecdr998941ee74744a83@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4ae3c140606061358j140eec9fl45e22f8a9e673215@mail.gmail.com>
	 <84144f020606070516m4bccdecdr998941ee74744a83@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your kind reply.

I did the following experiment.

I create my own cache with kmem_cache_create() and specify the
constructor to be init_once()-- a simple constructor like NFS does.

I checked the cache parameter and find that each slab has 1 page and
can hold 10 objects.

Then, I used kmem_cache_alloc() to allocate 128 objects. So it should
occupy 12 full slabs and 1 partial slab. Right?

But when I walk through the slabs_full and slabs_partial list, I found
that slabs_full returned 13 slabs but slabs_partial returned 0.

That's why I am confused. I am using 2.6.16 BTW.

Any further insight?

Thanks,
Xin

On 6/7/06, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> On 6/6/06, Xin Zhao <uszhaoxin@gmail.com> wrote:
> > I am trying to check how many slabs are used for inode_cache, but
> > found that all slabs are added to slabs_full list, and slabs_partial
> > is always empty. Even if the active object number does not exactly
> > occupy all slabs.
> >
> > Does that mean Linux 2.6 remove the use of slabs_partial?
>
> No. If slabs_partial is really empty, the number of active objects
> should match the number of objects in a slab; otherwise you should see
> an error message when you do cat /proc/slabinfo (see s_show in
> mm/slab.c for details).
>
> How are you verifying that the partial list is empty?
>
> On 6/6/06, Xin Zhao <uszhaoxin@gmail.com> wrote:
> > Another question, the constructor transfered to the
> > kmem_cache_create() function is called for every object in a slab when
> > it is created. Is this true? Is there any way to call back a function
> > _only once_ when a new slab is allocated?
>
> We don't have per-slab constructors. Only per-object. What do you need it for?
>
>                                             Pekka
>
