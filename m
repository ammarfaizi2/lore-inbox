Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131134AbRAETvp>; Fri, 5 Jan 2001 14:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131326AbRAETvf>; Fri, 5 Jan 2001 14:51:35 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:46096 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S131134AbRAETvP>; Fri, 5 Jan 2001 14:51:15 -0500
Date: Fri, 05 Jan 2001 14:51:01 -0500
From: Chris Mason <mason@suse.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
Message-ID: <906850000.978724261@tiny>
In-Reply-To: <Pine.LNX.4.21.0101051318190.2745-100000@freak.distro.conectiva>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, January 05, 2001 01:43:07 PM -0200 Marcelo Tosatti
<marcelo@conectiva.com.br> wrote:

> 
> On Fri, 5 Jan 2001, Chris Mason wrote:
> 
>> 
>> Here's the latest version of the patch, against 2.4.0.  The
>> biggest open issues are what to do with bdflush, since
>> page_launder could do everything bdflush does.  
> 
> I think we want to remove flush_dirty_buffers() from bdflush. 
> 

Whoops.  If bdflush doesn't balance the dirty list, who does?

But, we can do this in bdflush:

if (free_shortage())
	flushed = page_launder(GFP_KERNEL, 0) ;
else
	flushed = flush_dirty_buffers(0) ;

The idea is that page_launder knows best which pages to free when memory is
low, and flush_dirty_buffers knows best which pages to write when things
are unbalanced.  Not the cleanest idea ever, since I'd prefer the first
pages written when we need balancing are also the ones most likely to be
freed by page_launder.

In other words, I'd like to make a flush_inactive_dirty() inside
mm/vmscan.c, and have bdflush call that before working on the buffer cache
dirty list.

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
