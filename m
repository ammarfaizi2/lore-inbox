Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWGKVpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWGKVpX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 17:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWGKVpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 17:45:20 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:23244 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751333AbWGKVpS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 17:45:18 -0400
Date: Tue, 11 Jul 2006 15:32:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Michael Buesch <mb@bu3sch.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, yi.zhu@intel.com,
       jketreno@linux.intel.com, Netdev list <netdev@vger.kernel.org>,
       linville@tuxdriver.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] do not allow IPW_2100=Y or IPW_2200=Y
Message-ID: <20060711133227.GA1650@elf.ucw.cz>
References: <20060710152032.GA8540@elf.ucw.cz> <44B2940A.2080102@pobox.com> <200607102305.06572.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607102305.06572.mb@bu3sch.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2006-07-10 23:05:06, Michael Buesch wrote:
> On Monday 10 July 2006 19:53, you wrote:
> > Pavel Machek wrote:
> > > Kconfig currently allows compiling IPW_2100 and IPW_2200 into kernel
> > > (not as a module). Unfortunately, such configuration does not work,
> > > because these drivers need a firmware, and it can't be loaded by
> > > userspace loader when userspace is not running.
> > 
> > False, initramfs...
> 
> Does the ipw driver _really_ need the firmware on insmod time?
> bcm43xx, for example, loads the firmware on "ifconfig up" time.
> If ipw really needs the firmware on insmod, is it possible to
> defer it to later at "ifconfig up" time?

Probably not. This (very dirty) hack implements that (with some level
of success -- ifconfig down/ifconfig up is enough to get wireless
working).

Signed-off-by: Pavel Machek <pavel@suse.cz>

									Pavel

--- clean-mm/drivers/net/wireless/ipw2200.c	2006-07-11 15:22:50.000000000 +0200
+++ linux-mm/drivers/net/wireless/ipw2200.c	2006-07-11 14:38:01.000000000 +0200
@@ -97,6 +97,7 @@
 static int bt_coexist = 0;
 static int hwcrypto = 0;
 static int roaming = 1;
+static int needs_reinit = 1;
 static const char ipw_modes[] = {
 	'a', 'b', 'g', '?'
 };
@@ -10013,10 +10014,20 @@
 	sys_config->silence_threshold = 0x1e;
 }
 
+static int ipw_pci_suspend(struct pci_dev *pdev, pm_message_t state);
+static int ipw_pci_resume(struct pci_dev *pdev);
+
 static int ipw_net_open(struct net_device *dev)
 {
 	struct ipw_priv *priv = ieee80211_priv(dev);
 	IPW_DEBUG_INFO("dev->open\n");
+
+	if (needs_reinit) {
+		printk("ipw: Delayed loading the firmware\n");
+		ipw_pci_suspend(priv->pci_dev, PMSG_FREEZE);
+		ipw_pci_resume(priv->pci_dev);
+	}
+
 	/* we should be verifying the device is ready to be opened */
 	mutex_lock(&priv->mutex);
 	if (!(priv->status & STATUS_RF_KILL_MASK) &&
@@ -11295,7 +11306,8 @@
 
 	if (ipw_up(priv)) {
 		mutex_unlock(&priv->mutex);
-		return -EIO;
+		needs_reinit = 1;
+		return 0;
 	}
 
 	mutex_unlock(&priv->mutex);


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
