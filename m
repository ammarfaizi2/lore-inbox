Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291637AbSBTIAg>; Wed, 20 Feb 2002 03:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290285AbSBTIA1>; Wed, 20 Feb 2002 03:00:27 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:49344 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S291637AbSBTIAQ>; Wed, 20 Feb 2002 03:00:16 -0500
From: Christoph Rohland <cr@sap.com>
To: Uli Martens <u.martens@scientific.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] tmpfs: incr. link-count on directory rename
In-Reply-To: <1013648840.2317.5.camel@isax>
	<20020214061933.GA17774@mentor.odyssey.cs.cmu.edu>
	<1013679241.20006.21.camel@pc-um>
Organisation: SAP LinuxLab
Date: Tue, 19 Feb 2002 17:39:14 +0100
In-Reply-To: <1013679241.20006.21.camel@pc-um> (Uli Martens's message of "14
 Feb 2002 10:34:01 +0100")
Message-ID: <m3y9hpctot.fsf@linux.wdf.sap-ag.de>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uli,

On 14 Feb 2002, Uli Martens wrote:
> Oops, you're right, the linkcount of old_dir isn't decremented at
> the moment, too. I will test your patch this evening, but I think it
> looks better than mine... ;)

I prefer this one.

Linus, Marcelo, please apply.

The patch fixes the refcounting of directories on renames in tmpfs.

Greetings
		Christoph

diff -uNr 18-rc1/mm/shmem.c c/mm/shmem.c
--- 18-rc1/mm/shmem.c	Thu Jan 17 10:06:05 2002
+++ c/mm/shmem.c	Tue Feb 19 17:31:23 2002
@@ -1083,19 +1083,25 @@
  */
 static int shmem_rename(struct inode * old_dir, struct dentry *old_dentry, struct inode * new_dir,struct dentry *new_dentry)
 {
-	int error = -ENOTEMPTY;
+	struct inode *inode;
 
-	if (shmem_empty(new_dentry)) {
-		struct inode *inode = new_dentry->d_inode;
-		if (inode) {
-			inode->i_ctime = CURRENT_TIME;
-			inode->i_nlink--;
-			dput(new_dentry);
-		}
-		error = 0;
-		old_dentry->d_inode->i_ctime = old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME;
+	if (!shmem_empty(new_dentry)) 
+		return -ENOTEMPTY;
+
+	inode = new_dentry->d_inode;
+	if (inode) {
+		inode->i_ctime = CURRENT_TIME;
+		inode->i_nlink--;
+		dput(new_dentry);
+	}
+	inode = old_dentry->d_inode;
+	if (S_ISDIR(inode->i_mode)) {
+		old_dir->i_nlink--;
+		new_dir->i_nlink++;
 	}
-	return error;
+
+	inode->i_ctime = old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME;
+	return 0;
 }
 
 static int shmem_symlink(struct inode * dir, struct dentry *dentry, const char * symname)

