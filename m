Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264623AbUFMAUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264623AbUFMAUj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 20:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264670AbUFMAUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 20:20:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:2276 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264623AbUFMAUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 20:20:36 -0400
Date: Sat, 12 Jun 2004 17:19:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Ford <david+challenge-response@blue-labs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sound driver (opti) spinlock bug, 2.6.7-rc3
Message-Id: <20040612171947.31218266.akpm@osdl.org>
In-Reply-To: <40CB632B.2070706@blue-labs.org>
References: <40CB632B.2070706@blue-labs.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford <david+challenge-response@blue-labs.org> wrote:
>
> sound/isa/opti9xx/opti92x-ad1848.c:428: 
>  spin_lock(sound/isa/opti9xx/opti92x-ad1848.c:cf40eea0) already locked by 
>  sound/isa/opti9xx/opti92x-ad1848.c/604

Like this?

The locking in there seems fairly optimistic - looks like someone did a
cli() translation on it.

--- 25/sound/isa/opti9xx/opti92x-ad1848.c~opti92x-ad1848-locking-fix	2004-06-12 17:09:38.699325296 -0700
+++ 25-akpm/sound/isa/opti9xx/opti92x-ad1848.c	2004-06-12 17:16:38.029577408 -0700
@@ -601,13 +601,11 @@ __skip_base:
 	dma_bits |= 0x04;
 #endif	/* CS4231 || OPTi93X */
 
-	spin_lock_irqsave(&chip->lock, flags);
 #ifndef OPTi93X
-	 outb(irq_bits << 3 | dma_bits, chip->wss_base);
+	outb(irq_bits << 3 | dma_bits, chip->wss_base);
 #else /* OPTi93X */
 	snd_opti9xx_write(chip, OPTi9XX_MC_REG(3), (irq_bits << 3 | dma_bits));
 #endif /* OPTi93X */
-	spin_unlock_irqrestore(&chip->lock, flags);
 
 __skip_resources:
 	if (chip->hardware > OPTi9XX_HW_82C928) {
_

