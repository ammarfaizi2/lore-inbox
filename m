Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRAJXZL>; Wed, 10 Jan 2001 18:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131536AbRAJXZB>; Wed, 10 Jan 2001 18:25:01 -0500
Received: from linuxjedi.org ([192.234.5.42]:12306 "EHLO linuxjedi.org")
	by vger.kernel.org with ESMTP id <S129406AbRAJXYs>;
	Wed, 10 Jan 2001 18:24:48 -0500
Message-ID: <3A5CF0AA.1AC1E753@linuxjedi.org>
Date: Wed, 10 Jan 2001 18:30:50 -0500
From: "David L. Parsley" <parsley@linuxjedi.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "Adam J. Richter" <adam@yggdrasil.com>, parsley@roanoke.edu,
        linux-kernel@vger.kernel.org
Subject: [PATCH] one-liner fix for bforget() honoring BH_Protected; was: Re: 
 Patch (repost): cramfs memory corruption fix
In-Reply-To: <Pine.LNX.4.10.10101071938540.28661-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------E80008ACDF49B97EBECC34A4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E80008ACDF49B97EBECC34A4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> 
> On Sat, 6 Jan 2001, Adam J. Richter wrote:
> >
> >       This sounds like a bug that I posted a fix for a long time ago.
> > cramfs calls bforget on the superblock area, destroying that block of
> > the ramdisk, even when the ramdisk does not contain a cramfs file system.
> > Normally, bforget is called on block that really can be trashed,
> > such as blocks release by truncate or unlink.
> 
> I'd really prefer just not letting bforget() touch BH_Protected buffers.
> bforget() is also used by other things than unlink/truncate: it's used by
> various partition codes etc, and it's used by the raid logic.

Yup, I backed out Adam's one-liner in favor of the attached one-liner. 
Tested on 2.4.0, but should patch cleanly to just about anything. ;-)

BTW Linus - you were of course right on the cramfs wanting 4096
blocksize... but without this fix, that doesn't matter much. ;-)

regards,
	David

-- 
David L. Parsley
Network Administrator
Roanoke College
--------------E80008ACDF49B97EBECC34A4
Content-Type: text/plain; charset=us-ascii;
 name="bforgetfix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bforgetfix.diff"

--- linux.linus/fs/buffer.c	Wed Jan  3 23:45:26 2001
+++ linux/fs/buffer.c	Wed Jan 10 15:49:36 2001
@@ -1145,13 +1145,15 @@
  * free list if it can.. We can NOT free the buffer if:
  *  - there are other users of it
  *  - it is locked and thus can have active IO
+ *  - it is marked BH_Protected
  */
 void __bforget(struct buffer_head * buf)
 {
 	/* grab the lru lock here to block bdflush. */
 	spin_lock(&lru_list_lock);
 	write_lock(&hash_table_lock);
-	if (!atomic_dec_and_test(&buf->b_count) || buffer_locked(buf))
+	if (!atomic_dec_and_test(&buf->b_count) || buffer_locked(buf) || 
+	    buffer_protected(buf))
 		goto in_use;
 	__hash_unlink(buf);
 	remove_inode_queue(buf);

--------------E80008ACDF49B97EBECC34A4--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
