Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315734AbSGSG1d>; Fri, 19 Jul 2002 02:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315758AbSGSG1d>; Fri, 19 Jul 2002 02:27:33 -0400
Received: from loke.as.arizona.edu ([128.196.209.61]:33924 "EHLO
	loke.as.arizona.edu") by vger.kernel.org with ESMTP
	id <S315734AbSGSG1b>; Fri, 19 Jul 2002 02:27:31 -0400
Date: Thu, 18 Jul 2002 23:28:23 -0700 (MST)
From: Craig Kulesa <ckulesa@as.arizona.edu>
To: linux-kernel@vger.kernel.org
Subject: [USB] uhci-hcd oops on APM resume (2.5.23-26)
Message-ID: <Pine.LNX.4.44.0207182241510.4647-100000@loke.as.arizona.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey Greg & Co... :)

I have a readily reproducible USB oops when resuming from an APM suspend
on my IBM Thinkpad 390E (CONFIG_APM_ALLOW_INTS=y, usb modular).  This
report is for 2.5.26 vanilla, although I have seen the same problem for
several kernel releases, at least going back to 2.5.23.  At boot time, the
following information is syslog'd:

	usb.c: registered new driver usbfs
	usb.c: registered new driver hub
	uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
	PCI: Found IRQ 11 for device 00:02.2
	hcd-pci.c: uhci-hcd @ 00:02.2, Intel Corp. 82371AB PIIX4 USB
	hcd-pci.c: irq 11, io base 0000fca0
	hcd.c: new USB bus registered, assigned bus number 1
	hub.c: USB hub found at /
	hub.c: 2 ports detected
	[...]
	apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)


Looks fine.  Works great!  Upon the first APM suspend:

	hcd-pci.c: suspend 00:02.2 to state 3
	hcd-pci.c: resume 00:02.2
	usb.c: USB disconnect on device 1

Uh oh.  The disconnect notice has me a bit worried...

	*** Aside ***
	-------------
The system is now already in a deranged state, as unloading the usb 
modules will, for example, cause rmmod to segfault and a kernel oops:

