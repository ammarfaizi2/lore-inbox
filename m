Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268360AbUIKXVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268360AbUIKXVr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 19:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268365AbUIKXVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 19:21:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:45971 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268360AbUIKXVp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 19:21:45 -0400
Date: Sat, 11 Sep 2004 16:19:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, mochel@digitalimplant.org
Subject: Re: swsusp: clean up reading
Message-Id: <20040911161946.6f064c77.akpm@osdl.org>
In-Reply-To: <20040910085405.GC12751@elf.ucw.cz>
References: <20040910085405.GC12751@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
>  -static void wait_io(void)
>  -{
>  -	while(atomic_read(&io_done))
>  -		io_schedule();
>  -}
>  -
>  -
>   static struct block_device * resume_bdev;
>   
> ...
> 
>  -	wait_io();
>  +	while (atomic_read(&io_done))
>  +		yield();

This doesn't seem to be much of an improvement, really.  It still runs the
risk that the caller might have SCHIED_FIFO policy and we end up in a
spinloop until I/O completion.

Why not stick a `struct completion' at bio->bi_private, do complete() in
the end_io handler and wait_for_completion() in the caller?

I'll add the current patch to -mm for now, thanks.
