Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264868AbUDWQqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264868AbUDWQqL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 12:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264866AbUDWQqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 12:46:11 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:36481 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S264868AbUDWQqB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 12:46:01 -0400
Date: Fri, 23 Apr 2004 18:45:59 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: vojtech@suse.cz
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Problems with atkbd_command & atkbd_interrupt interaction
Message-ID: <20040423164558.GA3448@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vojtech,
  I've found bad problem in atkbd_interrupt code, which causes
that keyboard is not detected while you type some keys on the keyboard
while system boots (before keyboard port gets detected):

During bootup, atkbd_probe is invoked twice - once when keyboard is
disabled, and once when it is enabled. First pass is OK, as keyboard
does not send any scancodes itself, and so you cannot break it. But
on second pass keyboard is enabled, and it sends scancodes as it wishes
- but atkbd_interrupt does not expect that:

When atkbd_command begins (with CMD_GETID command), it sets atkbd->cmdcnt 
to 2, saying that it expects 2 bytes reply, then it sets CMD_GETID
command to keyboard, and spins in the loop until ACK is received.

Meanwhile keyboard continues with sending scancodes (it has pretty
large 4KB internal buffer, and ACK gets put at the end of that buffer,
beyond last scancode queued; is there any doc which disallows that
behavior?) - and (that's bug I'd say) atkbd_interrupt stuffs first two
of scancodes into atkbd->cmdbuf[] array, although it waits for ACK, and
it did not see ACK yet. Other scancodes (after first two) are passed through
atkbd_interrupt, and are (correctly) handed to the keycode handling
(which refuses them as ATKBD_KEY_UNKNOWN as they come too early before
default keycode mapping was established).

Then finally ACK from keyboard arrives, atkbd_interrupt sets atkbd->ack,
unblocking atkbd_sendbyte(), which returns to atkbd_command. It now
finds that both bytes with command's reply already arrived, and returns
- unfortunately with completely bogus data, as instead of CMD_GETID
reply it contains two random scancodes user pressed - and they almost
always differ from 0xAB 0xXX, so code decides that keyboard is dead.

Immediately after ACK keyboard ID (0xAB 0x14) arrives from keyboard, and 
they are interpreted as normal (key) scancodes, as nobody was expecting
them.

It looks to me like that atkbd->cmdcnt should be set not in
atkbd_command, but in the atkbd_sendbyte while last command byte is 
sent to the keyboard, and atkbd_interrupt should stuff bytes into cmdbuf
only if atkbd->ack == 1.

Patch below fixes problem for me. I'm not sure about wmb() - probably there
should be also rmb() between fetching atkbd->cmdcnt and atkbd->ack in
atkbd_interrupt.
						Thanks,
							Petr Vandrovec

--- linux/drivers/input/keyboard/atkbd.c.orig	2004-04-22 18:26:57.000000000 +0200
+++ linux/drivers/input/keyboard/atkbd.c	2004-04-23 18:30:46.000000000 +0200
@@ -243,7 +243,7 @@
 				goto out;
 		}
 
-	if (atkbd->cmdcnt) {
+	if (atkbd->cmdcnt && atkbd->ack == 1) {
 		atkbd->cmdbuf[--atkbd->cmdcnt] = code;
 		goto out;
 	}
@@ -365,10 +365,12 @@
  * replacement anyway, and they only make a mess in the protocol.
  */
 
-static int atkbd_sendbyte(struct atkbd *atkbd, unsigned char byte)
+static int atkbd_sendbyte(struct atkbd *atkbd, unsigned char byte, int cmdcnt)
 {
 	int timeout = 20000; /* 200 msec */
 	atkbd->ack = 0;
+	wmb(); /* First clear ACK, then write how many reply bytes we want... though maybe it would want real spinlock */
+	atkbd->cmdcnt = cmdcnt;
 
 #ifdef ATKBD_DEBUG
 	printk(KERN_DEBUG "atkbd.c: Sent: %02x\n", byte);
@@ -393,8 +395,6 @@
 	int receive = (command >> 8) & 0xf;
 	int i;
 
-	atkbd->cmdcnt = receive;
-
 	if (command == ATKBD_CMD_RESET_BAT)
 		timeout = 2000000; /* 2 sec */
 
@@ -403,11 +403,11 @@
 			atkbd->cmdbuf[(receive - 1) - i] = param[i];
 
 	if (command & 0xff)
-		if (atkbd_sendbyte(atkbd, command & 0xff))
+		if (atkbd_sendbyte(atkbd, command & 0xff, send ? 0 : receive))
 			return (atkbd->cmdcnt = 0) - 1;
 
 	for (i = 0; i < send; i++)
-		if (atkbd_sendbyte(atkbd, param[i]))
+		if (atkbd_sendbyte(atkbd, param[i], (i != send - 1) ? 0 : receive))
 			return (atkbd->cmdcnt = 0) - 1;
 
 	while (atkbd->cmdcnt && timeout--) {
