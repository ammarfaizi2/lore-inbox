Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbVC3HDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbVC3HDQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 02:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVC3HDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 02:03:16 -0500
Received: from redpine-92-161-hyd.redpinesignals.com ([203.196.161.92]:31698
	"EHLO redpinesignals.com") by vger.kernel.org with ESMTP
	id S261777AbVC3HDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 02:03:06 -0500
Message-ID: <424A51F5.1050501@redpinesignals.com>
Date: Wed, 30 Mar 2005 12:45:01 +0530
From: P Lavin <lavin.p@redpinesignals.com>
Reply-To: lavin.p@redpinesignals.com
Organization: www.redpinesignals.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: no need to check for NULL before calling kfree() -fs/ext2/
References: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost>            <1111825958.6293.28.camel@laptopd505.fenrus.org>            <Pine.LNX.4.61.0503261811001.9945@chaos.analogic.com>            <Pine.LNX.4.62.0503270044350.3719@dragon.hyggekrogen.localhost>            <1111881955.957.11.camel@mindpipe>            <Pine.LNX.4.62.0503271246420.2443@dragon.hyggekrogen.localhost>            <20050327065655.6474d5d6.pj@engr.sgi.com>            <Pine.LNX.4.61.0503271708350.20909@yvahk01.tjqt.qr>            <20050327174026.GA708@redhat.com>            <1112064777.19014.17.camel@mindpipe>            <84144f02050328223017b17746@mail.gmail.com>            <Pine.LNX.4.61.0503290903530.13383@yvahk01.tjqt.qr>            <courier.42490293.000032B0@courier.cs.helsinki.fi>            <20050329184411.1faa71eb.pj@engr.sgi.com> <courier.424A43A5.00002305@courier.cs.helsinki.fi>
In-Reply-To: <courier.424A43A5.00002305@courier.cs.helsinki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
In my wlan driver module, i allocated some memory using kmalloc in 
interrupt context, this one failed but its not returning NULL , so i was 
proceeding further everything was going wrong... & finally the kernel 
crahed. Can any one of you tell me why this is happening ? i cannot use 
GFP_KERNEL because i'm calling this function from interrupt context & it 
may block. Any other solution for this ?? I'm concerned abt why kmalloc 
is not returning null if its not a success ??

Is it not necessary to check for NULL before calling kfree() ??
Regards,
Lavin

Pekka J Enberg wrote:

> Hi,
> Paul Jackson writes:
>
>> Even such obvious changes as removing redundant checks doesn't
>> seem to ensure a performance improvement.  Jesper Juhl posted
>> performance data for such changes in his microbenchmark a couple
>> of days ago.
>
>
> It is not a performance issue, it's an API issue. Please note that 
> kfree() is analogous libc free() in terms of NULL checking. People are 
> checking NULL twice now because they're confused whether kfree() deals 
> it or not.
> Paul Jackson writes:
>
>> Maybe we should be following your good advice:
>> > You don't know that until you profile! 
>> instead of continuing to make these code changes.
>
>
> I am all for profiling but it should not stop us from merging the 
> patches because we can restore the generated code with the included 
> (totally untested) patch.
>            Pekka
> Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
> ---
> Index: 2.6/include/linux/slab.h
> ===================================================================
> --- 2.6.orig/include/linux/slab.h       2005-03-22 14:31:30.000000000 
> +0200
> +++ 2.6/include/linux/slab.h    2005-03-30 09:08:13.000000000 +0300
> @@ -105,8 +105,14 @@
>       return __kmalloc(size, flags);
> }
> +static inline void kfree(const void * p)
> +{
> +       if (!p)
> +               return;
> +       __kfree(p);
> +}
> +
> extern void *kcalloc(size_t, size_t, int);
> -extern void kfree(const void *);
> extern unsigned int ksize(const void *);
> extern int FASTCALL(kmem_cache_reap(int));
> Index: 2.6/mm/slab.c
> ===================================================================
> --- 2.6.orig/mm/slab.c  2005-03-22 14:31:31.000000000 +0200
> +++ 2.6/mm/slab.c       2005-03-30 09:08:45.000000000 +0300
> @@ -2567,13 +2567,11 @@
> * Don't free memory not originally allocated by kmalloc()
> * or you will run into trouble.
> */
> -void kfree (const void *objp)
> +void __kfree (const void *objp)
> {
>       kmem_cache_t *c;
>       unsigned long flags;
> -       if (!objp)
> -               return;
>       local_irq_save(flags);
>       kfree_debugcheck(objp);
>       c = GET_PAGE_CACHE(virt_to_page(objp));
> @@ -2581,7 +2579,7 @@
>       local_irq_restore(flags);
> }
> -EXPORT_SYMBOL(kfree);
> +EXPORT_SYMBOL(__kfree);
> #ifdef CONFIG_SMP
> /**
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


