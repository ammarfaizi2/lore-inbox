Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275759AbRJFWdX>; Sat, 6 Oct 2001 18:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275765AbRJFWdO>; Sat, 6 Oct 2001 18:33:14 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:18949 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S275759AbRJFWc6>; Sat, 6 Oct 2001 18:32:58 -0400
Date: Sun, 7 Oct 2001 00:31:27 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Reply-To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Anton Blanchard <anton@samba.org>, Rik van Riel <riel@conectiva.com.br>,
        Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: %u-order allocation failed
In-Reply-To: <E15pylR-0002LE-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.1011007002406.18004A-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It is perfectly OK to have a bit slower access to task_struct with
> > probability 1/1000000.
> 
> Except that you added a bug where some old driver code would crash the 
> machine by doing so.

?

> > Yes, but there are still other dangerous usages of kmalloc and
> > __get_free_pages. (The most offending one is in select.c)
> 
> Nothing dangeorus there. The -ac vm isnt triggering these cases.

Sorry, but it can be triggered by _ANY_ VM since buddy allocator was
introduced. You have no guarantee, that you find two or more consecutive
free pages. And if you don't, poll() fails. 

> > not abort his operation when it happens. Instead - they are trying to make
> > high-order allocations fail less often :-/  How should random
> > Joe-driver-developer know, that kmalloc(4096) is safe and kmalloc(4097) is
> > not?
> 
> 4096 is not safe - there is no safe size for a kmalloc, you can always run
> out of memory - deal with it.

This is not about running out of memory. It is about free space
fragmentation. Think this: 

You have no swap.
Program allocates one file cache page, one anon page, one cache page, one
anon page and so on. The memory will look like:

cache page
anon page
cache page
anon page
cache page
anon page
etc.

Now some driver wants to allocate 4097 and it CAN'T. Even when there's
half memory free.

Mikulas


