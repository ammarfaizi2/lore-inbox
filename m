Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264882AbUEQCb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264882AbUEQCb7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 22:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264884AbUEQCb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 22:31:59 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:50892 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S264882AbUEQCby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 22:31:54 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 17 May 2004 12:31:48 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16552.9236.688861.452524@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, andrea@suse.de,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: dget BUG from proc_exe_link in 2.6.6-mm2
In-Reply-To: message from Andrew Morton on Sunday May 16
References: <16552.2406.114861.925324@cse.unsw.edu.au>
	<20040516180812.602b2aac.akpm@osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday May 16, akpm@osdl.org wrote:
> exit_mmap() (at least) doesn't hold down_write(mmap_sem), and never has -
> it assumes that there are no more references to the going-away mm's vma
> tree.  It forgot about /proc.  I don't immediately see why this is a new
> bug.
> 
> I dunno if this will work, but I do know that it'll cause deadlocks every
> time when the oops code tries to kill off the oopsing task via do_exit(),
> which is a bit unfortunate.
> 

You don't really need to protect the remove_vm_struct.  You only need
to protect mm->mmap.  It should be sufficient to 'down' and 'up' the
semaphore after "mm->mmap = NULL" and before calling remove_mv_struct.
That will synchronise with proc_exe_link.

NeilBrown


 ----------- Diffstat output ------------
 ./mm/mmap.c |    7 +++++++
 1 files changed, 7 insertions(+)

diff ./mm/mmap.c~current~ ./mm/mmap.c
--- ./mm/mmap.c~current~	2004-05-17 12:28:07.000000000 +1000
+++ ./mm/mmap.c	2004-05-17 12:28:09.000000000 +1000
@@ -1493,6 +1493,13 @@ void exit_mmap(struct mm_struct *mm)
 
 	spin_unlock(&mm->page_table_lock);
 
+	down_write(&mm->mmap_sem);
+	/* anyone who might have grabbed mm->mmap before we NULLed it
+	 * should have done so under mm->mmap_sem (e.g. proc_exe_link)
+	 * and so will have let go if it by now, so it is safe to tear it down
+	 */
+	up_write(&mm->mmap_sem);
+
 	/*
 	 * Walk the list again, actually closing and freeing it
 	 * without holding any MM locks.
