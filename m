Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267507AbUIPHHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267507AbUIPHHB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 03:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267494AbUIPHHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 03:07:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:19385 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267507AbUIPHGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 03:06:38 -0400
Date: Thu, 16 Sep 2004 00:04:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stelian Pop <stelian@popies.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Message-Id: <20040916000438.46d91e94.akpm@osdl.org>
In-Reply-To: <20040916064320.GA9886@deep-space-9.dsnet>
References: <20040913135253.GA3118@crusoe.alcove-fr>
	<20040915153013.32e797c8.akpm@osdl.org>
	<20040916064320.GA9886@deep-space-9.dsnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop <stelian@popies.net> wrote:
>
> > Implementation-wise, the head and tail indices should *not* be constrained
>  > to be less than the size of the buffer.  They should be allowed to wrap all
>  > the way back to zero.  This allows you to distinguish between the
>  > completely-empty and completely-full states while using 100% of the storage.
> 
>  Do you mean 'size' (the size of alloc'ed buffer) is redundant or 'len' 
>  (the amount of data in the FIFO) is redundant ? I see how 'len' could
>  be removed (and didn't do it in the first place because I choosed
>  code simplification over a 4 bytes gain in storage), but I hardly
>  see how 'size' could be removed...

Well I'm not sure what the semantic difference is between `size' and `len'.
They're not very well-chosen identifiers, really.

My point is that there is no need to store the "number of bytes currently
in the buffer", because that is always equal to `head - tail' if you allow
those indices to freely wrap.

All the struct needs is `head', `tail' and `number_of_bytes_at_buf', all
unsigned.

add(char c)
{
	p->buf[p->head++ % p->number_of_bytes_at_buf] = c;
}

get()
{
	return p->buf[p->tail++ %  p->number_of_bytes_at_buf];
}

free_space()
{
	return p->head - p->tail;
}

pretty simple...
