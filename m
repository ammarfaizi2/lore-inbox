Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbUDWU40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbUDWU40 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 16:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbUDWU40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 16:56:26 -0400
Received: from mail.stw-bonn.de ([131.220.99.37]:6609 "EHLO mail.stw-bonn.de")
	by vger.kernel.org with ESMTP id S261317AbUDWU4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 16:56:21 -0400
Date: Fri, 23 Apr 2004 22:56:17 +0200
From: "E. Oltmanns" <oltmanns@uni-bonn.de>
To: linux-kernel@vger.kernel.org
Subject: Kernel Oops during usb usage (2.6.5)
Message-ID: <20040423205617.GA1798@local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello everyone,

Summary:
Kernel Oops caused by multiple access requests to a single scanner
through libusb.

Detailed description:
The following script leads to an kernel oops on my System:
#!/bin/bash
scanimage > test &
scanimage -h

This is because scanimage -h tries to append a list of availlable
scanners to the help output and thus interferes with the first
scanimage process which is initializing the scanner at the same
moment. I am using the kernel 2.6.5 and the usb host controller
ohci-hcd. The kernel is tainted because I am using the loop-aes module
and the mppe patch from pptpclient.sf.net/mppe/ which should not
interfere with the scanning process.

Relevant kernel logs and the output of ksymoops applied to those logs
are attached seperately. Please let me know if you need any further
information.
Btw: After the occurrence of the kernel oops I tried a
# modprobe -r ohci-hcd

After showing some messages which indicated modprobe's effort to
process the command, modprobe hang it even
kill -9 pid
or
killall -9 modprobe
could not stop the process. When rebooting the system stopped during
shut down when it tried to stop alsa (most likely, because it uses
modprobe to unload the alsa related modules at this point).

Best regards,

Elias

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kern.log"

