Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266177AbRF2Umm>; Fri, 29 Jun 2001 16:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266179AbRF2Umc>; Fri, 29 Jun 2001 16:42:32 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:63498 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266177AbRF2Um2>; Fri, 29 Jun 2001 16:42:28 -0400
Subject: Re: Bounce buffer deadlock
To: lord@sgi.com (Steve Lord)
Date: Fri, 29 Jun 2001 21:42:16 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200106292033.f5TKXqw03584@jen.americas.sgi.com> from "Steve Lord" at Jun 29, 2001 03:33:52 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15G55k-0000yd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Has anyone else seen a hang like this:
> 
>   bdflush()
>     flush_dirty_buffers()
>       ll_rw_block()
> 	submit_bh(buffer X)
> 	  generic_make_request()
> 	    __make_request()
> 	        create_bounce()
> 		  alloc_bounce_page()
> 		    alloc_page()
> 		      try_to_free_pages()
> 			do_try_to_free_pages()
> 			  page_launder()
> 			    try_to_free_buffers( , 2)  -- i.e. wait for buffers
> 			      sync_page_buffers()
> 				__wait_on_buffer(buffer X)

Whoops. We actually carefully set PF_MEMALLOC to avoid deadlocks here but if
the buffer is laundered.... ummm

Looks like page_launder needs to be more careful

> I hit this in 2.4.6-pre6, and I don't see anything in the ac series to protect
> against it.

Not this one no

Alan

