Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266038AbUHARAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266038AbUHARAW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 13:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266034AbUHARAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 13:00:21 -0400
Received: from email.archlab.tuwien.ac.at ([128.131.118.17]:44731 "EHLO
	email.archlab.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S265977AbUHAQ7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 12:59:48 -0400
Date: Sun, 1 Aug 2004 18:59:46 +0200
To: linux-kernel@vger.kernel.org
Subject: XFS: Oops in 2.4.26 and 2.4.27-rc4
Message-ID: <20040801165946.GA1045@email.archlab.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Cahya Wirawan <cwirawan@email.archlab.tuwien.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Last week I have reported Oops with latest kernel 2.6.7 , it turns out
that XFS can't work with 4K stacks, so I decided not to use kernel 2.6
at the moment. Now I am trying to use kernel 2.4.26, and actually I
expected that it is more stable than the kernel 2.6 , but after I 
made the same stress test like I did with 2.6 (ltp.sf.net), this kernel
2.4.26 and 2.4.27-rc4 get an Oops again. The server will not always
crash, but it gets always an Oops at the same test (diotest4), and it is
reproducible in 3 pc (intel notebook, amd pc, and double xeon processor
server). Following is Oops from amd pc:

# Using vanilla kernel. AMD cpu, smp disabled.
ksymoops 2.4.9 on i686 2.4.26.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.26/ (default)
     -m /usr/src/linux-2.4.26/System.map (specified)
 
Unable to handle kernel NULL pointer dereference at virtual address 0000002c
c01fd83b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01fd83b>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010207
eax: 00000000   ebx: 00001000   ecx: 00001000   edx: c2fec400
esi: 00000000   edi: 00001000   ebp: cd889e80   esp: cd889df0
ds: 0018   es: 0018   ss: 0018
Process diotest4 (pid: 6185, stackpage=cd889000)
Stack: d5891bdc 0000d000 00000000 00000010 cd889e44 00000021 00000002 cd889e80 
00001000 d5891bc0 00001000 0000d000 00000000 ffff6000 ffff4000 00000002 
00000021 04400001 00000000 00000000 c2fec400 ffffffff ffffffff d6c13b00 
Call Trace:    [<c012eb04>] [<c0130e40>] [<c02013e1>] [<c01fdaeb>] [<c013cf2c>]
[<c0108fff>]
Code: 8b 46 2c 8b 4d bc 8d 3c 01 89 d9 31 c0 c1 e9 02 f3 ab f6 c3 


>>EIP; c01fd83b <linvfs_direct_IO+16b/370>   <=====

>>edx; c2fec400 <_end+2b81420/186e9080>
>>ebp; cd889e80 <_end+d41eea0/186e9080>
>>esp; cd889df0 <_end+d41ee10/186e9080>

Trace; c012eb04 <generic_file_direct_IO+264/2c0>
Trace; c0130e40 <do_generic_direct_read+40/60>
Trace; c02013e1 <xfs_read+151/2c0>
Trace; c01fdaeb <linvfs_read+ab/c0>
Trace; c013cf2c <sys_read+9c/130>
Trace; c0108fff <system_call+33/38>

Code;  c01fd83b <linvfs_direct_IO+16b/370>
00000000 <_EIP>:
Code;  c01fd83b <linvfs_direct_IO+16b/370>   <=====
   0:   8b 46 2c                  mov    0x2c(%esi),%eax   <=====
Code;  c01fd83e <linvfs_direct_IO+16e/370>
   3:   8b 4d bc                  mov    0xffffffbc(%ebp),%ecx
Code;  c01fd841 <linvfs_direct_IO+171/370>
   6:   8d 3c 01                  lea    (%ecx,%eax,1),%edi
Code;  c01fd844 <linvfs_direct_IO+174/370>
   9:   89 d9                     mov    %ebx,%ecx
Code;  c01fd846 <linvfs_direct_IO+176/370>
   b:   31 c0                     xor    %eax,%eax
Code;  c01fd848 <linvfs_direct_IO+178/370>
   d:   c1 e9 02                  shr    $0x2,%ecx
Code;  c01fd84b <linvfs_direct_IO+17b/370>
  10:   f3 ab                     repz stos %eax,%es:(%edi)
Code;  c01fd84d <linvfs_direct_IO+17d/370>
  12:   f6 c3 00                  test   $0x0,%bl


And I save another Oops messages in this url:
SMP server (with gentoo patch): http://s2.enemy.org/~cahya/Oops.0.txt
AMD pc (with gentoo patch):     http://s2.enemy.org/~cahya/Oops.1.txt
AMD pc (vanilla kernel):        http://s2.enemy.org/~cahya/Oops.2.txt
AMD pc (kernel 2.4.27-rc4):     http://s2.enemy.org/~cahya/Oops.3.txt
But they all have about the same call trace.

Thanks,
Cahya.
