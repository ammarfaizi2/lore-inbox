Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbVBMV5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVBMV5z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 16:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVBMV5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 16:57:55 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:62223 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261315AbVBMV5w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 16:57:52 -0500
Date: Mon, 14 Feb 2005 08:56:45 +1100
To: Christian Heim <christian.th.heim@gmx.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       kai.germaschewski@gmx.de
Subject: Re: linux-2.6.11-rc3 and isdn mppp
Message-ID: <20050213215645.GA9704@gondor.apana.org.au>
References: <200502121750.23899.christian.th.heim@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <200502121750.23899.christian.th.heim@gmx.de>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 12, 2005 at 04:50:23PM +0000, Christian Heim wrote:
> Well, i have to setup ISDN here at home, and wanted to use both channels.
> I am able to add the second channel, but then the kernel (at least i think) 
> starts to complain.
> 
> >17:36:22 kraftwerk Badness in local_bh_enable at kernel/softirq.c:140
> >17:36:22 kraftwerk [<c011b201>] local_bh_enable+0x71/0x80
> >17:36:22 kraftwerk [<c030c1a7>] isdn_ppp_xmit+0xe7/0x7d0

isdn_net_get_locked_lp is doing a local_bh_enable with hard IRQs
disabled.  This is not allowed.

The following patch fixes the problem by removing the unnecessary
local_bh_enable while the hard IRQs are disabled.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

===== drivers/isdn/i4l/isdn_net.h 1.48 vs edited =====
--- 1.48/drivers/isdn/i4l/isdn_net.h	2004-06-23 00:44:03 +10:00
+++ edited/drivers/isdn/i4l/isdn_net.h	2005-02-14 08:52:19 +11:00
@@ -78,18 +78,19 @@
 
 	spin_lock_irqsave(&nd->queue_lock, flags);
 	lp = nd->queue;         /* get lp on top of queue */
-	spin_lock_bh(&nd->queue->xmit_lock);
+	spin_lock(&nd->queue->xmit_lock);
 	while (isdn_net_lp_busy(nd->queue)) {
-		spin_unlock_bh(&nd->queue->xmit_lock);
+		spin_unlock(&nd->queue->xmit_lock);
 		nd->queue = nd->queue->next;
 		if (nd->queue == lp) { /* not found -- should never happen */
 			lp = NULL;
 			goto errout;
 		}
-		spin_lock_bh(&nd->queue->xmit_lock);
+		spin_lock(&nd->queue->xmit_lock);
 	}
 	lp = nd->queue;
 	nd->queue = nd->queue->next;
+	local_bh_disable();
 errout:
 	spin_unlock_irqrestore(&nd->queue_lock, flags);
 	return lp;

--/04w6evG8XlLl3ft--
