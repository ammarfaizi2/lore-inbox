Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263215AbTIATR6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 15:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263244AbTIATR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 15:17:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:33674 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263215AbTIATR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 15:17:56 -0400
Date: Mon, 1 Sep 2003 12:18:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: [BUG] mtime&ctime updated when it should not
Message-Id: <20030901121807.29119055.akpm@osdl.org>
In-Reply-To: <20030901181113.GA15672@atrey.karlin.mff.cuni.cz>
References: <20030901181113.GA15672@atrey.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara <jack@suse.cz> wrote:
>
>   Hello,
> 
>   one user pointed my attention to the fact that when the write fails
> (for example when the user quota is exceeded) the modification time is
> still updated (the problem appears both in 2.4 and 2.6). According to
> SUSv3 that should not happen because the specification says that mtime
> and ctime should be marked for update upon a successful completition
> of a write (not that it would forbid updating the times in other cases
> but I find it at least a bit nonintuitive).

hrm.  Doesn't sound super-important.  But..

>   The easiest fix would be probably to "backup" the times at the
> beginning of the write and restore the original values when the write
> fails (simply not updating the times would require more surgery because
> for example vmtruncate() is called when the write fails and it also
> updates the times).
>   So should I write the patch or is the current behaviour considered
> correct?

Isn't this sufficient?


diff -puN mm/filemap.c~a mm/filemap.c
--- 25/mm/filemap.c~a	2003-09-01 12:16:13.000000000 -0700
+++ 25-akpm/mm/filemap.c	2003-09-01 12:17:04.000000000 -0700
@@ -1696,7 +1696,6 @@ generic_file_aio_write_nolock(struct kio
 		goto out;
 
 	remove_suid(file->f_dentry);
-	inode_update_time(inode, 1);
 
 	/* coalesce the iovecs and go direct-to-BIO for O_DIRECT */
 	if (unlikely(file->f_flags & O_DIRECT)) {
@@ -1811,7 +1810,12 @@ generic_file_aio_write_nolock(struct kio
 	}
 	
 out_status:	
-	err = written ? written : status;
+	if (written) {
+		err = written;
+		inode_update_time(inode, 1);
+	} else {
+		err = status;
+	}
 out:
 	pagevec_lru_add(&lru_pvec);
 	current->backing_dev_info = 0;

_

