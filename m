Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293187AbSB1Vcx>; Thu, 28 Feb 2002 16:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310201AbSB1VbE>; Thu, 28 Feb 2002 16:31:04 -0500
Received: from thufir.bluecom.no ([217.118.32.12]:23304 "EHLO
	thufir.bluecom.no") by vger.kernel.org with ESMTP
	id <S310170AbSB1V1i>; Thu, 28 Feb 2002 16:27:38 -0500
Subject: Re: [PATCH] 2.4.18 Eicon ISDN driver fix.
From: petter wahlman <petter@bluezone.no>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Armin Schindler <mac@melware.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        info@melware.de
In-Reply-To: <Pine.LNX.4.21.0202281441330.2182-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0202281441330.2182-100000@freak.distro.conectiva>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 28 Feb 2002 22:14:08 +0100
Message-Id: <1014930851.26536.0.camel@BadEip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-02-28 at 18:41, Marcelo Tosatti wrote:
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
> 

--- linux/drivers/isdn/eicon/eicon_mod.c        Fri Dec 21 18:41:54 2001
+++ linux-2.4.18-pw/drivers/isdn/eicon/eicon_mod.c      Thu Feb 28
21:48:32 2002
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




