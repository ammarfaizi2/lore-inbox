Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751700AbVKJDWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbVKJDWL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 22:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbVKJDWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 22:22:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18613 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751700AbVKJDWJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 22:22:09 -0500
Date: Wed, 9 Nov 2005 19:18:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kirill Korotaev <dev@sw.ru>
Cc: saw@sawoct.com, xemul@sw.ru, linux-kernel@vger.kernel.org, den@sw.ru,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH]: buddy allocator: ext3 failed to alloc with
 __GFP_NOFAIL
Message-Id: <20051109191802.02612594.akpm@osdl.org>
In-Reply-To: <43725227.5040605@sw.ru>
References: <4370ACB2.3000103@sw.ru>
	<43725227.5040605@sw.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> wrote:
>
> So kswapd (which has PF_MEMALLOC flag) can fail to allocate memory even 
>  when it allocates it with __GFP_NOFAIL flag.
> 
>  --- ./mm/page_alloc.c.alpg	2005-11-09 21:42:50.000000000 +0300
>  +++ ./mm/page_alloc.c	2005-11-09 21:44:22.000000000 +0300
>  @@ -870,6 +870,7 @@ zone_reclaim_retry:
>   	if (((p->flags & PF_MEMALLOC) || unlikely(test_thread_flag(TIF_MEMDIE)))
>   			&& !in_interrupt()) {
>   		if (!(gfp_mask & __GFP_NOMEMALLOC)) {
>  +nofail_alloc:
>   			/* go through the zonelist yet again, ignoring mins */
>   			for (i = 0; (z = zones[i]) != NULL; i++) {
>   				if (!cpuset_zone_allowed(z, gfp_mask))
>  @@ -878,6 +879,10 @@ zone_reclaim_retry:
>   				if (page)
>   					goto got_pg;
>   			}
>  +			if (gfp_mask & __GFP_NOFAIL) {
>  +				blk_congestion_wait(WRITE, HZ/50);
>  +				goto nofail_alloc;
>  +			}
>   		}
>   		goto nopage;
>   	}

The problem here is that we'll loop if TIF_MEMDIE is set.

But given that the caller has specified __GFP_NOFAIL, I think that's
correct behaviour - __GFP_NOFAIL means "I am lame, and will oops if you
cannot allocate memory".   So we just ignore TIF_MEMDIE..

That being said, why do we need another loop here?  Would it not
be sufficient to do:

--- devel/mm/page_alloc.c~a	2005-11-09 19:15:03.000000000 -0800
+++ devel-akpm/mm/page_alloc.c	2005-11-09 19:15:32.000000000 -0800
@@ -907,7 +907,8 @@ zone_reclaim_retry:
 					goto got_pg;
 			}
 		}
-		goto nopage;
+		if (!(gfp_mask & __GFP_NOFAIL))
+			goto nopage;
 	}
 
 	/* Atomic allocations - we can't balance anything */
_

Answer: because that way we'll go recursive if PF_MEMALLOC is set.  Ho-hum.
