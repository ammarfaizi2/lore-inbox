Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263025AbTGTHsS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 03:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbTGTHsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 03:48:18 -0400
Received: from fc.capaccess.org ([151.200.199.53]:40973 "EHLO fc.capaccess.org")
	by vger.kernel.org with ESMTP id S262931AbTGTHsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 03:48:16 -0400
Message-id: <fc.0010c7b2009ad0a90010c7b2009ad0a9.9ad0aa@capaccess.org>
Date: Sun, 20 Jul 2003 04:05:19 -0400
Subject: Forreal Mode update
To: linux-kernel@vger.kernel.org, linux-assembly@vger.kernel.org
From: "Rick A. Hohensee" <rickh@capaccess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't have interrupts working in Forreal Mode yet, but I think I've
figured out what the two likely scenarios are. (Forreal Mode is
unprotected USE32. PE=0, Dbit in CS descriptor =1.)

PE=0 clearly means intvecs are 4-byte 8086-emulation-style, regardless of
Dbit. The exact description of INT says so, and it would be a very big
deal for it to be otherwise, like a special class of GDTless interrupt
gate for a mode INTeL doesn't support, or who knows what. The issue a
4-byte intvec creates in a USE32 world is what happens to a USE32 EIP
when the intvec offset is assigned to IP. Just IP, not EIP. Is the high
side of EIP persistant, like the high side of EAX when you clobber AX, or
does it get zeroed? Those appear to be the two possibilities. Getting
zeroed, UNLIKE EAX, would be better. Then your Forreal Mode event handler
code needs to be in the low meg. Just the handlers, and just thier
entry-points. No-Sweat Item. IF, HOWEVER, the high side of EIP is simply
left there, all is not lost. Then there are schemes to replicate faux IDTs
every 64k, and you can still have more than a meg of code in 32 bit
unprotected Forreal Mode. And with an extra jump to get to the actual
handler code Forreal Mode may still be faster to handle interrupts than
Pmode, thanks in part to the 4-byte intvecs.

Things that aren't issues are the Dbit of the handler code, which can be
USE32 also, and if fact must be, and thus the interrupt and the IRET stack
frames balance. The rmode CS values in the intvecs probably should all be
0, keeping them in the non-issue category. The real sticky bit is the
undefined behavior of the high side of EIP.

Even if you have to do something like keep all code in the low meg, data
beyond the low meg is already a non-issue in Forreal Mode.

Rick Hohensee


