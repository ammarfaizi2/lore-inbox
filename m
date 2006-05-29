Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbWE2VYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWE2VYK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWE2VYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:24:09 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:17592 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751327AbWE2VYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:24:03 -0400
Date: Mon, 29 May 2006 23:24:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 16/61] lock validator: fown locking workaround
Message-ID: <20060529212423.GP3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

temporary workaround for the lock validator: make all uses of
f_owner.lock irq-safe. (The real solution will be to express to
the lock validator that f_owner.lock rules are to be generated
per-filesystem.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 fs/cifs/file.c |   18 +++++++++---------
 fs/fcntl.c     |   11 +++++++----
 2 files changed, 16 insertions(+), 13 deletions(-)

Index: linux/fs/cifs/file.c
===================================================================
--- linux.orig/fs/cifs/file.c
+++ linux/fs/cifs/file.c
@@ -108,7 +108,7 @@ static inline int cifs_open_inode_helper
 			 &pCifsInode->openFileList);
 	}
 	write_unlock(&GlobalSMBSeslock);
-	write_unlock(&file->f_owner.lock);
+	write_unlock_irq(&file->f_owner.lock);
 	if (pCifsInode->clientCanCacheRead) {
 		/* we have the inode open somewhere else
 		   no need to discard cache data */
@@ -280,7 +280,7 @@ int cifs_open(struct inode *inode, struc
 		goto out;
 	}
 	pCifsFile = cifs_init_private(file->private_data, inode, file, netfid);
-	write_lock(&file->f_owner.lock);
+	write_lock_irq(&file->f_owner.lock);
 	write_lock(&GlobalSMBSeslock);
 	list_add(&pCifsFile->tlist, &pTcon->openFileList);
 
@@ -291,7 +291,7 @@ int cifs_open(struct inode *inode, struc
 					    &oplock, buf, full_path, xid);
 	} else {
 		write_unlock(&GlobalSMBSeslock);
-		write_unlock(&file->f_owner.lock);
+		write_unlock_irq(&file->f_owner.lock);
 	}
 
 	if (oplock & CIFS_CREATE_ACTION) {           
@@ -470,7 +470,7 @@ int cifs_close(struct inode *inode, stru
 	pTcon = cifs_sb->tcon;
 	if (pSMBFile) {
 		pSMBFile->closePend = TRUE;
-		write_lock(&file->f_owner.lock);
+		write_lock_irq(&file->f_owner.lock);
 		if (pTcon) {
 			/* no sense reconnecting to close a file that is
 			   already closed */
@@ -485,23 +485,23 @@ int cifs_close(struct inode *inode, stru
 					the struct would be in each open file,
 					but this should give enough time to 
 					clear the socket */
-					write_unlock(&file->f_owner.lock);
+					write_unlock_irq(&file->f_owner.lock);
 					cERROR(1,("close with pending writes"));
 					msleep(timeout);
-					write_lock(&file->f_owner.lock);
+					write_lock_irq(&file->f_owner.lock);
 					timeout *= 4;
 				} 
-				write_unlock(&file->f_owner.lock);
+				write_unlock_irq(&file->f_owner.lock);
 				rc = CIFSSMBClose(xid, pTcon,
 						  pSMBFile->netfid);
-				write_lock(&file->f_owner.lock);
+				write_lock_irq(&file->f_owner.lock);
 			}
 		}
 		write_lock(&GlobalSMBSeslock);
 		list_del(&pSMBFile->flist);
 		list_del(&pSMBFile->tlist);
 		write_unlock(&GlobalSMBSeslock);
-		write_unlock(&file->f_owner.lock);
+		write_unlock_irq(&file->f_owner.lock);
 		kfree(pSMBFile->search_resume_name);
 		kfree(file->private_data);
 		file->private_data = NULL;
Index: linux/fs/fcntl.c
===================================================================
--- linux.orig/fs/fcntl.c
+++ linux/fs/fcntl.c
@@ -470,9 +470,10 @@ static void send_sigio_to_task(struct ta
 void send_sigio(struct fown_struct *fown, int fd, int band)
 {
 	struct task_struct *p;
+	unsigned long flags;
 	int pid;
 	
-	read_lock(&fown->lock);
+	read_lock_irqsave(&fown->lock, flags);
 	pid = fown->pid;
 	if (!pid)
 		goto out_unlock_fown;
@@ -490,7 +491,7 @@ void send_sigio(struct fown_struct *fown
 	}
 	read_unlock(&tasklist_lock);
  out_unlock_fown:
-	read_unlock(&fown->lock);
+	read_unlock_irqrestore(&fown->lock, flags);
 }
 
 static void send_sigurg_to_task(struct task_struct *p,
@@ -503,9 +504,10 @@ static void send_sigurg_to_task(struct t
 int send_sigurg(struct fown_struct *fown)
 {
 	struct task_struct *p;
+	unsigned long flags;
 	int pid, ret = 0;
 	
-	read_lock(&fown->lock);
+	read_lock_irqsave(&fown->lock, flags);
 	pid = fown->pid;
 	if (!pid)
 		goto out_unlock_fown;
@@ -525,7 +527,8 @@ int send_sigurg(struct fown_struct *fown
 	}
 	read_unlock(&tasklist_lock);
  out_unlock_fown:
-	read_unlock(&fown->lock);
+	read_unlock_irqrestore(&fown->lock, flags);
+
 	return ret;
 }
 
