Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268899AbRG0Q5J>; Fri, 27 Jul 2001 12:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268896AbRG0Q4u>; Fri, 27 Jul 2001 12:56:50 -0400
Received: from tahallah.demon.co.uk ([158.152.175.193]:9223 "EHLO
	tahallah.demon.co.uk") by vger.kernel.org with ESMTP
	id <S268895AbRG0Q4j>; Fri, 27 Jul 2001 12:56:39 -0400
Date: Fri, 27 Jul 2001 17:54:45 +0100 (BST)
From: Alex Buell <alex.buell@tahallah.demon.co.uk>
X-X-Sender: <alex@tahallah.demon.co.uk>
Reply-To: <alex.buell@tahallah.demon.co.uk>
To: Anton Blanchard <anton@samba.org>
cc: Mailing List - sparclinux <sparclinux@vger.kernel.org>,
        "David S. Miller" <davem@redhat.com>,
        Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: cg14 frambuffer bug in 2.2.19 (and probably 2.4.x as well)
In-Reply-To: <20010728000508.A5602@krispykreme>
Message-ID: <Pine.LNX.4.33.0107271747370.12765-100000@tahallah.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sat, 28 Jul 2001, Anton Blanchard wrote:

> Im compiling my kernels on 2.95.3 at the moment. I found one bug that
> turned out to be my fault (in include/asm-sparc/bitops.h), but there
> are sure to be more I havent caught yet.

Hmm, just seen davem's list of CVS commits, have run an update just now,
and will try again using 2.95.3.

Here's a patch to apply on top of the fix applied to 2.4.7 today, to fix
the ugliness of the if {} else {} statement and save a few bytes.

PS: If we need to discuss this any further, let's move this back to
sparclinux mailing list, shall we?

--- linux/drivers/video/cgfourteenfb.c.orig     Fri Jul 27 17:41:15 2001
+++ linux/drivers/video/cgfourteenfb.c  Fri Jul 27 17:46:15 2001
@@ -236,19 +236,17 @@
        struct cg_cursor *c = &fb->cursor;
        struct cg14_cursor *cur = fb->s.cg14.cursor;
        unsigned long flags;
+       u8 tmp;

        spin_lock_irqsave(&fb->lock, flags);
-       if (c->enable) {
-               u8 tmp = sbus_readb(&cur->ccr);
+       tmp = sbus_readb(&cur->ccr);

+       if (c->enable)
                tmp |= CG14_CCR_ENABLE;
-               sbus_writeb(tmp, &cur->ccr);
-       } else {
-               u8 tmp = sbus_readb(&cur->ccr);
-
+       else
                tmp &= ~CG14_CCR_ENABLE;
-               sbus_writeb(tmp, &cur->ccr);
-       }
+
+       sbus_writeb(tmp, &cur->ccr);
        sbus_writew(((c->cpos.fbx - c->chot.fbx) & 0xfff), &cur->cursx);
        sbus_writew(((c->cpos.fby - c->chot.fby) & 0xfff), &cur->cursy);
        spin_unlock_irqrestore(&fb->lock, flags);


-- 
Hey, they *are* out to get you, but it's nothing personal.

http://www.tahallah.demon.co.uk


