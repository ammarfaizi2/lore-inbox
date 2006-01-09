Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbWAIFNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWAIFNq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 00:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWAIFNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 00:13:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62351 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751259AbWAIFNo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 00:13:44 -0500
Date: Sun, 8 Jan 2006 21:13:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: ryan@tau.solarneutrino.net, Kai.Makisara@kolumbus.fi,
       James.Bottomley@SteelEye.com, hugh@veritas.com, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Fw: crash on x86_64 - mm related?
Message-Id: <20060108211321.49a78679.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601082000450.3169@g5.osdl.org>
References: <Pine.LNX.4.64.0512121007220.15597@g5.osdl.org>
	<1134411882.9994.18.camel@mulgrave>
	<20051215190930.GA20156@tau.solarneutrino.net>
	<1134705703.3906.1.camel@mulgrave>
	<20051226234238.GA28037@tau.solarneutrino.net>
	<Pine.LNX.4.63.0512271807130.4955@kai.makisara.local>
	<20060104172727.GA320@tau.solarneutrino.net>
	<Pine.LNX.4.63.0601042334310.5087@kai.makisara.local>
	<20060105201249.GB1795@tau.solarneutrino.net>
	<Pine.LNX.4.64.0601051312380.3169@g5.osdl.org>
	<20060109033149.GC283@tau.solarneutrino.net>
	<Pine.LNX.4.64.0601082000450.3169@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> On Sun, 8 Jan 2006, Ryan Richter wrote:
> >
> > Kernel BUG at mm/swap.c:49
> 
> Well, it sure triggered.
> 
> > Process taper (pid: 4501, threadinfo ffff8101453d8000, task ffff81017d0143c0)
> > Call Trace:<ffffffff8028c614>{sgl_unmap_user_pages+124}
> >		 <ffffffff8028834d>{release_buffering+27}
> 
> and it's that same sgl_unmap_user_pages() that keeps on triggering it.
> 
> Which was not what I was hoping for. I was hoping we'd see somebody _else_ 
> decrementing the page count below the map count, and get a new clue.
> 
> However, the page flags you show later on (0x1c) ended up making me take 
> notice of something. That's "dirty", and maybe it's from
> 
> 	if (dirtied)
> 		SetPageDirty(page);
> 
> in that same sgl_unmap_user_pages() routine.. And it strikes me that that 
> is bogus.
> 
> Code like that should use "set_page_dirty()", which does the appropriate 
> callbacks to the filesystem for that page. I wonder if the bug is simply 
> because the ST code just sets the dirty bit without telling anybody else 
> about it...
> 

It should be using set_page_dirty_lock().  As should st_unmap_user_pages().
 I doubt if this would explain a refcounting problem though.

Ryan, It might be worth poisoning the thing, see if the completion is being
called twice:


diff -puN drivers/scsi/st.c~a drivers/scsi/st.c
--- devel/drivers/scsi/st.c~a	2006-01-08 21:11:47.000000000 -0800
+++ devel-akpm/drivers/scsi/st.c	2006-01-08 21:12:13.000000000 -0800
@@ -4482,11 +4482,12 @@ static int sgl_unmap_user_pages(struct s
 		struct page *page = sgl[i].page;
 
 		if (dirtied)
-			SetPageDirty(page);
+			set_page_dirty_lock(page);
 		/* FIXME: cache flush missing for rw==READ
 		 * FIXME: call the correct reference counting function
 		 */
 		page_cache_release(page);
+		sgl[i].page = NULL;
 	}
 
 	return 0;
_

