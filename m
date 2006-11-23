Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933400AbWKWTms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933400AbWKWTms (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 14:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933472AbWKWTms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 14:42:48 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:26640 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S933400AbWKWTmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 14:42:46 -0500
Date: Thu, 23 Nov 2006 19:42:36 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Vitaly Wool <vitalywool@gmail.com>
Cc: drzeus-mmc@drzeus.cx, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix random SD/MMC card recognition failures on ARM Versatile
Message-ID: <20061123194236.GD8984@flint.arm.linux.org.uk>
Mail-Followup-To: Vitaly Wool <vitalywool@gmail.com>, drzeus-mmc@drzeus.cx,
	linux-kernel@vger.kernel.org
References: <20061123184606.bb203ae6.vitalywool@gmail.com> <20061123160335.GB8984@flint.arm.linux.org.uk> <acd2a5930611231129v3515022al931bec5b04ce27f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acd2a5930611231129v3515022al931bec5b04ce27f@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2006 at 10:29:30PM +0300, Vitaly Wool wrote:
> On 11/23/06, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> >Doubtful.  mmci_stop_data() already does this, which will be called
> >immediately prior to mmci_request_end().  So you're doubling up the
> >writes to registers again.
> 
> There's the case (mmci_cmd_irq) where mmc_stop_data is not called
> prior to mmci_request_end(), so it's not that simple.

Ah, I see it.  In that case we need to call mmc_stop_data() when
we're ending the initial command due to an error.  IOW, like this:

diff --git a/drivers/mmc/mmci.c b/drivers/mmc/mmci.c
index 828503c..5ad0259 100644
--- a/drivers/mmc/mmci.c
+++ b/drivers/mmc/mmci.c
@@ -42,6 +42,8 @@ mmci_request_end(struct mmci_host *host,
 {
 	writel(0, host->base + MMCICOMMAND);
 
+	BUG_ON(host->data);
+
 	host->mrq = NULL;
 	host->cmd = NULL;
 
@@ -198,6 +200,8 @@ mmci_cmd_irq(struct mmci_host *host, str
 	}
 
 	if (!cmd->data || cmd->error != MMC_ERR_NONE) {
+		if (host->data)
+			mmci_stop_data(host);
 		mmci_request_end(host, cmd->mrq);
 	} else if (!(cmd->data->flags & MMC_DATA_READ)) {
 		mmci_start_data(host, cmd->data);


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
