Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271823AbRIHX4v>; Sat, 8 Sep 2001 19:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271826AbRIHX4m>; Sat, 8 Sep 2001 19:56:42 -0400
Received: from d117.dhcp212-198-140.noos.fr ([212.198.140.117]:25182 "HELO
	pridamix.molteni.net") by vger.kernel.org with SMTP
	id <S271823AbRIHX4e>; Sat, 8 Sep 2001 19:56:34 -0400
Message-ID: <3B9AB010.8956A5AD@molteni.net>
Date: Sun, 09 Sep 2001 01:56:01 +0200
From: Olivier Molteni <olivier@molteni.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: OOPS in fs/locks.c linux 2.4.9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using a Netapp F820C with Linux 2.4.9 kernel as client.
When I do many concurrents acces with locking  (a strongly modified
vesrion of the cyrus imap deliver agent) I get Oops from kernel.
The real problem for me is not the application but really that my kernel
Oops when locking, it's just that with this apps I can reproduct the bug

each time I try.

I have been looking in kernel archives and news, but I can't find
anything that help me...
I've tried the ac9 kernel which includes several NFS updates, but
unsuccesfully !
I've tryed to mount the filer in NFSV2 and got the same result...

I've seen with ksymoops that the function that is in cause is
locks_delete_lock in fs/locks.c

So I've logged it with printk and found that we entered in
locks_delete_lock with fl == NULL

first I try a simple return if I detect a null fl.
I worked (no more oops) but the problem is not solved, because the
process stay blocked on IO (D)
I would try to use the locks_wake_up_blocks(fl, wait); call, but as fl
is set to NULL, I have no great hope about that !!
So I have to find where the value of the calling fl is set to NULL and
why ...

If somebody could help me, please, let me know !

Best regards,
Olivier Molteni.

The NetApp system revision is :
NetApp Release 6.1.1: Tue Jul 17 03:24:50 PDT 2001

The Oops message is:
Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
c013d6e7
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013d6e7>]
EFLAGS: 00010296
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: f7d77960
esi: 00000004   edi: 00000001   ebp: bfffdb2c   esp: c626ff74
ds: 0018   es: 0018   ss: 0018
Process cyrdeliver (pid: 15652, stackpage=c626f000)
Stack: f7d77960 ed00eac0 c013f048 f7d77960 00000000 ecc895c0 00000000
c012e3f5
       ecc895c0 ed00eac0 00000000 ecc895c0 00000000 ecc895c0 bfffbb2c
c012e447
       ecc895c0 ed00eac0 c626e000 c0106d2b 00000004 00000004 bfffcb2c
bfffbb2c
Call Trace: [<c013f048>] [<c012e3f5>] [<c012e447>] [<c0106d2b>]

Code: 8b 03 89 02 c7 03 00 00 00 00 8b 56 04 8b 43 04 89 50 04 89

When decoding with ksymoops I got:

ksymoops 2.3.4 on i686 2.4.9-ac10.  Options used
     -v vmlinux.1 (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m System.map.1 (specified)

Unable to handle kernel NULL pointer dereference at virtual address
00000000
c013d6e7
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013d6e7>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010296
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: f7d77960
esi: 00000004   edi: 00000001   ebp: bfffdb2c   esp: c626ff74
ds: 0018   es: 0018   ss: 0018
Process cyrdeliver (pid: 15652, stackpage=c626f000)
Stack: f7d77960 ed00eac0 c013f048 f7d77960 00000000 ecc895c0 00000000
c012e3f5
       ecc895c0 ed00eac0 00000000 ecc895c0 00000000 ecc895c0 bfffbb2c
c012e447
       ecc895c0 ed00eac0 c626e000 c0106d2b 00000004 00000004 bfffcb2c
bfffbb2c
Call Trace: [<c013f048>] [<c012e3f5>] [<c012e447>] [<c0106d2b>]
Code: 8b 03 89 02 c7 03 00 00 00 00 8b 56 04 8b 43 04 89 50 04 89

>>EIP; c013d6e7 <locks_delete_lock+b/e8>   <=====
Trace; c013f048 <locks_remove_posix+58/6c>
Trace; c012e3f5 <filp_close+55/64>
Trace; c012e447 <sys_close+43/54>
Trace; c0106d2b <system_call+33/38>
Code;  c013d6e7 <locks_delete_lock+b/e8>
00000000 <_EIP>:
Code;  c013d6e7 <locks_delete_lock+b/e8>   <=====
   0:   8b 03                     mov    (%ebx),%eax   <=====
Code;  c013d6e9 <locks_delete_lock+d/e8>
   2:   89 02                     mov    %eax,(%edx)
Code;  c013d6eb <locks_delete_lock+f/e8>
   4:   c7 03 00 00 00 00         movl   $0x0,(%ebx)
Code;  c013d6f1 <locks_delete_lock+15/e8>
   a:   8b 56 04                  mov    0x4(%esi),%edx
Code;  c013d6f4 <locks_delete_lock+18/e8>
   d:   8b 43 04                  mov    0x4(%ebx),%eax
Code;  c013d6f7 <locks_delete_lock+1b/e8>
  10:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c013d6fa <locks_delete_lock+1e/e8>
  13:   89 00                     mov    %eax,(%eax)


I have tryed these patchs:
2.4.9-ac9
2.4.0-ac10

This one from marc.theaimsgroup.com/?l=linux-kernel&m=99994077910602&w=2

--- fs/locks.c  Fri Sep  7 23:06:49 2001
+++ fs/locks.c.new      Sat Sep  8 01:03:50 2001
@@ -698,6 +698,9 @@
        struct file_lock *new_fl = locks_alloc_lock(0);
        int error;

+       if (new_fl == NULL)
+               return -ENOMEM;
+
        new_fl->fl_owner = current->files;
        new_fl->fl_pid = current->pid;
        new_fl->fl_file = filp;




