Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030389AbWHACaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030389AbWHACaA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 22:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030363AbWHACaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 22:30:00 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:65293 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030392AbWHAC37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 22:29:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=Jjooi+t3xqjEPBZmHYz4mK79yB/+K3fsDoncZyImivxG/cqbwDBBtrzQaSRcNA8aVAEgolKpC6oErVxe1nbFAD7jngH0EF7YHEZKYR9PZ8Dtz17s0GZUfPP5TvMJJ6TvPnTgiwxdV1j4xL2UiP2BKAIxHq5SoyCTPEcP//n8ncc=
Date: Tue, 1 Aug 2006 06:29:51 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] task_struct: remove writeonly counters
Message-ID: <20060801022951.GB7006@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/read_write.c       |   23 ++---------------------
 include/linux/sched.h |    2 --
 kernel/fork.c         |    4 ----
 3 files changed, 2 insertions(+), 27 deletions(-)

--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -264,11 +264,8 @@ ssize_t vfs_read(struct file *file, char
 				ret = file->f_op->read(file, buf, count, pos);
 			else
 				ret = do_sync_read(file, buf, count, pos);
-			if (ret > 0) {
+			if (ret > 0)
 				fsnotify_access(file->f_dentry);
-				current->rchar += ret;
-			}
-			current->syscr++;
 		}
 	}
 
@@ -316,11 +313,8 @@ ssize_t vfs_write(struct file *file, con
 				ret = file->f_op->write(file, buf, count, pos);
 			else
 				ret = do_sync_write(file, buf, count, pos);
-			if (ret > 0) {
+			if (ret > 0)
 				fsnotify_modify(file->f_dentry);
-				current->wchar += ret;
-			}
-			current->syscw++;
 		}
 	}
 
@@ -609,9 +603,6 @@ sys_readv(unsigned long fd, const struct
 		fput_light(file, fput_needed);
 	}
 
-	if (ret > 0)
-		current->rchar += ret;
-	current->syscr++;
 	return ret;
 }
 
@@ -630,9 +621,6 @@ sys_writev(unsigned long fd, const struc
 		fput_light(file, fput_needed);
 	}
 
-	if (ret > 0)
-		current->wchar += ret;
-	current->syscw++;
 	return ret;
 }
 
@@ -713,13 +701,6 @@ static ssize_t do_sendfile(int out_fd, i
 
 	retval = in_file->f_op->sendfile(in_file, ppos, count, file_send_actor, out_file);
 
-	if (retval > 0) {
-		current->rchar += retval;
-		current->wchar += retval;
-	}
-	current->syscr++;
-	current->syscw++;
-
 	if (*ppos > max)
 		retval = -EOVERFLOW;
 
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -962,8 +962,6 @@ #endif
  * to a stack based synchronous wait) if its doing sync IO.
  */
 	wait_queue_t *io_wait;
-/* i/o counters(bytes read/written, #syscalls */
-	u64 rchar, wchar, syscr, syscw;
 #if defined(CONFIG_BSD_PROCESS_ACCT)
 	u64 acct_rss_mem1;	/* accumulated rss usage */
 	u64 acct_vm_mem1;	/* accumulated virtual memory usage */
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1024,10 +1024,6 @@ #endif
 	p->utime = cputime_zero;
 	p->stime = cputime_zero;
  	p->sched_time = 0;
-	p->rchar = 0;		/* I/O counter: bytes read */
-	p->wchar = 0;		/* I/O counter: bytes written */
-	p->syscr = 0;		/* I/O counter: read syscalls */
-	p->syscw = 0;		/* I/O counter: write syscalls */
 	acct_clear_integrals(p);
 
  	p->it_virt_expires = cputime_zero;

