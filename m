Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbVHGGRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbVHGGRq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 02:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbVHGGRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 02:17:46 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:24798 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751123AbVHGGRp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 02:17:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=VNixDiEHFBRrZxFV690Astst4w38dG4jsDa+jei+ZZ1H+Fj6/hRE7yCNBD7+tHwGbNaNjbf+OzmBDEn8zZFGzJSIWdusDai1QBL1ixfsQR5vPk2W/0I56N66nc5Y7+fCQAE6xlBUugppajuJNPHPqHF55LLnl5MXqvhkXG3MPDw=
Date: Sun, 7 Aug 2005 15:17:37 +0900
From: Tejun Heo <htejun@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3] sata: restore sg on setup failure
Message-ID: <20050807061737.GA14913@htj.dyndns.org>
References: <20050729050654.GA10413@havoc.gtf.org> <20050807054850.GA13335@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050807054850.GA13335@htj.dyndns.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 I forgot to restore sg->length on setup failure.  This patch adds it.


Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2005-08-07 15:13:20.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2005-08-07 15:15:27.000000000 +0900
@@ -2401,8 +2401,11 @@ static int ata_sg_setup_one(struct ata_q
 
 	dma_address = dma_map_single(ap->host_set->dev, qc->buf_virt,
 				     sg->length, dir);
-	if (dma_mapping_error(dma_address))
+	if (dma_mapping_error(dma_address)) {
+		/* restore sg */
+		sg->length += qc->pad_len;
 		return -1;
+	}
 
 	sg_dma_address(sg) = dma_address;
 	sg_dma_len(sg) = sg->length;
@@ -2473,8 +2476,11 @@ static int ata_sg_setup(struct ata_queue
 
 	dir = qc->dma_dir;
 	n_elem = dma_map_sg(ap->host_set->dev, sg, qc->n_elem, dir);
-	if (n_elem < 1)
+	if (n_elem < 1) {
+		/* restore last sg */
+		lsg->length += qc->pad_len;
 		return -1;
+	}
 
 	DPRINTK("%d sg elements mapped\n", n_elem);
 
