Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265443AbUAZEG4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 23:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265452AbUAZEG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 23:06:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:19120 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265443AbUAZEGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 23:06:54 -0500
Date: Sun, 25 Jan 2004 20:07:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Philippe Elie <phil.el@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, levon@movementarian.org
Subject: Re: [PATCH] oprofile per-cpu buffer overrun
Message-Id: <20040125200701.3c7b769a.akpm@osdl.org>
In-Reply-To: <20040126023715.GA3166@zaniah>
References: <20040126023715.GA3166@zaniah>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philippe Elie <phil.el@wanadoo.fr> wrote:
>
> Hi Andrew,
> 
> In a ring buffer controlled by a read and write positions we
> can't use buffer_size but only buffer_size - 1 entry,

you can, actually.

> the last
> free entry act as a guard to avoid write pos overrun. This bug
> was hidden because the writer, oprofile_add_sample(), request
> one more entry than really needed.
> 
>...
> diff -u -p -r1.9 cpu_buffer.c
> --- drivers/oprofile/cpu_buffer.c	26 May 2003 04:42:54 -0000	1.9
> +++ drivers/oprofile/cpu_buffer.c	24 Jan 2004 21:07:03 -0000
> @@ -86,9 +86,9 @@ static unsigned long nr_available_slots(
>  	unsigned long tail = b->tail_pos;
>  
>  	if (tail > head)
> -		return tail - head;
> +		return (tail - head) - 1;
>  
> -	return tail + (b->buffer_size - head);
> +	return tail + (b->buffer_size - head) - 1;
>  }

When implementing a circular buffer it is better to not constrain the head
and tail indices - just let them grow and wrap without bound.  You only need
to bring them in-bounds when you actually use them to index the buffer.

This way,

- head-tail is always the amount of used space, no need to futz around
  handling the case where one has wrapped and the other hasn't.

- you get to use all of the buffer, because the cases head-tail == 0
  (empty) and head-tail == bufsize (full) are now distinguishable.

  It helps if the buffer size is a power of two, of course, but integer
  modulus is pretty quick.

All the net drivers and the printk log buffer implement their ring buffers
in this way; it works nicely.

