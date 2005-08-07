Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752390AbVHGRIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390AbVHGRIP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 13:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752389AbVHGRIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 13:08:15 -0400
Received: from mailfe03.swip.net ([212.247.154.65]:12789 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1752391AbVHGRIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 13:08:14 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Date: Sun, 7 Aug 2005 19:08:05 +0200
From: Alexander Nyberg <alexn@telia.com>
To: Ryan Anderson <ryan@michonline.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops in 2.6.13-rc5-git-current (0d317fb72fe3cf0f611608cf3a3015bbe6cd2a66)
Message-ID: <20050807170805.GA14289@localhost.localdomain>
References: <20050807035630.GA5271@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050807035630.GA5271@mythryan2.michonline.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 06, 2005 at 11:56:30PM -0400 Ryan Anderson wrote:

> 
> Unable to handle kernel paging request at virtual address 6b6b6b6b
>  printing eip:
> c0188d15
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT 
> Modules linked in: ppp_deflate bsd_comp ppp_async ppp_generic slhc radeon esp6 ah6 wp512 tgr192 tea khazad michael_mic cast6 cast5 arc4 anubis nfsd exportfs lp binfmt_misc ipv6 tsdev evdev analog parport_pc parport 8250_pnp 8250 serial_core via_agp serpent aes_i586 crypto_null snd_via82xx gameport snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore uhci_hcd via_ircc irda dm_mod r8169 raid5 xor tulip via drm agpgart cpuid smbfs usbkbd usbcore trm290 triflex sc1200 ns87415 it821x cy82c693 cs5530 cs5520 atiixp raid1 md_mod
> CPU:    0
> EIP:    0060:[inotify_inode_queue_event+85/336]    Not tainted VLI
> EFLAGS: 00010206   (2.6.13-rc5-g0d317fb7) 
> EIP is at inotify_inode_queue_event+0x55/0x150
> eax: 6b6b6b6b   ebx: 6b6b6b63   ecx: 00000000   edx: 00000066
> esi: c3effe34   edi: ce8c76ac   ebp: d4bb864c   esp: d8655eb0
> ds: 007b   es: 007b   ss: 0068
> Process nfsd (pid: 3750, threadinfo=d8654000 task=d6155020)
> Stack: 00000286 00000286 00000000 00000400 d4bb8760 d4bb8768 00000000 c3effe34 
>        ce8c76ac d4bb864c c0170626 00000000 c3effe34 d6608ad4 db74b17c c3effe34 
>        e0cfe9a4 00000013 e0d01b34 c0dd91b4 ce8c76ac ffffc000 d66092dc d66093c4 
> Call Trace:
>  [vfs_unlink+358/560] vfs_unlink+0x166/0x230
>  [pg0+544348580/1067586560] nfsd_unlink+0x104/0x230 [nfsd]
>  [pg0+544361268/1067586560] nfsd_cache_lookup+0x1c4/0x3c0 [nfsd]
>  [pg0+544371728/1067586560] nfsd3_proc_remove+0x80/0xc0 [nfsd]
>  [pg0+544381018/1067586560] nfs3svc_decode_diropargs+0x8a/0x100 [nfsd]
>  [pg0+544380880/1067586560] nfs3svc_decode_diropargs+0x0/0x100 [nfsd]
>  [pg0+544321698/1067586560] nfsd_dispatch+0x82/0x1f0 [nfsd]
>  [svc_authenticate+112/336] svc_authenticate+0x70/0x150
>  [svc_process+960/1648] svc_process+0x3c0/0x670
>  [pg0+544323105/1067586560] nfsd+0x1a1/0x350 [nfsd]
>  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
>  [pg0+544322688/1067586560] nfsd+0x0/0x350 [nfsd]
>  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10

(the long-aged vfs veteran steps into the picture...)

It looks like the following sequence is done in the wrong order.
When vfs_unlink() is called from sys_unlink() it has taken a ref
on the inode and sys_unlink() does the last iput() but when called
from other callsites vfs_unlink() might do the last iput()

Can you reproduce with this patch? It should happen with some nfs
activity, I'll try to set up a scenario myself.

Index: mm/fs/namei.c
===================================================================
--- mm.orig/fs/namei.c	2005-08-07 12:06:16.000000000 +0200
+++ mm/fs/namei.c	2005-08-07 18:17:20.000000000 +0200
@@ -1869,8 +1869,8 @@
 	/* We don't d_delete() NFS sillyrenamed files--they still exist. */
 	if (!error && !(dentry->d_flags & DCACHE_NFSFS_RENAMED)) {
 		struct inode *inode = dentry->d_inode;
-		d_delete(dentry);
 		fsnotify_unlink(dentry, inode, dir);
+		d_delete(dentry);
 	}
 
 	return error;
