Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265053AbUHNUVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265053AbUHNUVT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 16:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265134AbUHNUVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 16:21:19 -0400
Received: from dh138.citi.umich.edu ([141.211.133.138]:61570 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S265053AbUHNUTx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 16:19:53 -0400
Subject: Re: PATCH [2/7] Fix posix locking code
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040814205306.A22261@infradead.org>
References: <1092511792.4109.22.camel@lade.trondhjem.org>
	 <20040814205306.A22261@infradead.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1092514790.4109.52.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 14 Aug 2004 16:19:51 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På lau , 14/08/2004 klokka 15:53, skreiv Christoph Hellwig:
> On Sat, Aug 14, 2004 at 03:29:53PM -0400, Trond Myklebust wrote:
> >  VFS: Enable filesystems and to hook certain functions for copying
> >       locks, and freeing locks using the new struct file_lock_operations.
> > 
> >  VFS: Enable lock managers (i.e. lockd) to hook functions for comparing
> >       lock ownership using the new struct lock_manager_operations.
> 
> Please document these operations and their locking rules in
> Documentation/filesystems/Locking

Right here...

diff -u --recursive --new-file linux-2.6.8.1-07-cleanup_posix/Documentation/filesystems/Locking linux-2.6.8.1-08-Documentation/Documentation/filesystems/Locking
--- linux-2.6.8.1-07-cleanup_posix/Documentation/filesystems/Locking	2004-08-14 14:27:32.000000000 -0400
+++ linux-2.6.8.1-08-Documentation/Documentation/filesystems/Locking	2004-08-14 16:07:11.000000000 -0400
@@ -276,21 +276,34 @@
 internal fs locking and real critical areas are much smaller than the areas
 filesystems protect now.
 
---------------------------- file_lock ------------------------------------
+----------------------- file_lock_operations ------------------------------
 prototypes:
-	void (*fl_notify)(struct file_lock *);	/* unblock callback */
 	void (*fl_insert)(struct file_lock *);	/* lock insertion callback */
 	void (*fl_remove)(struct file_lock *);	/* lock removal callback */
+	void (*fl_copy_lock)(struct file_lock *, struct file_lock *);
+	void (*fl_release_private)(struct file_lock *);
+
 
 locking rules:
-		BKL	may block
-fl_notify:	yes	no
-fl_insert:	yes	no
-fl_remove:	yes	no
+			BKL	may block
+fl_insert:		yes	no
+fl_remove:		yes	no
+fl_copy_lock:		yes	no
+fl_release_private:	yes	yes
+
+----------------------- lock_manager_operations ---------------------------
+prototypes:
+	int (*fl_compare_owner)(struct file_lock *, struct file_lock *);
+	void (*fl_notify)(struct file_lock *);  /* unblock callback */
+
+locking rules:
+			BKL	may block
+fl_compare_owner:	yes	no
+fl_notify:		yes	no
+
 	Currently only NLM provides instances of this class. None of the
 them block. If you have out-of-tree instances - please, show up. Locking
 in that area will change.
-
 --------------------------- buffer_head -----------------------------------
 prototypes:
 	void (*b_end_io)(struct buffer_head *bh, int uptodate);