Jul 18 19:11:05 gromit kernel: Unable to handle kernel NULL pointer 
Jul 18 19:11:05 gromit kernel: c01122b9
Jul 18 19:11:05 gromit kernel: *pde = 00000000
Jul 18 19:11:05 gromit kernel: Oops: 0002
Jul 18 19:11:05 gromit kernel: CPU:    0
Jul 18 19:11:05 gromit kernel: EIP:    0010:[<c01122b9>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jul 18 19:11:05 gromit kernel: EFLAGS: 00010286
Jul 18 19:11:05 gromit kernel: eax: ffffffff   ebx: cbc01824   ecx: 
cba6b020   e
Jul 18 19:11:05 gromit kernel: esi: c5929420   edi: c5929760   ebp: 
c5929720   e
Jul 18 19:11:05 gromit kernel: ds: 0018   es: 0018   ss: 0018
Jul 18 19:11:05 gromit kernel: Stack: 00000008 c1215cf0 c9561580 00000100 
cba6b0
Jul 18 19:11:05 gromit kernel:        00000011 c9561060 c011264e 00000011 
c95610
Jul 18 19:11:05 gromit kernel:        0000000e c13fb2e0 c9561580 c13f1ee0 
c13fb0
Jul 18 19:11:05 gromit kernel: Call Trace: [<c011264e>] [<c010811a>] 
[<c0105985>
Jul 18 19:11:05 gromit kernel: Code: ff 40 14 8b 4c 24 10 89 01 83 c1 04 

>>EIP; c01122b9 <copy_files+179/260>   <=====
Trace; c011264e <do_fork+2ae/760>
Trace; c010811a <handle_IRQ_event+3a/70>
Trace; c0105985 <sys_fork+15/30>
Code;  c01122b9 <copy_files+179/260>
00000000 <_EIP>:
Code;  c01122b9 <copy_files+179/260>   <=====
   0:   ff 40 14                  incl   0x14(%eax)   <=====
Code;  c01122bc <copy_files+17c/260>
   3:   8b 4c 24 10               mov    0x10(%esp,1),%ecx
Code;  c01122c0 <copy_files+180/260>
   7:   89 01                     mov    %eax,(%ecx)
Code;  c01122c2 <copy_files+182/260>
   9:   83 c1 04                  add    $0x4,%ecx


Okay... back to the original problem.  Even if we had left the system 
alone and simply suspended again, upon the next resume:

	hcd-pci.c: suspend 00:02.2 to state 3
	hcd-pci.c: resume 00:02.2

and then another ooops immediately follows:

Unable to handle kernel paging request at virtual address 00002000
ccaaf95d
*pde = 09c5d067
Oops: 0000
CPU:    0
EIP:    0010:[<ccaaf95d>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 0000fca0   ecx: 000003e8   edx: 0000fca8
esi: 0000fca0   edi: cbdd4800   ebp: 00000001   esp: ca44dea4
ds: 0018   es: 0018   ss: 0018
Stack: cbdd4800 fffffff0 c11d1800 ccab016d cbdd4800 cbdd4800 c11d1800 
cbdd4800 
       cca9f7a2 cbdd4800 c11d1800 cbdd487c c11d1800 00000000 c11d1808 
c11df734 
       c11df720 c016d11b c11d1800 c016d209 c11d1800 c11df720 00000000 
00000003 
Call Trace: [<ccab016d>] [<cca9f7a2>] [<c016d11b>] [<c016d209>] 
[<c016d2ff>] 
   [<c016d34d>] [<c0120086>] [<c0120146>] [<ccad1853>] [<ccad1f1b>] 
[<c011a264>]
 
   [<c01173eb>] [<c0117324>] [<c013e5a7>] [<c01082cc>] [<c0106cd7>] 
Code: 8b 80 00 20 00 00 ef b8 c1 00 00 00 89 da 66 ef 5b 5e 5f c3 

>>EIP; ccaaf95d <[uhci-hcd]start_hc+5d/80>   <=====
Trace; ccab016d <[uhci-hcd]uhci_resume+1d/30>
Trace; cca9f7a2 <[usbcore]usb_hcd_pci_resume+72/a0>
Trace; c016d11b <pci_pm_resume_device+1b/20>
Trace; c016d209 <pci_pm_resume_bus+29/60>
Trace; c016d2ff <pci_pm_resume+1f/30>
Trace; c016d34d <pci_pm_callback+3d/40>
Trace; c0120086 <pm_send+46/80>
Trace; c0120146 <pm_send_all+46/a0>
Trace; ccad1853 <[apm]suspend+a3/f0>
Trace; ccad1f1b <[apm]do_ioctl+cb/160>
Trace; c011a264 <timer_bh+24/270>
Trace; c01173eb <bh_action+1b/50>
Trace; c0117324 <tasklet_hi_action+44/70>
Trace; c013e5a7 <sys_ioctl+1f7/210>
Trace; c01082cc <do_IRQ+9c/b0>
Trace; c0106cd7 <syscall_call+7/b>
Code;  ccaaf95d <[uhci-hcd]start_hc+5d/80>
00000000 <_EIP>:
Code;  ccaaf95d <[uhci-hcd]start_hc+5d/80>   <=====
   0:   8b 80 00 20 00 00         mov    0x2000(%eax),%eax   <=====
Code;  ccaaf963 <[uhci-hcd]start_hc+63/80>
   6:   ef                        out    %eax,(%dx)
Code;  ccaaf964 <[uhci-hcd]start_hc+64/80>
   7:   b8 c1 00 00 00            mov    $0xc1,%eax
Code;  ccaaf969 <[uhci-hcd]start_hc+69/80>
   c:   89 da                     mov    %ebx,%edx
Code;  ccaaf96b <[uhci-hcd]start_hc+6b/80>
   e:   66 ef                     out    %ax,(%dx)
Code;  ccaaf96d <[uhci-hcd]start_hc+6d/80>
  10:   5b                        pop    %ebx
Code;  ccaaf96e <[uhci-hcd]start_hc+6e/80>
  11:   5e                        pop    %esi
Code;  ccaaf96f <[uhci-hcd]start_hc+6f/80>
  12:   5f                        pop    %edi
Code;  ccaaf970 <[uhci-hcd]start_hc+70/80>
  13:   c3                        ret    

If I unload all the USB stuff before any APM suspends, the system is 
perfectly happy upon resume, every time. 

Incidentally, the usb-uhci-hcd driver did the same thing, though the oops 
was in a different place in the driver init code.  Not that it matters so 
much now... :)   BTW, kernel 2.4, all releases, work fine.

Full kernel config is at...
http://loke.as.arizona.edu/~ckulesa/kernel/rmap-vm/misc/2.5.26-config


Craig Kulesa
Steward Observatory
Univ. of Arizona

