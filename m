Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289161AbSB0H6w>; Wed, 27 Feb 2002 02:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291531AbSB0H6m>; Wed, 27 Feb 2002 02:58:42 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:55167 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S289161AbSB0H6c>; Wed, 27 Feb 2002 02:58:32 -0500
Date: Wed, 27 Feb 2002 08:58:05 +0100 (MET)
From: Armin Schindler <mac@melware.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>, <info@melware.de>,
        petter wahlman <petter@bluezone.no>
Subject: Re: [PATCH] 2.4.18 Eicon ISDN driver fix.
In-Reply-To: <1014679267.27236.6.camel@BadEip>
Message-ID: <Pine.LNX.4.31.0202270850380.17482-100000@phoenix.one.melware.de>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixes the race condition with copy_to_user and will
not introduce a new race. What can happen is that two reader-processes
may get mixed-up messages, but more than one reader isn't allowed here
anyway.

Please apply this patch to 2.4 and 2.2, it works for both.

Thanx,
Armin

On 26 Feb 2002, petter wahlman wrote:
> The following code is calling a possibly blocking operation while
> holding a spinlock.
>
>
> Petter Wahlman


--- linux-2.4.18/drivers/isdn/eicon/eicon_mod.c Fri Dec 21 18:41:54 2001
+++ linux-2.4.18-pw/drivers/isdn/eicon/eicon_mod.c      Mon Feb 25
23:45:05 2002
@@ -665,8 +665,11 @@
                        else
                                cnt = skb->len;

-                       if (user)
+                       if (user) {
+                               spin_unlock_irqrestore(&eicon_lock,
flags);
                                copy_to_user(p, skb->data, cnt);
+                               spin_lock_irqsave(&eicon_lock, flags);
+                       }
                        else
                                memcpy(p, skb->data, cnt);






