Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129516AbQKOJu1>; Wed, 15 Nov 2000 04:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129775AbQKOJuR>; Wed, 15 Nov 2000 04:50:17 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:7158 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129516AbQKOJuG>; Wed, 15 Nov 2000 04:50:06 -0500
From: Christoph Rohland <cr@sap.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: shm swapping in 2.4 again
Organisation: SAP LinuxLab
Date: 15 Nov 2000 10:19:48 +0100
Message-ID: <qwwpujx383v.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rik et al,

here I am again. I investigated more into the shm swapping in 2.4 and
discovered the following things:

-  shm_swap is called from swap_out. Actually on my machine after a
   while it only gets called without __GFP_IO set, which means it will
   not do anything which again leads to deadlock.
-  I changed shm_swap to not have a priority but to try to free a
   number of pages. It will return the number of freed pages to the
   caller. This seems to be more reasonable than simply scanning part
   of he available memory. (I cleaned up shm.c a lot to do this...)
-  If I call this from page_launder it will work much better, but after a
   while it gets stuck on prepare_highmem_swapout and will again lock
   up under heavy load.

I see basically two ways to go:
1) try to make shm_swap more intelligent which pages to pick in
   itself. This would e.g. mean to build its own page list with lowmem
   pages queued before highmem and scanning this list instead the list
   of shm segments. But still the global vm will have balancing issues
   if you have loads of shm in use. The global vm also seems to be
   very bad at ummapping the oages from process contexts. I see a lot
   of false tries due to page_count > 1.
2) Integrating it into the global lru lists and/or the page cache. 

I think the second approach is the way to go but I do not understand
the global lru list handling enough to do this and I do not know if we
can do this in the short time.

I append a patch which implements the above mentioned changes. It is
not ready yet, but functional.

Comments?
		Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
