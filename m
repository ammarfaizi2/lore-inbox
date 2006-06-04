Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751335AbWFDKIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWFDKIn (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 06:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWFDKIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 06:08:43 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:65193 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1751335AbWFDKIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 06:08:43 -0400
Subject: [patch, -rc5-mm3] lock validator: fix ns83820.c irq-flags part 3
From: Arjan van de Ven <arjan@linux.intel.com>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@osdl.org>
In-Reply-To: <986ed62e0606040253pfe9c300qf88029f88ae65039@mail.gmail.com>
References: <20060604083017.GA8241@elte.hu>
	 <1149411525.3109.73.camel@laptopd505.fenrus.org>
	 <986ed62e0606040253pfe9c300qf88029f88ae65039@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 04 Jun 2006 12:08:27 +0200
Message-Id: <1149415707.3109.96.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-04 at 02:53 -0700, Barry K. Nathan wrote:
> On 6/4/06, Arjan van de Ven <arjan@linux.intel.com> wrote:
> > just the preempt the next email from Barry; while fixing this one I
> > looked at the usage of the locks more and found another patch needed...
> [snip]
> 
> Nice try, but it didn't work. ~_^
> 
> I was about to reply to the previous ns83820 patch with my dmesg, when
> I saw this one. I applied this patch too, and like the previous patch,
> it reports an instance of illegal lock usage. My dmesg follows.
> -- 


ok this is a real driver deadlock:

The ns83820 driver enabled interrupts (by unlocking the misc_lock with
_irq) while still holding the rx_info.lock, which is required to be irq
safe since it's used in the ISR like this:
                writel(1, dev->base + IER);
                spin_unlock_irq(&dev->misc_lock);
                kick_rx(ndev);
                spin_unlock_irq(&dev->rx_info.lock);

This is can cause a deadlock if an irq was pending at the first
spin_unlock_irq already, or if one would hit during kick_rx(). 
Simply remove the first _irq solves this

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>


---
 drivers/net/ns83820.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.17-rc5-mm3/drivers/net/ns83820.c
===================================================================
--- linux-2.6.17-rc5-mm3.orig/drivers/net/ns83820.c
+++ linux-2.6.17-rc5-mm3/drivers/net/ns83820.c
@@ -808,7 +808,7 @@ static int ns83820_setup_rx(struct net_d
 
 		writel(dev->IMR_cache, dev->base + IMR);
 		writel(1, dev->base + IER);
-		spin_unlock_irq(&dev->misc_lock);
+		spin_unlock(&dev->misc_lock);
 
 		kick_rx(ndev);
 

