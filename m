Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275504AbRJAU2l>; Mon, 1 Oct 2001 16:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275511AbRJAU2c>; Mon, 1 Oct 2001 16:28:32 -0400
Received: from winds.org ([209.115.81.9]:21778 "EHLO winds.org")
	by vger.kernel.org with ESMTP id <S275506AbRJAU2Y>;
	Mon, 1 Oct 2001 16:28:24 -0400
Date: Mon, 1 Oct 2001 16:28:52 -0400 (EDT)
From: Byron Stanoszek <gandalf@winds.org>
To: <linux-kernel@vger.kernel.org>
Subject: [Oops] on remounting root device in 2.4.9-ac10
Message-ID: <Pine.LNX.4.33.0110011614060.11434-100000@winds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote this little snippet of code in init/main.c for an embedded system back
in the days of the 2.2 kernel. This runs the /linuxrc program off of an NFS
root mount, which uncompresses an ext2 image to /dev/ram0. When linuxrc
finishes, the kernel remounts root as /dev/ram0. The snippet:

#ifdef CONFIG_BLK_DEV_INITRD

        /* Run /linuxrc script */
        pid = kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
        if (pid > 0)
                while (pid != wait(&i));

        /* Remount /dev/ram0 as root */
        real_root_dev = MKDEV(1,0);
        root_mountflags = MS_SYNCHRONOUS;
        if ((error = change_root(real_root_dev, "/initrd")))
                printk(KERN_ERR "Change root to /initrd: error %d\n", error);

#endif

This used to work just fine in 2.2, but it gives the following oops in
kernel 2.4.9-ac10:


change_root: old root has d_count=2
Unable to handle kernel NULL pointer reference at virtual address 0000000c
c0131178
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0131178>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000001   ebx: 00000000   ecx: 00000018   edx: c123e2e0
esi: 00000000   edi: c123e2a0   ebp: fffffffed  esp: c12fde50
ds: 0018   es: 0018   ss: 0018
Process swapper (pid:1, stackpage=c12fd000)
Stack: c12fdf7c 00000000 c123e2a0 c12fdfb4 00000001 00000400 00000800 c7ee3000
       c7eef400 c7ee66e0 c01472dd c121b45c 00000000 c0147573 c7ee66e0 c01473cd
       00000000 c7ee66e0 c1235420 c12356a0 c121b45c 00000001 00000000 00000010
Call Trace: [<c01472dd>] [<c0147573>] [<c01475cd>] [<c014764a>] [<c014a03e>]
   [<c0133deb>] [<c0133d25>] [<c0134590>] [<c0115626>] [<c0106cbb>]
[<c01051e1>]
   [<c010520c>] [<c0105624>]
Code: 0f b7 43 0c 89 c2 0f b6 d2 c1 f8 08 89 e6 c1 c6 08 09 d6 ff

>>EIP; c0131178 <blkdev_get+24/114>   <=====
Trace; c01472dc <ext2_get_page+50/78>
Trace; c0147572 <ext2_find_entry+6a/f8>
Trace; c01475cc <ext2_find_entry+c4/f8>
Trace; c014764a <ext2_inode_by_name+1a/38>
Trace; c014a03e <ext2_lookup+5e/68>
Trace; c0133dea <real_lookup+52/c4>
Trace; c0133d24 <path_release+c/2c>
Trace; c0134590 <path_walk+664/674>
Trace; c0115626 <sys_waitpid+16/20>
Trace; c0106cba <system_call+32/38>
Trace; c01051e0 <prepare_namespace+d4/f4>
Trace; c010520c <init+c/110>
Trace; c0105624 <kernel_thread+28/38>
Code;  c0131178 <blkdev_get+24/114>
00000000 <_EIP>:
Code;  c0131178 <blkdev_get+24/114>   <=====
   0:   0f b7 43 0c               movzwl 0xc(%ebx),%eax   <=====
Code;  c013117c <blkdev_get+28/114>
   4:   89 c2                     mov    %eax,%edx
Code;  c013117e <blkdev_get+2a/114>
   6:   0f b6 d2                  movzbl %dl,%edx
Code;  c0131180 <blkdev_get+2c/114>
   9:   c1 f8 08                  sar    $0x8,%eax
Code;  c0131184 <blkdev_get+30/114>
   c:   89 e6                     mov    %esp,%esi
Code;  c0131186 <blkdev_get+32/114>
   e:   c1 c6 08                  rol    $0x8,%esi
Code;  c0131188 <blkdev_get+34/114>
  11:   09 d6                     or     %edx,%esi
Code;  c013118a <blkdev_get+36/114>
  13:   ff 00                     incl   (%eax)


I don't know the filesystem code well enough to determine where the real error
is, but it appears to be a standard bug in remounting root to ramdisk. (The
exact change to main.c is to supply a real_root_dev of 0x0100 instead of
getting it from the kernel command line--nothing else is changed).

If anyone has any pointers or has seen this problem before, let me know!

Thanks,
 -Byron Stanoszek

-- 
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com

