Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030370AbWGTUDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030370AbWGTUDh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 16:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030371AbWGTUDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 16:03:36 -0400
Received: from main.gmane.org ([80.91.229.2]:54980 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030370AbWGTUDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 16:03:36 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kari Hurtta <hurtta+gmane@siilo.fmi.fi>
Subject: Re: [RFC/PATCH] revoke/frevoke system calls
Date: 20 Jul 2006 23:02:53 +0300
Message-ID: <5dd5c0nixe.fsf@attruh.keh.iki.fi>
References: <Pine.LNX.4.58.0607201504040.18901@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cs181108174.pp.htv.fi
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Cc: linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg <penberg@cs.Helsinki.FI> writes in
gmane.linux.file-systems,gmane.linux.kernel:

> From: Pekka Enberg <penberg@cs.helsinki.fi>
> 
> This patch implements the revoke(2) and frevoke(2) system calls for all
> types of files. We revoke files in two passes: first we scan all open 
> files that refer to the inode and substitute the struct file pointer in fd 
> table with NULL causing all subsequent operations on that fd to fail. 
> After we have done that to all file descriptors, we close the files and 
> take down mmaps.
> 
> Note that now we need to unconditionally do fput/fget in sys_write and
> sys_read because they race with do_revoke.
> 
> Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

What permissions is needed revoke access of other users open
files ?

> +asmlinkage int sys_revoke(const char __user *filename)
> +{
> +	int err;
> +	struct nameidata nd;
> +
> +	err = __user_walk(filename, 0, &nd);
> +	if (!err) {
> +		err = do_revoke(nd.dentry->d_inode, NULL);
> +		path_release(&nd);
> +	}
> +	return err;
> +}
> +
> +asmlinkage int sys_frevoke(unsigned int fd)
> +{
> +	struct file *file = fget(fd);
> +	int err = -EBADF;
> +
> +	if (file) {
> +		err = do_revoke(file->f_dentry->d_inode, file);
> +		fput(file);
> +	}
> +	return err;
> +}

Is that requiring only that user is able to refer file ?


BSD manual page for revoke(2) seems say:

    Access to a file may be revoked only by its owner or the super user.

/ Kari Hurtta

