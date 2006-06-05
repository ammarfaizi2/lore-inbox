Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932318AbWFEDkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWFEDkp (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 23:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWFEDkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 23:40:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:13683 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932318AbWFEDko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 23:40:44 -0400
X-IronPort-AV: i="4.05,207,1146466800"; 
   d="scan'208"; a="45772349:sNHT20202665"
Subject: Re: [patch mm1-rc2] lock validator: netlink.c netlink_table_grab
	fix
From: Zhu Yi <yi.zhu@intel.com>
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: Benoit Boissinot <benoit.boissinot@ens-lyon.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
        Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
        jketreno@linux.intel.com
In-Reply-To: <20060602095303.GA1115@slug>
References: <20060529212109.GA2058@elte.hu>
	 <20060530091415.GA13341@ens-lyon.fr> <20060601144241.GA952@slug>
	 <1149217811.13745.127.camel@debian.sh.intel.com>
	 <20060602095303.GA1115@slug>
Content-Type: multipart/mixed; boundary="=-XVCEJ/dxc/U//r8tcEZd"
Organization: Intel Corp.
Date: Mon, 05 Jun 2006 11:40:46 +0800
Message-Id: <1149478847.27879.19.camel@debian.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XVCEJ/dxc/U//r8tcEZd
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2006-06-02 at 09:53 +0000, Frederik Deweerdt wrote:
> On Fri, Jun 02, 2006 at 11:10:10AM +0800, Zhu Yi wrote:
> > On Thu, 2006-06-01 at 16:42 +0200, Frederik Deweerdt wrote:
> > > This got rid of the oops for me, is it the right fix?
> > 
> > I don't think netlink will contend with hardirqs. Can you test with this
> > fix for ipw2200 driver?
> > 
> It does work, thanks. But doesn't this add a possibility of missing 
> some interrupts?
> 	cpu0				cpu1
>         ====				====
> in isr				in tasklet
> 
> 				ipw_enable_interrupts
> 				|->priv->status |= STATUS_INT_ENABLED;

This is unlikely. cpu0 should not receive ipw2200 interrupt since the
interrupt is disabled until HERE (see below).

> ipw_disable_interrupts
> |->priv->status &= ~STATUS_INT_ENABLED;
> |->ipw_write32(priv, IPW_INTA_MASK_R, ~IPW_INTA_MASK_ALL);
> 
> 				|->ipw_write32(priv, IPW_INTA_MASK_R, IPW_INTA_MASK_ALL);
> 				/* This is possible due to priv->lock no longer being taken
> 				   in isr */

				HERE


Well, this is not 100% if when the card fires two consecutive
interrupts. Though unlikely, it's better to protect early than seeing
some "weird" bugs one day. I proposed attached patch. If you can help to
test, that will be appreciated (I cannot see the lockdep warning on my
box somehow).

Thanks,
-yi

--=-XVCEJ/dxc/U//r8tcEZd
Content-Disposition: attachment; filename=lock_irq.patch
Content-Type: text/x-patch; name=lock_irq.patch; charset=GB2312
Content-Transfer-Encoding: 7bit

diff -urp a/drivers/net/wireless/ipw2200.c b/drivers/net/wireless/ipw2200.c
--- a/drivers/net/wireless/ipw2200.c	2006-04-01 09:47:24.000000000 +0800
+++ b/drivers/net/wireless/ipw2200.c	2006-06-05 11:32:18.000000000 +0800
@@ -542,7 +542,7 @@ static inline void ipw_clear_bit(struct 
 	ipw_write32(priv, reg, ipw_read32(priv, reg) & ~mask);
 }
 
-static inline void ipw_enable_interrupts(struct ipw_priv *priv)
+static inline void __ipw_enable_interrupts(struct ipw_priv *priv)
 {
 	if (priv->status & STATUS_INT_ENABLED)
 		return;
@@ -550,7 +550,7 @@ static inline void ipw_enable_interrupts
 	ipw_write32(priv, IPW_INTA_MASK_R, IPW_INTA_MASK_ALL);
 }
 
-static inline void ipw_disable_interrupts(struct ipw_priv *priv)
+static inline void __ipw_disable_interrupts(struct ipw_priv *priv)
 {
 	if (!(priv->status & STATUS_INT_ENABLED))
 		return;
@@ -558,6 +558,20 @@ static inline void ipw_disable_interrupt
 	ipw_write32(priv, IPW_INTA_MASK_R, ~IPW_INTA_MASK_ALL);
 }
 
+static inline void ipw_enable_interrupts(struct ipw_priv *priv)
+{
+	spin_lock_irqsave(&priv->irq_lock, priv->lock_flags);
+	__ipw_enable_interrupts(priv);
+	spin_unlock_irqrestore(&priv->irq_lock, priv->lock_flags);
+}
+
+static inline void ipw_disable_interrupts(struct ipw_priv *priv)
+{
+	spin_lock_irqsave(&priv->irq_lock, priv->lock_flags);
+	__ipw_disable_interrupts(priv);
+	spin_unlock_irqrestore(&priv->irq_lock, priv->lock_flags);
+}
+
 #ifdef CONFIG_IPW2200_DEBUG
 static char *ipw_error_desc(u32 val)
 {
@@ -1959,7 +1973,7 @@ static void ipw_irq_tasklet(struct ipw_p
 	unsigned long flags;
 	int rc = 0;
 
-	spin_lock_irqsave(&priv->lock, flags);
+	spin_lock_irqsave(&priv->irq_lock, flags);
 
 	inta = ipw_read32(priv, IPW_INTA_RW);
 	inta_mask = ipw_read32(priv, IPW_INTA_MASK_R);
@@ -1968,6 +1982,10 @@ static void ipw_irq_tasklet(struct ipw_p
 	/* Add any cached INTA values that need to be handled */
 	inta |= priv->isr_inta;
 
+	spin_unlock_irqrestore(&priv->irq_lock, flags);
+
+	spin_lock_irqsave(&priv->lock, flags);
+
 	/* handle all the justifications for the interrupt */
 	if (inta & IPW_INTA_BIT_RX_TRANSFER) {
 		ipw_rx(priv);
@@ -2096,10 +2114,10 @@ static void ipw_irq_tasklet(struct ipw_p
 		IPW_ERROR("Unhandled INTA bits 0x%08x\n", inta & ~handled);
 	}
 
+	spin_unlock_irqrestore(&priv->lock, flags);
+
 	/* enable all interrupts */
 	ipw_enable_interrupts(priv);
-
-	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
 #define IPW_CMD(x) case IPW_CMD_ ## x : return #x
@@ -11058,7 +11076,7 @@ static irqreturn_t ipw_isr(int irq, void
 	if (!priv)
 		return IRQ_NONE;
 
-	spin_lock(&priv->lock);
+	spin_lock(&priv->irq_lock);
 
 	if (!(priv->status & STATUS_INT_ENABLED)) {
 		/* Shared IRQ */
@@ -11080,7 +11098,7 @@ static irqreturn_t ipw_isr(int irq, void
 	}
 
 	/* tell the device to stop sending interrupts */
-	ipw_disable_interrupts(priv);
+	__ipw_disable_interrupts(priv);
 
 	/* ack current interrupts */
 	inta &= (IPW_INTA_MASK_ALL & inta_mask);
@@ -11091,11 +11109,11 @@ static irqreturn_t ipw_isr(int irq, void
 
 	tasklet_schedule(&priv->irq_tasklet);
 
-	spin_unlock(&priv->lock);
+	spin_unlock(&priv->irq_lock);
 
 	return IRQ_HANDLED;
       none:
-	spin_unlock(&priv->lock);
+	spin_unlock(&priv->irq_lock);
 	return IRQ_NONE;
 }
 
@@ -12185,6 +12203,7 @@ static int ipw_pci_probe(struct pci_dev 
 #ifdef CONFIG_IPW2200_DEBUG
 	ipw_debug_level = debug;
 #endif
+	spin_lock_init(&priv->irq_lock);
 	spin_lock_init(&priv->lock);
 	for (i = 0; i < IPW_IBSS_MAC_HASH_SIZE; i++)
 		INIT_LIST_HEAD(&priv->ibss_mac_hash[i]);
diff -urp a/drivers/net/wireless/ipw2200.h b/drivers/net/wireless/ipw2200.h
--- a/drivers/net/wireless/ipw2200.h	2006-04-01 09:47:24.000000000 +0800
+++ b/drivers/net/wireless/ipw2200.h	2006-06-05 11:32:18.000000000 +0800
@@ -1181,6 +1181,8 @@ struct ipw_priv {
 	struct ieee80211_device *ieee;
 
 	spinlock_t lock;
+	spinlock_t irq_lock;
+	unsigned long lock_flags;
 	struct mutex mutex;
 
 	/* basic pci-network driver stuff */

--=-XVCEJ/dxc/U//r8tcEZd--
