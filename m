Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131910AbRCYAos>; Sat, 24 Mar 2001 19:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131912AbRCYAoj>; Sat, 24 Mar 2001 19:44:39 -0500
Received: from zeus.kernel.org ([209.10.41.242]:46273 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131910AbRCYAo2>;
	Sat, 24 Mar 2001 19:44:28 -0500
Date: Sun, 25 Mar 2001 00:40:13 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <aviro@redhat.com>
Cc: linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: [PATCH] 2.4.2-ac24 buffer.c oops on highmem
Message-ID: <20010325004013.E11686@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

We've just seen a buffer.c oops in:

>>EIP; c013ae4b <__block_prepare_write+2bb/300>   <=====
Trace; c013b732 <block_prepare_write+22/70>
Trace; c015dbba <ext2_get_block+a/4e0>
Trace; c012a67e <generic_file_write+3ee/710>
Trace; c015dbba <ext2_get_block+a/4e0>
Trace; c01281c0 <file_read_actor+0/f0>
Trace; c01384a6 <sys_write+96/d0>
Trace; c010910b <system_call+33/38>

__block_prepare_write()'s "out:" error handler tries to do a

			memset(bh->b_data, 0, bh->b_size);

even if the buffer's page has already been kmapped for highmem.
Highmem pages will obviously have b_data being NULL.  Patch below.

I had a quick look through the rest of buffer.c and apart from the
initialisation of bh->b_data in set_bh_page(), there are no other
references left to b_data once we fix this.

Cheers,
 Stephen


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.4.2-ac24.blockwrite.diff"

--- fs/buffer.c.~1~	Sat Mar 24 17:30:13 2001
+++ fs/buffer.c	Sat Mar 24 18:16:55 2001
@@ -1629,12 +1629,14 @@
 	return 0;
 out:
 	bh = head;
+	block_start = 0;
 	do {
 		if (buffer_new(bh) && !buffer_uptodate(bh)) {
-			memset(bh->b_data, 0, bh->b_size);
+			memset(kaddr+block_start, 0, bh->b_size);
 			set_bit(BH_Uptodate, &bh->b_state);
 			mark_buffer_dirty(bh);
 		}
+		block_start += bh->b_size;
 		bh = bh->b_this_page;
 	} while (bh != head);
 	return err;

--EeQfGwPcQSOJBaQU--
