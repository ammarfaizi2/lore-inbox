Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWFRNgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWFRNgb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 09:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWFRNgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 09:36:31 -0400
Received: from kanga.kvack.org ([66.96.29.28]:28549 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932185AbWFRNga (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 09:36:30 -0400
Date: Sun, 18 Jun 2006 10:37:18 -0300
From: Marcelo Tosatti <marcelo@kvack.org>
To: Grant Coady <gcoady.lk@gmail.com>
Cc: linux-kernel@vger.kernel.org, Willy Tarreau <willy@w.ods.org>,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: Linux 2.4.33-rc1
Message-ID: <20060618133718.GA2467@dmt>
References: <20060616181419.GA15734@dmt> <hka6925bl0in1f3jm7m4vh975a64lcbi7g@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hka6925bl0in1f3jm7m4vh975a64lcbi7g@4ax.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2006 at 08:21:44AM +1000, Grant Coady wrote:
> On Fri, 16 Jun 2006 15:14:19 -0300, Marcelo Tosatti <marcelo@kvack.org> wrote:
> 
> >Here is 2.4.33-rc1.
> 
> I provoked a network related oops as user 'grant', with this CLI input
> boo-boo on an ssh terminal:
> 
> grant@sempro:~$ rm /home/share/config-2.6.17-rc6-mm1a dmesg-2.6.17-rc6-mm1a
> 
> /home/share is an NFS mounted directory
> 
> Was able to login direct as root and copy the oops info with mouse (gpm)
> copy/paste, but console locked up on localnet access, here's the guff:
> 
> ksymoops 2.4.11 on i686 2.4.33-rc1.  Options used
>      -v /home/grant/linux/linux-2.4.33-rc1/vmlinux (specified)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.33-rc1/ (default)
>      -m /boot/System.map-2.4.33-rc1 (specified)
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000088
> *pde = 00000000
> Oops: 0002
> CPU:    0
> EIP:    0010:[<c013eeb4>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010282
> eax: 00000000   ebx: 00000000   ecx: 00000088   edx: 00000088
> esi: f6e2fd08   edi: f5839ac0   ebp: f6e2fc80   esp: f5889f6c
> ds: 0018   es: 0018   ss: 0018
> Process rm (pid: 243, stackpage=f5889000)
> Stack: f6e2fc80 f5839ac0 f5839ac0 f7bdd000 f5889f90 f5839ac0 c013f066 f6e2fc80
>        f5839ac0 f6e36440 c19ac440 f7bdd00c 00000016 be8f2661 00000010 00000000
>        00000004 f5888000 bffff96b 08051050 bffff758 c0106eff bffff96b 00000002
> Call Trace:    [<c013f066>] [<c0106eff>]
> Code: ff 80 88 00 00 00 0f 8e 2e 16 00 00 85 db 74 16 89 d8 8b 5c
> 
> 
> >>EIP; c013eeb4 <vfs_unlink+a4/1a0>   <=====
> 
> >>esi; f6e2fd08 <_end+36a9405c/386be3d4>
> >>edi; f5839ac0 <_end+3549de14/386be3d4>
> >>ebp; f6e2fc80 <_end+36a93fd4/386be3d4>
> >>esp; f5889f6c <_end+354ee2c0/386be3d4>
> 
> Trace; c013f066 <sys_unlink+b6/120>
> Trace; c0106eff <system_call+33/38>
> 
> Code;  c013eeb4 <vfs_unlink+a4/1a0>
> 00000000 <_EIP>:
> Code;  c013eeb4 <vfs_unlink+a4/1a0>   <=====
>    0:   ff 80 88 00 00 00         incl   0x88(%eax)   <=====
> Code;  c013eeba <vfs_unlink+aa/1a0>
>    6:   0f 8e 2e 16 00 00         jle    163a <_EIP+0x163a>
> Code;  c013eec0 <vfs_unlink+b0/1a0>
>    c:   85 db                     test   %ebx,%ebx
> Code;  c013eec2 <vfs_unlink+b2/1a0>
>    e:   74 16                     je     26 <_EIP+0x26>
> Code;  c013eec4 <vfs_unlink+b4/1a0>
>   10:   89 d8                     mov    %ebx,%eax
> Code;  c013eec6 <vfs_unlink+b6/1a0>
>   12:   8b 5c 00 00               mov    0x0(%eax,%eax,1),%ebx

Grant,

Can you please try the attached patch.

Grab a reference to the victim inode before calling vfs_unlink() to avoid
it vanishing under us.

diff --git a/fs/namei.c b/fs/namei.c
index 42cce98..7993283 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1509,6 +1509,7 @@ asmlinkage long sys_unlink(const char * 
 	char * name;
 	struct dentry *dentry;
 	struct nameidata nd;
+	struct inode *inode = NULL;
 
 	name = getname(pathname);
 	if(IS_ERR(name))
@@ -1527,11 +1528,16 @@ asmlinkage long sys_unlink(const char * 
 		/* Why not before? Because we want correct error value */
 		if (nd.last.name[nd.last.len])
 			goto slashes;
+		inode = dentry->d_inode;
+		if (inode)
+			atomic_inc(&inode->i_count);
 		error = vfs_unlink(nd.dentry->d_inode, dentry);
 	exit2:
 		dput(dentry);
 	}
 	up(&nd.dentry->d_inode->i_sem);
+	if (inode)
+		iput(inode);
 exit1:
 	path_release(&nd);
 exit:
