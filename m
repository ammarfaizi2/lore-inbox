Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266221AbRF3Rkn>; Sat, 30 Jun 2001 13:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266224AbRF3Rke>; Sat, 30 Jun 2001 13:40:34 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:35090 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S266221AbRF3RkU>; Sat, 30 Jun 2001 13:40:20 -0400
Date: Sat, 30 Jun 2001 13:07:20 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Steve Lord <lord@sgi.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Bounce buffer deadlock 
In-Reply-To: <200106301734.f5UHYML03030@jen.americas.sgi.com>
Message-ID: <Pine.LNX.4.21.0106301303250.3227-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Jun 2001, Steve Lord wrote:

> > 
> > 
> > On Fri, 29 Jun 2001, Steve Lord wrote:
> > 
> > > 
> > > Has anyone else seen a hang like this:
> > > 
> > >   bdflush()
> > >     flush_dirty_buffers()
> > >       ll_rw_block()
> > > 	submit_bh(buffer X)
> > > 	  generic_make_request()
> > > 	    __make_request()
> > > 	        create_bounce()
> > > 		  alloc_bounce_page()
> > > 		    alloc_page()
> > > 		      try_to_free_pages()
> > > 			do_try_to_free_pages()
> > > 			  page_launder()
> > > 			    try_to_free_buffers( , 2)  -- i.e. wait for buffers
> > > 			      sync_page_buffers()
> > > 				__wait_on_buffer(buffer X)
> > > 
> > > Where the buffer head X going in the top of the stack is the same as the on
> > e
> > > we wait on at the bottom.
> > > 
> > > There still seems to be nothing to prevent the try to free buffers from
> > > blocking on a buffer like this. Setting a flag on the buffer around the
> > > create_bounce call, and skipping it in the try_to_free_buffers path would
> > > be one approach to avoiding this.
> > 
> > Yes there is a bug: Linus is going to put a new fix soon. 
> > 
> > > I hit this in 2.4.6-pre6, and I don't see anything in the ac series to prot
> > ect
> > > against it.
> > 
> > Thats because the -ac series does not contain the __GFP_BUFFER/__GFP_IO
> > moditications which are in the -ac series.
> 
> It looks to me as if all memory allocations of type GFP_BUFFER which happen
> in generic_make_request downwards can hit the same type of deadlock,
> bounce buffers, the request functions of the raid and lvm paths can all
> end up in try_to_free_buffers on a buffer they themselves hold the lock on.

Yes. 2.4.6-pre8 fixes that (not sure if its up already). 

> If the fix is to avoid page_launder in these cases then the number of
> occurrences when an alloc_pages fails will go up. 

> I was attempting to come up with a way of making try_to_free_buffers
> fail on buffers which are being processed in the generic_make_request
> path by marking them, the problem is there is no single place to reset
> the state of a buffer so that try_to_free_buffers will wait for it.
> Doing it after the end of the loop in generic_make_request is race
> prone to say the least.

I really want to fix things like this in 2.5. (ie not avoid the deadlock
by completly avoiding physical IO, but avoid the deadlock by avoiding
physical IO on the "device" which is doing the allocation)

Could you send me your code ? No problem if it does not work at all :)


