Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266217AbRF3RT1>; Sat, 30 Jun 2001 13:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266219AbRF3RTR>; Sat, 30 Jun 2001 13:19:17 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:23825 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S266217AbRF3RTI>; Sat, 30 Jun 2001 13:19:08 -0400
Date: Sat, 30 Jun 2001 12:46:14 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Steve Lord <lord@sgi.com>, Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Bounce buffer deadlock
In-Reply-To: <Pine.LNX.4.21.0106301229280.3227-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0106301245590.3227-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Jun 2001, Marcelo Tosatti wrote:

> 
> 
> On Fri, 29 Jun 2001, Steve Lord wrote:
> 
> > 
> > Has anyone else seen a hang like this:
> > 
> >   bdflush()
> >     flush_dirty_buffers()
> >       ll_rw_block()
> > 	submit_bh(buffer X)
> > 	  generic_make_request()
> > 	    __make_request()
> > 	        create_bounce()
> > 		  alloc_bounce_page()
> > 		    alloc_page()
> > 		      try_to_free_pages()
> > 			do_try_to_free_pages()
> > 			  page_launder()
> > 			    try_to_free_buffers( , 2)  -- i.e. wait for buffers
> > 			      sync_page_buffers()
> > 				__wait_on_buffer(buffer X)
> > 
> > Where the buffer head X going in the top of the stack is the same as the one
> > we wait on at the bottom.
> > 
> > There still seems to be nothing to prevent the try to free buffers from
> > blocking on a buffer like this. Setting a flag on the buffer around the
> > create_bounce call, and skipping it in the try_to_free_buffers path would
> > be one approach to avoiding this.
> 
> Yes there is a bug: Linus is going to put a new fix soon. 
> 
> > I hit this in 2.4.6-pre6, and I don't see anything in the ac series to protect
> > against it.
> 
> Thats because the -ac series does not contain the __GFP_BUFFER/__GFP_IO
> moditications which are in the -ac series.
				  ^^ 

I mean 2.4.6-pre, sorry.

