Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291640AbSB0C2H>; Tue, 26 Feb 2002 21:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291664AbSB0C1u>; Tue, 26 Feb 2002 21:27:50 -0500
Received: from zero.tech9.net ([209.61.188.187]:43791 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S291640AbSB0C1g>;
	Tue, 26 Feb 2002 21:27:36 -0500
Subject: Re: is there a spin_trylock_irqsave?
From: Robert Love <rml@tech9.net>
To: Gigi Sebastian Alapatt <ggnet@hotmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F132iGXix4A2DreBBsQ00008ce6@hotmail.com>
In-Reply-To: <F132iGXix4A2DreBBsQ00008ce6@hotmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 26 Feb 2002 21:27:37 -0500
Message-Id: <1014776857.879.104.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-02-26 at 21:14, Gigi Sebastian Alapatt wrote:
> 
> Is there a spin_trylock_irqsave?
> 
> Basicially
> 
> spin_once_trylock_irqsave?

No, although there is a spin_trylock_bh for whatever reason.

Implementing this would not be hard, you just need to disable irqs
_before_ spin_trylock to avoid a race.  Something like:

	int dog;
	unsigned long flags;

	local_irq_save(flags);
	dog = spin_trylock(lock);
	if (!dog)
		local_irq_restore(flags);

Oh, I'll just attach a patch.  Enjoy,

	Robert Love

diff -urN linus/include/linux/spinlock.h linux/include/linux/spinlock.h
--- linus/include/linux/spinlock.h	Tue Feb 26 20:17:12 2002
+++ linux/include/linux/spinlock.h	Tue Feb 26 21:22:22 2002
@@ -38,6 +38,12 @@
 						__r = spin_trylock(lock);      \
 						if (!__r) local_bh_enable();   \
 						__r; })
+#define spin_trylock_irqsave(lock, flags)	({ int __r;		       \
+						local_irq_save(flags);         \
+						__r = spin_trylock(lock);      \
+						if (!__r)                      \
+						local_irq_restore(flags);      \
+						__r; })
 
 /* Must define these before including other files, inline functions need them */
 

