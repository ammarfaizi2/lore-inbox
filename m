Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273926AbRIRVGB>; Tue, 18 Sep 2001 17:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273927AbRIRVFn>; Tue, 18 Sep 2001 17:05:43 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:25380 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S273926AbRIRVFe>; Tue, 18 Sep 2001 17:05:34 -0400
Date: Tue, 18 Sep 2001 23:05:53 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010918230553.G720@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0109181254200.7152-100000@freak.distro.conectiva> <Pine.LNX.4.21.0109181508080.7836-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0109181508080.7836-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Tue, Sep 18, 2001 at 04:18:34PM -0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 04:18:34PM -0300, Marcelo Tosatti wrote:
> I still can reproduce the alloc pages failures with the following patch.

Could you try the very last patch I posted?

> --- linux.orig/mm/vmscan.c      Tue Sep 18 15:43:14 2001
> +++ linux/mm/vmscan.c   Tue Sep 18 16:37:52 2001
> @@ -361,13 +361,19 @@
>                 }
>  
>                 deactivate_page_nolock(page);
> +
>                 list_del(entry);
> -               list_add_tail(entry, &inactive_local_lru);
>  
> -               if (__builtin_expect(!memclass(page->zone, classzone), 0))
> +               if (__builtin_expect(!memclass(page->zone, classzone),
> 0)) {
> +                       list_add_tail(entry, &inactive_list);
> +                       __max_scan--;
>                         continue;
> +               }
>  
>                 __max_scan--;
> +
> +               list_add_tail(entry, &inactive_local_lru);
> +

I actually used a much more aggressive approch, I always left all the
page visibles now, not just for the memclass check. After all the same
issue that can arise with the memclass check can also arise in a smaller
scale with the other failed checks. But the oom weren't just because of
the "hiding", I suspect that infact.

Andrea
