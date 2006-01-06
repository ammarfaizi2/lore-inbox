Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbWAFAnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWAFAnh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWAFAnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:43:37 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:11651 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932340AbWAFAnf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:43:35 -0500
Date: Thu, 5 Jan 2006 16:45:33 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       git-commits-head@vger.kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 3/6] Insanity avoidance in /proc (CVE-2005-4605)
Message-ID: <20060106004533.GC25207@sorel.sous-sol.org>
References: <20060105235845.967478000@sorel.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="insanity-avoidance-in-proc.patch"
In-Reply-To: <20060105235947.100933000@sorel.sous-sol.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Insanity avoidance in /proc

The old /proc interfaces were never updated to use loff_t, and are just
generally broken.  Now, we should be using the seq_file interface for
all of the proc files, but converting the legacy functions is more work
than most people care for and has little upside..

But at least we can make the non-LFS rules explicit, rather than just
insanely wrapping the offset or something.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 fs/proc/generic.c |   47 +++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

--- linux-2.6.14.5.orig/fs/proc/generic.c
+++ linux-2.6.14.5/fs/proc/generic.c
@@ -54,6 +54,18 @@ proc_file_read(struct file *file, char _
 	ssize_t	n, count;
 	char	*start;
 	struct proc_dir_entry * dp;
+	unsigned long long pos;
+
+	/*
+	 * Gaah, please just use "seq_file" instead. The legacy /proc
+	 * interfaces cut loff_t down to off_t for reads, and ignore
+	 * the offset entirely for writes..
+	 */
+	pos = *ppos;
+	if (pos > MAX_NON_LFS)
+		return 0;
+	if (nbytes > MAX_NON_LFS - pos)
+		nbytes = MAX_NON_LFS - pos;
 
 	dp = PDE(inode);
 	if (!(page = (char*) __get_free_page(GFP_KERNEL)))
@@ -202,30 +214,17 @@ proc_file_write(struct file *file, const
 static loff_t
 proc_file_lseek(struct file *file, loff_t offset, int orig)
 {
-    lock_kernel();
-
-    switch (orig) {
-    case 0:
-	if (offset < 0)
-	    goto out;
-	file->f_pos = offset;
-	unlock_kernel();
-	return(file->f_pos);
-    case 1:
-	if (offset + file->f_pos < 0)
-	    goto out;
-	file->f_pos += offset;
-	unlock_kernel();
-	return(file->f_pos);
-    case 2:
-	goto out;
-    default:
-	goto out;
-    }
-
-out:
-    unlock_kernel();
-    return -EINVAL;
+	loff_t retval = -EINVAL;
+	switch (orig) {
+	case 1:
+		offset += file->f_pos;
+	/* fallthrough */
+	case 0:
+		if (offset < 0 || offset > MAX_NON_LFS)
+			break;
+		file->f_pos = retval = offset;
+	}
+	return retval;
 }
 
 static int proc_notify_change(struct dentry *dentry, struct iattr *iattr)

--
