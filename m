Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbUCaWjX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 17:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbUCaWjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 17:39:20 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:654 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262596AbUCaWhu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 17:37:50 -0500
Date: Wed, 31 Mar 2004 16:37:37 -0600
To: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: [PATCH] ibmvscsi driver - sixth version
References: <opr3u0ffo7l6e53g@us.ibm.com> <20040225134518.A4238@infradead.org>  <opr3xta6gbl6e53g@us.ibm.com> <1079027038.2820.57.camel@mulgrave>  <opr5qwiyw4l6e53g@us.ibm.com> <1080770310.2071.44.camel@mulgrave>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, paulus@samba.org,
       anton@samba.org
From: Dave Boutcher <sleddog@us.ibm.com>
Organization: IBM
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr5qzszzml6e53g@us.ibm.com>
In-Reply-To: <1080770310.2071.44.camel@mulgrave>
User-Agent: Opera7.23/Win32 M2 build 3227
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 Mar 2004 16:58:28 -0500, James Bottomley 
<James.Bottomley@SteelEye.com> wrote:
> Actually, this:
>
> +	    (u64) (unsigned long)dma_map_single(dev, cmd->request_buffer,
> +						cmd->request_bufflen,
> +						DMA_BIDIRECTIONAL);
> +	if (pci_dma_mapping_error(data->virtual_address)) {
> +		printk(KERN_ERR
> +		       "ibmvscsi: Unable to map request_buffer for command!\n");
> +		return 0;
>
> Should be
>
> if(dma_mapping_error())
>
> I have no idea why there are two identical APIs for the mapping error,
> but since you use the DMA API, you should use its version.  You can also
> drop the #include <linux/pci.h> as well.

Well, that would be true if arch/ppc64 had dma_mapping_error implemented.
Which it not.  You would need something like the following patch, which
will show up when we rationalize it with the rest of ppc64 and an
appropriate bk pull happens...I'll work with my ppc64 bretheren and then
re-submit the ibmvscsi patch.

===== dma-mapping.h 1.5 vs edited =====
--- 1.5/include/asm-ppc64/dma-mapping.hTue Mar 16 18:47:00 2004
+++ edited/dma-mapping.hWed Mar 31 16:33:07 2004
@@ -15,6 +15,11 @@
  #include <asm/scatterlist.h>
  #include <asm/bug.h>

+#define DMA_ERROR_CODE      (~(dma_addr_t)0x0)
+static inline int dma_mapping_error(dma_addr_t dma_addr) {
+        return (dma_addr == DMA_ERROR_CODE);
+}
+
  extern int dma_supported(struct device *dev, u64 mask);
  extern int dma_set_mask(struct device *dev, u64 dma_mask);
  extern void *dma_alloc_coherent(struct device *dev, size_t size,

> This:
>
> +	sg_mapped = dma_map_sg(dev, sg, cmd->use_sg, DMA_BIDIRECTIONAL);
> +
> +	if (pci_dma_mapping_error(sg_dma_address(&sg[0])))
> +		return 0;
>
> Is wrong.  dma_map_sg returns zero if there's a mapping error, you
> should check for that.

Yes, my bad.  I was so delighted with pci_dma_mapping_error() that I
got a little carried away.  Thanks.

Dave B
