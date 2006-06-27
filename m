Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161101AbWF0P2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161101AbWF0P2X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 11:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161105AbWF0P2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 11:28:22 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:54979 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1161101AbWF0P2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 11:28:19 -0400
Subject: Re: Areca driver recap + status
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Robert Mueller <robm@fastmail.fm>
Cc: Andrew Morton <akpm@osdl.org>, rdunlap@xenotime.net, hch@infradead.org,
       erich@areca.com.tw, brong@fastmail.fm, dax@gurulabs.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <057801c69970$70b45090$0e00cb0a@robm>
References: <09be01c695b3$2ed8c2c0$c100a8c0@robm>
	 <20060621222826.ff080422.akpm@osdl.org>
	 <1151333338.2673.4.camel@mulgrave.il.steeleye.com>
	 <057801c69970$70b45090$0e00cb0a@robm>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 10:27:54 -0500
Message-Id: <1151422074.3340.25.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-27 at 08:32 +1000, Robert Mueller wrote:
> > - PAE (cast of dma_addr_t to unsigned long) issues.
> 
> Can you explain a bit what this is about and what the effect is? It's just 
> that we've been using the driver (older version from the areca website) in a 
> PAE kernel on machines with 8G of memory and haven't had a problem yet 
> (running high IO load for several weeks) but this sounds like it 
> might/should cause corruption or crashing in this situation?

It's these pieces:

+		pcmd->SCp.ptr = (char *)(unsigned long) dma_addr;


+	else if (pcmd->request_bufflen != 0)
+		pci_unmap_single(acb->pdev,
+			(dma_addr_t)(unsigned long)pcmd->SCp.ptr,
+			pcmd->request_bufflen, pcmd->sc_data_direction);

On a PAE platform, dma_addr_t is u64 and unsigned long is u32, so any
address > 4GB will be truncated by these operations.

I think all this does is cause a slow leak of dma mappings, and on any
kernel > 2.6.16 the leak should be even smaller, since we've severely
restricted the use_sg == 0 case.  It probably is only significant on
x86_64 with the gart iommu enabled.

James


