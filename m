Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279074AbRJ2IuC>; Mon, 29 Oct 2001 03:50:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279075AbRJ2Itx>; Mon, 29 Oct 2001 03:49:53 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:128 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S279074AbRJ2Ito>; Mon, 29 Oct 2001 03:49:44 -0500
From: Christoph Rohland <cr@sap.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] tmpfs symlink size bug
In-Reply-To: <20011028103826.A17842@gondor.apana.org.au>
Organisation: SAP LinuxLab
Date: 29 Oct 2001 09:49:30 +0100
Message-ID: <m3wv1ej0f9.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On Sun, 28 Oct 2001, Herbert Xu wrote:
> Since 2.4.12 the size of symlinks on tmpfs has been off by one.  The
> following patch corrects that error.

Thanks for spotting. I prefer the following patch.

Alan, Linus, please apply.

Greetings
		Christoph

--- 2.4.13/mm/shmem.c	Sun Oct 28 16:59:03 2001
+++ t2.4.13/mm/shmem.c	Mon Oct 29 09:45:51 2001
@@ -1151,16 +1151,16 @@
 	if (error)
 		return error;
 
-	len = strlen(symname) + 1;
-	if (len > PAGE_CACHE_SIZE)
+	len = strlen(symname);
+	if (len >= PAGE_CACHE_SIZE)
 		return -ENAMETOOLONG;
 		
 	inode = dentry->d_inode;
 	info = SHMEM_I(inode);
 	inode->i_size = len;
-	if (len <= sizeof(struct shmem_inode_info)) {
+	if (len < sizeof(struct shmem_inode_info)) {
 		/* do it inline */
-		memcpy(info, symname, len);
+		memcpy(info, symname, len + 1);
 		inode->i_op = &shmem_symlink_inline_operations;
 	} else {
 		spin_lock (&shmem_ilock);
@@ -1173,7 +1173,7 @@
 			return PTR_ERR(page);
 		}
 		kaddr = kmap(page);
-		memcpy(kaddr, symname, len);
+		memcpy(kaddr, symname, len + 1);
 		kunmap(page);
 		SetPageDirty(page);
 		UnlockPage(page);

