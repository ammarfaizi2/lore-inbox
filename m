Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbUDZWta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbUDZWta (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 18:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbUDZWta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 18:49:30 -0400
Received: from gprs214-26.eurotel.cz ([160.218.214.26]:1664 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261822AbUDZWt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 18:49:27 -0400
Date: Tue, 27 Apr 2004 00:49:11 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, vojtech@ucw.cz,
       VANDROVE@vc.cvut.cz
Subject: Re: Not so theoretical race in atkbd_command
Message-ID: <20040426224911.GA276@elf.ucw.cz>
References: <20040426213555.GA1368@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040426213555.GA1368@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> There's quite real race in atkbd_command:
> 
> static int atkbd_command(struct atkbd *atkbd, unsigned char *param,
> int command)
> {
>         int timeout = 500000; /* 500 msec */
>         int send = (command >> 12) & 0xf;
>         int receive = (command >> 8) & 0xf;
>         int i;
> 
>         atkbd->cmdcnt = receive;
> [user presses key here]
> 
> atkbd_interrupt eats user keypress, thinking its reply. Boom. To
> exploit:
> 
> while true; do setleds +num; setleds -num; done
> 
> then try typing.

Petr suggested following follow-up patch. I'm not quite sure it is
effective. I still get lost keys with

 while true; do setleds +num; setleds -num; done

								Pavel

--- tmp/linux/drivers/input/keyboard/atkbd.c	2004-04-27 00:41:19.000000000 +0200
+++ linux/drivers/input/keyboard/atkbd.c	2004-04-27 00:36:10.000000000 +0200
@@ -244,7 +244,7 @@
 				goto out;
 		}
 
-	if (atkbd->cmdcnt) {
+	if (atkbd->cmdcnt && atomic_read(&atkbd->ack) == 1) {
 		atkbd->cmdbuf[--atkbd->cmdcnt] = code;
 		goto out;
 	}
@@ -366,10 +366,12 @@
  * replacement anyway, and they only make a mess in the protocol.
  */
 
-static int atkbd_sendbyte(struct atkbd *atkbd, unsigned char byte)
+static int atkbd_sendbyte(struct atkbd *atkbd, unsigned char byte, int cmdcnt)
 {
 	int timeout = 20000; /* 200 msec */
-	atomic_set(&atkbd->ack, 0); mb();
+	atomic_set(&atkbd->ack, 0);
+	mb(); /* First clear ACK, then write how many reply bytes we want... though maybe it would want real spinlock */
+	atkbd->cmdcnt = cmdcnt;
 
 #ifdef ATKBD_DEBUG
 	printk(KERN_DEBUG "atkbd.c: Sent: %02x\n", byte);
@@ -397,8 +399,6 @@
 	int receive = (command >> 8) & 0xf;
 	int i;
 
-	atkbd->cmdcnt = receive;
-
 	if (command == ATKBD_CMD_RESET_BAT)
 		timeout = 2000000; /* 2 sec */
 
@@ -407,11 +407,11 @@
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

-- 
934a471f20d6580d5aad759bf0d97ddc






