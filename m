Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262958AbTJOMDT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 08:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbTJOMDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 08:03:19 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:63888 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262958AbTJOMDR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 08:03:17 -0400
Date: Wed, 15 Oct 2003 14:02:59 +0200
From: Jens Axboe <axboe@suse.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [SCSI] Set max_phys_segments to sg_tablesize
Message-ID: <20031015120259.GC1077@suse.de>
References: <20031015115740.GA23469@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031015115740.GA23469@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15 2003, Herbert Xu wrote:
> Hi:
> 
> Many SCSI host drivers assume that use_sg will be <= sg_tablesize.
> Hence they may break under 2.6 as the number of physical segments
> is not limited by sg_tablesize.  This patch fixes that.

Is sg_tablesize guarenteed to be set? Looks like you need a

===== drivers/scsi/hosts.c 1.94 vs edited =====
--- 1.94/drivers/scsi/hosts.c   Sun Sep 21 19:52:38 2003
+++ edited/drivers/scsi/hosts.c Wed Oct 15 14:02:14 2003
@@ -234,7 +234,11 @@
        shost->hostt = sht;
        shost->this_id = sht->this_id;
        shost->can_queue = sht->can_queue;
+
        shost->sg_tablesize = sht->sg_tablesize;
+       if (!shost->sg_tablesize)
+               shost->sg_tablesize = MAX_PHYS_SEGMENTS;
+
        shost->cmd_per_lun = sht->cmd_per_lun;
        shost->unchecked_isa_dma = sht->unchecked_isa_dma;
        shost->use_clustering = sht->use_clustering;

additionally.

-- 
Jens Axboe

