Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261408AbREZP1p>; Sat, 26 May 2001 11:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261471AbREZP1f>; Sat, 26 May 2001 11:27:35 -0400
Received: from [200.203.199.88] ([200.203.199.88]:40710 "HELO netbank.com.br")
	by vger.kernel.org with SMTP id <S261274AbREZP1V>;
	Sat, 26 May 2001 11:27:21 -0400
Date: Sat, 26 May 2001 12:22:59 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
In-Reply-To: <20010526171459.Y9634@athlon.random>
Message-ID: <Pine.LNX.4.21.0105261219360.30264-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 May 2001, Andrea Arcangeli wrote:

> @@ -1416,11 +1416,9 @@
>  	 */
>  	run_task_queue(&tq_disk);
>  
> -	/* 
> -	 * Set our state for sleeping, then check again for buffer heads.
> -	 * This ensures we won't miss a wake_up from an interrupt.
> -	 */
> -	wait_event(buffer_wait, nr_unused_buffer_heads >= MAX_BUF_PER_PAGE);
> +	current->policy |= SCHED_YIELD;
> +	__set_current_state(TASK_RUNNING);
> +	schedule();
>  	goto try_again;
>  }

This cannot possibly fix the problem because this code is
never reached.

What was observed in the backtraces by arjan, ben, marcelo
and people at IBM was:

create_buffers -> get_unused_buffer_head -> __alloc_pages

with the system looping infinitely in __alloc_pages. The
code you are changing above ONLY gets reached in case the
__alloc_pages (and thus, get_unused_buffer_head) returns
failure.

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

