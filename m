Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274691AbRITWwX>; Thu, 20 Sep 2001 18:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274690AbRITWwE>; Thu, 20 Sep 2001 18:52:04 -0400
Received: from [195.223.140.107] ([195.223.140.107]:12278 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274689AbRITWvy>;
	Thu, 20 Sep 2001 18:51:54 -0400
Date: Fri, 21 Sep 2001 00:52:25 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: flush_tlb_all in vmalloc_area_pages
Message-ID: <20010921005225.K729@athlon.random>
In-Reply-To: <20010907165612.T11329@athlon.random> <20010920.142638.68040129.davem@redhat.com> <20010921002547.G729@athlon.random> <20010920.152919.35356833.davem@redhat.com> <20010921003845.J729@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010921003845.J729@athlon.random>; from andrea@suse.de on Fri, Sep 21, 2001 at 12:38:45AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2001 at 12:38:45AM +0200, Andrea Arcangeli wrote:
> On Thu, Sep 20, 2001 at 03:29:19PM -0700, David S. Miller wrote:
> > Please, I would heavily suggest leaving this area until 2.5.x there
> 
> ok

Linus please apply to next pre patch, I understood from David that for
him the direct mapping can overlap the vmalloc virtual address space, it
really doesn't make much sense to me but since this is a noop for me and
I trust him, we can really delay this to 2.5:

--- 2.4.10pre12aa2/mm/vmalloc.c.~1~	Thu Sep 20 01:44:20 2001
+++ 2.4.10pre12aa2/mm/vmalloc.c	Fri Sep 21 00:40:48 2001
@@ -144,6 +144,7 @@
 	int ret;
 
 	dir = pgd_offset_k(address);
+	flush_cache_all();
 	spin_lock(&init_mm.page_table_lock);
 	do {
 		pmd_t *pmd;

And btw, now I suspect David can have also have an arguments for the
tlb_flush removal (infact the problem is the same, if the address space
is shared by direct mapping and vmalloc we'd also need to flush the
tlb), but such one isn't really a noop for the other archs so I will be
more concerned not to reintroduce it and to at least just put an #ifndef
__i386__ around it (safe for both parts).

Andrea
