Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262940AbTJNV1g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 17:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262947AbTJNV1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 17:27:36 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:51214 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262940AbTJNV1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 17:27:23 -0400
Date: Tue, 14 Oct 2003 23:27:06 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: vojtech@suse.cz, Zwane Mwaikambo <zwane@linuxpower.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: Another keyboard woes with 2.6.0...
Message-ID: <20031014212706.GA5898@win.tue.nl>
References: <20030912165044.GA14440@vana.vc.cvut.cz> <Pine.LNX.4.53.0309121341380.6886@montezuma.fsmlabs.com> <20030916232318.A1699@pclin040.win.tue.nl> <20031006220847.GA5139@vana.vc.cvut.cz> <20031014181606.GD21740@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031014181606.GD21740@vana.vc.cvut.cz>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14, 2003 at 08:16:06PM +0200, Petr Vandrovec wrote:

> Got it again. This time with detailed logging.

Excellent. This immediately shows another bug in the code.

> Oct 14 19:59:18 ppc kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) [30115341]
> Oct 14 19:59:18 ppc kernel: i8042.c: ed -> i8042 (kbd-data) [30115342]
> Oct 14 19:59:18 ppc kernel: i8042.c: fa <- i8042 (interrupt, kbd, 1) [30115346]
> Oct 14 19:59:18 ppc kernel: atkbd.c: Unknown key released (translated set 2, code 0x165, data 0xfa, on isa0060/serio0).

The code (some version of 2.6.0-test6) says

	if (atkbd->translated) do {
		if (atkbd->emul != 1) {
			if (code == ATKBD_RET_ACK)
				break;
			...
		}
		if (code < 0x80) {
			code = atkbd_unxlate_table[code];
			break;
		}
		code = atkbd_unxlate_table[code & 0x7f];
	}

Here an e0 preceded, setting the atkbd->emul flag.
Now the acknowledge for the 0xed command was not recognized as
ATKBD_RET_ACK and untranslated as if it were a keystroke.

Yes, I hope to convince Vojtech that untranslating is evil.

The question is: what to do with a protocol scancode?
My answer from long ago was: view it as a protocol scancode only
when it is expected - after we send a command we expect an ACK.
And indeed, 2.4 still has

	if (reply_expected) {
		if (scancode == KBD_REPLY_ACK) {
			acknowledge = 1;
			reply_expected = 0;
	...

That is, the right way, or at least the way that worked since 1.1.54,
is to test only for KBD_REPLY_ACK when we just sent something.

The wrong solution follows below (not compiled or tested):

--- atkbd.c~    Mon Sep 29 09:12:26 2003
+++ atkbd.c     Tue Oct 14 23:15:57 2003
@@ -183,11 +183,19 @@
                atkbd->resend = 0;
 #endif
 
+       switch (code) {
+               case ATKBD_RET_ACK:
+                       atkbd->ack = 1;
+                       goto out;
+               case ATKBD_RET_NAK:
+                       atkbd->ack = -1;
+                       goto out;
+       }
+
        if (atkbd->translated) do {
 
                if (atkbd->emul != 1) {
-                       if (code == ATKBD_RET_EMUL0 || code == ATKBD_RET_EMUL1 ||
-                           code == ATKBD_RET_ACK || code == ATKBD_RET_NAK)
+                       if (code == ATKBD_RET_EMUL0 || code == ATKBD_RET_EMUL1)
                                break;
                        if (code == ATKBD_RET_BAT) {
                                if (!atkbd->bat_xl)
@@ -211,15 +219,6 @@
 
        } while (0);
 
-       switch (code) {
-               case ATKBD_RET_ACK:
-                       atkbd->ack = 1;
-                       goto out;
-               case ATKBD_RET_NAK:
-                       atkbd->ack = -1;
-                       goto out;
-       }
-
        if (atkbd->cmdcnt) {
                atkbd->cmdbuf[--atkbd->cmdcnt] = code;
                goto out;

(This is right for the great majority of people that does not
have fa,fe occur as non-protocol scancodes. In rare cases
some more surgery is needed. Left to Vojtech.)

Andries


[patch against some source similar to 2.6.0-test6]

