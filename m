Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932538AbWFWJP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbWFWJP4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 05:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932949AbWFWJP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 05:15:56 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:22161 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932538AbWFWJPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 05:15:55 -0400
Date: Fri, 23 Jun 2006 11:10:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 16/61] lock validator: fown locking workaround
Message-ID: <20060623091052.GD919@elte.hu>
References: <20060529212109.GA2058@elte.hu> <20060529212423.GP3155@elte.hu> <20060529183404.48878079.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529183404.48878079.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> On Mon, 29 May 2006 23:24:23 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > temporary workaround for the lock validator: make all uses of 
> > f_owner.lock irq-safe. (The real solution will be to express to the 
> > lock validator that f_owner.lock rules are to be generated 
> > per-filesystem.)
> 
> This description forgot to tell us what problem is being worked 
> around.

f_owner locking rules are per-filesystem: some of them have this lock 
irq-safe [because they use it in irq-context generated SIGIOs], some of 
them have it irq-unsafe [because they dont generate SIGIOs in irq 
context]. The lock validator meshes them together and produces a false 
positive. The workaround changed all uses of f_owner.lock to be 
irq-safe.

> This patch is a bit of a show-stopper.  How hard-n-bad is the real 
> fix?

the real fix would be to correctly map the 'key' of the f_owner.lock to 
the filesystem. I.e. to embedd a "lockdep_type_key s_fown_key" in 
'struct file_system_type', and to use that key when initializing 
f_own.lock.

the practical problem is that the initialization site of f_owner.lock 
does not know about which filesystem this file will belong to.

there might be another way though: the only non-core user of f_own.lock 
is CIFS, and that use of f_own.lock seems unnecessary - it does not 
change any fowner state, and its justification for taking that lock 
seems rather vague as well:

 *  GlobalSMBSesLock protects:
 *      list operations on tcp and SMB session lists and tCon lists
 *  f_owner.lock protects certain per file struct operations

maybe CIFS or VFS people could comment?

that way you could remove the following patch from -mm:

   lock-validator-fown-locking-workaround.patch

and add the patch below. (the fcntl.c portion of the above patch is 
meanwhile moot)

	Ingo

--------------------------------------
Subject: CIFS: remove f_owner.lock use
From: Ingo Molnar <mingo@elte.hu>

CIFS takes/releases f_owner.lock - why? It does not change anything
in the fowner state. Remove this locking.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 fs/cifs/file.c |    9 ---------
 1 file changed, 9 deletions(-)

Index: linux/fs/cifs/file.c
===================================================================
--- linux.orig/fs/cifs/file.c
+++ linux/fs/cifs/file.c
@@ -110,7 +110,6 @@ static inline int cifs_open_inode_helper
 			 &pCifsInode->openFileList);
 	}
 	write_unlock(&GlobalSMBSeslock);
-	write_unlock(&file->f_owner.lock);
 	if (pCifsInode->clientCanCacheRead) {
 		/* we have the inode open somewhere else
 		   no need to discard cache data */
@@ -287,7 +286,6 @@ int cifs_open(struct inode *inode, struc
 		goto out;
 	}
 	pCifsFile = cifs_init_private(file->private_data, inode, file, netfid);
-	write_lock(&file->f_owner.lock);
 	write_lock(&GlobalSMBSeslock);
 	list_add(&pCifsFile->tlist, &pTcon->openFileList);
 
@@ -298,7 +296,6 @@ int cifs_open(struct inode *inode, struc
 					    &oplock, buf, full_path, xid);
 	} else {
 		write_unlock(&GlobalSMBSeslock);
-		write_unlock(&file->f_owner.lock);
 	}
 
 	if (oplock & CIFS_CREATE_ACTION) {           
@@ -477,7 +474,6 @@ int cifs_close(struct inode *inode, stru
 	pTcon = cifs_sb->tcon;
 	if (pSMBFile) {
 		pSMBFile->closePend = TRUE;
-		write_lock(&file->f_owner.lock);
 		if (pTcon) {
 			/* no sense reconnecting to close a file that is
 			   already closed */
@@ -492,23 +488,18 @@ int cifs_close(struct inode *inode, stru
 					the struct would be in each open file,
 					but this should give enough time to 
 					clear the socket */
-					write_unlock(&file->f_owner.lock);
 					cERROR(1,("close with pending writes"));
 					msleep(timeout);
-					write_lock(&file->f_owner.lock);
 					timeout *= 4;
 				} 
-				write_unlock(&file->f_owner.lock);
 				rc = CIFSSMBClose(xid, pTcon,
 						  pSMBFile->netfid);
-				write_lock(&file->f_owner.lock);
 			}
 		}
 		write_lock(&GlobalSMBSeslock);
 		list_del(&pSMBFile->flist);
 		list_del(&pSMBFile->tlist);
 		write_unlock(&GlobalSMBSeslock);
-		write_unlock(&file->f_owner.lock);
 		kfree(pSMBFile->search_resume_name);
 		kfree(file->private_data);
 		file->private_data = NULL;