Apr 23 21:56:13 linux kernel: usb 2-1: usb_disable_device nuking non-ep0 URBs
Apr 23 21:56:13 linux kernel: usb 2-1: unregistering interface 2-1:1.0
Apr 23 21:56:13 linux kernel: drivers/usb/core/usb.c: usb_hotplug
Apr 23 21:56:13 linux kernel: usb 2-1: registering 2-1:1.0 (config #1, interface 0)
Apr 23 21:56:13 linux kernel: drivers/usb/core/usb.c: usb_hotplug
Apr 23 21:56:13 linux kernel: usb 2-1: usb_disable_device nuking non-ep0 URBs
Apr 23 21:56:13 linux kernel: ohci_hcd 0000:00:02.3: shutdown urb dc97d0c0 pipe c0018200 ep3out-bulk
Apr 23 21:56:13 linux kernel: usbfs: USBDEVFS_BULK failed dev 2 ep 0x3 len 5 ret -108
Apr 23 21:56:13 linux kernel: usb 2-1: unregistering interface 2-1:1.0
Apr 23 21:56:13 linux kernel: drivers/usb/core/usb.c: usb_hotplug
Apr 23 21:56:13 linux kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
Apr 23 21:56:13 linux kernel:  printing eip:
Apr 23 21:56:13 linux kernel: e08f12c2
Apr 23 21:56:13 linux kernel: *pde = 00000000
Apr 23 21:56:13 linux kernel: Oops: 0000 [#1]
Apr 23 21:56:13 linux kernel: PREEMPT 
Apr 23 21:56:13 linux kernel: CPU:    0
Apr 23 21:56:13 linux kernel: EIP:    0060:[__crc_sleep_on+2586755/10722792]    Tainted: PF 
Apr 23 21:56:13 linux kernel: EFLAGS: 00010246   (2.6.5) 
Apr 23 21:56:13 linux kernel: EIP is at findintfep+0x32/0xb0 [usbcore]
Apr 23 21:56:13 linux kernel: eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 00000000
Apr 23 21:56:13 linux kernel: esi: dc97da40   edi: ffffffea   ebp: bfffa7a0   esp: dddcbeac
Apr 23 21:56:13 linux kernel: ds: 007b   es: 007b   ss: 0068
Apr 23 21:56:13 linux kernel: Process scanimage (pid: 2087, threadinfo=dddca000 task=dcf6b120)
Apr 23 21:56:13 linux kernel: Stack: dddcbec8 00000000 df678a40 00000000 00000000 dc97da40 dddcbf00 bfffa7a0 
Apr 23 21:56:13 linux kernel:        e08f1961 df6f5400 00000003 00000010 c0147546 df1e6b80 dea6b840 df6f5400 
Apr 23 21:56:13 linux kernel:        00000000 dbc95ad0 dc2c2400 00000002 df1e6b80 00000003 00000005 00007530 
Apr 23 21:56:13 linux kernel: Call Trace:
Apr 23 21:56:13 linux kernel:  [__crc_sleep_on+2588450/10722792] proc_bulk+0x71/0x320 [usbcore]
Apr 23 21:56:13 linux kernel:  [handle_mm_fault+214/368] handle_mm_fault+0xd6/0x170
Apr 23 21:56:13 linux kernel:  [__crc_sleep_on+2595205/10722792] usbdev_ioctl+0x274/0x330 [usbcore]
Apr 23 21:56:13 linux kernel:  [schedule+812/1440] schedule+0x32c/0x5a0
Apr 23 21:56:13 linux kernel:  [inflate_codes+786/1184] inflate_codes+0x312/0x4a0
Apr 23 21:56:13 linux kernel:  [file_ioctl+116/432] file_ioctl+0x74/0x1b0
Apr 23 21:56:13 linux kernel:  [inflate_codes+786/1184] inflate_codes+0x312/0x4a0
Apr 23 21:56:13 linux kernel:  [inflate_codes+786/1184] inflate_codes+0x312/0x4a0
Apr 23 21:56:13 linux kernel:  [sys_ioctl+289/656] sys_ioctl+0x121/0x290
Apr 23 21:56:13 linux kernel:  [inflate_codes+786/1184] inflate_codes+0x312/0x4a0
Apr 23 21:56:13 linux kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Apr 23 21:56:13 linux kernel:  [inflate_codes+786/1184] inflate_codes+0x312/0x4a0
Apr 23 21:56:13 linux kernel: 
Apr 23 21:56:13 linux kernel: Code: 0f b6 40 04 39 44 24 0c 73 5c 89 44 24 08 8b 4c 24 0c 31 ed 
Apr 23 21:56:14 linux kernel:  <7>usb 2-1: registering 2-1:1.0 (config #1, interface 0)
Apr 23 21:56:14 linux kernel: drivers/usb/core/usb.c: usb_hotplug

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ksymoops.log"

ksymoops 2.4.9 on i686 2.6.5.  Options used
     -V (default)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.6.5/ (default)
     -m /boot/System.map-2.6.5 (default)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Apr 23 21:56:13 linux kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
Apr 23 21:56:13 linux kernel: e08f12c2
Apr 23 21:56:13 linux kernel: *pde = 00000000
Apr 23 21:56:13 linux kernel: Oops: 0000 [#1]
Apr 23 21:56:13 linux kernel: CPU:    0
Apr 23 21:56:13 linux kernel: EIP:    0060:[__crc_sleep_on+2586755/10722792]    Tainted: PF 
Apr 23 21:56:13 linux kernel: EFLAGS: 00010246   (2.6.5) 
Apr 23 21:56:13 linux kernel: eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 00000000
Apr 23 21:56:13 linux kernel: esi: dc97da40   edi: ffffffea   ebp: bfffa7a0   esp: dddcbeac
Apr 23 21:56:13 linux kernel: ds: 007b   es: 007b   ss: 0068
Apr 23 21:56:13 linux kernel: Stack: dddcbec8 00000000 df678a40 00000000 00000000 dc97da40 dddcbf00 bfffa7a0 
Apr 23 21:56:13 linux kernel:        e08f1961 df6f5400 00000003 00000010 c0147546 df1e6b80 dea6b840 df6f5400 
Apr 23 21:56:13 linux kernel:        00000000 dbc95ad0 dc2c2400 00000002 df1e6b80 00000003 00000005 00007530 
Apr 23 21:56:13 linux kernel: Call Trace:
Warning (Oops_read): Code line not seen, dumping what data is available


>>esi; dc97da40 <__crc_enable_lapic_nmi_watchdog+ab116/2ef085>
>>edi; ffffffea <__kernel_rt_sigreturn+1baa/????>
>>ebp; bfffa7a0 <__crc_xfrm_policy_put_afinfo+18802f/1c9ec6>
>>esp; dddcbeac <__crc_register_filesystem+27ce24/4c8196>

Apr 23 21:56:13 linux kernel: Code: 0f b6 40 04 39 44 24 0c 73 5c 89 44 24 08 8b 4c 24 0c 31 ed 
Using defaults from ksymoops -t elf32-i386 -a i386


Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f b6 40 04               movzbl 0x4(%eax),%eax
Code;  00000004 Before first symbol
   4:   39 44 24 0c               cmp    %eax,0xc(%esp,1)
Code;  00000008 Before first symbol
   8:   73 5c                     jae    66 <_EIP+0x66>
Code;  0000000a Before first symbol
   a:   89 44 24 08               mov    %eax,0x8(%esp,1)
Code;  0000000e Before first symbol
   e:   8b 4c 24 0c               mov    0xc(%esp,1),%ecx
Code;  00000012 Before first symbol
  12:   31 ed                     xor    %ebp,%ebp


1 warning issued.  Results may not be reliable.

--rwEMma7ioTxnRzrJ--
