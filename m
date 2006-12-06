Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937574AbWLFTuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937574AbWLFTuL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 14:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937577AbWLFTuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 14:50:11 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:60179 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937574AbWLFTuJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 14:50:09 -0500
Date: Wed, 6 Dec 2006 19:50:06 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: ... and more...
Message-ID: <20061206195006.GH4587@ftp.linux.org.uk>
References: <20061206184145.GC4587@ftp.linux.org.uk> <20061206185140.GD4587@ftp.linux.org.uk> <20061206191820.GF4587@ftp.linux.org.uk> <20061206194641.GG4587@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061206194641.GG4587@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2006 at 07:46:41PM +0000, Al Viro wrote:

Gah...  Harmless but stupid: leftover netdev_priv(dev);

diff --git a/drivers/i2c/chips/m41t00.c b/drivers/i2c/chips/m41t00.c
index 2dd0a34..420377c 100644
--- a/drivers/i2c/chips/m41t00.c
+++ b/drivers/i2c/chips/m41t00.c
@@ -215,8 +215,15 @@ m41t00_set(void *arg)
 }
 
 static ulong new_time;
+/* well, isn't this API just _lovely_? */
+static void
+m41t00_barf(struct work_struct *unusable)
+{
+	m41t00_set(&new_time);
+}
+
 static struct workqueue_struct *m41t00_wq;
-static DECLARE_WORK(m41t00_work, m41t00_set, &new_time);
+static DECLARE_WORK(m41t00_work, m41t00_barf);
 
 int
 m41t00_set_rtc_time(ulong nowtime)
diff --git a/drivers/net/mv643xx_eth.c b/drivers/net/mv643xx_eth.c
index 21d0137..c41ae42 100644
--- a/drivers/net/mv643xx_eth.c
+++ b/drivers/net/mv643xx_eth.c
@@ -277,9 +277,11 @@ static void mv643xx_eth_tx_timeout(struc
  *
  * Actual routine to reset the adapter when a timeout on Tx has occurred
  */
-static void mv643xx_eth_tx_timeout_task(struct net_device *dev)
+static void mv643xx_eth_tx_timeout_task(struct work_struct *ugly)
 {
-	struct mv643xx_private *mp = netdev_priv(dev);
+	struct mv643xx_private *mp = container_of(ugly, struct mv643xx_private,
+						  tx_timeout_task);
+	struct net_device *dev = mp->mii.dev; /* yuck */
 
 	if (!netif_running(dev))
 		return;
@@ -1360,8 +1362,7 @@ #endif
 #endif
 
 	/* Configure the timeout task */
-	INIT_WORK(&mp->tx_timeout_task,
-			(void (*)(void *))mv643xx_eth_tx_timeout_task, dev);
+	INIT_WORK(&mp->tx_timeout_task, mv643xx_eth_tx_timeout_task);
 
 	spin_lock_init(&mp->lock);
 

