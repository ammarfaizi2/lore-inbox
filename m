Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbVEKW5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVEKW5R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 18:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVEKW5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 18:57:16 -0400
Received: from mail.kroah.org ([69.55.234.183]:41689 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261306AbVEKWzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 18:55:42 -0400
Date: Wed, 11 May 2005 15:55:20 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       stable@kernel.org
Subject: Re: Linux 2.6.11.9
Message-ID: <20050511225520.GB12357@kroah.com>
References: <20050511225448.GA12357@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050511225448.GA12357@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -Nru a/Documentation/SecurityBugs b/Documentation/SecurityBugs
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/SecurityBugs	2005-05-11 15:43:56 -07:00
@@ -0,0 +1,38 @@
+Linux kernel developers take security very seriously.  As such, we'd
+like to know when a security bug is found so that it can be fixed and
+disclosed as quickly as possible.  Please report security bugs to the
+Linux kernel security team.
+
+1) Contact
+
+The Linux kernel security team can be contacted by email at
+<security@kernel.org>.  This is a private list of security officers
+who will help verify the bug report and develop and release a fix.
+It is possible that the security team will bring in extra help from
+area maintainers to understand and fix the security vulnerability.
+
+As it is with any bug, the more information provided the easier it
+will be to diagnose and fix.  Please review the procedure outlined in
+REPORTING-BUGS if you are unclear about what information is helpful.
+Any exploit code is very helpful and will not be released without
+consent from the reporter unless it has already been made public.
+
+2) Disclosure
+
+The goal of the Linux kernel security team is to work with the
+bug submitter to bug resolution as well as disclosure.  We prefer
+to fully disclose the bug as soon as possible.  It is reasonable to
+delay disclosure when the bug or the fix is not yet fully understood,
+the solution is not well-tested or for vendor coordination.  However, we
+expect these delays to be short, measurable in days, not weeks or months.
+A disclosure date is negotiated by the security team working with the
+bug submitter as well as vendors.  However, the kernel security team
+holds the final say when setting a disclosure date.  The timeframe for
+disclosure is from immediate (esp. if it's already publically known)
+to a few weeks.  As a basic default policy, we expect report date to
+disclosure date to be on the order of 7 days.
+
+3) Non-disclosure agreements
+
+The Linux kernel security team is not a formal body and therefore unable
+to enter any non-disclosure agreements.
diff -Nru a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS	2005-05-11 15:43:56 -07:00
+++ b/MAINTAINERS	2005-05-11 15:43:56 -07:00
@@ -1966,6 +1966,11 @@
 W:	http://www.weinigel.se
 S:	Supported
 
+SECURITY CONTACT
+P:	Security Officers
+M:	security@kernel.org
+S:	Supported
+
 SELINUX SECURITY MODULE
 P:	Stephen Smalley
 M:	sds@epoch.ncsc.mil
diff -Nru a/Makefile b/Makefile
--- a/Makefile	2005-05-11 15:43:56 -07:00
+++ b/Makefile	2005-05-11 15:43:56 -07:00
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 11
-EXTRAVERSION = .8
+EXTRAVERSION = .9
 NAME=Woozy Beaver
 
 # *DOCUMENTATION*
diff -Nru a/REPORTING-BUGS b/REPORTING-BUGS
--- a/REPORTING-BUGS	2005-05-11 15:43:56 -07:00
+++ b/REPORTING-BUGS	2005-05-11 15:43:56 -07:00
@@ -16,6 +16,10 @@
 describe how to recreate it. That is worth even more than the oops itself.
 The list of maintainers is in the MAINTAINERS file in this directory.
 
+      If it is a security bug, please copy the Security Contact listed
+in the MAINTAINERS file.  They can help coordinate bugfix and disclosure.
+See Documentation/SecurityBugs for more infomation.
+
       If you are totally stumped as to whom to send the report, send it to
 linux-kernel@vger.kernel.org. (For more information on the linux-kernel
 mailing list see http://www.tux.org/lkml/).
diff -Nru a/fs/binfmt_elf.c b/fs/binfmt_elf.c
--- a/fs/binfmt_elf.c	2005-05-11 15:43:56 -07:00
+++ b/fs/binfmt_elf.c	2005-05-11 15:43:56 -07:00
@@ -257,7 +257,7 @@
 	}
 
 	/* Populate argv and envp */
-	p = current->mm->arg_start;
+	p = current->mm->arg_end = current->mm->arg_start;
 	while (argc-- > 0) {
 		size_t len;
 		__put_user((elf_addr_t)p, argv++);
@@ -1279,7 +1279,7 @@
 static int fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
 		       struct mm_struct *mm)
 {
-	int i, len;
+	unsigned int i, len;
 	
 	/* first copy the parameters from user space */
 	memset(psinfo, 0, sizeof(struct elf_prpsinfo));
diff -Nru a/fs/partitions/msdos.c b/fs/partitions/msdos.c
--- a/fs/partitions/msdos.c	2005-05-11 15:43:56 -07:00
+++ b/fs/partitions/msdos.c	2005-05-11 15:43:56 -07:00
@@ -114,9 +114,6 @@
 		 */
 		for (i=0; i<4; i++, p++) {
 			u32 offs, size, next;
-
-			if (SYS_IND(p) == 0)
-				continue;
 			if (!NR_SECTS(p) || is_extended_partition(p))
 				continue;
 
@@ -433,8 +430,6 @@
 	for (slot = 1 ; slot <= 4 ; slot++, p++) {
 		u32 start = START_SECT(p)*sector_size;
 		u32 size = NR_SECTS(p)*sector_size;
-		if (SYS_IND(p) == 0)
-			continue;
 		if (!size)
 			continue;
 		if (is_extended_partition(p)) {
diff -Nru a/kernel/exit.c b/kernel/exit.c
--- a/kernel/exit.c	2005-05-11 15:43:56 -07:00
+++ b/kernel/exit.c	2005-05-11 15:43:56 -07:00
@@ -516,8 +516,6 @@
 	 */
 	BUG_ON(p == reaper || reaper->exit_state >= EXIT_ZOMBIE);
 	p->real_parent = reaper;
-	if (p->parent == p->real_parent)
-		BUG();
 }
 
 static inline void reparent_thread(task_t *p, task_t *father, int traced)
