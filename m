Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbUCaWAN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 17:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbUCaV76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 16:59:58 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:49077 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261932AbUCaV7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 16:59:16 -0500
Subject: Re: [PATCH] ibmvscsi driver - sixth version
From: James Bottomley <James.Bottomley@steeleye.com>
To: Dave Boutcher <sleddog@us.ibm.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <opr5qwiyw4l6e53g@us.ibm.com>
References: <opr3u0ffo7l6e53g@us.ibm.com>
	<20040225134518.A4238@infradead.org>  <opr3xta6gbl6e53g@us.ibm.com>
	<1079027038.2820.57.camel@mulgrave>  <opr5qwiyw4l6e53g@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 31 Mar 2004 16:58:28 -0500
Message-Id: <1080770310.2071.44.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-31 at 16:26, Dave Boutcher wrote:
> Comments always welcomed.  I would like to get this upstream if I can, 
> since the linux distributors are complaining slightly that it is not.

Actually, this:

+	    (u64) (unsigned long)dma_map_single(dev, cmd->request_buffer,
+						cmd->request_bufflen,
+						DMA_BIDIRECTIONAL);
+	if (pci_dma_mapping_error(data->virtual_address)) {
+		printk(KERN_ERR
+		       "ibmvscsi: Unable to map request_buffer for command!\n");
+		return 0;

Should be

if(dma_mapping_error())

I have no idea why there are two identical APIs for the mapping error,
but since you use the DMA API, you should use its version.  You can also
drop the #include <linux/pci.h> as well.


This:

+	sg_mapped = dma_map_sg(dev, sg, cmd->use_sg, DMA_BIDIRECTIONAL);
+
+	if (pci_dma_mapping_error(sg_dma_address(&sg[0])))
+		return 0;

Is wrong.  dma_map_sg returns zero if there's a mapping error, you
should check for that.

James


