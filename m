Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbTLSMCD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 07:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbTLSMCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 07:02:03 -0500
Received: from gaia.cela.pl ([213.134.162.11]:13069 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S262746AbTLSMB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 07:01:58 -0500
Date: Fri, 19 Dec 2003 13:01:49 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.23: BUG at inode.c:589! on ext3 during umount
Message-ID: <Pine.LNX.4.44.0312191233410.23932-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.4.23-rc5 (which is 2.4.23) with slight non-fs related patches.
Running on Toshiba Satellite 2590CDT Notebook, Celeron 400 + 192 MB ram.
.config available on request.

On a system running for weeks after stopping almost all processes (5 or 6 
left), unloading almost all modules (ipv6, binfmt_misc, ipchains 
left), umounting almost all filesystems - remaining: tmpfs on /,
devfs on /dev, procfs on /proc, ext3(hda4) on /sysroot.

Running umount /sysroot results in umount segfaulting and the following
oops. The umount however succeeds - but the console umount was run on
cannot be dealloced (lsof shows no-one accessing it).  e2fsck /dev/hda4
replayed the journal (nothing in it, but took _long_), and states the fs
is clean.  mount /sysroot hangs (not because of fs errors, mounts fine
after reboot).

Furthermore devfs /dev/vcc/{1,11} (system console and console umount was 
run on) no longer exist after dealloctvt {1,11} (which reports 
failure, 1: system console, 11: in use) while Alt+F{1,11} can 
still switch to these consoles and display their proper contents.

the bug happens @ fs/inode.c:

void clear_inode(struct inode *inode) {
  invalidate_inode_buffers(inode);
  if (inode->i_data.nrpages)
!   BUG();
  ...

Cheers,
MaZe.

---------------------------------------------------------------

ksymoops 2.4.5 on i686 2.4.23-rc5-athena.  Options used
     -V (specified)
     -k /proc/ksyms (specified)
     -L (specified)
     -o /lib/modules/2.4.23-rc5-athena/ (specified)
     -m /boot/System.map-2.4.23-rc5-athena (specified)

Warning (compare_maps): mismatch on symbol do_special  , ksyms_base says c01ac090, System.map says c019b750.  Ignoring ksyms_base entry
Kernel BUG at inode.c:589!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c014f8da>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: cbbc6060   ebx: cbbc6040   ecx: 3fe2d061   edx: cbbc6060
esi: cbbc6040   edi: c138bf58   ebp: 00000121   esp: c138bf20
ds: 0018   es: 0018   ss: 0018
Process umount (pid: 20000, stackpage=c138b000)
Stack: cbbc6040 cbbc6048 c014f9ed cbbc6040 00000000 00000000 cbf0fc64 00000001
       c138bf58 bffffa88 c014fb7d c138bf58 cbf0fc00 c138bf58 cbbc6228 cbc24de8
       cbf0fc00 cbf0fc44 c0247160 c013ff1a cbf0fc00 00000000 c138bf8c 0804df38
Call Trace:    [<c014f9ed>] [<c014fb7d>] [<c013ff1a>] [<c01525cf>] [<c012a3a2>]
  [<c0152635>] [<c0109075>]
Code: 0f 0b 4d 02 9d 07 22 c0 8b 83 08 01 00 00 a8 10 75 08 0f 06


>>EIP; c014f8da <clear_inode+1a/e0>   <=====

>>eax; cbbc6060 <_end+b9037c8/c53f7c8>
>>ebx; cbbc6040 <_end+b9037a8/c53f7c8>
>>ecx; 3fe2d061 Before first symbol
>>edx; cbbc6060 <_end+b9037c8/c53f7c8>
>>esi; cbbc6040 <_end+b9037a8/c53f7c8>
>>edi; c138bf58 <_end+10c96c0/c53f7c8>
>>esp; c138bf20 <_end+10c9688/c53f7c8>

Trace; c014f9ed <dispose_list+4d/b0>
Trace; c014fb7d <invalidate_inodes+7d/90>
Trace; c013ff1a <kill_super+8a/110>
Trace; c01525cf <sys_umount+3f/90>
Trace; c012a3a2 <sys_munmap+42/70>
Trace; c0152635 <sys_oldumount+15/20>
Trace; c0109075 <ret+0/f>

Code;  c014f8da <clear_inode+1a/e0>
00000000 <_EIP>:
Code;  c014f8da <clear_inode+1a/e0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c014f8dc <clear_inode+1c/e0>
   2:   4d                        dec    %ebp
Code;  c014f8dd <clear_inode+1d/e0>
   3:   02 9d 07 22 c0 8b         add    0x8bc02207(%ebp),%bl
Code;  c014f8e3 <clear_inode+23/e0>
   9:   83 08 01                  orl    $0x1,(%eax)
Code;  c014f8e6 <clear_inode+26/e0>
   c:   00 00                     add    %al,(%eax)
Code;  c014f8e8 <clear_inode+28/e0>
   e:   a8 10                     test   $0x10,%al
Code;  c014f8ea <clear_inode+2a/e0>
  10:   75 08                     jne    1a <_EIP+0x1a>
Code;  c014f8ec <clear_inode+2c/e0>
  12:   0f 06                     clts   


1 warning issued.  Results may not be reliable.

--------------------------------------

no idea why that single warning was issued - nothing was changed and 
do_special is in the keyboard code if I'm not mistaken and isn't in any 
module...

