Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273820AbRIRDhR>; Mon, 17 Sep 2001 23:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273822AbRIRDhI>; Mon, 17 Sep 2001 23:37:08 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:20507 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S273820AbRIRDhA>; Mon, 17 Sep 2001 23:37:00 -0400
Date: Tue, 18 Sep 2001 05:37:11 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010918053711.P698@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0109172016200.6823-100000@freak.distro.conectiva> <Pine.LNX.4.21.0109172156490.6905-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.21.0109172156490.6905-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Mon, Sep 17, 2001 at 10:08:22PM -0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2001 at 10:08:22PM -0300, Marcelo Tosatti wrote:
> 
> 
> On Mon, 17 Sep 2001, Marcelo Tosatti wrote:
> 
> > 
> > 
> > On Mon, 17 Sep 2001, Linus Torvalds wrote:
> > 
> > > 
> > > Ok, the big thing here is continued merging, this time with Andrea.
> > > 
> > > I still don't like some of the VM changes, but integrating Andrea's VM
> > > changes results in (a) better performance and (b) much cleaner inactive
> > > page handling in particular. Besides, for the 2.4.x tree, the big priority
> > > is stability, we can re-address my other concerns during 2.5.x.
> > 
> > Andrea, 
> > 
> > Could you please make a resume of your VM changes ? 
> > 
> > Its hard to keep up with VM changes this way. 
> 
> Andrea, 
> 
> I've just read a bit of your new VM code and I have a few comments.
> 
> You completly removed the "inactive freeable pages" logic: There is no

yes, it wasn't relly useful to keep this list lazily, you either keep it
enforced with locking overhead or such information isn't valuable.

> more distiction between "freeable inactive" and "free" pages. All VM work
> is based on "freepages.high" watermark. I don't like that: it seems to

hardly on freepages.high:

diff -urN vm-ref/mm/swap.c vm/mm/swap.c
--- vm-ref/mm/swap.c	Tue Sep 18 00:18:17 2001
+++ vm/mm/swap.c	Tue Sep 18 00:18:35 2001
@@ -24,50 +24,13 @@
 #include <asm/uaccess.h> /* for copy_to/from_user */
 #include <asm/pgtable.h>
 
-/*
- * We identify three levels of free memory.  We never let free mem
- * fall below the freepages.min except for atomic allocations.  We
- * start background swapping if we fall below freepages.high free
- * pages, and we begin intensive swapping below freepages.low.
- *
- * Actual initialization is done in mm/page_alloc.c
- */
-freepages_t freepages = {
-	0,	/* freepages.min */
-	0,	/* freepages.low */
-	0	/* freepages.high */
-};
-

> make page freeing more aggressive over time.

I don't see your point with "page freeing more aggressive over time".

> Also, if we have several try_to_free_pages() callers, for different
> classzones, I'm right saying that a caller with a "smaller" classzone can
> "hide" pages in its "active_local_lru" and/or "inactive_local_lru" (during
> shrink_cache) from other processes trying to free pages from those higher
> zones ?

I'm deeply impressed, you seem to have understood the rewrite greatly
well, congrats, this "hiding" was infact my main concern I had on the
memclass check during shrink_cache, but I don't think this will ever
give us troubles.  In such there are suprious swapouts with HIGHMEM
we'll just need to waste some cpu by lefting those pages visible with a
few changes in shrink_cache, but again I'm almost sure there won't be
problems, we do multiple scans before failing so those pages will return
visible before the other task has a chance to fail the allocation.

Andrea
