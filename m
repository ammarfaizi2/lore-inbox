Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131309AbRCRXuA>; Sun, 18 Mar 2001 18:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131307AbRCRXtv>; Sun, 18 Mar 2001 18:49:51 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:9994 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131308AbRCRXth>; Sun, 18 Mar 2001 18:49:37 -0500
Date: Sun, 18 Mar 2001 17:59:53 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: changing mm->mmap_sem  (was: Re: system call for process
 information?)
In-Reply-To: <200103181813.KAA22153@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0103181757400.13050-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Mar 2001, Linus Torvalds wrote:
> In article <Pine.LNX.4.21.0103181122480.13050-100000@imladris.rielhome.conectiva>,
> Rik van Riel  <riel@conectiva.com.br> wrote:
> >
> >OK, I'll write some code to prevent multiple threads from
> >stepping all over each other when they pagefault at the
> >same address.
> >
> >What would be the preferred method of fixing this ?
> >
> >- fixing do_swap_page and all ->nopage functions
> 
> There is no need to fix gthe "nopage" functions. They never see the
> page table directly anyway.
> 
> So the only thing that _should_ be needed is to make sure that
> do_no_page(), do_swap_page() and do_anonymous_page() will re-aquire
> the mm->page_table_lock and undo their work if it turns out that the
> page table entry is no longer empty..

... in which case concurrency is maximised, but there is a
possibility of doing double work...

> >- hacking handle_mm_fault to make sure no overlapping
> >  pagefaults will be served at the same time
> 
> No. The whole reason the rw_semaphores were done in the first place
> was to allow page faults to happen concurrently to allow threaded
> applictions to scale up even when faulting.

Indeed, having threaded apps do multiple page faults at the
same time is the main goal of this patch. However, I don't
see how it would be good for scalability to have multiple
threads fault in the same page at the same time, when they
could just wait for one of them to do the work.

Only faults for different addresses would proceed, not faults
for the same address...

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

