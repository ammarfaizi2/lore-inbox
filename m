Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWAIQ1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWAIQ1H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 11:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbWAIQ1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 11:27:06 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:25049 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964795AbWAIQ1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 11:27:05 -0500
Subject: Re: Oops with 2.6.15-mm1
From: JANAK DESAI <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: simon schuler <simon.schuler@gmx.net>, linux-kernel@vger.kernel.org
In-Reply-To: <43BFFC40.1050307@us.ibm.com>
References: <20060105062249.4bc94697.akpm@osdl.org>
	 <43BE8495.8050907@gmx.net> <20060106151215.106fd0ca.akpm@osdl.org>
	 <43BFFC40.1050307@us.ibm.com>
Content-Type: text/plain
Message-Id: <1136823702.13054.12.camel@hobbs.atlanta.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 09 Jan 2006 11:22:20 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-07 at 12:37, JANAK DESAI wrote:
> Andrew Morton wrote:
> 
> >simon schuler <simon.schuler@gmx.net> wrote:
> >  
> >
> >>I'm getting an oops sometimes (about 70% probability) when I try to 
> >>start a wine application.
> >>last working kernel version: 2.6.15-rc5-mm1
> >>not working: 2.6.15-mm1, 2.6.15-rc5-mm3
> >>not tested: 2.6.15-rc5-mm2
> >>
> >>.config is attached.
> >>I don't know if this is a known issue...
> >>If you need more information, let me know.
> >>
> >>Unable to handle kernel NULL pointer dereference at virtual address 00000004
> >> printing eip:
> >>c0118755
> >>*pde = 00000000
> >>Oops: 0000 [#1]
> >>last sysfs file: /class/vc/vcsa1/dev
> >>Modules linked in:
> >>CPU:    0
> >>EIP:    0060:[<c0118755>]    Not tainted VLI
> >>EFLAGS: 00210282   (2.6.15-mm1)
> >>EIP is at dup_fd+0x25/0x290
> >>eax: eff40c20   ebx: eff40c28   ecx: eff40c20   edx: eff40c58
> >>esi: ead0e000   edi: 00000000   ebp: eff7aaa0   esp: ead0fe48
> >>ds: 007b   es: 007b   ss: 0068
> >>Process wine (pid: 769, threadinfo=ead0e000 task=eb468ab0)
> >>Stack: <0>00000000 ebbe8854 00000001 ec1abd0c eff40c20 c015b937 ec1abd0c 
> >>00000001
> >>       <0>00000000 eb468ab0 ead0e000 c0423ebe eff7aaa0 c0118a1c eb468ab0 
> >>ead0fe88
> >>       <0>fffffff4 eff40ce0 c0118a73 00000000 eb468ab0 00000060 ead0e000 
> >>c01867e4
> >>Call Trace:
> >> [<c015b937>] vfs_read+0x127/0x190
> >> [<c0118a1c>] copy_files+0x5c/0x80
> >> [<c0118a73>] unshare_files+0x33/0x70
> >> [<c01867e4>] load_elf_binary+0x174/0xe10
> >> [<c014102f>] get_page_from_freelist+0x7f/0xd0
> >> [<c0259d0f>] copy_from_user+0x3f/0xa0
> >> [<c0259d0f>] copy_from_user+0x3f/0xa0
> >> [<c0166063>] copy_strings+0x163/0x230
> >> [<c0167160>] search_binary_handler+0x50/0x180
> >> [<c0167414>] do_execve+0x184/0x220
> >> [<c0101c4c>] sys_execve+0x3c/0x80
> >> [<c010300b>] sysenter_past_esp+0x54/0x75
> >>Code: bc 27 00 00 00 00 55 57 56 53 83 ec 24 8b 44 24 38 8b b8 64 04 00 
> >>00 e8 6a ff ff ff 85 c0 89 44 24 10 0f 84 b6 01 00 00 8b 58 04 <8b> 77 
> >>04 89 34 24 e8 d0 fe ff ff 89 44 24 18 31 c0 8b 54 24 18
> >>
> >>    
> >>
> >
> >OK, thanks.  It looks like a problem in the new unsharing code...
> >
> >
> >  
> >
> Thanks. I am investigating the problem now and will send updated patches
> as soon as I fix the problem. I am also writing up detailed 
> justification, design
> considerations and test plan. I will include it in the patch set as well.
> 
> -Janak
> 

The following patch, applicable to 2.6.15-rc5-mm3 and 2.6.15-mm1,
fixes the above oops introduced by the new unsharing code. Updated
patch set, forward ported to the latest -mm and with detail
documentation, will follow in the next few days. 

Signed-off-by: Janak Desai <janak@us.ibm.com>

---

 fork.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff -Naurp 2.6.15-rc5-mm3/kernel/fork.c 2.6.15-rc5-mm3+fix/kernel/fork.c
--- 2.6.15-rc5-mm3/kernel/fork.c	2006-01-09 15:29:12.000000000 +0000
+++ 2.6.15-rc5-mm3+fix/kernel/fork.c	2006-01-09 15:32:52.000000000 +0000
@@ -621,17 +621,15 @@ out:
 
 /*
  * Allocate a new files structure and copy contents from the
- * files structure of the passed in task structure.
+ * passed in files structure.
  */
-static struct files_struct *dup_fd(struct task_struct *tsk, int *errorp)
+static struct files_struct *dup_fd(struct files_struct *oldf, int *errorp)
 {
-	struct files_struct *oldf, *newf;
+	struct files_struct *newf;
 	struct file **old_fds, **new_fds;
 	int open_files, size, i, expand;
 	struct fdtable *old_fdt, *new_fdt;
 
-	oldf = tsk->files;
-
 	newf = alloc_files();
 	if (!newf)
 		goto out;
@@ -746,7 +744,7 @@ static int copy_files(unsigned long clon
 	 */
 	tsk->files = NULL;
 	error = -ENOMEM;
-	newf = dup_fd(current, &error);
+	newf = dup_fd(oldf, &error);
 	if (!newf)
 		goto out;
 
@@ -1486,7 +1484,7 @@ static int unshare_fd(unsigned long unsh
 
 	if ((unshare_flags & CLONE_FILES) &&
 	    (fd && atomic_read(&fd->count) > 1)) {
-		*new_fdp = dup_fd(current, &error);
+		*new_fdp = dup_fd(fd, &error);
 		if (!*new_fdp)
 			return error;
 	}


