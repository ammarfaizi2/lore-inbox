Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281450AbRLQR34>; Mon, 17 Dec 2001 12:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281738AbRLQR3r>; Mon, 17 Dec 2001 12:29:47 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:269 "EHLO vasquez.zip.com.au")
	by vger.kernel.org with ESMTP id <S281450AbRLQR3e>;
	Mon, 17 Dec 2001 12:29:34 -0500
Message-ID: <3C1E2A19.BC654FF0@zip.com.au>
Date: Mon, 17 Dec 2001 09:23:37 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: FORT David <popo.enlighted@free.fr>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 deadlock in kswapd
In-Reply-To: <3C1DF93E.80907@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FORT David wrote:
> 
> Hi,
> today i was transfering some files between two drives(reiserfs->ext3) and
> suddenly everything locked up. I sys-rqed to show the executed IP and
> every five times i've tryed it was showing the following stack trace:
> 
> ...
> 
>  >>EIP; c0111657 <flush_tlb_others+e7/110>   <=====
> Trace; c01117b5 <flush_tlb_page+75/80>
> Trace; c012f052 <swap_out+312/4b0>
> ...

Dodgy hardware, I'm afraid - it looks like a cross-CPU interrupt
was sent but not received.  Not uncommon.

> The interesting thing is that i don't have any swap, so i'm really
> interested
> in knowing why kswapd is envolved here.

Look at the swapout code: it calls flush_tlb_page() in preparation
for swapping a page out.  It then tries to allocate swap space,
finds there is none and bales out.  This can comsume quite a lot
of CPU under some circumstances.

-
