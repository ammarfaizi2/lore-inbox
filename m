Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261847AbSLHX1B>; Sun, 8 Dec 2002 18:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261857AbSLHX1B>; Sun, 8 Dec 2002 18:27:01 -0500
Received: from packet.digeo.com ([12.110.80.53]:59887 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261847AbSLHX1A>;
	Sun, 8 Dec 2002 18:27:00 -0500
Message-ID: <3DF3D706.977AC5BB@digeo.com>
Date: Sun, 08 Dec 2002 15:34:30 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] High-res-timers part 3 (posix to hrposix) take 20
References: <3DB9A314.6CECA1AC@mvista.com> <3DF2F965.59D7CD84@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Dec 2002 23:34:34.0787 (UTC) FILETIME=[5D91F730:01C29F12]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> 
> --- linux-2.5.50-bk7-kb/include/linux/id_reuse.h        Wed Dec 31 16:00:00 1969
> +++ linux/include/linux/id_reuse.h      Sat Dec  7 21:37:58 2002

Maybe I'm thick, but this whole id_resue layer seems rather obscure.

As it is being positioned as a general-purpose utility it needs
API documentation as well as a general description.

> +extern inline void update_bitmap(struct idr_layer *p, int bit)

Please use static inline, not extern inline.  If only for consistency,
and to lessen the amount of stuff which needs to be fixed up by those
of us who like to use `-fno-inline' occasionally.

> +extern inline void update_bitmap_set(struct idr_layer *p, int bit)

A lot of the functions in this header are too large to be inlined.

> +extern inline void idr_lock(struct idr *idp)
> +{
> +       spin_lock(&idp->id_slock);
> +}

Please, just open-code the locking.  This simply makes it harder to follow the
main code.

> +
> +static struct idr_layer *id_free;
> +static int id_free_cnt;

hm.  We seem to have a global private freelist here.  Is the more SMP-friendly
slab not suitable?

> ...
> +static int sub_alloc(struct idr_layer *p, int shift, void *ptr)
> +{
> +       int bitmap = p->bitmap;
> +       int v, n;
> +
> +       n = ffz(bitmap);
> +       if (shift == 0) {
> +               p->ary[n] = (struct idr_layer *)ptr;
> +               __set_bit(n, &p->bitmap);
> +               return(n);
> +       }
> +       if (!p->ary[n])
> +               p->ary[n] = alloc_layer();
> +       v = sub_alloc(p->ary[n], shift-IDR_BITS, ptr);
> +       update_bitmap_set(p, n);
> +       return(v + (n << shift));
> +}

Recursion!

> +void idr_init(struct idr *idp)

Please tell us a bit about this id layer: what problems it solves, how it
solves them, why it is needed and why existing kernel facilities are
unsuitable.

Thanks.
