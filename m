Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293053AbSCWNTN>; Sat, 23 Mar 2002 08:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293060AbSCWNTE>; Sat, 23 Mar 2002 08:19:04 -0500
Received: from mailhost.teleline.es ([195.235.113.141]:65329 "EHLO
	tsmtp10.mail.isp") by vger.kernel.org with ESMTP id <S293053AbSCWNSt>;
	Sat, 23 Mar 2002 08:18:49 -0500
Date: Sat, 23 Mar 2002 14:19:19 +0100
From: Diego Calleja <DiegoCG@teleline.es>
To: linux-kernel@vger.kernel.org
Subject: Reproducible oops in 2.5.7-pre2
Message-Id: <20020323141920.2ccd858e.DiegoCG@teleline.es>
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This oops happens _always_ when I try to boot with 2.4.7-pre2. It happens just after:
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0
found reiserfs format "3.6" with standard journal
This is the oops:


command line of ksymoops: ksymoops --no-ksyms --no-lsmod -o /lib/modules/2.5.7-pre2 -m /boot/System.map-2.5.7-pre2

ksymoops 2.4.3 on i686 2.4.19-pre3-ac5.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.5.7-pre2/ (specified)
     -m /boot/System.map-2.5.7-pre2 (specified)

No modules in ksyms, skipping objects
Unable to handle kernel NULL pointer dereference at virtual address 00000010
 c0135800
Oops: 0000
CPU: 0
EIP:    0010:[<c0135800>]       Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00001000   ebx: 0000000a   ecx: 00000004   edx: 00000000
esi: 00000004   edi: 00002012   ebp: 00000000   esp: c1069d6c
ds: 0018        es: 0018        ss: 0018
Stack: 00001000 00002012 00000000 c1fabc00 c1fabc00 c0135eff 00000000 00002012
       00001000 c1fabc00 c2800000 c28113ec c0136107 00000000 00002012 00001000
       c1fabc00 c0172a09 00000000 00002012 00001000 00000400 00000000 c1fabd54
Call Trace: [<c0135eff>] [<c0136107>] [<c0172a09>] [<c0134fb0>] [<c0164cef>]
    [<c0165604>] [<c017c120>] [<c013ad79>] [<c0139a24>] [<c01659e7>] 
   [<c01654d8>] [<c0139bf2>] [c014a549>] [<c014a800>] [<c014a664>] 
    [<c014ac34>] [<c01f1606>] [<c0105269>] [<c016507f>] [<c0105614>]
Code: 66 8b 45 10 b0 00 8a 55 10 01 d0 25 ff ff 00 00 89 44 24 10

>>EIP; c0135800 <__get_hash_table+1c/c4>   <=====
Trace; c0135efe <__getblk+16/3c>
Trace; c0136106 <__bread+16/70>
Trace; c0172a08 <journal_init+f0/6ac>
Trace; c0134fb0 <__wait_on_buffer+84/90>
Trace; c0164cee <read_bitmaps+d2/174>
Trace; c0165604 <reiserfs_fill_super+12c/4a0>
Trace; c017c120 <sprintf+14/18>
Trace; c013ad78 <bdevname+30/3a>
Trace; c0139a24 <get_sb_bdev+1cc/230>
Trace; c01659e6 <reiserfs_get_sb+1e/24>
Trace; c01654d8 <reiserfs_fill_super+0/4a0>
Trace; c0139bf2 <do_kern_mount+4a/c4>
Trace; c014ac34 <sys_mount+a4/114>
Trace; c01f1606 <inet_dump_ifaddr+10e/17c>
Trace; c0105268 <prepare_namespace+a8/e0>
Trace; c016507e <read_super_block+1ca/1cc>
Trace; c0105614 <kernel_thread+28/38>
Code;  c0135800 <__get_hash_table+1c/c4>
00000000 <_EIP>:
Code;  c0135800 <__get_hash_table+1c/c4>   <=====
   0:   66 8b 45 10               mov    0x10(%ebp),%ax   <=====
Code;  c0135804 <__get_hash_table+20/c4>
   4:   b0 00                     mov    $0x0,%al
Code;  c0135806 <__get_hash_table+22/c4>
   6:   8a 55 10                  mov    0x10(%ebp),%dl
Code;  c0135808 <__get_hash_table+24/c4>
   9:   01 d0                     add    %edx,%eax
Code;  c013580a <__get_hash_table+26/c4>
   b:   25 ff ff 00 00            and    $0xffff,%eax
Code;  c0135810 <__get_hash_table+2c/c4>
  10:   89 44 24 10               mov    %eax,0x10(%esp,1)

Kernel panic: Attempted to kill init!

Another thing with 2.5.7-pre2 kernel is that i can't compile it without having nfs server sopport enabled.
This is the error:
arch/i386/kernel/kernel.o: In function 'sys_call_table':
arch/i386/kernel/kernel.o(.data+0x304): undefined reference to 'sys_nfsservctl'
make: *** [vmlinux] Error 1

I think the problem is in include/linux/nfsd/syscall.h:

/*
 * Kernel syscall implementation
 */
#if defined(CONFIG_NFSD) || defined(CONFIG_NFSD_MODULE)
extern asmlinkage long sys_nfsservctl(int, struct nfsctl_arg *, void);
#else
#define sys_nsfservctl		sys_ni_syscall
#endif



