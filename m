Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbUFVIF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbUFVIF2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 04:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbUFVIF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 04:05:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:18304 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261378AbUFVIFL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 04:05:11 -0400
Date: Tue, 22 Jun 2004 01:05:07 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andries.Brouwer@cwi.nl
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: CAP_DAC_OVERRIDE
Message-ID: <20040622010505.I22989@build.pdx.osdl.net>
References: <UTC200406220134.i5M1YxJ20330.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <UTC200406220134.i5M1YxJ20330.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Tue, Jun 22, 2004 at 03:34:59AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andries.Brouwer@cwi.nl (Andries.Brouwer@cwi.nl) wrote:
> It seems that CAP_DAC_OVERRIDE is treated inconsistently.
> In fs/namei.c:vfs_permission() it allows one to search in
> a directory with zero permissions:
> 
>         if (!(mask & MAY_EXEC) ||
>             (inode->i_mode & S_IXUGO) || S_ISDIR(inode->i_mode))
>                 if (capable(CAP_DAC_OVERRIDE))
>                         return 0;
> 
> while in fs/namei.c:exec_permission_lite() it does not.
> Maybe the patch below would be appropriate.

Andries, I agree, it's handled inconsistently.  The typical usage would
never notice this since both caps would be either enabled or disabled.
I believe we could actually simplify the overrides to simply:

	if (capable(CAP_DAC_OVERRIDE) || capable(CAP_DAC_READ_SEARCH))
		goto ok;

Because this is only MAY_EXEC on directories check.  However, that does
hide the override reasoning, so conservative approach below.  I changed
it just slightly from yours to keep in line with code in vfs_permission.

thanks,
-chris

===== fs/namei.c 1.96 vs edited =====
--- 1.96/fs/namei.c	2004-06-20 18:20:57 -07:00
+++ edited/fs/namei.c	2004-06-22 01:02:00 -07:00
@@ -316,7 +316,7 @@
 {
 	umode_t	mode = inode->i_mode;
 
-	if ((inode->i_op && inode->i_op->permission))
+	if (inode->i_op && inode->i_op->permission)
 		return -EAGAIN;
 
 	if (current->fsuid == inode->i_uid)
@@ -327,7 +327,8 @@
 	if (mode & MAY_EXEC)
 		goto ok;
 
-	if ((inode->i_mode & S_IXUGO) && capable(CAP_DAC_OVERRIDE))
+	if (((inode->i_mode & S_IXUGO) || S_ISDIR(inode->i_mode)) &&
+	    capable(CAP_DAC_OVERRIDE))
 		goto ok;
 
 	if (S_ISDIR(inode->i_mode) && capable(CAP_DAC_READ_SEARCH))
