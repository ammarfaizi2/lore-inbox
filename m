Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317955AbSGWF7K>; Tue, 23 Jul 2002 01:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317956AbSGWF7K>; Tue, 23 Jul 2002 01:59:10 -0400
Received: from [196.26.86.1] ([196.26.86.1]:8382 "HELO
	infosat-gw.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317955AbSGWF7J>; Tue, 23 Jul 2002 01:59:09 -0400
Date: Tue, 23 Jul 2002 08:20:00 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: [PATCH] uart_start thinko
Message-ID: <Pine.LNX.4.44.0207230818410.32636-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,
	With this patch i can now fully use the console as i normally do, 
ie kernel messages, agetty and syslogd. I think you forgot to remove the 
other locks when you were doing the shuffle between __uart_start and uart_start ;)

NMI Watchdog detected LOCKUP on CPU0, eip c02017c6, registers:
CPU:    0
EIP:    0010:[<c02017c6>]    Not tainted
EFLAGS: 00000086
eax: cec38000   ebx: c0429bc0   ecx: cec39e1b   edx: 00000031
esi: cf5f2854   edi: cecca000   ebp: 00000046   esp: cec39dd8
ds: 0018   es: 0018   ss: 0018
Process syslogd (pid: 441, threadinfo=cec38000 task=cf49b340)
Stack: cec38000 c0429bc0 cf5f2854 cecca000 c01fe2cf cecca000 00000286 cecca000
       0000000f cec39e0c 0000000f c0208d03 cecca000 206e614a 32203120 32343a31 
       ce31313a c0117706 c0377108 00000001 00000001 00000282 00000282 00000001
Call Trace: [<c01fe2cf>] [<c0208d03>] [<c0117706>] [<c020d63c>] [<c0122b3a>] 
   [<c020b465>] [<c0117600>] [<c01227e0>] [<c0117600>] [<c01224eb>] [<c0206049>]
   [<c020b2d0>] [<c0205db0>] [<c014be94>] [<c015d559>] [<c028b2a4>] [<c014c063>] 
   [<c01075db>] 

Code: 80 3b 00 f3 90 7e f9 e9 1e ca ff ff 80 3e 00 f3 90 7e f9 e9 

>>EIP; c02017c6 <.text.lock.core+c/206>   <=====
Trace; c01fe2cf <uart_start+5f/b0>
Trace; c0208d03 <opost_block+173/190>
Trace; c0117706 <__wake_up+66/b0>
Trace; c020d63c <batch_entropy_process+ac/b0>
Trace; c0122b3a <__run_task_queue+ca/e0>
Trace; c020b465 <write_chan+195/220>
Trace; c0117600 <default_wake_function+0/40>
Trace; c01227e0 <tasklet_hi_action+70/c0>
Trace; c0117600 <default_wake_function+0/40>
Trace; c01224eb <do_softirq+7b/f0>
Trace; c0206049 <tty_write+299/380>
Trace; c020b2d0 <write_chan+0/220>
Trace; c0205db0 <tty_write+0/380>
Trace; c014be94 <do_readv_writev+204/330>
Trace; c015d559 <do_select+279/290>
Trace; c028b2a4 <sys_socketcall+154/200>
Trace; c014c063 <sys_writev+43/54>
Trace; c01075db <syscall_call+7/b>
Code;  c02017c6 <.text.lock.core+c/206>
00000000 <_EIP>:
Code;  c02017c6 <.text.lock.core+c/206>   <=====
   0:   80 3b 00                  cmpb   $0x0,(%ebx)   <=====
Code;  c02017c9 <.text.lock.core+f/206>
   3:   f3 90                     repz nop
Code;  c02017cb <.text.lock.core+11/206>
   5:   7e f9                     jle    0 <_EIP>
Code;  c02017cd <.text.lock.core+13/206>
   7:   e9 1e ca ff ff            jmp    ffffca2a <_EIP+0xffffca2a> c01fe1f0 <__uart_start+40/c0>
Code;  c02017d2 <.text.lock.core+18/206>
   c:   80 3e 00                  cmpb   $0x0,(%esi)
Code;  c02017d5 <.text.lock.core+1b/206>
   f:   f3 90                     repz nop
Code;  c02017d7 <.text.lock.core+1d/206>
  11:   7e f9                     jle    c <_EIP+0xc> c02017d2 <.text.lock.core+18/206>
Code;  c02017d9 <.text.lock.core+1f/206>
  13:   e9 00 00 00 00            jmp    18 <_EIP+0x18> c02017de <.text.lock.core+24/206>


Index: linux-2.5.27/drivers/serial//core.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.27/drivers/serial/core.c,v
retrieving revision 1.1
diff -u -r1.1 core.c
--- linux-2.5.27/drivers/serial//core.c	22 Jul 2002 17:07:08 -0000	1.1
+++ linux-2.5.27/drivers/serial//core.c	22 Jul 2002 17:11:43 -0000
@@ -104,13 +104,10 @@
 {
 	struct uart_info *info = tty->driver_data;
 	struct uart_port *port = info->port;
-	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
 	if (!uart_circ_empty(&info->xmit) && info->xmit.buf &&
 	    !tty->stopped && !tty->hw_stopped)
 		port->ops->start_tx(port, 1);
-	spin_unlock_irqrestore(&port->flags, flags);
 }
 
 static void uart_start(struct tty_struct *tty)

-- 
function.linuxpower.ca

