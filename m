Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262862AbTJZBuI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 21:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbTJZBuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 21:50:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:16588 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262862AbTJZBuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 21:50:03 -0400
Date: Sat, 25 Oct 2003 18:50:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Cc: linux-kernel@vger.kernel.org,
       "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>,
       James Morris <jmorris@redhat.com>, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: 2.6.0-test9 and sleeping function called from invalid context
Message-Id: <20031025185055.4d9273ae.akpm@osdl.org>
In-Reply-To: <200310260045.52094.arekm@pld-linux.org>
References: <200310260045.52094.arekm@pld-linux.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arkadiusz Miskiewicz <arekm@pld-linux.org> wrote:
>
> Debug: sleeping function called from invalid context at 
>  include/asm/semaphore.h:119
>  in_atomic():1, irqs_disabled():0
>  Call Trace:
>   [<c011dfbb>] __might_sleep+0xab/0xf0
>   [<c019ed91>] inode_doinit_with_dentry+0x41/0x5d0
>   [<cf9b91b0>] bm_fill_super+0x0/0x40 [binfmt_misc]
>   [<c0170904>] d_instantiate+0x64/0x80
>   [<cf9b8f30>] bm_register_write+0x150/0x1d0 [binfmt_misc]
>   [<cf9b8de0>] bm_register_write+0x0/0x1d0 [binfmt_misc]
>   [<c01586ea>] vfs_write+0xca/0x140
>   [<c01587ff>] sys_write+0x3f/0x60
>   [<c010b37f>] syscall_call+0x7/0xb

Not nice.

fs/binfmt_misc.c:bm_register_write() is doing d_instantiate()
under a write_lock(), and the selinux d_instantiate() hook is
performing sleeping functions.

Now, we can just move the d_instantiate() call to outside the lock:

--- 25/fs/binfmt_misc.c~bm_register_write-locking-fix	2003-10-25 18:39:45.000000000 -0700
+++ 25-akpm/fs/binfmt_misc.c	2003-10-25 18:40:29.000000000 -0700
@@ -529,8 +529,8 @@ static ssize_t bm_register_write(struct 
 	inode->u.generic_ip = e;
 	inode->i_fop = &bm_entry_operations;
 
-	write_lock(&entries_lock);
 	d_instantiate(dentry, inode);
+	write_lock(&entries_lock);
 	list_add(&e->list, &entries);
 	write_unlock(&entries_lock);
 

which I think is OK, but the wider question would be: is the SELinux
d_instantiate callout allowed to sleep?  A quick audit seems to indicate
that it's OK, but only by luck I think.


