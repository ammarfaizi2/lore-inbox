Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262940AbTJZK7U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 05:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262944AbTJZK7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 05:59:20 -0500
Received: from hera.cwi.nl ([192.16.191.8]:15264 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262940AbTJZK7S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 05:59:18 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 26 Oct 2003 11:59:11 +0100 (MET)
Message-Id: <UTC200310261059.h9QAxBS13289.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, torvalds@osdl.org
Subject: Re: Linux 2.6.0-test9
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Pls forward.

Below a keyboard patch I sent to l-k 12 days ago.
Discussion:

Petr Vandrovec reported

> got (twice, but yesterday I rebooted box hard, as I thought that it is dead)
> strange lockup, where box stopped reacting on keyboard.

and

> Oct 14 19:59:18 ppc kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) [30115341]
> Oct 14 19:59:18 ppc kernel: i8042.c: ed -> i8042 (kbd-data) [30115342]
> Oct 14 19:59:18 ppc kernel: i8042.c: fa <- i8042 (interrupt, kbd, 1) [30115346]
> Oct 14 19:59:18 ppc kernel: atkbd.c: Unknown key released (translated set 2, code 0x165, data 0xfa, on isa0060/serio0).

What happens is that the kernel code does an untranslate on the 0xfa
that is the ACK for 0xed (set LEDs) when 0xe0 preceded. Now the ACK
is never seen and we hang waiting for it.

Now 0xfa can be a key scancode or it can be a protocol scancode.
Only few keyboards use it as a key scancode, and if we always
interpret it as a protocol scancode then these rare keyboards
will have a dead key. If we interpret it as a key scancode then
we have a dead keyboard in case it was protocol.

The below patch moves the test for ACK and NAK up, so that they
are always seen as protocol.

This is just a minimal patch. What I did in 1.1.54 was to keep track of
commands sent with a flag reply_expected, so that 0xfa could be taken
as ACK when a reply is expected and as key scancode otherwise.
That is the better solution, but requires larger surgery.

Andries


diff -u --recursive --new-file -X /linux/dontdiff a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Sun Oct 26 00:00:10 2003
+++ b/drivers/input/keyboard/atkbd.c	Sun Oct 26 02:28:24 2003
@@ -184,11 +184,19 @@
 		atkbd->resend = 0;
 #endif
 
+	switch (code) {
+		case ATKBD_RET_ACK:
+			atkbd->ack = 1;
+			goto out;
+		case ATKBD_RET_NAK:
+			atkbd->ack = -1;
+			goto out;
+	}
+
 	if (atkbd->translated) do {
 
 		if (atkbd->emul != 1) {
-			if (code == ATKBD_RET_EMUL0 || code == ATKBD_RET_EMUL1 ||
-			    code == ATKBD_RET_ACK || code == ATKBD_RET_NAK)
+			if (code == ATKBD_RET_EMUL0 || code == ATKBD_RET_EMUL1)
 				break;
 			if (code == ATKBD_RET_BAT) {
 				if (!atkbd->bat_xl)
@@ -212,15 +220,6 @@
 
 	} while (0);
 
-	switch (code) {
-		case ATKBD_RET_ACK:
-			atkbd->ack = 1;
-			goto out;
-		case ATKBD_RET_NAK:
-			atkbd->ack = -1;
-			goto out;
-	}
-
 	if (atkbd->cmdcnt) {
 		atkbd->cmdbuf[--atkbd->cmdcnt] = code;
 		goto out;
