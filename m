Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130462AbQLGThC>; Thu, 7 Dec 2000 14:37:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130442AbQLGTgm>; Thu, 7 Dec 2000 14:36:42 -0500
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:50180 "EHLO
	anduin.gondor.com") by vger.kernel.org with ESMTP
	id <S130429AbQLGTgg>; Thu, 7 Dec 2000 14:36:36 -0500
Date: Thu, 7 Dec 2000 20:05:58 +0100
From: Jan Niehusmann <jan@gondor.com>
To: linux-kernel@vger.kernel.org, adilger@turbolinux.com
Subject: Re: fs corruption with invalidate_buffers()
Message-ID: <20001207200558.A976@gondor.com>
In-Reply-To: <20001206030723.A1136@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001206030723.A1136@gondor.com>; from jan@gondor.com on Wed, Dec 06, 2000 at 03:07:23AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2000 at 03:07:23AM +0100, Jan Niehusmann wrote:
> While resizing the filesystem, invalidate_buffers() is called from the
> lvm code. (lvm.c, line 2251, in lvm_do_lv_extend_reduce()) 
> If I remove this call, the corruption goes away. But this is probably not
> the correct fix, as it can cause problems when reducing the lv size.

Some more details:

I added the following code to put_last_free(bh) in buffer.c:

--- buffer.c.orig	Wed Dec  6 17:19:57 2000
+++ buffer.c	Thu Dec  7 19:55:39 2000
@@ -500,6 +500,11 @@
 	struct bh_free_head *head = &free_list[BUFSIZE_INDEX(bh->b_size)];
 	struct buffer_head **bhp = &head->list;
 
+	if(bh->b_page && Page_Uptodate(bh->b_page)
+			&& bh->b_page->mapping) { // XXX ???
+		BUG();
+	}
+
 	bh->b_state = 0;
 
 	spin_lock(&head->lock);


That is, if I want to put a buffer to the free list, I check if it is 
mapped and uptodate. If I understand the memory management correctly, this
is a Bad Thing and should not happen. But guess what? It does, in
invalidate_buffers. 

I think invalidate_buffers should check if the buffer belongs to a 
mapped page, and if it does, invalidate this mapping.

Jan


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
