Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWFBDKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWFBDKE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 23:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWFBDKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 23:10:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:61019 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751170AbWFBDKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 23:10:02 -0400
X-IronPort-AV: i="4.05,200,1146466800"; 
   d="scan'208"; a="44695348:sNHT20321504"
Subject: Re: [patch mm1-rc2] lock validator: netlink.c netlink_table_grab
	fix
From: Zhu Yi <yi.zhu@intel.com>
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: Benoit Boissinot <benoit.boissinot@ens-lyon.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       jketreno@linux.intel.com
In-Reply-To: <20060601144241.GA952@slug>
References: <20060529212109.GA2058@elte.hu>
	 <20060530091415.GA13341@ens-lyon.fr>  <20060601144241.GA952@slug>
Content-Type: multipart/mixed; boundary="=-WiH4nIzNzZYamjzR48Md"
Organization: Intel Corp.
Date: Fri, 02 Jun 2006 11:10:10 +0800
Message-Id: <1149217811.13745.127.camel@debian.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WiH4nIzNzZYamjzR48Md
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2006-06-01 at 16:42 +0200, Frederik Deweerdt wrote:
> This got rid of the oops for me, is it the right fix?

I don't think netlink will contend with hardirqs. Can you test with this
fix for ipw2200 driver?

Thanks,
-yi

--=-WiH4nIzNzZYamjzR48Md
Content-Disposition: attachment; filename=ipw2200-lockdep-fix.patch
Content-Type: text/x-patch; name=ipw2200-lockdep-fix.patch; charset=GB2312
Content-Transfer-Encoding: 7bit

diff -urp a/drivers/net/wireless/ipw2200.c b/drivers/net/wireless/ipw2200.c
--- a/drivers/net/wireless/ipw2200.c	2006-04-01 09:47:24.000000000 +0800
+++ b/drivers/net/wireless/ipw2200.c	2006-06-01 14:32:00.000000000 +0800
@@ -11058,11 +11058,9 @@ static irqreturn_t ipw_isr(int irq, void
 	if (!priv)
 		return IRQ_NONE;
 
-	spin_lock(&priv->lock);
-
 	if (!(priv->status & STATUS_INT_ENABLED)) {
 		/* Shared IRQ */
-		goto none;
+		return IRQ_NONE;
 	}
 
 	inta = ipw_read32(priv, IPW_INTA_RW);
@@ -11071,12 +11069,12 @@ static irqreturn_t ipw_isr(int irq, void
 	if (inta == 0xFFFFFFFF) {
 		/* Hardware disappeared */
 		IPW_WARNING("IRQ INTA == 0xFFFFFFFF\n");
-		goto none;
+		return IRQ_NONE;
 	}
 
 	if (!(inta & (IPW_INTA_MASK_ALL & inta_mask))) {
 		/* Shared interrupt */
-		goto none;
+		return IRQ_NONE;
 	}
 
 	/* tell the device to stop sending interrupts */
@@ -11091,12 +11089,7 @@ static irqreturn_t ipw_isr(int irq, void
 
 	tasklet_schedule(&priv->irq_tasklet);
 
-	spin_unlock(&priv->lock);
-
 	return IRQ_HANDLED;
-      none:
-	spin_unlock(&priv->lock);
-	return IRQ_NONE;
 }
 
 static void ipw_rf_kill(void *adapter)

--=-WiH4nIzNzZYamjzR48Md--
