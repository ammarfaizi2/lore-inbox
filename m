Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266175AbRF2Ucu>; Fri, 29 Jun 2001 16:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266176AbRF2Uck>; Fri, 29 Jun 2001 16:32:40 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:39241 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S266175AbRF2UcZ>; Fri, 29 Jun 2001 16:32:25 -0400
Message-Id: <200106292033.f5TKXqw03584@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: Bounce buffer deadlock
Date: Fri, 29 Jun 2001 15:33:52 -0500
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Has anyone else seen a hang like this:

  bdflush()
    flush_dirty_buffers()
      ll_rw_block()
	submit_bh(buffer X)
	  generic_make_request()
	    __make_request()
	        create_bounce()
		  alloc_bounce_page()
		    alloc_page()
		      try_to_free_pages()
			do_try_to_free_pages()
			  page_launder()
			    try_to_free_buffers( , 2)  -- i.e. wait for buffers
			      sync_page_buffers()
				__wait_on_buffer(buffer X)

Where the buffer head X going in the top of the stack is the same as the one
we wait on at the bottom.

There still seems to be nothing to prevent the try to free buffers from
blocking on a buffer like this. Setting a flag on the buffer around the
create_bounce call, and skipping it in the try_to_free_buffers path would
be one approach to avoiding this.

I hit this in 2.4.6-pre6, and I don't see anything in the ac series to protect
against it.

Steve


