Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261901AbVGGTaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbVGGTaf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 15:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbVGGTaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 15:30:22 -0400
Received: from ms001msg.fastwebnet.it ([213.140.2.51]:3582 "EHLO
	ms001msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S262055AbVGGTaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 15:30:02 -0400
Date: Thu, 7 Jul 2005 21:30:27 +0200
From: Mattia Dongili <malattia@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: vojtech@suse.cz, Dmitry Torokhov <dtor@mail.ru>
Subject: Synaptics Touchpad not detected in 2.6.13-rc2
Message-ID: <20050707193027.GA4162@inferi.kami.home>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	vojtech@suse.cz, Dmitry Torokhov <dtor@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.13-rc2-mm1-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

with -rc2 (-rc1 didn't show this behaviour) I get the following when
modprobing psmouse.ko:

atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86,
might be trying access hardware directly.

and the touchpad is not detected at all.

The ps2_adjust_timeout function seems to be the cause, restoring the old
fixed timeout in ps2_command seems to cure this issue (see diff below).
It could be probably done better by detecting which command misses the
the last bytes and recalibrating ps2_adjust_timeout instead. Or maybe
checking the return value of wait_event_timeout for a next round of
wait?

This is the device (on a Vaio GR), which other info could I provide to
better diagnose the problem?

Synaptics Touchpad, model: 1, fw: 5.9, id: 0x2548b1, caps: 0x804753/0x0
input: SynPS/2 Synaptics TouchPad on isa0060/serio1

I: Bus=0011 Vendor=0002 Product=0007 Version=0000
N: Name="SynPS/2 Synaptics TouchPad"
P: Phys=isa0060/serio1/input0
H: Handlers=mouse2 event5 
B: EV=b 
B: KEY=6420 0 70000 0 0 0 0 0 0 0 0 
B: ABS=11000003 


--- linux-vaio/drivers/input/serio/libps2.c	2005-07-07 21:04:35.000000000 +0200
+++ linux-clean/drivers/input/serio/libps2.c	2005-07-07 21:06:34.000000000 +0200
@@ -210,7 +210,7 @@ int ps2_command(struct ps2dev *ps2dev, u
 
 	if (ps2dev->cmdcnt && timeout > 0) {
 
-		timeout = ps2_adjust_timeout(ps2dev, command, timeout);
+		timeout = msecs_to_jiffies(100);
 		wait_event_timeout(ps2dev->wait,
 				   !(ps2dev->flags & PS2_FLAG_CMD), timeout);
 	}

-- 
mattia
:wq!
