Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273065AbRJYMpD>; Thu, 25 Oct 2001 08:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273255AbRJYMoy>; Thu, 25 Oct 2001 08:44:54 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:55223 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S273065AbRJYMoh>; Thu, 25 Oct 2001 08:44:37 -0400
Message-ID: <XFMail.20011025144450.R.Oehler@GDImbH.com>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Thu, 25 Oct 2001 14:44:50 +0200 (MEST)
Reply-To: R.Oehler@GDImbH.com
From: R.Oehler@GDImbH.com
To: andrewm@uow.edu.au
Subject: Linux 2.4.10: printk() deadlocks
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, andrew,


currently I'm porting our WORM filesystem (OWFS) from kernel
2.4.0 to kernel 2.4.10. I'm used to rely on printk() to be callable
from every place in the kernel, but now I experience deadlocks
when calling it from some places within our filesystem.
(I'm writing a ~600 lines in 2 seconds and I enlarged the buffer size
to 1MB, what worked perfectly in the past.)
The call-chain is:

    EBP       EIP         Function(args)
0xc14dfdd0 0xc01157d4 printk+0xf4 (0xd0876fc1, 0xc14dff24, 0xe7, 0xc14dfe20, 0xc14dfe20)
                               kernel .text 0xc0100000 0xc01156e0 0xc01157f4
0xc14dff74 0xd086a6f8 [OWFS]OwDebugPrintI+0x218 (0xcc5bcde0, 0x100f, 0xd0878100, 0x40000014, 0x8)
                               OWFS .text 0xd0867060 0xd086a4e0 0xd086a724
0xc14dffb0 0xd086c04b [OWFS]OWFS_write_inode+0x10f (0xcc5bcde0, 0x0)
                               OWFS .text 0xd0867060 0xd086bf3c 0xd086c080
0xc14dffd0 0xc0145f1b sync_unlocked_inodes+0xe3
                               kernel .text 0xc0100000 0xc0145e38 0xc0145fd8
0xc14dffd8 0xc0136c0c sync_old_buffers+0x8
                               kernel .text 0xc0100000 0xc0136c04 0xc0136c48
0xc14dffec 0xc0136e9b kupdate+0xe7
                               kernel .text 0xc0100000 0xc0136db4 0xc0136ea0
           0xc01054c0 kernel_thread+0x28
                               kernel .text 0xc0100000 0xc0105498 0xc01054d0

0xc01157c0 printk+0xe0 decl   0xc028331c
0xc01157c6 printk+0xe6 js     0xc01ef070 stext_lock+0x1d0
0xc01157cc printk+0xec xor    %eax,%eax
0xc01157ce printk+0xee test   %eax,%eax
0xc01157d0 printk+0xf0 jne    0xc01157e5 printk+0x105
0xc01157d2 printk+0xf2 push   %esi
0xc01157d3 printk+0xf3 popf   
0xc01157d4 printk+0xf4 movl   $0x0,0xc03b3120
0xc01157de printk+0xfe call   0xc0115838 release_console_sem
0xc01157e3 printk+0x10 3jmp    0xc01157e7 printk+0x107
0xc01157e5 printk+0x10 5push   %esi
0xc01157e6 printk+0x10 6popf   
0xc01157e7 printk+0x10 7lea    0xfffffff4(%ebp),%esp
0xc01157ea printk+0x10 amov    %edi,%eax
0xc01157ec printk+0x10 cpop    %ebx
0xc01157ed printk+0x10 dpop    %esi

