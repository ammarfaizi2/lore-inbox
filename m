Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263855AbTKSCqT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 21:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263857AbTKSCqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 21:46:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:663 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263855AbTKSCqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 21:46:17 -0500
Date: Tue, 18 Nov 2003 18:51:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why lock_kernel() in drivers/pci/proc.c (2.6.0-test9)??
Message-Id: <20031118185139.4edb2e8f.akpm@osdl.org>
In-Reply-To: <16314.54665.18373.588780@wombat.disy.cse.unsw.edu.au>
References: <16314.54665.18373.588780@wombat.disy.cse.unsw.edu.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb <peterc@gelato.unsw.edu.au> wrote:
>
> 
> Hi,
> 	What is the BKL protecting in
> drivers/pci/proc.c:proc_bus_pci_lseek() ?

nothing much.

> It looks useless to me, as file->f_pos is changed outside the lock
> anyway, and all the other variables inside the locked region are
> effectively constants for the purpose of this code.
> 
> So unless something subtle's going on, I suggest this:
> 

We normally use i_sem to prevent parallel lseeks against the same fd from
scribbling on f_pos.  Which seems fairly pointless since parallel reads
aren't using i_sem.

But this would be a more conventional debklification.  Does it work OK?


 drivers/pci/proc.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff -puN drivers/pci/proc.c~proc_bus_pci_lseek-remove-lock_kernel drivers/pci/proc.c
--- 25/drivers/pci/proc.c~proc_bus_pci_lseek-remove-lock_kernel	2003-11-18 18:47:20.000000000 -0800
+++ 25-akpm/drivers/pci/proc.c	2003-11-18 18:48:16.000000000 -0800
@@ -25,7 +25,7 @@ proc_bus_pci_lseek(struct file *file, lo
 {
 	loff_t new = -1;
 
-	lock_kernel();
+	down(&file->f_dentry->d_inode->i_sem);
 	switch (whence) {
 	case 0:
 		new = off;
@@ -37,10 +37,12 @@ proc_bus_pci_lseek(struct file *file, lo
 		new = PCI_CFG_SPACE_SIZE + off;
 		break;
 	}
-	unlock_kernel();
 	if (new < 0 || new > PCI_CFG_SPACE_SIZE)
-		return -EINVAL;
-	return (file->f_pos = new);
+		new = -EINVAL;
+	else
+		file->f_pos = new;
+	up(&file->f_dentry->d_inode->i_sem);
+	return new;
 }
 
 static ssize_t

_

