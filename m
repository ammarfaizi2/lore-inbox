Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135206AbREHTD0>; Tue, 8 May 2001 15:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135210AbREHTDS>; Tue, 8 May 2001 15:03:18 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:41223 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S135206AbREHTC6>; Tue, 8 May 2001 15:02:58 -0400
Date: Tue, 8 May 2001 14:23:56 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Mark Hemment <markhe@veritas.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] allocation looping + kswapd CPU cycles 
In-Reply-To: <Pine.LNX.4.21.0105081225520.31900-100000@alloc>
Message-ID: <Pine.LNX.4.21.0105081419070.7774-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 8 May 2001, Mark Hemment wrote:

> 
>   In 2.4.3pre6, code in page_alloc.c:__alloc_pages(), changed from;
> 
> 	try_to_free_pages(gfp_mask);
> 	wakeup_bdflush();
> 	if (!order)
> 		goto try_again;
> to
> 	try_to_free_pages(gfp_mask);
> 	wakeup_bdflush();
> 	goto try_again;
> 
> 
>   This introduced the effect of a non-zero order, __GFP_WAIT allocation
> (without PF_MEMALLOC set), never returning failure.  The allocation keeps
> looping in __alloc_pages(), kicking kswapd, until the allocation succeeds.
> 
>   If there is plenty of memory in the free-pools and inactive-lists
> free_shortage() will return false, causing the state of these
> free-pools/inactive-lists not to be 'improved' by kswapd.
> 
>   If there is nothing else changing/improving the free-pools or
> inactive-lists, the allocation loops forever (kicking kswapd).
> 
>   Does anyone know why the 2.4.3pre6 change was made?

Because wakeup_bdflush(0) can wakeup bdflush _even_ if it does not have
any job to do (ie less than 30% dirty buffers in the default config).  

> 
>   The attached patch (against 2.4.5-pre1) fixes the looping symptom, by
> adding a counter and looping only twice for non-zero order allocations.

Looks good. (actually Rik had a patch similar to this which fixed a real
case with cdda2wav just like you described)

