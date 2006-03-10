Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWCJEhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWCJEhX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 23:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWCJEhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 23:37:23 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:58327 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751190AbWCJEhW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 23:37:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=qAGH+9LFCL6G3Sj6fIUM+nu9YbdFKRoShGc15Y0Pm7SFaCduV++qIeSK+ZYSR6TyFqO780xD5aWjGI/9IP8eeFl63A/srMlq03ktMsC/A2FH2d4kcFv/IPA+YJGYdNRHMkW5MVhlOGPWe51ttcXzd1qhUMQVUEoYdXyGH9iVGfU=
Date: Fri, 10 Mar 2006 13:37:17 +0900
From: Tejun Heo <htejun@gmail.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AHCI prefetch
Message-ID: <20060310043717.GA7510@htj.dyndns.org>
References: <20060304173505.GA28643@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060304173505.GA28643@havoc.gtf.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 04, 2006 at 12:35:05PM -0500, Jeff Garzik wrote:
> 
> This patch has been sitting in my tmp directory for ages.
> 
> We should probably turn this on, though the practical difference is
> probably minimal.
> 

The patch works okay on my machine (ICH7R) although the patch didn't
apply to #upstream.  I'm not very sure about this change though.

1. Why apply it only to ATAPI devices?  ATA devices can benefit to.
   If it's because this bit shouldn't be turned on for NCQ, we can
   turn it on conditionally.  We'll probably need similar condition
   for ATAPI devices too if we support FIS-based PM switching.

2. I'm a bit skeptical whether this change will bring any noticeable
   performance improvement.  OTOH, this seems to be a good source for
   obscure problems on some controllers which might not implement/test
   this feature properly.  As more controllers implement AHCI spec,
   the possibility grows.

Anyways, here's the patch regenerated against #upstream.

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 1c2ab3d..cfa6eaf 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -66,6 +66,7 @@ enum {
 	AHCI_IRQ_ON_SG		= (1 << 31),
 	AHCI_CMD_ATAPI		= (1 << 5),
 	AHCI_CMD_WRITE		= (1 << 6),
+	AHCI_CMD_PREFETCH	= (1 << 7),
 	AHCI_CMD_RESET		= (1 << 8),
 	AHCI_CMD_CLR_BUSY	= (1 << 10),
 
@@ -631,7 +632,7 @@ static void ahci_qc_prep(struct ata_queu
 	if (qc->tf.flags & ATA_TFLAG_WRITE)
 		opts |= AHCI_CMD_WRITE;
 	if (is_atapi)
-		opts |= AHCI_CMD_ATAPI;
+		opts |= AHCI_CMD_ATAPI | AHCI_CMD_PREFETCH;
 
 	ahci_fill_cmd_slot(pp, opts);
 }
