Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262494AbVEMS41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbVEMS41 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 14:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbVEMSyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 14:54:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47580 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262480AbVEMSsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 14:48:11 -0400
Date: Fri, 13 May 2005 14:48:06 -0400
From: Dave Jones <davej@redhat.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: tickle nmi watchdog whilst doing serial writes.
Message-ID: <20050513184806.GA24166@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was fun. I inserted a music CD with some obnoxious copy-protection
on it into the drive, and lots of SCSI errors went zipping over to
the serial console. Unfortunatly, the box was also compiling a kernel,
playing oggs, and doing a number of other things at the same time,
so this happened..

NMI Watchdog detected LOCKUP on CPU2CPU 2
Modules linked in: loop usb_storage md5 ipv6 parport_pc lp parport autofs4 i2c_dev i2c_core rfcomm l2cap bluetooth sunrpc pcdPid: 3138, comm: gpm Not tainted 2.6.11-1.1290_FC4smp
RIP: 0010:[<ffffffff80273b8a>] <ffffffff80273b8a>{serial_in+106}
RSP: 0018:ffff81003afc3d50  EFLAGS: 00000002
RAX: 0000000000000020 RBX: 0000000000000020 RCX: 0000000000000000
RDX: 00000000000003fd RSI: 0000000000000005 RDI: ffffffff804dcd60
RBP: 00000000000024fc R08: 000000000000000a R09: 0000000000000033
R10: ffff81001beb7c20 R11: 0000000000000020 R12: ffffffff804dcd60
R13: ffffffff804ade76 R14: 000000000000002b R15: 000000000000002c
FS:  00002aaaaaac4920(0000) GS:ffffffff804fca00(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaaabcb000 CR3: 000000003c0d0000 CR4: 00000000000006e0
Process gpm (pid: 3138, threadinfo ffff81003afc2000, task ffff81003eb63780)
Stack: ffffffff80275f2e 0000000000000000 ffffffff80448380 0000000000007d6b
       000000000000002c fffffffffffffbbf 0000000000000292 0000000000008000
       ffffffff80138e8c 0000000000007d97
Call Trace:<ffffffff80275f2e>{serial8250_console_write+270} <ffffffff80138e8c>{__call_console_drivers+76}
       <ffffffff8013914b>{release_console_sem+315} <ffffffff80260325>{con_open+149}
       <ffffffff80254e99>{tty_open+537} <ffffffff80192713>{chrdev_open+387}
       <ffffffff80188824>{dentry_open+260} <ffffffff80188994>{filp_open+68}
       <ffffffff80187b73>{get_unused_fd+227} <ffffffff80188a6c>{sys_open+76}
       <ffffffff8010ebc6>{tracesys+209}

Code: 0f b6 c0 c3 66 90 41 57 49 89 f7 41 56 41 be 00 01 00 00 41
console shuts up ...


Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.11/drivers/serial/8250.c~	2005-05-13 14:18:44.000000000 -0400
+++ linux-2.6.11/drivers/serial/8250.c	2005-05-13 14:30:56.000000000 -0400
@@ -40,6 +40,7 @@
 #include <linux/serial_core.h>
 #include <linux/serial.h>
 #include <linux/serial_8250.h>
+#include <linux/nmi.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -2099,8 +2100,10 @@ static inline void wait_for_xmitr(struct
 	if (up->port.flags & UPF_CONS_FLOW) {
 		tmout = 1000000;
 		while (--tmout &&
-		       ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0))
+		       ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0)) {
 			udelay(1);
+			touch_nmi_watchdog();
+		}
 	}
 }
 

We *could* tickle it less often, but given we're busy waiting anyway
it probably doesnt make sense to not favour the more simple approach.
Hmm, maybe we want a cpu_relax() in there too. opinions?

		Dave

