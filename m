Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317182AbSIEGub>; Thu, 5 Sep 2002 02:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317176AbSIEGub>; Thu, 5 Sep 2002 02:50:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26640 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317169AbSIEGua>;
	Thu, 5 Sep 2002 02:50:30 -0400
Message-ID: <3D7702BE.85A5D11D@zip.com.au>
Date: Thu, 05 Sep 2002 00:07:42 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Race in shrink_cache
References: <E17mooe-00064m-00@starship> <3D76FB64.7AAB215F@zip.com.au> <E17mqFV-00065Y-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> ...
> /*
>  * We must not allow an anon page
>  * with no buffers to be visible on
>  * the LRU, so we unlock the page after
>  * taking the lru lock
>  */
> 
> That is, what's scary about an anon page without buffers?

ooop.  That's an akpm comment.  umm, err..

It solves this BUG:

http://www.cs.helsinki.fi/linux/linux-kernel/2001-37/0594.html

Around the 2.4.10 timeframe, Andrea started putting anon pages
on the LRU.  Then he backed that out, then put it in again.  I
think this comment dates from the time when anon pages were
not on the LRU.  So there's a little window there where the
page is unlocked, we've just dropped its swapdev buffers, the page is
on the LRU and pagemap_lru_lock is not held.

So another CPU came in, found the page on the LRU, saw that it had
no ->mapping and no ->buffers and went BUG.

The fix was to take pagemap_lru_lock before unlocking the page.

The comment is stale.
