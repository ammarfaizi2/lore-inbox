Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757636AbWKXHy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757636AbWKXHy3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 02:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757637AbWKXHy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 02:54:29 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:63649 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1757634AbWKXHy3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 02:54:29 -0500
Date: Fri, 24 Nov 2006 10:54:23 +0300
From: Vitaly Wool <vitalywool@gmail.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: drzeus-mmc@drzeus.cx, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix random SD/MMC card recognition failures on ARM
 Versatile
Message-Id: <20061124105423.e799e73e.vitalywool@gmail.com>
In-Reply-To: <20061123194236.GD8984@flint.arm.linux.org.uk>
References: <20061123184606.bb203ae6.vitalywool@gmail.com>
	<20061123160335.GB8984@flint.arm.linux.org.uk>
	<acd2a5930611231129v3515022al931bec5b04ce27f@mail.gmail.com>
	<20061123194236.GD8984@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.13; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2006 19:42:36 +0000
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> Ah, I see it.  In that case we need to call mmc_stop_data() when
> we're ending the initial command due to an error.  IOW, like this:
<snip> 

I'd suggest arranging that in a bit different way. It looks like it works better when MMCIDATACTRL/MMCIMASK1 are cleared after MMCICOMMAND (and I think it makes more sense to clear the command register first, thus we have less change to get spurious interrupts after MMCIMASK1 is set).

diff --git a/drivers/mmc/mmci.c b/drivers/mmc/mmci.c
index 828503c..afbb63b 100644
--- a/drivers/mmc/mmci.c
+++ b/drivers/mmc/mmci.c
@@ -37,11 +37,21 @@ #define DBG(host,fmt,args...)	\
 
 static unsigned int fmax = 515633;
 
+static void mmci_stop_data(struct mmci_host *host)
+{
+	writel(0, host->base + MMCIDATACTRL);
+	writel(0, host->base + MMCIMASK1);
+	host->data = NULL;
+}
+
 static void
 mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 {
 	writel(0, host->base + MMCICOMMAND);
 
+	if (host->data)
+		mmci_stop_data(host);
+
 	host->mrq = NULL;
 	host->cmd = NULL;
 
@@ -57,13 +67,6 @@ mmci_request_end(struct mmci_host *host,
 	spin_lock(&host->lock);
 }
 
-static void mmci_stop_data(struct mmci_host *host)
-{
-	writel(0, host->base + MMCIDATACTRL);
-	writel(0, host->base + MMCIMASK1);
-	host->data = NULL;
-}
-
 static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 {
 	unsigned int datactrl, timeout, irqmask;
@@ -168,8 +171,6 @@ mmci_data_irq(struct mmci_host *host, st
 			flush_dcache_page(host->sg_ptr->page);
 	}
 	if (status & MCI_DATAEND) {
-		mmci_stop_data(host);
-
 		if (!data->stop) {
 			mmci_request_end(host, data->mrq);
 		} else {


Vitaly
