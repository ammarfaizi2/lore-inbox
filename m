Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129593AbQLPTiV>; Sat, 16 Dec 2000 14:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130449AbQLPTiA>; Sat, 16 Dec 2000 14:38:00 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:23305 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129455AbQLPThp>; Sat, 16 Dec 2000 14:37:45 -0500
Date: Sat, 16 Dec 2000 11:07:00 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Chris Mason <mason@suse.com>
cc: Jeff Chua <jeffchua@silk.corp.fedex.com>, linux-kernel@vger.kernel.org
Subject: Re: Test12 ll_rw_block error.
In-Reply-To: <Pine.LNX.4.10.10012160851270.30931-100000@home.suse.com>
Message-ID: <Pine.LNX.4.10.10012161102470.21362-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 16 Dec 2000, Chris Mason wrote:
> 
> In other words, after calling reiserfs_get_block, the buffer might be
> mapped and uptodate, with no i/o required in block_read_full_page
> 
> The following patch to block_read_full_page fixes things for me, and seems
> like a good idea in general.  It might be better to apply something
> similar to submit_bh instead...comments?

Making the change to submit_bh() would make it look more like the old
ll_rw_block() in this regard, but at the same time I really don't like the
old ll_rw_block() interface that knew about semantics..

Your patch looks fine, although I'd personally prefer this one even more:

	fs/buffer.c patch cut-and-paste:
	+++ fs/buffer.c Sat Dec 16 11:02:44 2000
	@@ -1700,6 +1693,9 @@
	                                set_bit(BH_Uptodate, &bh->b_state);
	                                continue;
	                        }
	+                       /* get_block() might have updated the buffer synchronously */
	+                       if (buffer_uptodate(bh))
	+                               continue;
	                }
	 
	                arr[nr] = bh;

which makes it explicit about how we could have suddenly gotten an
up-to-date buffer. Does that work for you?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
