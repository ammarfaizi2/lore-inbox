Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265969AbTIJXER (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 19:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265971AbTIJXEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 19:04:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:26250 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265969AbTIJXEK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 19:04:10 -0400
Date: Wed, 10 Sep 2003 15:46:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ranjeet Shetye <ranjeet.shetye2@zultys.com>
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>,
       Greg KH <greg@kroah.com>
Subject: Re: [OOPS] Linux-2.6.0-test5-bk
Message-Id: <20030910154608.14ad0ac8.akpm@osdl.org>
In-Reply-To: <1063232210.4441.14.camel@ranjeet-pc2.zultys.com>
References: <1063232210.4441.14.camel@ranjeet-pc2.zultys.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ranjeet Shetye <ranjeet.shetye2@zultys.com> wrote:
>
> Unable to handle kernel paging request at virtual address ffffffef
>  printing eip:
> c027184c
> *pde = 00001067
> *pte = 00000000
> Oops: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c027184c>]    Not tainted
> EFLAGS: 00010282
> EIP is at atomic_dec_and_lock+0x8/0x54
> eax: ffffffef   ebx: ffffffef   ecx: ffffffef   edx: cf372254
> esi: ffffffef   edi: cf743e20   ebp: c12efea8   esp: c12efea0
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 1, threadinfo=c12ee000 task=c12ed8c0)
> Stack: ffffffef ffffffef c12efec4 c01675e4 ffffffef c05a21b0 ffffffef cf7469b4 
>        cf743e20 c12efee4 c018aa52 ffffffef 000041ed c018a998 c05f0f80 00000000 
>        c05f0f80 c12eff00 c018aab1 c05f0f80 cf743e20 c05f0f84 00000000 c05f0f80 
> Call Trace:
>  [<c01675e4>] dput+0x24/0x227
>  [<c018aa52>] create_dir+0x9e/0xa4
>  [<c018a998>] init_dir+0x0/0x1c
>  [<c018aab1>] sysfs_create_dir+0x36/0x6c
>  [<c026eee0>] create_dir+0x1f/0x49
>  [<c026f331>] kobject_add+0x4d/0x124

Bug in fs/sysfs/dir.c:create_dir() - sysfs_create() returned -EEXIST and we
turned that into a pointer and did a dput() on it.  

Something like this should fix it.  The -EEXIST return may be another bug?



diff -puN fs/sysfs/dir.c~sysfs-create_dir-oops-fix fs/sysfs/dir.c
--- 25/fs/sysfs/dir.c~sysfs-create_dir-oops-fix	Wed Sep 10 15:41:35 2003
+++ 25-akpm/fs/sysfs/dir.c	Wed Sep 10 15:44:42 2003
@@ -24,10 +24,11 @@ static int init_dir(struct inode * inode
 static struct dentry * 
 create_dir(struct kobject * k, struct dentry * p, const char * n)
 {
-	struct dentry * dentry;
+	struct dentry *dentry, *ret;
 
 	down(&p->d_inode->i_sem);
 	dentry = sysfs_get_dentry(p,n);
+	ret = dentry;
 	if (!IS_ERR(dentry)) {
 		int error = sysfs_create(dentry,
 					 S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO,
@@ -36,11 +37,11 @@ create_dir(struct kobject * k, struct de
 			dentry->d_fsdata = k;
 			p->d_inode->i_nlink++;
 		} else
-			dentry = ERR_PTR(error);
+			ret = ERR_PTR(error);
 		dput(dentry);
 	}
 	up(&p->d_inode->i_sem);
-	return dentry;
+	return ret;
 }
 
 

_

