Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135321AbRDRUxJ>; Wed, 18 Apr 2001 16:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135323AbRDRUw7>; Wed, 18 Apr 2001 16:52:59 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:10256
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S135321AbRDRUwt>; Wed, 18 Apr 2001 16:52:49 -0400
Date: Wed, 18 Apr 2001 16:52:44 -0400
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org
cc: torvalds@transmeta.com, alan@redhat.com, zam@namesys.botik.ru
Subject: [PATCH] reiserfs transaction overflow
Message-ID: <315290000.987627164@tiny>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi guys,

Under certain loads, the reiserfs journal can overflow the
max transaction size, leading to a crash (but not corruption).

When the transaction is too full for another writer to join,
the writer triggers a commit, and waits for the next transaction.
But, it doesn't properly check to make sure the next transcation
has enough room, which can lead to overflow.  It is hard to
hit because there is a large margin of error in the way log space
is reserved (this bug was probably in v.00001 of the journal
code).

A similar patch will be needed for 3.5.x reiserfs, that will
follow soon.

Anyway, this patch should fix 2.4.x, please apply:

-chris

--- linux/fs/reiserfs/journal.c.1	Tue Apr 17 09:36:36 2001
+++ linux/fs/reiserfs/journal.c	Tue Apr 17 09:37:50 2001
@@ -2052,7 +2052,7 @@
 	sleep_on(&(SB_JOURNAL(p_s_sb)->j_join_wait)) ;
       }
     }
-    lock_journal(p_s_sb) ; /* relock to continue */
+    goto relock ;
   }
 
   if (SB_JOURNAL(p_s_sb)->j_trans_start_time == 0) { /* we are the first writer, set trans_id */


