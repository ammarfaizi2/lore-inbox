Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267916AbRGWSLc>; Mon, 23 Jul 2001 14:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268322AbRGWSLY>; Mon, 23 Jul 2001 14:11:24 -0400
Received: from cc668399-a.ewndsr1.nj.home.com ([24.180.97.113]:12532 "EHLO
	eriador.mirkwood.net") by vger.kernel.org with ESMTP
	id <S267511AbRGWSLS>; Mon, 23 Jul 2001 14:11:18 -0400
Date: Mon, 23 Jul 2001 14:11:35 -0400 (EDT)
From: PinkFreud <pf-kernel@mirkwood.net>
To: linux-kernel@vger.kernel.org
cc: Gerard Roudier <groudier@club-internet.fr>
Subject: 2.4.6 NCR53C8XX bug?  (was: 2.4.x problems (this is *not* a distribution
 related question!))
Message-ID: <Pine.LNX.4.20.0107231347060.5411-100000@eriador.mirkwood.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

ksymoops seems to point to the ncr53c8xx driver as causing this oops +
panic.

ksymoops 2.4.1 on i586 2.4.6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.6/ (default)
     -m /usr/src/rivendell/linux-2.4.6/System.map (specified)

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel paging request at virtual address 0119c3c1
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01aba03>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010006
eax: c119a7d8   ebx: 0119c3a4     ecx: 0119c2cc       edx: 0000004f
esi: 00000010   edi: c119e000     ebp: 0119c2c4       esp: c4633e9c
ds: 0018   es: 0018   ss: 0018
Process klogd (pid: 88, stackpage=c4633000)
Stack: c119e000 c119e000 0000000b c4633f2c c01ac897 c119e000 c119e000 00000246
       0000000b c4633f2c c4633ee8 00000286 c4666300 c01ae8ae c119e000 c11e7460
       04000001 0000000b c0107c8f 0000000b c119e000 c4633f2c 00000160 c029fa60
Call Trace: [<c01ac897>] [<c01ae8ae>] [<c0107c8f>] [<c0107dee>] [<c0106b60>] [<c0110062>] [<c01463d5>]
       [<c012b376>] [<c0106ac3>]
Code: 8a 43 1d 84 c0 7d 09 53 57 e8 5f f9 ff ff eb 0e a9 20 00 00

>>EIP; c01aba03 <ncr_wakeup_done+53/a4>   <=====
Trace; c01ac897 <ncr_exception+4f/314>
Trace; c01ae8ae <ncr53c8xx_intr+26/7c>
Trace; c0107c8f <handle_IRQ_event+2f/58>
Trace; c0107dee <do_IRQ+6e/b0>
Trace; c0106b60 <ret_from_intr+0/7>
Trace; c0110062 <do_syslog+142/304>
Trace; c01463d5 <kmsg_read+11/18>
Trace; c012b376 <sys_read+96/cc>
Trace; c0106ac3 <system_call+33/40>
Code;  c01aba03 <ncr_wakeup_done+53/a4>
0000000000000000 <_EIP>:
Code;  c01aba03 <ncr_wakeup_done+53/a4>   <=====
   0:   8a 43 1d                  mov    0x1d(%ebx),%al   <=====
Code;  c01aba06 <ncr_wakeup_done+56/a4>
   3:   84 c0                     test   %al,%al
Code;  c01aba08 <ncr_wakeup_done+58/a4>
   5:   7d 09                     jge    10 <_EIP+0x10> c01aba13 <ncr_wakeup_done+63/a4>
Code;  c01aba0a <ncr_wakeup_done+5a/a4>
   7:   53                        push   %ebx
Code;  c01aba0b <ncr_wakeup_done+5b/a4>
   8:   57                        push   %edi
Code;  c01aba0c <ncr_wakeup_done+5c/a4>
   9:   e8 5f f9 ff ff            call   fffff96d <_EIP+0xfffff96d> c01ab370 <ncr_complete+0/5a0>
Code;  c01aba11 <ncr_wakeup_done+61/a4>
   e:   eb 0e                     jmp    1e <_EIP+0x1e> c01aba21 <ncr_wakeup_done+71/a4>
Code;  c01aba13 <ncr_wakeup_done+63/a4>
  10:   a9 20 00 00 00            test   $0x20,%eax

Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.


I'm not sure why the warning is there:

root@rivendell:/usr/src/rivendell# ksyms -a | grep shmem_file_setup
c0129b28  __VERSIONED_SYMBOL(shmem_file_setup)
root@rivendell:/usr/src/rivendell# grep c0129b28 linux-2.4.6/System.map      
00000000c0129b28 T shmem_file_setup


In any case, I suspect the above is correct, despite the warning - if it's
not, please let me know.


Card I'm using this with:

root@rivendell:/usr/src/rivendell# cat /proc/scsi/ncr53c8xx/0 
  Chip NCR53C810, device id 0x1, revision id 0x2
  On PCI bus 0, device 6, function 0, IRQ 11
  Synchronous period factor 25, max commands per lun 32


	Mike Edwards

Brainbench certified Master Linux Administrator
http://www.brainbench.com/transcript.jsp?pid=158188
-----------------------------------
Unsolicited advertisments to this address are not welcome.

---------- Forwarded message ----------
Date: Sat, 21 Jul 2001 20:51:30 -0400 (EDT)
From: PinkFreud <pf-kernel@mirkwood.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.x problems (this is *not* a distribution related question!)

Sorry, all.  I realized that my last email seemed to resemble a
distribution question - it's not.  This is about two seperate problems I'm
experiencing under 2.4.x kernels.  The distributions were just mentioned
to illustrate the differences between installs.

If anyone has any ideas on either problem, I'd be more than interested in
seeing them.

Again, I am not subscribed to this list, so please CC me on any replies.

Thanks.


	Mike Edwards

Brainbench certified Master Linux Administrator
http://www.brainbench.com/transcript.jsp?pid=158188
-----------------------------------
Unsolicited advertisments to this address are not welcome.

---------- Forwarded message ----------
Date: Fri, 20 Jul 2001 13:26:12 -0400 (EDT)
From: PinkFreud <pf-kernel@mirkwood.net>
To: linux-kernel@vger.kernel.org
Subject: two seperate 2.4.x problems...

I am not subscribed to this list, so please CC me in any replies.  Thank 
you.


Hey, all.  I have two entirely seperate problems with 2.4.x kernels, on
two seperate systems.

The first occurs on a UDB (Digital Multia, model VX-51, Intel Pentium
100).  I recently installed Slackware 8.0, which includes 2.4.5.  Within a
day of installing, the kernel paniced.  I did not get a chance to save the
text of the oops.  The second time this happened was early this morning,
within a couple hours after a reboot (under 2.4.6).  Text of the oops and
panic are included below (note that this seems similar to the first one -
I noted, at least, that klogd seems to be listed as the culprit in both
cases).

Unable to handle kernel paging request at virtual address 0119c3c1
*pde = 00000000
Oops: 0000
CPU:	0
EIP:	0010:[<c01aba03>]
EFLAGS: 00010006
eax: c119a7d8	ebx: 0119c3a4	ecx: 0119c2cc	edx: 0000004f
esi: 00000010	edi: c119e000	ebp: 0119c2c4	esp: c4633e9c
ds: 0018   es: 0018   ss: 0018
Process klogd (pid: 88, stackpage=c4633000)
Stack: c119e000 c119e000 0000000b c4633f2c c01ac897 c119e000 c119e000 00000246
       0000000b c4633f2c c4633ee8 00000286 c4666300 c01ae8ae c119e000 c11e7460
       04000001 0000000b c0107c8f 0000000b c119e000 c4633f2c 00000160 c029fa60
Call Trace: [<c01ac897>] [<c01ae8ae>] [<c0107c8f>] [<c0107dee>] [<c0106b60>] [<c0110062>] [<c01463d5>]
       [<c012b376>] [<c0106ac3>]

Code: 8a 43 1d 84 c0 7d 09 53 57 e8 5f f9 ff ff eb 0e a9 20 00 00
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

I had to copy this from the screen, so I *may* have typoed some of the
addresses - but I think I got them right.

I previously ran Slackware 7.1 on this system (2.2.16 followed by 2.2.19,
I believe) with no adverse effects.  The problems only started to happen
when I installed Slackware 8.0, and, by extension, the 2.4.x kernels.  I
have not tried 2.2.19 under Slackware 8.0 yet.


The other problem I've been experiencing has to do with SMP and XFree86
4.x.x.  I believe this to be an XFree86 problem, but as they have yet to
respond after several requests for help, and due to the nature of the
problem, it may very well be kernel related.

On a SMP system (dual PIII/1 ghz, VIA chipset) running 2.4.x
(anything up to 2.4.6) kernels and XFree86 4.x.x (I've tried 4.0.1 up to
the current 4.1.0), I can pretty reliably cause the system to lock up.  I
simply start X, switch to a text console, and back to X.  The box locks
up, no keyboard, mouse, or network, and the display is blank.  Only thing
I can do is hit the reset button.  Obviously in such a situation, there
aren't any visible errors, nor are any able to be logged, as nothing is
actually written to disk by the time of the crash.  Under a uniprocessor
kernel, the lockup does *NOT* occur.

Again, I don't know if this is necessarily a kernel problem - trying the
same thing with svgalib doesn't seem to have any adverse effects.


Any help would be *greatly* appreciated.

Thanks!


	Mike Edwards

Brainbench certified Master Linux Administrator
http://www.brainbench.com/transcript.jsp?pid=158188
-----------------------------------
Unsolicited advertisments to this address are not welcome.



