Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbULADpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbULADpd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 22:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbULADpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 22:45:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:15020 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261209AbULADpT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 22:45:19 -0500
Date: Tue, 30 Nov 2004 19:44:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, delgado@dfn-cert.de
Cc: delgado@dfn-cert.de, linux-kernel@vger.kernel.org
Subject: Re: Problem: Kernel Panic/Oops on shutdown with 2.6.9 and Dell
 Optiplex SX280
Message-Id: <20041130194456.57c5f737.akpm@osdl.org>
In-Reply-To: <20041130160717.GA13106@kermit.dfn-cert.de>
References: <20041130160717.GA13106@kermit.dfn-cert.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Friedrich Delgado Friedrichs <delgado@dfn-cert.de> wrote:
>
> CPU:    1
>  EIP:    0060:[<c0171af7>]    Tainted: GF VLI
>  EFLAGS: 00010246   (2.6.9-1-smp 20041109140641)
>  EIP is at __d_path+087/1x170
>  eax: 00000000   ebx: dd9aefff   ecx: deb4d290   edx: dd9aeffe
>  esi: d86ce320   edi: 00000f07   ebp: 00000f07   esp: d744decc
>  ds: 007b   es: 007b   ss: 0068
>  Process fuser (pid: 16550, threadinfo=d744c000 task=deced350)
>  Stack: dd9aeffe deb4d290 00000000 df518100 deb4d290 dd9ae0f8 00000000 c0171c63
>         df518100 dd9ae0f8 00000f07 d86ce320 dd9ae0f8 d86ce320 c0aa8180 c035ab84
>         c017752e 00000f08 df096f00 00000005 0000002c c0aa8180 df096f00 c0186703
>  Call Trace:
>   [<c0171c63>] d_path+0x83/0xe0
>   [<c017752e>] seq_path+0x2e/0xf0
>   [<c0186703>] show_map+0xd3/0x100
>   [<c01770c2>] seq_read+0x232/0x290
>   [<c0176e90>] seq_read+0x0/0x290
>   [<c015aaae>] vfs_read+0xae/0xf0
>   [<c015ad0c>] sys_read+0xec/0x70
>   [<c0106dc9>] sysenter_past_esp+0x52/0x79
>  Code: 00 00 8d 43 ff 89 04 24 c6 43 ff 2f 8b 44 24 20 3b 74 24 04 0f 94 c2 39 44
>   24 08 0f 94 c0 21 d0 8b 14 24 a8 01 75 63 8b 44 24 08 <3b> 70 10 74 64 8b 6e 10
>   39 ee 74 5d 0f 18 45 00 8b 56 1c 8b 44
>   Nov 30 14:16:50 count kernel: Unable to handle kernel NULL pointer dereference
>  at virtual address 00000010

You crashed here, in __d_path:

                   if (dentry == vfsmnt->mnt_root || IS_ROOT(dentry)) {

because vfsmnt is zero.  When generating /proc/pid/maps, show_map()
stumbled across a vma whose vm_file->f_vfsmnt is zero.

It's interesting that this only happens during shutdown: something may be
racing against an unmount.

I'd suggest that you run with the below patch which, if it's right, will
display the offending path and will then pause for ten seconds.  If we can
identify which filesystem type that path lives on then perhaps we can make
some progress.


--- 25/fs/dcache.c~a	2004-11-30 19:38:49.441332720 -0800
+++ 25-akpm/fs/dcache.c	2004-11-30 19:43:20.865070040 -0800
@@ -32,6 +32,7 @@
 #include <linux/seqlock.h>
 #include <linux/swap.h>
 #include <linux/bootmem.h>
+#include <linux/delay.h>
 
 /* #define DCACHE_DEBUG 1 */
 
@@ -1291,6 +1292,7 @@ static char * __d_path( struct dentry *d
 	char * end = buffer+buflen;
 	char * retval;
 	int namelen;
+	int whoops = 0;
 
 	*--end = '\0';
 	buflen--;
@@ -1313,6 +1315,12 @@ static char * __d_path( struct dentry *d
 
 		if (dentry == root && vfsmnt == rootmnt)
 			break;
+		if (vfsmnt == NULL) {
+			printk(KERN_EMERG "%s: skipping NULL vfsmnt\n",
+					__FUNCTION__);
+			whoops = 1;
+			goto global_root;
+		}
 		if (dentry == vfsmnt->mnt_root || IS_ROOT(dentry)) {
 			/* Global root? */
 			spin_lock(&vfsmount_lock);
@@ -1347,6 +1355,11 @@ global_root:
 		goto Elong;
 	retval -= namelen-1;	/* hit the slash */
 	memcpy(retval, dentry->d_name.name, namelen);
+	if (whoops) {
+		retval[namelen] = 0;
+		printk(KERN_EMERG "path: `%s'\n", buffer);
+		mdelay(10000);
+	}
 	return retval;
 Elong:
 	return ERR_PTR(-ENAMETOOLONG);
_

