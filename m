Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031791AbWLBU6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031791AbWLBU6v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 15:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031792AbWLBU6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 15:58:51 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:9993 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1031791AbWLBU6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 15:58:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=a+AxIIxJgA0XDYB4c9NV8L+rhkYd/wC8j4wVGpWQw3szsRareWhpN1UDcE3hZpKxdak7nhWvb8Cqva4d/RwGP8gJWQ+dXSbQ7j043E7KQVv7HbZPbK6IZrOC7YOqsN4iTNAObjx4qgMq9WFn7BncBpfGmRKfhmAa2ly4PiL1Ao8=
Date: Sat, 2 Dec 2006 23:58:49 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: do_coredump() and not stopping rewrite attacks?
Message-ID: <20061202205849.GA2714@martell.zuzino.mipt.ru>
References: <20061202204744.GA5030@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061202204744.GA5030@martell.zuzino.mipt.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2006 at 11:47:44PM +0300, Alexey Dobriyan wrote:
> David Binderman compiled 2.6.19 with icc and grepped for "was set but never
> used". Many warnings are on
> 	http://coderock.org/kj/unused-2.6.19-fs

Heh, the very first line:
fs/exec.c(1465): remark #593: variable "flag" was set but never used

fs/exec.c:
  1477		/*
  1478		 *	We cannot trust fsuid as being the "true" uid of the
  1479		 *	process nor do we know its entire history. We only know it
  1480		 *	was tainted so we dump it as root in mode 2.
  1481		 */
  1482		if (mm->dumpable == 2) {	/* Setuid core dump mode */
  1483			flag = O_EXCL;		/* Stop rewrite attacks */
  1484			current->fsuid = 0;	/* Dump root private */
  1485		}

And then filp_open follows with "flag" totally ignored.

--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1515,7 +1515,8 @@ int do_coredump(long signr, int exit_cod
 		ispipe = 1;
  	} else
  		file = filp_open(corename,
-				 O_CREAT | 2 | O_NOFOLLOW | O_LARGEFILE, 0600);
+				 O_CREAT | 2 | O_NOFOLLOW | O_LARGEFILE | flag,
+				 0600);
 	if (IS_ERR(file))
 		goto fail_unlock;
 	inode = file->f_dentry->d_inode;

