Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264385AbTDXESW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 00:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbTDXESW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 00:18:22 -0400
Received: from adsl-63-206-88-150.dsl.snfc21.pacbell.net ([63.206.88.150]:3225
	"EHLO mnm.digeo.com") by vger.kernel.org with ESMTP id S264385AbTDXESU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 00:18:20 -0400
Date: Wed, 23 Apr 2003 21:31:19 -0700
From: Andrew Morton <akpm@digeo.com>
To: steven roemen <sdroemen1@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.68-mm2 bttv oops
Message-Id: <20030423213119.26c74759.akpm@digeo.com>
In-Reply-To: <1051153462.997.159.camel@lws04.home.net>
References: <1051153462.997.159.camel@lws04.home.net>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

steven roemen <sdroemen1@cox.net> wrote:
>
> here's what is in the syslog after booting the 2.5.68-mm2 kernel:
> bttv is built into the kernel.

This'll fix it up

 25-akpm/drivers/media/video/bttv-driver.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff -puN drivers/media/video/bttv-driver.c~irqreturn-bttv drivers/media/video/bttv-driver.c
--- 25/drivers/media/video/bttv-driver.c~irqreturn-bttv	Wed Apr 23 18:00:18 2003
+++ 25-akpm/drivers/media/video/bttv-driver.c	Wed Apr 23 18:02:52 2003
@@ -1279,7 +1279,7 @@ static int bttv_prepare_buffer(struct bt
 }
 
 static int
-buffer_setup(struct file *file, int *count, int *size)
+buffer_setup(struct file *file, unsigned int *count, unsigned int *size)
 {
 	struct bttv_fh *fh = file->private_data;
 	
@@ -3156,22 +3156,23 @@ bttv_irq_switch_fields(struct bttv *btv)
 	spin_unlock(&btv->s_lock);
 }
 
-static void bttv_irq(int irq, void *dev_id, struct pt_regs * regs)
+static irqreturn_t bttv_irq(int irq, void *dev_id, struct pt_regs * regs)
 {
 	u32 stat,astat;
 	u32 dstat;
 	int count;
 	struct bttv *btv;
+	int handled = 0;
 
 	btv=(struct bttv *)dev_id;
 	count=0;
-	while (1) 
-	{
+	while (1) {
 		/* get/clear interrupt status bits */
 		stat=btread(BT848_INT_STAT);
 		astat=stat&btread(BT848_INT_MASK);
 		if (!astat)
-			return;
+			break;
+		handled = 1;
 		btwrite(stat,BT848_INT_STAT);
 
 		/* get device status bits */
@@ -3231,6 +3232,7 @@ static void bttv_irq(int irq, void *dev_
 			       "bttv%d: IRQ lockup, cleared int mask\n", btv->nr);
 		}
 	}
+	return IRQ_RETVAL(handled);
 }
 
 

_

