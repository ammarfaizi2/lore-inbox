Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRBNCJC>; Tue, 13 Feb 2001 21:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130321AbRBNCIw>; Tue, 13 Feb 2001 21:08:52 -0500
Received: from tsukuba.m17n.org ([192.47.44.130]:26522 "EHLO tsukuba.m17n.org")
	by vger.kernel.org with ESMTP id <S129066AbRBNCIs>;
	Tue, 13 Feb 2001 21:08:48 -0500
Date: Wed, 14 Feb 2001 11:08:07 +0900 (JST)
Message-Id: <200102140208.LAA18226@mule.m17n.org>
From: NIIBE Yutaka <gniibe@m17n.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: rmk@arm.linux.org.uk (Russell King),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (lkml)
Subject: Re: [PATCH] swapin flush cache bug
In-Reply-To: <E14Sdb6-0001V5-00@the-village.bc.nu>
In-Reply-To: <200102131053.TAA11808@mule.m17n.org>
	<E14Sdb6-0001V5-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
 > Ok we need to handle that case a bit more intelligently so those flushes dont
 > get into other ports code paths. 

Possibly at fs/buffer.c:end_buffer_io_async?

We need to flush the cache when I/O was READ or READA.  Is there any
way for end_buffer_io_async to distinguish which I/O (READ or WRITE)
has been done?

--------------------------------------
Problem with write-back cache.

(1) Page got swapped out

           Swap out
   [ Disk ] <---- P [ Page ]

(2) Page got swapped in asynchronously, possibly by read-ahead

           Swap in
   [ Disk ] ----> P [ Page ]
	          K

   The I/O from disk goes through kernel virtual address K.
   We have cache entries indexed by K.

(3) Page fault occurs at user space U

   [ Disk ]       P [ Page ] <----- U
		  K

   The control goes to do_swap_page, found the page at
   lookup_swap_cache.

   If K and U indexes differently, we have cache alias issues, 
   we need to flush the entries indexed by K.
-- 
