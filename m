Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265576AbTF2FIS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 01:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265577AbTF2FIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 01:08:18 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:6670 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S265576AbTF2FIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 01:08:15 -0400
Date: Sun, 29 Jun 2003 15:19:11 +1000
To: Alan Chandler <alan@chandlerfamily.org.uk>, 189650@bugs.debian.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mge@sistina.de
Subject: [PATCH] Update gendisk devfs handler in lvrename
Message-ID: <20030629051911.GA30079@gondor.apana.org.au>
References: <20030518045231.GA8210@gondor.apana.org.au> <200305182215.06331.alan@chandlerfamily.org.uk> <20030531002747.GA2857@gondor.apana.org.au> <200305310910.09346.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <200305310910.09346.alan@chandlerfamily.org.uk>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tags 189650 pending
quit

On Sat, May 31, 2003 at 09:10:04AM +0100, Alan Chandler wrote:
> 
> I was able to reproduce with this simple test (some lines from command 
> history)
> 
>   462  lvcreate -L 100M -n testb vg1
>   463  lvcreate -L 100M -n testa vg1
>   464  mkreiserfs /dev/vg1/testa
>   465  mkreiserfs /dev/vg1/testb
>   466  ls
>   467  lvcreate -L 100M -n testc vg1
>   468  lvcreate -L 100M -n testd vg1
>   469  mkreiserfs /dev/vg1/testc
>   470  mkreiserfs /dev/vg1/testd
>   471  lvremove /dev/vg1/testa
>   472  lvrename vg testb testa
>   473  lvrename vg1 testb testa
>   474  lvrename vg1 testc testb
>   475  lvrename vg1 testd testc
>   476  lvcreate -L 100M -n testd vg1
> 
> At this point the lvcreate segfaulted.

...

> Unable to handle kernel paging request at virtual address 0000101c
> c015c1a0
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c015c1a0>]    Tainted: P
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010246
> eax: 00000000   ebx: 00001000   ecx: 00000000   edx: 00000040
> esi: d5458b05   edi: dc649f67   ebp: 0000003f   esp: dc649ea4
> ds: 0018   es: 0018   ss: 0018
> Process lvcreate (pid: 2468, stackpage=dc649000)
> Stack: 00000008 dc649f28 00000000 e095c67f c0155504 d5458ac0 dc649f28 00000040
>        e095eb20 e095dc00 00000008 00000220 c017e9a5 e095dc00 00000008 dc649f28
>        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> Call Trace:    [<e095c67f>] [<c0155504>] [<e095eb20>] [<e095dc00>] 
> [<c017e9a5>]
>   [<e095dc00>] [<e095eb20>] [<e095dc00>] [<e095dc00>] [<e095dc00>] 
> [<c0126c7a>]
>   [<c014bb7b>] [<e095dc00>] [<c01358f6>] [<c0108837>]
> Code: 83 7b 1c 00 75 9f 89 e8 5b 5e 5f 5d c3 8d 76 00 53 8b 5c 24
> 
> 
> >>EIP; c015c1a0 <devfs_generate_path+d0/e0>   <=====
> 
> >>esi; d5458b05 <_end+151be915/20572e70>
> >>edi; dc649f67 <_end+1c3afd77/20572e70>
> >>esp; dc649ea4 <_end+1c3afcb4/20572e70>
> 
> Trace; e095c67f <[lvm-mod]__module_author+3f/40>
> Trace; c0155504 <disk_name+54/210>
> Trace; e095eb20 <[lvm-mod]lvm_hd_struct+220/4400>
> Trace; e095dc00 <[lvm-mod]lvm_gendisk+0/30>
> Trace; c017e9a5 <part_show+105/150>
> Trace; e095dc00 <[lvm-mod]lvm_gendisk+0/30>
> Trace; e095eb20 <[lvm-mod]lvm_hd_struct+220/4400>
> Trace; e095dc00 <[lvm-mod]lvm_gendisk+0/30>
> Trace; e095dc00 <[lvm-mod]lvm_gendisk+0/30>
> Trace; e095dc00 <[lvm-mod]lvm_gendisk+0/30>
> Trace; c0126c7a <do_mmap_pgoff+41a/4d0>
> Trace; c014bb7b <seq_read+db/270>
> Trace; e095dc00 <[lvm-mod]lvm_gendisk+0/30>
> Trace; c01358f6 <sys_read+96/f0>
> Trace; c0108837 <system_call+33/38>
> 
> Code;  c015c1a0 <devfs_generate_path+d0/e0>
> 00000000 <_EIP>:
> Code;  c015c1a0 <devfs_generate_path+d0/e0>   <=====
>    0:   83 7b 1c 00               cmpl   $0x0,0x1c(%ebx)   <=====
> Code;  c015c1a4 <devfs_generate_path+d4/e0>
>    4:   75 9f                     jne    ffffffa5 <_EIP+0xffffffa5>
> Code;  c015c1a6 <devfs_generate_path+d6/e0>
>    6:   89 e8                     mov    %ebp,%eax
> Code;  c015c1a8 <devfs_generate_path+d8/e0>
>    8:   5b                        pop    %ebx
> Code;  c015c1a9 <devfs_generate_path+d9/e0>
>    9:   5e                        pop    %esi
> Code;  c015c1aa <devfs_generate_path+da/e0>
>    a:   5f                        pop    %edi
> Code;  c015c1ab <devfs_generate_path+db/e0>
>    b:   5d                        pop    %ebp
> Code;  c015c1ac <devfs_generate_path+dc/e0>
>    c:   c3                        ret
> Code;  c015c1ad <devfs_generate_path+dd/e0>
>    d:   8d 76 00                  lea    0x0(%esi),%esi
> Code;  c015c1b0 <devfs_get_ops+0/80>
>   10:   53                        push   %ebx
> Code;  c015c1b1 <devfs_get_ops+1/80>
>   11:   8b 5c 24 00               mov    0x0(%esp,1),%ebx
> 
> 
> 7 warnings issued.  Results may not be reliable.

OK, lvrename is not updating the devfs handler in gendisks.  This
patch fixes it.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: kernel-source-2.4/drivers/md/lvm.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/drivers/md/lvm.c,v
retrieving revision 1.1.1.12
diff -u -r1.1.1.12 lvm.c
--- kernel-source-2.4/drivers/md/lvm.c	1 Jun 2003 03:06:25 -0000	1.1.1.12
+++ kernel-source-2.4/drivers/md/lvm.c	29 Jun 2003 05:09:15 -0000
@@ -2697,7 +2697,8 @@
 		{
 			lvm_fs_remove_lv(vg_ptr, lv_ptr);
 			strncpy(lv_ptr->lv_name, lv_req->lv_name, NAME_LEN);
-			lvm_fs_create_lv(vg_ptr, lv_ptr);
+			lvm_gendisk.part[MINOR(lv_ptr->lv_dev)].de =
+				lvm_fs_create_lv(vg_ptr, lv_ptr);
 			break;
 		}
 	}

--vkogqOf2sHV7VnPd--
