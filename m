Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286209AbRLaDaT>; Sun, 30 Dec 2001 22:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286206AbRLaDaK>; Sun, 30 Dec 2001 22:30:10 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:30610 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S286209AbRLaD37>; Sun, 30 Dec 2001 22:29:59 -0500
Date: Mon, 31 Dec 2001 03:32:20 +0000
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Manfred Spraul <manfred@colorfullife.com>
Subject: [patch] Prefetching file_read_actor()
Message-ID: <20011231033220.A1686@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Manfred Spraul <manfred@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After noticing file_read_actor() showing up in profiles quite
a bit, I grepped old l-k messages, and turned up a post by
Manfred Spraul in which he posted a patch using inline asm
to prefetch read data.  This was x86 specific in generic code,
so was a little hackish..
Now that we have the prefetch macros, I decided to play with
this a little tonight, and came up with this patch..


diff -urN --exclude-from=/home/davej/.exclude linux-2.5.2-pre5/mm/filemap.c linux-2.5/mm/filemap.c
--- linux-2.5.2-pre5/mm/filemap.c	Sun Dec 16 23:21:24 2001
+++ linux-2.5/mm/filemap.c	Mon Dec 31 03:22:51 2001
@@ -1570,6 +1570,15 @@
 		size = count;
 
 	kaddr = kmap(page);
+
+	if (size > 128) {
+		int i;
+		for(i=0; i<size; i+=64) {
+			prefetch (kaddr+offset);
+			prefetch (kaddr+offset+(L1_CACHE_BYTES*2));
+		}
+	}
+
 	left = __copy_to_user(desc->buf, kaddr + offset, size);
 	kunmap(page);
 	
The results are an earth shaking 5 seconds off a make dep bzImage
on my P3, I've not benched an Athlon (or other prefetch aware
architecture) yet, but I expect to see similar speed ups..

Comments ?

Dave.

-- 
Dave Jones.                    http://www.codemonkey.org.uk
SuSE Labs.
