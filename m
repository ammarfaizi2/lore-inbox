Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751676AbWJWHYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbWJWHYe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 03:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751680AbWJWHYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 03:24:34 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29058 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751675AbWJWHYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 03:24:33 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
       <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Jakub Jelinek <jakub@redhat.com>, Mike Galbraith <efault@gmx.de>,
       "Albert Cahalan" <acahalan@gmail.com>,
       Bill Nottingham <notting@redhat.com>,
       Marco Roeland <marco.roeland@xs4all.nl>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [RFD][PATCH 1/2] sysctl: Allow a zero ctl_name in the middle of a sysctl table
Date: Mon, 23 Oct 2006 01:22:07 -0600
Message-ID: <m13b9fxzs0.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since it is becoming clear that there are just enough users of the
binary sysctl interface that completely removing the binary interface
from the kernel will not be an option for foreseeable future, we
need to find a way to address the sysctl maintenance issues.

The basic problem is that sysctl requires one central authority
to allocate sysctl numbers, or else conflicts and ABI breakage
occur.  The proc interface to sysctl does not have that problem,
as names are not densely allocated.

By not terminating a sysctl table until I have neither a ctl_name
nor a procname, it becomes simple to add sysctl entries that don't
show up in the binary sysctl interface.  Which allows people to avoid
allocating a binary sysctl value when not needed. 

I have audited the kernel code and in my reading I have not found a
single sysctl table that wasn't terminated by a completely zero filled
entry.  So this change in behavior should not affect anything.

I think this mechanism eases the pain enough that combined with a little
disciple we can solve the reoccurring sysctl ABI breakage.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 include/linux/sysctl.h |    9 ++++++---
 kernel/sysctl.c        |    8 +++++---
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 1b24bd4..c184732 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -961,8 +961,8 @@ extern ctl_handler sysctl_ms_jiffies;
 /*
  * Register a set of sysctl names by calling register_sysctl_table
  * with an initialised array of ctl_table's.  An entry with zero
- * ctl_name terminates the table.  table->de will be set up by the
- * registration and need not be initialised in advance.
+ * ctl_name and NULL procname terminates the table.  table->de will be
+ * set up by the registration and need not be initialised in advance.
  *
  * sysctl names can be mirrored automatically under /proc/sys.  The
  * procname supplied controls /proc naming.
@@ -973,7 +973,10 @@ extern ctl_handler sysctl_ms_jiffies;
  * Leaf nodes in the sysctl tree will be represented by a single file
  * under /proc; non-leaf nodes will be represented by directories.  A
  * null procname disables /proc mirroring at this node.
- * 
+ *
+ * sysctl entries with a zero ctl_name will not be available through
+ * the binary sysctl interface.
+ *
  * sysctl(2) can automatically manage read and write requests through
  * the sysctl table.  The data and maxlen fields of the ctl_table
  * struct enable minimal validation of the values being written to be
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 8bff2c1..09530ae 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1315,7 +1315,9 @@ repeat:
 		return -ENOTDIR;
 	if (get_user(n, name))
 		return -EFAULT;
-	for ( ; table->ctl_name; table++) {
+	for ( ; table->ctl_name || table->procname; table++) {
+		if (!table->ctl_name)
+			continue;
 		if (n == table->ctl_name || table->ctl_name == CTL_ANY) {
 			int error;
 			if (table->child) {
@@ -1532,7 +1534,7 @@ static void register_proc_table(ctl_tabl
 	int len;
 	mode_t mode;
 	
-	for (; table->ctl_name; table++) {
+	for (; table->ctl_name || table->procname; table++) {
 		/* Can't do anything without a proc name. */
 		if (!table->procname)
 			continue;
@@ -1579,7 +1581,7 @@ static void register_proc_table(ctl_tabl
 static void unregister_proc_table(ctl_table * table, struct proc_dir_entry *root)
 {
 	struct proc_dir_entry *de;
-	for (; table->ctl_name; table++) {
+	for (; table->ctl_name || table->procname; table++) {
 		if (!(de = table->de))
 			continue;
 		if (de->mode & S_IFDIR) {
-- 
1.4.2.rc3.g7e18e-dirty

