Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281552AbRKMJCj>; Tue, 13 Nov 2001 04:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281555AbRKMJCU>; Tue, 13 Nov 2001 04:02:20 -0500
Received: from mail.loewe-komp.de ([62.156.155.230]:33299 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S281552AbRKMJCE>; Tue, 13 Nov 2001 04:02:04 -0500
Message-ID: <3BF0E152.47AC899@loewe-komp.de>
Date: Tue, 13 Nov 2001 10:01:06 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Hannover
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.9-ac3 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: "Christian, Chip" <chip_christian@hp.com>
CC: linux-xfs@oss.sgi.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: NFS hit me (2.4.9-xfs) again
In-Reply-To: <23D04BDBA646D411BDDD00D0B774B539046028B7@SA-BWMAIL1>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Christian, Chip" wrote:
> 
> The reason that dput was dropped in 2.4.10 is that there's another one that also gets executed, causing the kernel oops right after the
> 
>         if (!pdentry) {
>         }
> code block.
> 
> I think you have a filesystem in need of repair.
> 
> RedHat ships this patch with their 2.4.9 kernels:
> 
> --- linux/fs/nfsd/nfsfh.c~      Fri Aug 17 21:30:25 2001
> +++ linux/fs/nfsd/nfsfh.c       Fri Aug 17 21:30:40 2001
> @@ -275,7 +275,6 @@
>         d_drop(tdentry); /* we never want ".." hashed */
>         if (!pdentry && tdentry->d_inode == NULL) {
>                 /* File system cannot find ".." ... sad but possible */
> -               dput(tdentry);
>                 pdentry = ERR_PTR(-EINVAL);
>         }
>         if (!pdentry) {

Yes, the patch makes sense.
I've checked both: /home and /usr/local with xfs_check and with xfs_repair -n
No warning, no error.

I have removed /var/tmp, which is a reiserfs, from /etc/exports
but it was seldom used (if any).

Thanks for your effort. I will now closely follow any nfs related patches.

> 
> -----Original Message-----
> From: Peter Wächtler [mailto:pwaechtler@loewe-komp.de]
> Sent: Friday, November 09, 2001 5:01
> To: linux-xfs@oss.sgi.com
> Cc: lkml
> Subject: NFS hit me (2.4.9-xfs) again
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> 00000000
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<00000000>]
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010286
> eax: 00000000   ebx: c9c0d7e0   ecx: 00000000   edx: c03a7b00
> esi: c9c0d560   edi: c9c0d7e0   ebp: c9c0d7e0   esp: cbddde84
> ds: 0018   es: 0018   ss: 0018
> Process nfsd (pid: 233, stackpage=cbddd000)
> Stack: c01729f4 cc97f420 c9c0d560 00000005 cdc40a00 c0172e56 c9c0d7e0 00000005
>        cd390200 cd390000 cbed2000 cbdddf20 cdc40be8 cd390200 c0173199 cdc40a00
>        cd390010 00000005 00000001 00000001 00000008 cbe17e00 cbee48c0 cd390200
> Call Trace: [<c01729f4>] [<c0172e56>] [<c0173199>] [<c0173ad2>] [<c017843d>]
>    [<c017173c>] [<c0171003>] [<c0240318>] [<c0170dab>] [<c010557f>]
> Code:  Bad EIP value.
> 
> >>EIP; 00000000 Before first symbol
> Trace; c01729f4 <nfsd_findparent+34/104>
> Trace; c0172e56 <find_fh_dentry+226/34c>
> Trace; c0173199 <fh_verify+21d/438>
> Trace; c0173ad2 <nfsd_lookup+92/4b8>
> Trace; c017843d <nfssvc_decode_diropargs+5d/d0>
> Trace; c017173c <nfsd_proc_lookup+88/9c>
> Trace; c0171003 <nfsd_dispatch+cb/168>
> Trace; c0240318 <svc_process+2ac/544>
> Trace; c0170dab <nfsd+1ab/338>
> Trace; c010557f <kernel_thread+23/30>
> 
> This is not the initial crash location - the machine was dead (and no serial
> console yet). But after restarting, about 6-10 clients tried to reconnect
> to NFSD and caused the crash.
> 
> The crash appears because "child->d_inode->i_op->lookup == NULL"
>
