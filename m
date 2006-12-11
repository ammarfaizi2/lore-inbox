Return-Path: <linux-kernel-owner+w=401wt.eu-S1762962AbWLKRPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762962AbWLKRPl (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 12:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762972AbWLKRPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 12:15:40 -0500
Received: from an-out-0708.google.com ([209.85.132.247]:63445 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762962AbWLKRPj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 12:15:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=ATHT5+IJyhawAcHUoTz0Xw4R87X6W1LyNdwLyhXyywtNk7OPVdRPH0Ii3/vPrtEfXNcPnt4e83qv7sCyvaySb6hIESAx4MKyDpMisfUyq8cnPhSRs5kjm6dLjnJa4TkGx0u5MAHToRFMr3+4a1j3wcO6NPmpMQ1/PQHfq9O2lVE=
Date: Tue, 12 Dec 2006 02:15:31 +0900
From: Tejun Heo <htejun@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linux-ide@vger.kernel.org,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] libata: don't initialize sg in ata_exec_internal() if DMA_NONE (take #2)
Message-ID: <20061211171531.GC18947@htj.dyndns.org>
References: <200612081914.41810.arnd.bergmann@de.ibm.com> <20061211140258.GB18947@htj.dyndns.org> <457D7F5C.8040609@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457D7F5C.8040609@pobox.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Calling sg_init_one() with NULL buf causes oops on certain
configurations.  Don't initialize sg in ata_exec_internal() if
DMA_NONE and make the function complain if @buf is NULL when dma_dir
isn't DMA_NONE.  While at it, fix comment.

The problem is discovered and initial patch was submitted by Arnd
Bergmann.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---

Modified as suggested.

Thanks.

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 011c0a8..0d51d13 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1332,7 +1332,7 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 }
 
 /**
- *	ata_exec_internal_sg - execute libata internal command
+ *	ata_exec_internal - execute libata internal command
  *	@dev: Device to which the command is sent
  *	@tf: Taskfile registers for the command and the result
  *	@cdb: CDB for packet command
@@ -1353,11 +1353,17 @@ unsigned ata_exec_internal(struct ata_device *dev,
 			   struct ata_taskfile *tf, const u8 *cdb,
 			   int dma_dir, void *buf, unsigned int buflen)
 {
-	struct scatterlist sg;
+	struct scatterlist *psg = NULL, sg;
+	unsigned int n_elem = 0;
 
-	sg_init_one(&sg, buf, buflen);
+	if (dma_dir != DMA_NONE) {
+		WARN_ON(!buf);
+		sg_init_one(&sg, buf, buflen);
+		psg = &sg;
+		n_elem++;
+	}
 
-	return ata_exec_internal_sg(dev, tf, cdb, dma_dir, &sg, 1);
+	return ata_exec_internal_sg(dev, tf, cdb, dma_dir, psg, n_elem);
 }
 
 /**
