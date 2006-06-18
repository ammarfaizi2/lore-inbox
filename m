Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbWFRWhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWFRWhu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 18:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbWFRWhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 18:37:50 -0400
Received: from 1wt.eu ([62.212.114.60]:55816 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1750901AbWFRWht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 18:37:49 -0400
Date: Mon, 19 Jun 2006 00:37:36 +0200
From: Willy Tarreau <w@1wt.eu>
To: Grant Coady <gcoady.lk@gmail.com>
Cc: Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: Linux 2.4.33-rc1
Message-ID: <20060618223736.GA4965@1wt.eu>
References: <20060616181419.GA15734@dmt> <hka6925bl0in1f3jm7m4vh975a64lcbi7g@4ax.com> <20060618133718.GA2467@dmt> <ksib9210010mt9r3gjevi3dhlp4biqf59k@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ksib9210010mt9r3gjevi3dhlp4biqf59k@4ax.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Grant,

On Mon, Jun 19, 2006 at 08:25:06AM +1000, Grant Coady wrote:
> On Sun, 18 Jun 2006 10:37:18 -0300, Marcelo Tosatti <marcelo@kvack.org> wrote:
> 
> >Can you please try the attached patch.
> >
> >Grab a reference to the victim inode before calling vfs_unlink() to avoid
> >it vanishing under us.
> >
> >diff --git a/fs/namei.c b/fs/namei.c
> >index 42cce98..7993283 100644
> >--- a/fs/namei.c
> >+++ b/fs/namei.c
> >@@ -1509,6 +1509,7 @@ asmlinkage long sys_unlink(const char * 
> > 	char * name;
> > 	struct dentry *dentry;
> > 	struct nameidata nd;
> >+	struct inode *inode = NULL;
> > 
> > 	name = getname(pathname);
> > 	if(IS_ERR(name))
> >@@ -1527,11 +1528,16 @@ asmlinkage long sys_unlink(const char * 
> > 		/* Why not before? Because we want correct error value */
> > 		if (nd.last.name[nd.last.len])
> > 			goto slashes;
> >+		inode = dentry->d_inode;
> >+		if (inode)
> >+			atomic_inc(&inode->i_count);
> > 		error = vfs_unlink(nd.dentry->d_inode, dentry);
> > 	exit2:
> > 		dput(dentry);
> > 	}

Could you add this line here, because your oops still looks like the NULL
is close to this area :

+       printk(KERN_DEBUG "nd.dentry->d_inode = %p\n", nd.dentry->d_inode);


> > 	up(&nd.dentry->d_inode->i_sem);
> >+	if (inode)
> >+		iput(inode);
> > exit1:
> > 	path_release(&nd);
> > exit:
> 
> /home/share is an NFS mounted directory, via ssh terminal:
> 
> grant@sempro:~$ dmesg >/home/share/dmesg-2.4.33-rc1a
> grant@sempro:~$ rm /home/share/dmesg-2.4.33-rc1a
> Segmentation fault
> 
> Network connection lost, copy / paste oops from screen to file, reboot, 
> and...
> 
> ksymoops 2.4.11 on i686 2.4.33-rc1a.  Options used
>      -v /home/grant/linux/linux-2.4.33-rc1a/vmlinux (specified)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.33-rc1a/ (default)
>      -m /boot/System.map-2.4.33-rc1a (specified)
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000088
> *pde = 00000000
> Oops: 0002
> CPU:    0
> EIP:    0010:[<c013eeb4>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010282
> eax: 00000000   ebx: 00000000   ecx: 00000088   edx: 00000088
> esi: f6e2ed08   edi: f5954e40   ebp: f6e2ec80   esp: f587ff68
> ds: 0018   es: 0018   ss: 0018
> Process rm (pid: 241, stackpage=f587f000)
> Stack: f6e2ec80 f5954e40 f5954e40 f75a7000 f58ca0c0 f587ff90 c013f078 f6e2ec80
>        f5954e40 f5954e40 f6eb8440 c19ac440 f75a700c 00000011 c1bbcfcb 00000010
>        00000000 00000004 f587e000 bffff986 08051050 bffff768 c0106eff bffff986
> Call Trace:    [<c013f078>] [<c0106eff>]
> Code: ff 80 88 00 00 00 0f 8e 58 16 00 00 85 db 74 16 89 d8 8b 5c
> 
> 
> >>EIP; c013eeb4 <vfs_unlink+a4/1a0>   <=====
> 
> >>esi; f6e2ed08 <_end+36a9305c/386be3d4>
> >>edi; f5954e40 <_end+355b9194/386be3d4>
> >>ebp; f6e2ec80 <_end+36a92fd4/386be3d4>
> >>esp; f587ff68 <_end+354e42bc/386be3d4>
> 
> Trace; c013f078 <sys_unlink+c8/140>
> Trace; c0106eff <system_call+33/38>
> 
> Code;  c013eeb4 <vfs_unlink+a4/1a0>
> 00000000 <_EIP>:
> Code;  c013eeb4 <vfs_unlink+a4/1a0>   <=====
>    0:   ff 80 88 00 00 00         incl   0x88(%eax)   <=====
> Code;  c013eeba <vfs_unlink+aa/1a0>
>    6:   0f 8e 58 16 00 00         jle    1664 <_EIP+0x1664>
> Code;  c013eec0 <vfs_unlink+b0/1a0>
>    c:   85 db                     test   %ebx,%ebx
> Code;  c013eec2 <vfs_unlink+b2/1a0>
>    e:   74 16                     je     26 <_EIP+0x26>
> Code;  c013eec4 <vfs_unlink+b4/1a0>
>   10:   89 d8                     mov    %ebx,%eax
> Code;  c013eec6 <vfs_unlink+b6/1a0>
>   12:   8b 5c 00 00               mov    0x0(%eax,%eax,1),%ebx
> 
> 
> Sorry for bad news.  As before, the 'rm file' succeeded, prior to the 
> segfault.  I put the dmesg (before oops) and 'grep = .config' up on 
> <http://bugsplatter.mine.nu/test/linux-2.4/sempro/> with -rc1a suffix
> 
> Repeat with extract 2.4.32 + patches --> same, note that the oops is 
> only on deleting file over NFS, I noticed 2.6.16.20 has extra NFS 
> stuff around this area.

Thanks for the info and the tests, maybe Al will have some insight here ?

> grant@sempro:~$ dmesg >dmesg
> grant@sempro:~$ rm dmesg
> grant@sempro:~$ dmesg >/home/share/dmesg-test
> grant@sempro:~$ rm /home/share/dmesg-test
> Segmentation fault
> 
> Grant.

Cheers,
Willy

