Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbTLIR5u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 12:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266033AbTLIR5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 12:57:50 -0500
Received: from mhub-m6.tc.umn.edu ([160.94.23.36]:19079 "EHLO
	mhub-m6.tc.umn.edu") by vger.kernel.org with ESMTP id S263057AbTLIR5o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 12:57:44 -0500
Subject: Re: [OOPS] 2.6.0-test11 sysfs
From: Matthew Reppert <repp0017@tc.umn.edu>
To: Guennadi Liakhovetski <gl@dsa-ac.de>
Cc: linux-kernel@vger.kernel.org,
       Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       Patrick Mochel <mochel@osdl.org>
In-Reply-To: <Pine.LNX.4.33.0312091826090.1130-100000@pcgl.dsa-ac.de>
References: <Pine.LNX.4.33.0312091826090.1130-100000@pcgl.dsa-ac.de>
Content-Type: text/plain
Message-Id: <1070992648.27231.7.camel@minerva>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 09 Dec 2003 11:57:28 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-09 at 11:35, Guennadi Liakhovetski wrote:
> Hello
> 
> Just installed 2.6.0-test11 on a Toshiba notebook, and  booting / loading
> PCMCIA produces the following Oops:
> 
> Linux Kernel Card Services
>   options:  [pci] [pm]
> Intel PCIC probe:
>   Intel i82365sl B step ISA-to-PCMCIA at port 0x3e0 ofs 0x00, 2 sockets
>     host opts [0]: none
>     host opts [1]: none
>     ISA irqs (scanned) = 3,4,5,7,9,10<6>    PCI card interrupts, status change on irq 10
> Unable to handle kernel NULL pointer dereference at virtual address 0000000c
>  printing eip:
> c01785a4
> *pde = 00000000
> Oops: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c01785a4>]    Not tainted
> EFLAGS: 00010282
> EIP is at sysfs_add_file+0xc/0x80
> eax: 00000000   ebx: c40370ec   ecx: 00000001   edx: 00000000
> esi: 00000001   edi: c4037e94   ebp: c1f7ff64   esp: c1f7ff58
> ds: 007b   es: 007b   ss: 0068
> Process modprobe (pid: 212, threadinfo=c1f7e000 task=c1f5cd20)
> Stack: c40370ec 00000001 c4036f44 c1f7ff74 c0178633 00000000 c4037e94 c1f7ff84
>        c01e3524 c40370f4 c4037e94 c1f7ffa4 c403b0b0 c40370ec c4037e94 c1f7e000
>        c4038020 c02b3040 00000224 c1f7ffbc c01323ab 40134000 0804bb2f bffffbbc
> Call Trace:
>  [<c0178633>] sysfs_create_file+0x1b/0x28
>  [<c01e3524>] class_device_create_file+0x1c/0x20
>  [<c403b0b0>] init_i82365+0x12c/0x1bc [i82365]
>  [<c01323ab>] sys_init_module+0xfb/0x200
>  [<c010a037>] syscall_call+0x7/0xb
> 
> Code: 8b 42 0c 8d 48 6c ff 48 6c 0f 88 3e 01 00 00 8b 07 50 52 e8
>  <6>cs: IO port probe 0x0c00-0x0cff: clean.
> cs: IO port probe 0x0800-0x08ff: clean.
> cs: IO port probe 0x0100-0x04ff: excluding 0x220-0x22f 0x330-0x337 0x378-0x37f 0x388-0x38f 0x3c0-0x3e7 0x480-0x48f 0x4d0-0x4d7
> cs: IO port probe 0x0a00-0x0aff: clean.
> 
> Right, you guessed it - there was no /sys directory:-) Shouldn't lead to
> an Oops though... Is it known already?

Hi,

Try this patch. (Patrick, is this the sane thing to do? And is it worth
it? If so, I can do similar things to the other sysfs_create_* functions
if you would like.)

Matt



  Avoid an oops if we try to add a file when sysfs mount point doesn't
exist.



diff -puN fs/sysfs/file.c~sysfs-add-file-oops fs/sysfs/file.c
--- linux-2.6.0-test11/fs/sysfs/file.c~sysfs-add-file-oops	2003-12-09
11:46:58.025205656 -0600
+++ linux-2.6.0-test11-arashi/fs/sysfs/file.c	2003-12-09
11:47:28.781529984 -0600
@@ -374,7 +374,7 @@ int sysfs_add_file(struct dentry * dir, 
 
 int sysfs_create_file(struct kobject * kobj, const struct attribute *
attr)
 {
-	if (kobj && attr)
+	if (kobj && kobj->dentry && attr)
 		return sysfs_add_file(kobj->dentry,attr);
 	return -EINVAL;
 }

_

