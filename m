Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264733AbUDWHOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264733AbUDWHOq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 03:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264734AbUDWHOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 03:14:46 -0400
Received: from smtpout.mac.com ([17.250.248.89]:12483 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S264733AbUDWHOe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 03:14:34 -0400
Message-ID: <8046885.1082704472016.JavaMail.pwaechtler@mac.com>
Date: Fri, 23 Apr 2004 09:14:32 +0200
From: Peter Waechtler <pwaechtler@mac.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] coredump - as root not only if euid switched
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
On Thursday, April 22, 2004, at 10:05PM, Linus Torvalds <torvalds@osdl.org> wrote:

>
>
>On Thu, 22 Apr 2004, Peter W�chtler wrote:
>>
>> > hm, OK.  There's a window in which someone can come in and recreate the
>> > file, but the open is using O_EXCL|O_CREATE so that seems safe enough.
>> 
>> So here is the updated patch with an open coded call to sys_unlink
>
>Aughr. 
>
>Wouldn't it be much nicer to just refuse to overwrite files owned by 
>anybody else?
>
>In other words, I'd much rather see a patch that is a much simpler one, 
>which just says: if we opened an existing file, we won't touch it if we 
>weren't the owners of it.
>
>That should be safe for root _and_ it should be safe for people who 
>already had a file descriptor open previously (hey, if the previous 
>root-owned core-file was world readable, then what else is new?)
>

the previous core was owned by user.donttellyourwisdom
The root process happily dumps it's core into it, doesn't change 
ownership nor permissions.

>Tell me why this isn't simpler?
>
I can't it's simpler.
If you are interested in the core (you don't because you don't make 
errors, you don't even use debuggers but change the VM ;> )
you get it, otherwise you have an old one.

>
>---
>--- 1.111/fs/exec.c	Wed Apr 21 02:11:57 2004
>+++ edited/fs/exec.c	Thu Apr 22 13:03:27 2004
>@@ -1378,6 +1378,8 @@
> 	inode = file->f_dentry->d_inode;
> 	if (inode->i_nlink > 1)
> 		goto close_fail;	/* multiple links - don't dump */
>+	if (inode->i_uid != current->euid || inode->i_gid != current->egid)
>+		goto close_fail;
> 	if (d_unhashed(file->f_dentry))
> 		goto close_fail;
> 
>
>
