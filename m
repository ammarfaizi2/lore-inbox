Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965298AbWJZCVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965298AbWJZCVm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 22:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965290AbWJZCTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 22:19:10 -0400
Received: from isilmar.linta.de ([213.239.214.66]:30943 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S965286AbWJZCTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 22:19:04 -0400
Date: Wed, 25 Oct 2006 22:16:36 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-pcmcia@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, amol@verismonetworks.com
Subject: [RFC PATCH 8/11] ioremap balanced with iounmap for drivers/pcmcia
Message-ID: <20061026021636.GI20473@dominikbrodowski.de>
Mail-Followup-To: linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org, amol@verismonetworks.com
References: <20061026021027.GA20473@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061026021027.GA20473@dominikbrodowski.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amol Lad <amol@verismonetworks.com>
Date: Fri, 20 Oct 2006 14:44:18 -0700
Subject: [PATCH] ioremap balanced with iounmap for drivers/pcmcia

ioremap must be balanced by an iounmap and failing to do so can result
in a memory leak.

Signed-off-by: Amol Lad <amol@verismonetworks.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/pcmcia/at91_cf.c        |    3 ++-
 drivers/pcmcia/au1000_generic.c |   10 ++++++++++
 drivers/pcmcia/m8xx_pcmcia.c    |   12 ++++++++----
 drivers/pcmcia/omap_cf.c        |    3 ++-
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/pcmcia/at91_cf.c b/drivers/pcmcia/at91_cf.c
index f8db6e3..3bcb7dc 100644
--- a/drivers/pcmcia/at91_cf.c
+++ b/drivers/pcmcia/at91_cf.c
@@ -310,9 +310,10 @@ static int __init at91_cf_probe(struct p
 	return 0;
 
 fail2:
-	iounmap((void __iomem *) cf->socket.io_offset);
 	release_mem_region(io->start, io->end + 1 - io->start);
 fail1:
+	if (cf->socket.io_offset)
+		iounmap((void __iomem *) cf->socket.io_offset);
 	if (board->irq_pin)
 		free_irq(board->irq_pin, cf);
 fail0a:
diff --git a/drivers/pcmcia/au1000_generic.c b/drivers/pcmcia/au1000_generic.c
index 5387de6..551bde5 100644
--- a/drivers/pcmcia/au1000_generic.c
+++ b/drivers/pcmcia/au1000_generic.c
@@ -449,6 +449,16 @@ out_err:
 		del_timer_sync(&skt->poll_timer);
 		pcmcia_unregister_socket(&skt->socket);
 		flush_scheduled_work();
+		if (i == 0) {
+			iounmap(skt->virt_io + (u32)mips_io_port_base);
+			skt->virt_io = NULL;
+		}
+#ifndef CONFIG_MIPS_XXS1500
+		else {
+			iounmap(skt->virt_io + (u32)mips_io_port_base);
+			skt->virt_io = NULL;
+		}
+#endif
 		ops->hw_shutdown(skt);
 
 	}
diff --git a/drivers/pcmcia/m8xx_pcmcia.c b/drivers/pcmcia/m8xx_pcmcia.c
index e070a28..3b72be8 100644
--- a/drivers/pcmcia/m8xx_pcmcia.c
+++ b/drivers/pcmcia/m8xx_pcmcia.c
@@ -427,7 +427,7 @@ static int voltage_set(int slot, int vcc
 			reg |= BCSR1_PCCVCC1;
 			break;
 		default:
-			return 1;
+			goto out_unmap;
 	}
 
 	switch(vpp) {
@@ -438,15 +438,15 @@ static int voltage_set(int slot, int vcc
 			if(vcc == vpp)
 				reg |= BCSR1_PCCVPP1;
 			else
-				return 1;
+				goto out_unmap;
 			break;
 		case 120:
 			if ((vcc == 33) || (vcc == 50))
 				reg |= BCSR1_PCCVPP0;
 			else
-				return 1;
+				goto out_unmap;
 		default:
-			return 1;
+			goto out_unmap;
 	}
 
 	/* first, turn off all power */
@@ -457,6 +457,10 @@ static int voltage_set(int slot, int vcc
 
 	iounmap(bcsr_io);
 	return 0;
+
+out_unmap:
+	iounmap(bcsr_io);
+	return 1;
 }
 
 #define socket_get(_slot_) PCMCIA_SOCKET_KEY_5V
diff --git a/drivers/pcmcia/omap_cf.c b/drivers/pcmcia/omap_cf.c
index c8e838c..06bf7f4 100644
--- a/drivers/pcmcia/omap_cf.c
+++ b/drivers/pcmcia/omap_cf.c
@@ -309,9 +309,10 @@ static int __devinit omap_cf_probe(struc
 	return 0;
 
 fail2:
-	iounmap((void __iomem *) cf->socket.io_offset);
 	release_mem_region(cf->phys_cf, SZ_8K);
 fail1:
+	if (cf->socket.io_offset)
+		iounmap((void __iomem *) cf->socket.io_offset);
 	free_irq(irq, cf);
 fail0:
 	kfree(cf);
-- 
1.4.3

