Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWEHDeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWEHDeG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 23:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWEHDeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 23:34:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9164 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932272AbWEHDeF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 23:34:05 -0400
Date: Sun, 7 May 2006 20:33:48 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Hokka Zakrisson <daniel@hozac.com>
cc: linux-kernel@vger.kernel.org,
       =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       greg@kroah.com, matthew@wil.cx
Subject: Re: [PATCH] fs: fcntl_setlease defies lease_init assumptions
In-Reply-To: <445E80DD.9090507@hozac.com>
Message-ID: <Pine.LNX.4.64.0605072030280.3718@g5.osdl.org>
References: <445E80DD.9090507@hozac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 May 2006, Daniel Hokka Zakrisson wrote:
>
> fcntl_setlease uses a struct file_lock on the stack to find the
> file_lock it's actually looking for. The problem with this approach is
> that lease_init will attempt to free the file_lock if the arg argument
> is invalid, causing kmem_cache_free to be called with the address of the
> on-stack file_lock.

Ok, I was actually really surprised that we'd ever allow a non-slab page 
to be free'd as a slab or kmalloc allocation, without screaming very 
loudly indeed. That implies a lack of some pretty fundamental sanity 
checking by default in the slab layer (I suspect slab debugging turns it 
on, but even without it, that's just nasty).

Can you see if this trivial patch at least causes a honking huge 
"kernel BUG" message to be triggered quickly?

Trond wrote an alternate patch for the actual problem which I sent 
separately, but it would probably be good to have more safety in the slab 
layer by default regardless.

		Linus

---
diff --git a/mm/slab.c b/mm/slab.c
index c32af7e..279ca59 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -597,6 +597,7 @@ static inline struct kmem_cache *page_ge
 {
 	if (unlikely(PageCompound(page)))
 		page = (struct page *)page_private(page);
+	BUG_ON(!PageSlab(page));
 	return (struct kmem_cache *)page->lru.next;
 }
 
@@ -609,6 +610,7 @@ static inline struct slab *page_get_slab
 {
 	if (unlikely(PageCompound(page)))
 		page = (struct page *)page_private(page);
+	BUG_ON(!PageSlab(page));
 	return (struct slab *)page->lru.prev;
 }
 
