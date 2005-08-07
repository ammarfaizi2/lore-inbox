Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbVHGFzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbVHGFzI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 01:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbVHGFzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 01:55:08 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:40525 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751104AbVHGFzG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 01:55:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=do5xa0lI0LSGe9fr0g1wmL7Bf6gBrxy//3zvhf7F3ckaGx9H709qs+XzU8IenZ8E/T20LNtLadOrHLDz6pUyje7jPZWmneAIeCOePgiSRnnV2m0YoDOy4mKVKGx+PCqSXFzXyiBJoGGuYUKjg2KCttIbwZdwGbtVwJ8djmdxgC8=
Date: Sun, 7 Aug 2005 14:53:40 +0900
From: Tejun Heo <htejun@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] sata: fix sata_sx4 dma_prep to not use sg->length
Message-ID: <20050807055340.GB13335@htj.dyndns.org>
References: <20050729050654.GA10413@havoc.gtf.org> <20050807054850.GA13335@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050807054850.GA13335@htj.dyndns.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 sata_sx4 directly references sg->length to calculate total_len in
pdc20621_dma_prep().  This is incorrect as dma_map_sg() could have
merged multiple sg's into one and, in such case, sg->length doesn't
reflect true size of the entry.  This patch makes it use
sg_dma_len(sg).


Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work/drivers/scsi/sata_sx4.c
===================================================================
--- work.orig/drivers/scsi/sata_sx4.c	2005-08-07 14:07:17.000000000 +0900
+++ work/drivers/scsi/sata_sx4.c	2005-08-07 14:08:25.000000000 +0900
@@ -468,7 +468,7 @@ static void pdc20621_dma_prep(struct ata
 	for (i = 0; i < last; i++) {
 		buf[idx++] = cpu_to_le32(sg_dma_address(&sg[i]));
 		buf[idx++] = cpu_to_le32(sg_dma_len(&sg[i]));
-		total_len += sg[i].length;
+		total_len += sg_dma_len(&sg[i]);
 	}
 	buf[idx - 1] |= cpu_to_le32(ATA_PRD_EOT);
 	sgt_len = idx * 4;
