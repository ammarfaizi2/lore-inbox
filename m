Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310373AbSCAHdS>; Fri, 1 Mar 2002 02:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310371AbSCAHbZ>; Fri, 1 Mar 2002 02:31:25 -0500
Received: from moutvdomng1.kundenserver.de ([212.227.126.181]:52168 "EHLO
	moutvdomng1.kundenserver.de") by vger.kernel.org with ESMTP
	id <S310372AbSCAHaf>; Fri, 1 Mar 2002 02:30:35 -0500
Date: Fri, 1 Mar 2002 08:30:31 +0100 (MET)
From: Armin Schindler <mac@melware.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        <info@melware.de>, petter wahlman <petter@bluezone.no>
Subject: Re: [PATCH] 2.4.18 Eicon ISDN driver fix.
In-Reply-To: <Pine.LNX.4.21.0202281441330.2182-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.31.0203010828210.8560-100000@phoenix.one.melware.de>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2002, Marcelo Tosatti wrote:
>
>
> On Wed, 27 Feb 2002, Armin Schindler wrote:
>
> > The patch below fixes the race condition with copy_to_user and will
> > not introduce a new race. What can happen is that two reader-processes
> > may get mixed-up messages, but more than one reader isn't allowed here
> > anyway.
> >
> > Please apply this patch to 2.4 and 2.2, it works for both.
>
> Armin,
>
> Your patch does not apply cleanly against my tree.
>
> Please regenerate it.

Hi Marcelo,

I don't why the patch does not apply, maybe whitespace problems ?
Okay, here it is again. I tested it with 2.4.18.

Thanks Armin


diff -Nurb pristine/drivers/isdn/eicon/eicon_mod.c linux/drivers/isdn/eicon/eicon_mod.c
--- pristine/drivers/isdn/eicon/eicon_mod.c	Fri Dec 21 18:41:54 2001
+++ linux/drivers/isdn/eicon/eicon_mod.c	Fri Mar  1 08:07:44 2002
@@ -665,8 +665,11 @@
 			else
 				cnt = skb->len;

-			if (user)
+			if (user) {
+				spin_unlock_irqrestore(&eicon_lock, flags);
 				copy_to_user(p, skb->data, cnt);
+				spin_lock_irqsave(&eicon_lock, flags);
+			}
 			else
 				memcpy(p, skb->data, cnt);



