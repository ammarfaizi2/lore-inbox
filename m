Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132862AbRALU1H>; Fri, 12 Jan 2001 15:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132868AbRALU05>; Fri, 12 Jan 2001 15:26:57 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:54289 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S132862AbRALU0s>; Fri, 12 Jan 2001 15:26:48 -0500
Date: Fri, 12 Jan 2001 15:26:32 -0500
From: Chris Mason <mason@suse.com>
To: viro@math.psu.edu, alan@redhat.com
cc: linux-kernel@vger.kernel.org
Subject: generic_file_write change in 2.4.0-ac8
Message-ID: <30380000.979331192@tiny>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi guys,

This code for generic_file_write calls vmtruncate without i_sem held.  Is
that intentional?  It should cause problems for reiserfs at least...

-chris

diff -u --new-file --recursive --exclude-from /usr/src/exclude
linux-2.4.0/mm/filemap.c linux.ac/mm/filemap.c
--- linux-2.4.0/mm/filemap.c	Wed Jan  3 02:59:45 2001
+++ linux.ac/mm/filemap.c	Thu Jan 11 17:26:55 2001
@@ -2578,6 +2625,13 @@
 	ClearPageUptodate(page);
 	kunmap(page);
 	goto unlock;
+sync_failure:
+	UnlockPage(page);
+	deactivate_page(page);
+	page_cache_release(page);
+	if (pos + bytes > inode->i_size)
+		vmtruncate(inode, inode->i_size);
+	goto done;
 }

 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
