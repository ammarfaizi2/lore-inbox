Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbTLBK7N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 05:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbTLBK7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 05:59:13 -0500
Received: from mta02-svc.ntlworld.com ([62.253.162.42]:63950 "EHLO
	mta02-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S261879AbTLBK7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 05:59:10 -0500
From: SA <bullet.train@ntlworld.com>
To: <linux-kernel@vger.kernel.org>
Subject: pwc.o bug?
Date: Tue, 2 Dec 2003 10:59:09 +0000
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312021059.09671.bullet.train@ntlworld.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear list,

There appears to be a bug in pwc.o which causes it to handle a common 
exception badly, makes it impossible to remove the module and could flood
the system logs with messages.  After this error a reboot is required to
fix the system.

If the webcam is removed from the USB bus when the device is open from 
userland the driver oops and remains locked with a usage count of 1 
preventing it and the drivers under it from being removed.  The driver then 
produces a kernel message " pwc pwc_isoc_handler() called with status 
-84 [CRC/Timeout]." with priority 7 several times a second.  If this message 
is logged then the logs can overflow.  
This may be videodev rather than pwc...


The disconnect can occur if the camera is removed or the connection is flakey.



Sample kernel log:

Dec  1 11:57:51 duvet kernel: usb-uhci.c: interrupt, status 2, frame# 1000
Dec  1 11:57:51 duvet kernel: usb.c: USB disconnect on device 00:07.2-1address 4
Dec  1 11:57:51 duvet kernel: pwc Disconnected while device/video is open!
Dec  1 11:57:51 duvet kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000048
Dec  1 11:57:51 duvet kernel:  printing eip:
Dec  1 11:57:51 duvet kernel: dc9a8402
Dec  1 11:57:51 duvet kernel: *pde = 00000000
Dec  1 11:57:51 duvet kernel: Oops: 0000
Dec  1 11:57:51 duvet kernel: ide-cd cdrom audio rce pwc videodev slm es1371 gameport ac97_codec soundcore parport_pc lp parport autofs nfs lockd sunrpc e100 ipt_REJECT iptable_filter ip_t
Dec  1 11:57:51 duvet kernel: CPU:    0
Dec  1 11:57:52 duvet kernel: EIP:    0060:[<dc9a8402>]    Tainted: PF
Dec  1 11:57:52 duvet kernel: EFLAGS: 00210296
Dec  1 11:57:52 duvet kernel:
Dec  1 11:57:52 duvet kernel: EIP is at video_ioctl [videodev] 0x22 (2.4.20-20.9)
Dec  1 11:57:52 duvet kernel: eax: 00000000   ebx: ffffffe7   ecx: 00000007   edx: 40047612
Dec  1 11:57:52 duvet kernel: esi: 40047612   edi: d2c75e80   ebp: 00000007   esp: ced13f88
Dec  1 11:57:52 duvet kernel: ds: 0068   es: 0068   ss: 0068
Dec  1 11:57:52 duvet kernel: Process camstream (pid: 22187, stackpage=ced13000)
Dec  1 11:57:52 duvet kernel: Stack: 00000000 40047612 0814e490 c0156ff9 c0691080 d2c75e80 40047612 0814e490
Dec  1 11:57:52 duvet kernel:        00000008 3fcb2cbf ced12000 0814e3a0 081d9180 bfffe6d8 c010953f 00000007
Dec  1 11:57:52 duvet kernel:        40047612 0814e490 0814e3a0 081d9180 bfffe6d8 00000036 c010002b 0000002b
Dec  1 11:57:52 duvet kernel: Call Trace:   [<c0156ff9>] sys_ioctl [kernel] 0xc9 (0xced13f94))
Dec  1 11:57:52 duvet kernel: [<c010953f>] system_call [kernel] 0x33 (0xced13fc0))
Dec  1 11:57:52 duvet kernel:
Dec  1 11:57:52 duvet kernel:
Dec  1 11:57:52 duvet kernel: Code: ff 50 48 89 c2 b8 ea ff ff ff 81 fa fd fd ff ff 0f 45 c2 83
Dec  1 11:57:52 duvet kernel:  <7>pwc pwc_isoc_handler() called with status -84 [CRC/Timeout].

The kernel taint comes from the use of the pwcx decompression driver and the nvidia opengl driver.

Using kernel 2.4.20-20.9.

SA