Entering kdb (current=0xc14de000, pid 7) due to Keyboard Entry
kdb> ps
Task Addr  Pid      Parent   [*] cpu  State Thread     Command
0xc1416000 00000001 00000000  0  000  run   0xc1416270 init
0xc14ea000 00000002 00000001  0  000  run   0xc14ea270 keventd
0xc14e6000 00000003 00000001  0  000  run   0xc14e6270 kapm-idled
0xc14e4000 00000004 00000000  0  000  run   0xc14e4270 ksoftirqd_CPU0
0xc14e2000 00000005 00000000  0  000  stop  0xc14e2270 kswapd
0xc14e0000 00000006 00000000  0  000  stop  0xc14e0270 bdflush
0xc14de000 00000007 00000000  0  000  run   0xc14de270*kupdated
0xcfa18000 00000179 00000001  0  000  stop  0xcfa18270 sshd
0xcf8a2000 00000216 00000001  0  000  stop  0xcf8a2270 portmap
0xcf878000 00000238 00000001  0  000  stop  0xcf878270 atd
0xcf88e000 00000295 00000001  0  000  run   0xcf88e270 automount
0xcf79c000 00000297 00000001  0  000  run   0xcf79c270 automount
0xcf85a000 00000299 00000001  0  000  run   0xcf85a270 automount
0xcf704000 00000346 00000001  0  000  run   0xcf704270 rpc.mountd
0xcf66c000 00000349 00000001  0  000  run   0xcf66c270 rpc.nfsd
0xcf4fa000 00000398 00000001  0  000  stop  0xcf4fa270 rpc.ugidd
0xcf492000 00000412 00000001  0  000  run   0xcf492270 sendmail
0xcee16000 00000421 00000001  0  000  run   0xcee16270 httpd
0xced72000 00000435 00000001  0  000  run   0xced72270 cron
0xced42000 00000451 00000421  0  000  stop  0xced42270 httpd
0xc1508000 00000461 00000001  0  000  stop  0xc1508270 mingetty
0xcfde4000 00000462 00000001  0  000  stop  0xcfde4270 mingetty
0xcfff8000 00000463 00000001  0  000  stop  0xcfff8270 mingetty
0xcff52000 00000464 00000001  0  000  stop  0xcff52270 mingetty
0xcff18000 00000465 00000001  0  000  stop  0xcff18270 mingetty
0xcfb4a000 00000466 00000001  0  000  stop  0xcfb4a270 mingetty
0xcecaa000 00000544 00000179  0  000  stop  0xcecaa270 sshd
0xceba0000 00000547 00000544  0  000  stop  0xceba0270 bash
0xce560000 00000629 00000179  0  000  run   0xce560270 sshd
0xce53a000 00000632 00000629  0  000  stop  0xce53a270 bash
0xce8c0000 00000940 00000179  0  000  run   0xce8c0270 sshd
0xce766000 00001076 00000940  0  000  stop  0xce766270 bash
0xce7ca000 00001269 00000179  0  000  stop  0xce7ca270 sshd
0xce20a000 00001274 00001269  0  000  stop  0xce20a270 bash
0xcb028000 00026363 00001076  0  000  run   0xcb028270 xemacs
0xc9a02000 00026793 00000001  0  000  stop  0xc9a02270 rpciod
0xc993e000 00026794 00000001  0  000  stop  0xc993e270 lockd
0xce412000 00030976 00000001  0  000  stop  0xce412270 scsi_eh_0
0xccd0a000 00031115 00000001  0  000  run   0xccd0a270 syslogd
0xcb120000 00031118 00000001  0  000  run   0xcb120270 klogd
0xcb1f6000 00031119 00000547  0  000  run   0xcb1f6270 less
0xc8e3a000 00000566 00001274  0  000  run   0xc8e3a270 sleep
0xce9cc000 00000590 00000632  0  000  run   0xce9cc270 mkdir


A diff between printk.c of the two kernels shows:
 * Rewrote bits to get rid of console_lock
 *      01Mar01 Andrew Morton <andrewm@uow.edu.au>

Please could you tell me a workaround or some possibility to get out 
of this situation? I think printk() should be an absolutely reliable 
function which never schedules. Else there is a great risk of deadlocks
in hard-to-reproduce situations because normally these situations are 
the ones resulting in printk()s, which are done to give programmers a hint
that an unecpected situation has occured. When the kernel hangs 
(without output to syslog) in such situations, then bugs of any kind will 
be much harder to find in the future.
Maybe one should fix this bug in the next kernels to avoid it to make 
it's way into the next CD-release of SuSE, Debian, RedHat, or whatever.



Regards,
        Ralf


 -----------------------------------------------------------------
|  Ralf Oehler
|  GDI - Gesellschaft fuer Digitale Informationstechnik mbH
|
|  E-Mail:      R.Oehler@GDImbH.com
|  Tel.:        +49 6182-9271-23 
|  Fax.:        +49 6182-25035           
|  Mail:        GDI, Bensbruchstraﬂe 11, D-63533 Mainhausen
|  HTTP:        www.GDImbH.com
 -----------------------------------------------------------------

time is a funny concept

