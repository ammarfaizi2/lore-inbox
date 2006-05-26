Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbWEZTaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWEZTaB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 15:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWEZTaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 15:30:01 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:19414 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751320AbWEZTaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 15:30:00 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Marcelo Tosatti <marcelo@kvack.org>
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org,
       Grant Coady <gcoady.lk@gmail.com>, Chris Wright <chrisw@sous-sol.org>
Subject: Re: [ANNOUNCE] Linux-2.4.32-hf32.5
Date: Sat, 27 May 2006 05:29:58 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <oele72524b719itt80ueugtur35tct214u@4ax.com>
References: <20060507131034.GA19198@exosec.fr> <20060525133427.GA22727@w.ods.org> <k2nd725cl0vocvb72boalj06tpjlita644@4ax.com> <20060526121623.GA14474@w.ods.org> <vvvd72p7mv2j9fet19evm807e0flonnugh@4ax.com> <20060526140731.GC14725@w.ods.org> <20060526182758.GB565@dmt>
In-Reply-To: <20060526182758.GB565@dmt>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 May 2006 15:27:58 -0300, Marcelo Tosatti <marcelo@kvack.org> wrote:

>may_delete() should be called before attempting to grab victim's
>i_zombie. Grant, can you please try the following?

Yep, applied against linux-2.4.32-hf32.5, boots on sempro (the box I 
gave the oops info for).  

Guess I'll see .33-pre4 and a -hf32.7 soon?

Cheers,
Grant.
>
>diff --git a/fs/namei.c b/fs/namei.c
>index 48bd26c..42cce98 100644
>--- a/fs/namei.c
>+++ b/fs/namei.c
>@@ -1479,19 +1479,20 @@ int vfs_unlink(struct inode *dir, struct
> {
> 	int error;
> 
>-	double_down(&dir->i_zombie, &dentry->d_inode->i_zombie);
> 	error = may_delete(dir, dentry, 0);
>-	if (!error) {
>-		error = -EPERM;
>-		if (dir->i_op && dir->i_op->unlink) {
>-			DQUOT_INIT(dir);
>-			if (d_mountpoint(dentry))
>-				error = -EBUSY;
>-			else {
>-				lock_kernel();
>-				error = dir->i_op->unlink(dir, dentry);
>-				unlock_kernel();
>-			}
>+	if (error)
>+		return error;
>+
>+	double_down(&dir->i_zombie, &dentry->d_inode->i_zombie);
>+	error = -EPERM;
>+	if (dir->i_op && dir->i_op->unlink) {
>+		DQUOT_INIT(dir);
>+		if (d_mountpoint(dentry))
>+			error = -EBUSY;
>+		else {
>+			lock_kernel();
>+			error = dir->i_op->unlink(dir, dentry);
>+			unlock_kernel();
> 		}
> 	}
> 	double_up(&dir->i_zombie, &dentry->d_inode->i_zombie);

