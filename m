Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbVBTUNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbVBTUNQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 15:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVBTUNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 15:13:16 -0500
Received: from chello212017098056.surfer.at ([212.17.98.56]:13574 "EHLO
	hofr.at") by vger.kernel.org with ESMTP id S261832AbVBTUNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 15:13:10 -0500
From: Der Herr Hofrat <der.herr@hofr.at>
Message-Id: <200502202009.j1KK9um25139@hofr.at>
Subject: proc path_walk glitch ?
To: linux-kernel@vger.kernel.org
Date: Sun, 20 Feb 2005 21:09:56 +0100 (CET)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


HI !

 I noticed a slight proc filesystem strangness in the 2.4.2X and 2.6.X 
 (atleast up to 2.6.8).  Assuming that process 8655 exists and is running 
 long enough (ls -lR / or so)

cd /proc/8655
kill -9 8655
ls
/usr/bin/ls: .: Stale NFS file handle

open(".", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = -1 ESTALE (Stale NFS file handle)  from  fs/namei.c -> link_path_walk :

int fastcall link_path_walk(const char * name, struct nameidata *nd)
{
	struct dentry *dentry;
	struct inode *inode;
	int err;
	unsigned int lookup_flags = nd->flags;

	while (*name=='/')
		name++;
	if (!*name)
		goto return_reval;
	...

return_reval:
		/*
		 * We bypassed the ordinary revalidation routines.
		 * Check the cached dentry for staleness.
		 */
		dentry = nd->dentry;
		if (dentry && dentry->d_op && dentry->d_op->d_revalidate) {
			err = -ESTALE;
			if (!dentry->d_op->d_revalidate(dentry, 0)) {
				d_invalidate(dentry);
				break;
			}
		}


 Why does return_reval return -ESTALE instead of -ENOENT here - might need an
extra check on what filesystem this is working on ?

/usr/bin/ls: .: no such file or directory

 would seem more meaningfull to me when I find it in a logfile.

thx !
hofrat
