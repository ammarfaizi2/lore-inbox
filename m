Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265463AbRF1Alo>; Wed, 27 Jun 2001 20:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265460AbRF1Alc>; Wed, 27 Jun 2001 20:41:32 -0400
Received: from tsukuba.m17n.org ([192.47.44.130]:24538 "EHLO tsukuba.m17n.org")
	by vger.kernel.org with ESMTP id <S265452AbRF1AlS>;
	Wed, 27 Jun 2001 20:41:18 -0400
Date: Thu, 28 Jun 2001 09:41:13 +0900 (JST)
Message-Id: <200106280041.f5S0fDr05278@mule.m17n.org>
From: NIIBE Yutaka <gniibe@m17n.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swapin flush cache bug
In-Reply-To: <20010628012349.L1554@redhat.com>
In-Reply-To: <200106270051.f5R0pkl19282@mule.m17n.org>
	<Pine.LNX.4.21.0106270710050.1291-100000@freak.distro.conectiva>
	<200106280007.f5S07qQ04446@mule.m17n.org>
	<20010628012349.L1554@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen, 

Stephen C. Tweedie wrote:
 > First, don't we want to do a flush_page_to_ram() *before* starting the
 > swap IO?

Well, let me explain the issue.  It is the thing we need to do
flushing *after* I/O.

--------------------------
Problem with virtually indexed physically tagged write-back cache.

(1) Page got swapped out

           Swap out
   [ Page ] ----> [ Disk ]

(2) Page got swapped in asynchronously, possibly by read-ahead

           Swap in
   [ Page ] <---- [ Disk ]
	   K

   The I/O from disk goes through kernel virtual address K.
   We have cache entries indexed by K.

(3) Page fault occurs at user space U

   U ----> [ Page ] -----> [ Disk ]
		   K

   The control goes to do_swap_page, found the page at
   lookup_swap_cache.

   If K and U indexes differently, we have cache alias issues, we need
   to flush the entries indexed by K and let them go to memory.  Or else, 
   user space will see bogus data in Page.
-- 
