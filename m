Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274082AbRI0XTd>; Thu, 27 Sep 2001 19:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274084AbRI0XTX>; Thu, 27 Sep 2001 19:19:23 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S274082AbRI0XTR>; Thu, 27 Sep 2001 19:19:17 -0400
Date: Thu, 27 Sep 2001 16:18:58 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Robert Macaulay <robert_macaulay@dell.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Craig Kulesa <ckulesa@as.arizona.edu>, <linux-kernel@vger.kernel.org>,
        Bob Matthews <bmatthews@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: highmem deadlock fix [was Re: VM in 2.4.10(+tweaks) vs.
 2.4.9-ac14/15(+stuff)]
In-Reply-To: <Pine.LNX.4.33.0109271605550.25667-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0109271618120.25667-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Sep 2001, Linus Torvalds wrote:
>
> Thinking about it, I think GFP_NOIO also implies "we must not wait for
> other buffers", because that could deadlock for _other_ things too, like
> loop and NBD (which use NOIO to make sure that they don't recurse - but
> that should also imply not waiting for themselves). The GFP_xxx approach
> should fix those deadlocks too.

Ie the patch would be something like the attached..

		Linus

------
diff -u --recursive --new-file v2.4.10/linux/fs/buffer.c linux/fs/buffer.c
--- v2.4.10/linux/fs/buffer.c	Wed Sep 26 11:53:42 2001
+++ linux/fs/buffer.c	Thu Sep 27 16:13:47 2001
@@ -2522,7 +2373,7 @@
 					ll_rw_block(WRITE, 1, &p);
 					tryagain = 0;
 				} else if (buffer_locked(p)) {
-					if (gfp_mask & __GFP_WAIT) {
+					if (gfp_mask & __GFP_WAITBUF) {
 						wait_on_buffer(p);
 						tryagain = 1;
 					} else
diff -u --recursive --new-file v2.4.10/linux/include/linux/mm.h linux/include/linux/mm.h
--- v2.4.10/linux/include/linux/mm.h	Sun Sep 23 11:41:01 2001
+++ linux/include/linux/mm.h	Thu Sep 27 16:13:35 2001
@@ -550,16 +550,17 @@
 #define __GFP_IO	0x40	/* Can start low memory physical IO? */
 #define __GFP_HIGHIO	0x80	/* Can start high mem physical IO? */
 #define __GFP_FS	0x100	/* Can call down to low-level FS? */
+#define __GFP_WAITBUF	0x200	/* Can we wait for buffers to complete? */

 #define GFP_NOHIGHIO	(__GFP_HIGH | __GFP_WAIT | __GFP_IO)
 #define GFP_NOIO	(__GFP_HIGH | __GFP_WAIT)
-#define GFP_NOFS	(__GFP_HIGH | __GFP_WAIT | __GFP_IO | __GFP_HIGHIO)
+#define GFP_NOFS	(__GFP_HIGH | __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_WAITBUF)
 #define GFP_ATOMIC	(__GFP_HIGH)
-#define GFP_USER	(             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS)
-#define GFP_HIGHUSER	(             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS | __GFP_HIGHMEM)
-#define GFP_KERNEL	(__GFP_HIGH | __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS)
-#define GFP_NFS		(__GFP_HIGH | __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS)
-#define GFP_KSWAPD	(             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS)
+#define GFP_USER	(             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_WAITBUF | __GFP_FS)
+#define GFP_HIGHUSER	(             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_WAITBUF | __GFP_FS | __GFP_HIGHMEM)
+#define GFP_KERNEL	(__GFP_HIGH | __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_WAITBUF | __GFP_FS)
+#define GFP_NFS		(__GFP_HIGH | __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_WAITBUF | __GFP_FS)
+#define GFP_KSWAPD	(             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_WAITBUF | __GFP_FS)

 /* Flag - indicates that the buffer will be suitable for DMA.  Ignored on some
    platforms, used as appropriate on others */

