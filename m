Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262088AbREZAHv>; Fri, 25 May 2001 20:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262097AbREZAHl>; Fri, 25 May 2001 20:07:41 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:4623 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S262088AbREZAHg>; Fri, 25 May 2001 20:07:36 -0400
Date: Fri, 25 May 2001 21:07:24 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [with-PATCH-really] highmem deadlock removal, balancing & cleanup
In-Reply-To: <Pine.LNX.4.31.0105251700350.15549-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0105252103570.10469-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2001, Linus Torvalds wrote:

> So I think I'll buy some experimentation. That HIGHMEM change is
> too ugly to live, though, I'd really like to hear more about why
> something that ugly is necessary.

If you mean the "GFP_BUFFER allocations should fail instead
of looping forever" thing, it is because:

1) GFP_BUFFER allocations are made in order to try to flush
   (and free) pages and allocate highmem pages.

2) This is the page flushing equivalent of PF_MEMALLOC, in
   the sense that we should not go and try to "recursively"
   flush more random pages until we find one that succeeds
   without an allocation; instead, we should just break the
   loop and let the caller deal with it.


If you mean the change to nr_free_buffer_pages(), that one
is needed because that function should return what the name
implies ... returning "2 GB of memory available for dirty
buffers" makes for a completely filled up ZONE_NORMAL and
processes which never get throttled for writing (and instead,
end up looping for more memory and killing performance for
the rest of the system).


regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

