Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWEPVlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWEPVlr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 17:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWEPVlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 17:41:15 -0400
Received: from mail.kroah.org ([69.55.234.183]:33966 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932184AbWEPVkp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 17:40:45 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 10/10] SPI: spi_bitbang: clocking fixes
Reply-To: Greg KH <greg@kroah.com>
Date: Tue, 16 May 2006 14:38:38 -0700
Message-Id: <11478155192773-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.3.2
In-Reply-To: <1147815518968-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Brownell <david-b@pacbell.net>

This fixes two problems triggered by the MMC stack updating clocks:

 - SPI masters driver should accept a max clock speed of zero; that's one
   convention for marking idle devices.  (Presumably that helps controllers
   that don't autogate clocks to "off" when not in use.)

 - There are more than 1000 nanoseconds per millisecond; setting the clock
   down to 125 KHz now works properly.

Showing once again that Zero (http://en.wikipedia.org/wiki/Zero) is still
an inexhaustible number of bugs.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 drivers/spi/spi_bitbang.c |   24 ++++++++++++++----------
 1 files changed, 14 insertions(+), 10 deletions(-)

1e316d7566b63767aa18902235c719e9e95465d0
diff --git a/drivers/spi/spi_bitbang.c b/drivers/spi/spi_bitbang.c
index 0f7f5c6..dd2f950 100644
--- a/drivers/spi/spi_bitbang.c
+++ b/drivers/spi/spi_bitbang.c
@@ -167,9 +167,11 @@ int spi_bitbang_setup_transfer(struct sp
 	/* nsecs = (clock period)/2 */
 	if (!hz)
 		hz = spi->max_speed_hz;
-	cs->nsecs = (1000000000/2) / hz;
-	if (cs->nsecs > MAX_UDELAY_MS * 1000)
-		return -EINVAL;
+	if (hz) {
+		cs->nsecs = (1000000000/2) / hz;
+		if (cs->nsecs > (MAX_UDELAY_MS * 1000 * 1000))
+			return -EINVAL;
+	}
 
 	return 0;
 }
@@ -184,9 +186,6 @@ int spi_bitbang_setup(struct spi_device 
 	struct spi_bitbang	*bitbang;
 	int			retval;
 
-	if (!spi->max_speed_hz)
-		return -EINVAL;
-
 	bitbang = spi_master_get_devdata(spi->master);
 
 	/* REVISIT: some systems will want to support devices using lsb-first
@@ -216,7 +215,7 @@ int spi_bitbang_setup(struct spi_device 
 	if (retval < 0)
 		return retval;
 
-	dev_dbg(&spi->dev, "%s, mode %d, %u bits/w, %u nsec\n",
+	dev_dbg(&spi->dev, "%s, mode %d, %u bits/w, %u nsec/bit\n",
 			__FUNCTION__, spi->mode & (SPI_CPOL | SPI_CPHA),
 			spi->bits_per_word, 2 * cs->nsecs);
 
@@ -405,6 +404,7 @@ int spi_bitbang_transfer(struct spi_devi
 {
 	struct spi_bitbang	*bitbang;
 	unsigned long		flags;
+	int			status = 0;
 
 	m->actual_length = 0;
 	m->status = -EINPROGRESS;
@@ -414,11 +414,15 @@ int spi_bitbang_transfer(struct spi_devi
 		return -ESHUTDOWN;
 
 	spin_lock_irqsave(&bitbang->lock, flags);
-	list_add_tail(&m->queue, &bitbang->queue);
-	queue_work(bitbang->workqueue, &bitbang->work);
+	if (!spi->max_speed_hz)
+		status = -ENETDOWN;
+	else {
+		list_add_tail(&m->queue, &bitbang->queue);
+		queue_work(bitbang->workqueue, &bitbang->work);
+	}
 	spin_unlock_irqrestore(&bitbang->lock, flags);
 
-	return 0;
+	return status;
 }
 EXPORT_SYMBOL_GPL(spi_bitbang_transfer);
 
-- 
1.3.2

