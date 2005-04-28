Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262137AbVD1BAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262137AbVD1BAv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 21:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbVD1BAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 21:00:51 -0400
Received: from fire.osdl.org ([65.172.181.4]:54470 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262137AbVD1BAl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 21:00:41 -0400
Date: Wed, 27 Apr 2005 18:00:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org, mason@suse.com
Subject: Re: [patch] fix the 2nd buffer race properly
Message-Id: <20050427180012.26b75e0f.akpm@osdl.org>
In-Reply-To: <4270296D.9010109@yahoo.com.au>
References: <426F908C.2060804@yahoo.com.au>
	<20050427105655.5edc13ce.akpm@osdl.org>
	<4270296D.9010109@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> > There are two situations:
>  > 
>  > a) Thread 2 comes in and tries to write a buffer which thread1 didn't write:
>  > 
>  >    Yes, thread 1 will get confused and will try to write thread 2's buffer.
>  > 
>  > b) Thread 2 comes in and tries to write a buffer which thread 1 is
>  >    writing.  (Say, the buffer was redirtied by
>  >    munmap->__set_page_dirty_buffers, which doesn't lock the page or the
>  >    buffers)
>  > 
> 
>  I don't think b) happens, because thread 1 has to have finished all
>  its writes before the page will end writeback and thread 2 can go
>  anywhere.

hm, spose so.

>  >    Thread 2 will fail the test_set_buffer_locked() and will redirty the page.
>  > 
>  > That's all a bit too complex.   How's about this instead?
>  > 
> 
>  Well you really don't need to hold the page locked for that long.

Is a rare case, so there's no perfomance issue here.

I do prefer the idea of simply keeping other threads of control out of the
page until this thread has finished playing with its buffers.

(The buffer-ring walk we have in there is racy against page reclaim, too. 
If only the first buffer is dirty, we inspect the other buffers after
PageWriteback has potentially cleared.)

>  block_read_full_page, nobh_prepare_write both use the same sort of
>  array of buffer heads logic - I think it makes sense not to touch
>  any buffers after submitting them all for IO...?

Well.  Most code in there uses the ->b_this_page walk.
