Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLDVWd>; Mon, 4 Dec 2000 16:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129834AbQLDVWY>; Mon, 4 Dec 2000 16:22:24 -0500
Received: from zeus.kernel.org ([209.10.41.242]:42250 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129226AbQLDVWI>;
	Mon, 4 Dec 2000 16:22:08 -0500
Date: Mon, 4 Dec 2000 20:50:04 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Stephen Tweedie <sct@redhat.com>, Andi Kleen <ak@muc.de>,
        Andrea Arcangeli <andrea@suse.de>, wtenhave@sybase.com,
        hdeller@redhat.com, Eric Lowe <elowe@myrile.madriver.k12.oh.us>,
        Larry Woodman <woodman@missioncriticallinux.com>, linux-mm@kvack.org
Subject: New patches for 2.2.18pre24 raw IO (fix for bounce buffer copy)
Message-ID: <20001204205004.H8700@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I have pushed another set of raw IO patches out, this time to fix a
bug with bounce buffer copying when running on highmem boxes.  It is
likely to affect any bounce buffer copies using non-page-aligned
accesses if both highmem and normal pages are involved in the kiobuf.

The specific new patch added in this patchset is attached below.  The
full set has been uploaded as 

	kiobuf-2.2.18pre24-B.tar.gz

at

	ftp.*.kernel.org:/pub/linux/kernel/people/sct/raw-io/
and	ftp.uk.linux.org:/pub/linux/sct/fs/raw-io/

This one really should kill all known bugs, dead.  Please stress it
out and let me know if anybody encounters any further problems.  A
merge of all of the pending raw IO fixes into 2.4 should be happening
soon once the current VM changes for marking pages dirty are working.

Cheers,
 Stephen


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="raw-2.2.18pre24.91.fix-bouncecopy"

--- linux-2.2.18pre24.raw.bigmem/fs/iobuf.c.~1~	Mon Dec  4 20:13:49 2000
+++ linux-2.2.18pre24.raw.bigmem/fs/iobuf.c	Mon Dec  4 20:14:08 2000
@@ -211,10 +211,10 @@
 		unsigned long kin, kout;
 		int pagelen = length;
 		
+		if ((pagelen+offset) > PAGE_SIZE)
+			pagelen = PAGE_SIZE - offset;
+			
 		if (bounce_page) {
-			if ((pagelen+offset) > PAGE_SIZE)
-				pagelen = PAGE_SIZE - offset;
-		
 			if (direction == COPY_TO_BOUNCE) {
 				kin  = kmap(page, KM_READ);
 				kout = kmap(bounce_page, KM_WRITE);

--DocE+STaALJfprDB--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
