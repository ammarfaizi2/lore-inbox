Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317610AbSHYWLK>; Sun, 25 Aug 2002 18:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317616AbSHYWLK>; Sun, 25 Aug 2002 18:11:10 -0400
Received: from air-2.osdl.org ([65.172.181.6]:48529 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S317610AbSHYWLJ>;
	Sun, 25 Aug 2002 18:11:09 -0400
Date: Sun, 25 Aug 2002 15:22:55 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Nicholas Miell <nmiell@attbi.com>
cc: linux-kernel@vger.kernel.org, <johannes@erdfelt.com>, <greg@kroah.com>
Subject: Re: OOPS: USB and/or devicefs
In-Reply-To: <1030270093.1531.8.camel@entropy>
Message-ID: <Pine.LNX.4.44.0208251519530.1021-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 25 Aug 2002, Nicholas Miell wrote:

> I'm not sure what caused this exactly -- I unplugged a USB hub and then
> did a ls in the hub's directory in the devicefs. The ls died (in D
> state), and I found this in my logs.

> 00000000 <_EIP>:
> Code;  c015b40f <driverfs_unlink+f/40>   <=====
>    0:   ff 4f 5c                  decl   0x5c(%edi)   <=====
> Code;  c015b412 <driverfs_unlink+12/40>
>    3:   0f 88 39 08 00 00         js     842 <_EIP+0x842> c015bc51 <.text.lock.inode+0/bf>
> Code;  c015b418 <driverfs_unlink+18/40>
>    9:   8b 46 08                  mov    0x8(%esi),%eax
> Code;  c015b41b <driverfs_unlink+1b/40>
>    c:   66 ff 48 24               decw   0x24(%eax)
> Code;  c015b41f <driverfs_unlink+1f/40>
>   10:   56                        push   %esi
> Code;  c015b420 <driverfs_unlink+20/40>
>   11:   e8 fb ab 00 00            call   ac11 <_EIP+0xac11> c0166020 <sys_shmctl+170/880>


A dentry has been created with no inode associated with it, and
driverfs_unlink() attempts to access it without checking it.  

Could you please try the attached patch and let me know if it helps?

Thanks,

	-pat

===== fs/driverfs/inode.c 1.48 vs edited =====
--- 1.48/fs/driverfs/inode.c	Mon Aug  5 11:13:07 2002
+++ edited/fs/driverfs/inode.c	Sun Aug 25 15:13:51 2002
@@ -211,11 +211,13 @@
 static int driverfs_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = dentry->d_inode;
-	down(&inode->i_sem);
-	dentry->d_inode->i_nlink--;
-	dput(dentry);
-	up(&inode->i_sem);
-	d_delete(dentry);
+	if (inode) {
+		down(&inode->i_sem);
+		dentry->d_inode->i_nlink--;
+		dput(dentry);
+		up(&inode->i_sem);
+		d_delete(dentry);
+	}
 	return 0;
 }
 

