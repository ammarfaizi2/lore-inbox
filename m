Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267804AbUJCLNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267804AbUJCLNt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 07:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267808AbUJCLNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 07:13:49 -0400
Received: from scanner2.mail.elte.hu ([157.181.151.9]:35497 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267804AbUJCLNo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 07:13:44 -0400
Date: Sun, 3 Oct 2004 13:14:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jean Delvare <khali@linux-fr.org>
Cc: Andrew Morton <akpm@osdl.org>, Bill Davidsen <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org
Subject: Re: mmap() on cdrom files fails since 2.6.9-rc2-bk2
Message-ID: <20041003111458.GA15390@elte.hu>
References: <2Jw9b-52b-13@gated-at.bofh.it> <20040929222619.5da3f207.khali@linux-fr.org> <20041001184431.4e0c6ba5.akpm@osdl.org> <20041002090125.302fff71.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041002090125.302fff71.khali@linux-fr.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jean Delvare <khali@linux-fr.org> wrote:

> > Capture the strace output.
> 
> Here it is (using 2.6.9-rc2-mm4):

> old_mmap(NULL, 42, PROT_READ, MAP_SHARED, 3, 0) = -1 EPERM (Operation not permitted)

could you try the patch below? mmap() done from !pt_gnu_stack binaries
on noexec mounted filesystems indeed could fail due to the extra
PROT_EXEC bit.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/mm/mmap.c.orig
+++ linux/mm/mmap.c
@@ -773,13 +773,6 @@ unsigned long do_mmap_pgoff(struct file 
 	int accountable = 1;
 	unsigned long charged = 0;
 
-	/*
-	 * Does the application expect PROT_READ to imply PROT_EXEC:
-	 */
-	if (unlikely((prot & PROT_READ) &&
-			(current->personality & READ_IMPLIES_EXEC)))
-		prot |= PROT_EXEC;
-
 	if (file) {
 		if (is_file_hugepages(file))
 			accountable = 0;
@@ -791,6 +784,15 @@ unsigned long do_mmap_pgoff(struct file 
 		    (file->f_vfsmnt->mnt_flags & MNT_NOEXEC))
 			return -EPERM;
 	}
+	/*
+	 * Does the application expect PROT_READ to imply PROT_EXEC?
+	 *
+	 * (the exception is when the underlying filesystem is noexec
+	 *  mounted, in which case we dont add PROT_EXEC.)
+	 */
+	if ((prot & PROT_READ) && (current->personality & READ_IMPLIES_EXEC))
+		if (!(file && (file->f_vfsmnt->mnt_flags & MNT_NOEXEC)))
+			prot |= PROT_EXEC;
 
 	if (!len)
 		return addr;
