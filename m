Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267180AbRGKBkt>; Tue, 10 Jul 2001 21:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267181AbRGKBkj>; Tue, 10 Jul 2001 21:40:39 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:43761 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S267180AbRGKBkW>; Tue, 10 Jul 2001 21:40:22 -0400
Message-ID: <3B4BADBF.D3E27F42@mvista.com>
Date: Tue, 10 Jul 2001 18:37:03 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-mips@oss.sgi.com
Subject: Re: memory alloc failuer : __alloc_pages: 1-order allocation failed.
In-Reply-To: <3B4BA24E.1FB614B0@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just found more about this problem....

Jun Sun wrote:
> 
> I am running 2.4.2 on a linux/mips box, with 32MB system RAM (no swap).  When
> I run a stress test, I will hit memory allocation failure:
> 
> __alloc_pages: 1-order allocation failed.
> IP: queue_glue: no memory for gluing queue 8108cce0
> 
> However, I traced the system and found several questions.
> 
> First, free reports enough free memory and LOTS of cache memory.  See below.
> Should'nt Linux free cache memory to satisfy this request?
> 
>              total       used       free     shared    buffers     cached
> Mem:         30052      29296        756          0          0      16928
> -/+ buffers/cache:      12368      17684
> Swap:            0          0          0
>

The memory allocation is invoked with GFP_ATOMIC, and thus does not free up
the cached pages.  (Why? because it is invoked from interrupt context?)
 
> I used kgdb and dig into rmqueue() in mm/page_alloc.c file.  There are two
> zones in this system.  They do have many free pages but none of free blocks
> seem to be big enough for the 2-page request.  Does this make sense?  Why does
> kernel end up with so many fragmented 1-page free areas?  See the kgdb output
> below.
>

Shouldn't some kernel daemon try to maintain a "reasonable" free_area,
including a 2-page block?  It seems like in my case the daemon failed to do
the job.  (Which daemon is it? kflushd?)  What is the condition to kick start
this daemon?  I suppose in my case the total free page count is still high,
which may fail to start the daemon.

In the end, allocating memory from interrupt context for re-assembling IP
packet does not sound pretty either ...


Jun
