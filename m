Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbWBUU2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWBUU2a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 15:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbWBUU2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 15:28:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52621 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932352AbWBUU23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 15:28:29 -0500
Date: Tue, 21 Feb 2006 15:27:57 -0500
From: Dave Jones <davej@redhat.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: softlockup interaction with slow consoles
Message-ID: <20060221202757.GB24159@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"David S. Miller" <davem@davemloft.net>, ak@suse.de,
	linux-kernel@vger.kernel.org, mingo@elte.hu
References: <p73mzgk4y9u.fsf@verdi.suse.de> <20060221.120143.15763934.davem@davemloft.net> <200602212105.38075.ak@suse.de> <20060221.121948.60060362.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060221.121948.60060362.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 12:19:48PM -0800, David S. Miller wrote:
 > From: Andi Kleen <ak@suse.de>
 > Date: Tue, 21 Feb 2006 21:05:37 +0100
 > 
 > > The classic way is to just use touch_nmi_watchdog() somewhere
 > > in the loop that does work. That touches the softwatchdog too
 > > these days.
 > 
 > "jiffies" aren't advancing, since interrupts are disabled by
 > release_console_sem(), so that doesn't work.
 > 
 > I tried that already :-)

Where did you put it?  I hit a similar problem a few months back,
and this patch did the trick for me..

		Dave

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


--- linux-2.6.11/drivers/serial/8250.c~	2005-05-14 02:49:02.000000000 -0400
+++ linux-2.6.11/drivers/serial/8250.c	2005-05-14 02:54:30.000000000 -0400
@@ -2098,9 +2098,11 @@ static inline void wait_for_xmitr(struct
 	/* Wait up to 1s for flow control if necessary */
 	if (up->port.flags & UPF_CONS_FLOW) {
 		tmout = 1000000;
-		while (--tmout &&
-		       ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0))
+		while (!(serial_in(up, UART_MSR) & UART_MSR_CTS) && --tmout) {
 			udelay(1);
+			if ((tmout % 1000) == 0)
+				touch_nmi_watchdog();
+		}
 	}
 }
 




