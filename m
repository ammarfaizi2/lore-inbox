Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265115AbTF1Imp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 04:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265117AbTF1Imp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 04:42:45 -0400
Received: from holomorphy.com ([66.224.33.161]:17557 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265115AbTF1Imo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 04:42:44 -0400
Date: Sat, 28 Jun 2003 01:56:52 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.73-mm2
Message-ID: <20030628085652.GW26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030627202130.066c183b.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030627202130.066c183b.akpm@digeo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 27, 2003 at 08:21:30PM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.73/2.5.73-mm2/
> Just bits and pieces.

This could almost be sent through rusty, but I think in general BKL
removal patches should go through whatever ringer -mm et al provide.


-- wli

Remove spurious BKL acquisitions in /proc/. The BKL is not required to
access nr_threads for reporting, and get_locks_status() takes it
internally, wrapping all operations with it.


diff -prauN wli-2.5.73-3/fs/proc/proc_misc.c wli-2.5.73-4/fs/proc/proc_misc.c
--- wli-2.5.73-3/fs/proc/proc_misc.c	2003-06-23 10:29:54.000000000 -0700
+++ wli-2.5.73-4/fs/proc/proc_misc.c	2003-06-23 10:32:25.000000000 -0700
@@ -497,11 +497,10 @@ static int ds1286_read_proc(char *page, 
 static int locks_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
-	int len;
-	lock_kernel();
-	len = get_locks_status(page, start, off, count);
-	unlock_kernel();
-	if (len < count) *eof = 1;
+	int len = get_locks_status(page, start, off, count);
+
+	if (len < count)
+		*eof = 1;
 	return len;
 }
 
diff -prauN wli-2.5.73-3/fs/proc/root.c wli-2.5.73-4/fs/proc/root.c
--- wli-2.5.73-3/fs/proc/root.c	2003-06-22 11:33:07.000000000 -0700
+++ wli-2.5.73-4/fs/proc/root.c	2003-06-23 10:32:25.000000000 -0700
@@ -81,11 +81,13 @@ void __init proc_root_init(void)
 
 static struct dentry *proc_root_lookup(struct inode * dir, struct dentry * dentry)
 {
-	if (dir->i_ino == PROC_ROOT_INO) { /* check for safety... */
-		lock_kernel();
+	/*
+	 * nr_threads is actually protected by the tasklist_lock;
+	 * however, it's conventional to do reads, especially for
+	 * reporting, without any locking whatsoever.
+	 */
+	if (dir->i_ino == PROC_ROOT_INO) /* check for safety... */
 		dir->i_nlink = proc_root.nlink + nr_threads;
-		unlock_kernel();
-	}
 
 	if (!proc_lookup(dir, dentry)) {
 		return NULL;
