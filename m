Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131197AbRBDJyk>; Sun, 4 Feb 2001 04:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131522AbRBDJyb>; Sun, 4 Feb 2001 04:54:31 -0500
Received: from [62.122.17.207] ([62.122.17.207]:61448 "EHLO penny")
	by vger.kernel.org with ESMTP id <S131197AbRBDJyM>;
	Sun, 4 Feb 2001 04:54:12 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.1 segfault when doing "ls /dev/"
Reply-To: Pierfrancesco Caci <p.caci@tin.it>
From: Pierfrancesco Caci <ik5pvx@penny.ik5pvx.ampr.org>
Date: 04 Feb 2001 10:58:34 +0100
Message-ID: <87u26avkfp.fsf@penny.ik5pvx.ampr.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It happened with 2.4.0, it continues to happen with 2.4.1 too

root@penny:~ # ps -ax|grep devfs
   48 ?        S      0:00 /sbin/devfsd /dev
 6300 pts/0    S      0:00 grep devfs
root@penny:~ # cd /dev
root@penny:/dev # ls
Segmentation fault
root@penny:/dev # ps -ax|grep devfs
 6309 pts/0    S      0:00 grep devfs
root@penny:/dev # 

>From now on, I get a segfault whenever I try to see what's inside /dev
but I can see what's _below_ /dev/, supposing I know where to look:

root@penny:/dev # ls scsi
host0
root@penny:/dev # ls tts
0  1


Here's the output of ksymoops:


Feb  4 10:28:57 penny kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Feb  4 10:28:57 penny kernel: c013b1c9
Feb  4 10:28:57 penny kernel: *pde = 00000000
Feb  4 10:28:57 penny kernel: CPU:    0
Feb  4 10:28:57 penny kernel: EIP:    0010:[vfs_follow_link+33/348]
Feb  4 10:28:57 penny kernel: EFLAGS: 00010217
Feb  4 10:28:57 penny kernel: eax: 00000000   ebx: c7ae9fa4   ecx: 00000735   edx: c0320a60
Feb  4 10:28:57 penny kernel: esi: 00000000   edi: 00000000   ebp: 00000000   esp: c7ae9f10
Feb  4 10:28:57 penny kernel: ds: 0018   es: 0018   ss: 0018
Feb  4 10:28:57 penny kernel: Process devfsd (pid: 48, stackpage=c7ae9000)
Feb  4 10:28:57 penny kernel: Stack: c7ae9fa4 00000000 c3aea960 c7ae9fa4 00000000 c015a703 c7ae9fa4 00000000 
Feb  4 10:28:57 penny kernel:        c7ae8000 c0138db9 c3aea960 c7ae9fa4 c69c87e0 c2e4e000 00000000 c7ae9fa4 
Feb  4 10:28:57 penny kernel:        00000000 00000001 00000000 c7ae9fa8 00000009 c3aea960 c2e4e005 00000004 
Feb  4 10:28:57 penny kernel: Call Trace: [devfs_follow_link+31/36] [path_walk+1701/1964] [__user_walk+60/88] [sys_chown+22/72] [system_call+51/56] [startup_32+43/313] 
Feb  4 10:28:57 penny kernel: Code: 80 3f 2f 0f 85 c2 00 00 00 53 e8 b0 d2 ff ff ba 00 e0 ff ff 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
0000000000000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   80 3f 2f                  cmpb   $0x2f,(%edi)
Code;  00000003 Before first symbol
   3:   0f 85 c2 00 00 00         jne    cb <_EIP+0xcb> 000000cb Before first symbol
Code;  00000009 Before first symbol
   9:   53                        push   %ebx
Code;  0000000a Before first symbol
   a:   e8 b0 d2 ff ff            call   ffffd2bf <_EIP+0xffffd2bf> ffffd2bf <END_OF_CODE+356a3187/????>
Code;  0000000f Before first symbol
   f:   ba 00 e0 ff ff            mov    $0xffffe000,%edx

Feb  4 10:28:57 penny kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Feb  4 10:28:57 penny kernel: c013b1c9
Feb  4 10:28:57 penny kernel: *pde = 00000000
Feb  4 10:28:57 penny kernel: Oops: 0000
Feb  4 10:28:57 penny kernel: CPU:    0
Feb  4 10:28:57 penny kernel: EIP:    0010:[vfs_follow_link+33/348]
Feb  4 10:28:57 penny kernel: EFLAGS: 00010217
Feb  4 10:28:57 penny kernel: eax: 00000000   ebx: c39b3fa4   ecx: 00000735   edx: c0320a60
Feb  4 10:28:57 penny kernel: esi: c3aea0e0   edi: 00000000   ebp: 00000000   esp: c39b3f10
Feb  4 10:28:57 penny kernel: ds: 0018   es: 0018   ss: 0018
Feb  4 10:28:57 penny kernel: Process ls (pid: 6303, stackpage=c39b3000)
Feb  4 10:28:57 penny kernel: Stack: c39b3fa4 c3aea0e0 c3aea0e0 c39b3fa4 00000000 c015a703 c39b3fa4 00000000 
Feb  4 10:28:57 penny kernel:        c39b2000 c0138db9 c3aea0e0 c39b3fa4 c69c87e0 c31c4000 00000000 c39b3fa4 
Feb  4 10:28:57 penny kernel:        00000002 00000001 00000002 c01382ea 00000009 c3aea0e0 c31c4000 00000004 
Feb  4 10:28:57 penny kernel: Call Trace: [devfs_follow_link+31/36] [path_walk+1701/1964] [getname+90/152] [__user_walk+60/88] [sys_stat64+22/120] [system_call+51/56] 
Feb  4 10:28:57 penny kernel: Code: 80 3f 2f 0f 85 c2 00 00 00 53 e8 b0 d2 ff ff ba 00 e0 ff ff 

Code;  00000000 Before first symbol
0000000000000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   80 3f 2f                  cmpb   $0x2f,(%edi)
Code;  00000003 Before first symbol
   3:   0f 85 c2 00 00 00         jne    cb <_EIP+0xcb> 000000cb Before first symbol
Code;  00000009 Before first symbol
   9:   53                        push   %ebx
Code;  0000000a Before first symbol
   a:   e8 b0 d2 ff ff            call   ffffd2bf <_EIP+0xffffd2bf> ffffd2bf <END_OF_CODE+356a3187/????>
Code;  0000000f Before first symbol
   f:   ba 00 e0 ff ff            mov    $0xffffe000,%edx


root@penny:/usr/src/linux/scripts # . ver_linux 
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux penny 2.4.1 #1 Sat Feb 3 20:43:54 CET 2001 i686 unknown
Kernel modules         2.4.1
Gnu C                  2.95.3
Gnu Make               3.79.1
Binutils               2.10.1.0.2
Linux C Library        2.2.1
Dynamic linker         ldd (GNU libc) 2.2.1
Procps                 2.0.7
Mount                  2.10q
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         rd sb sb_lib uart401 nfs mousedev hid input ipv6 nfsd lockd sunrpc af_packet eepro100 3c509 awe_wave opl3 sound soundcore isa-pnp uhci usbcore ipchains

root@penny:/usr/src/linux/scripts # dpkg -l devfsd
ii  devfsd         1.3.10-5       Daemon for the device filesystem


Pf


-- 

-------------------------------------------------------------------------------
 Pierfrancesco Caci | ik5pvx | mailto:p.caci@tin.it  -  http://gusp.dyndns.org
  Firenze - Italia  | Office for the Complication of Otherwise Simple Affairs 
     Linux penny 2.4.1 #1 Sat Feb 3 20:43:54 CET 2001 i686 unknown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
