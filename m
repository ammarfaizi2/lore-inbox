Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbTKDRLx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 12:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbTKDRLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 12:11:53 -0500
Received: from fed1mtao05.cox.net ([68.6.19.126]:2749 "EHLO fed1mtao05.cox.net")
	by vger.kernel.org with ESMTP id S262356AbTKDRLv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 12:11:51 -0500
Date: Tue, 4 Nov 2003 10:11:49 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Jes Sorensen <jes@trained-monkey.org>,
       Jamie Wellnitz <Jamie.Wellnitz@emulex.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: virt_to_page/pci_map_page vs. pci_map_single
Message-ID: <20031104101149.B24704@home.com>
References: <1067885332.2076.13.camel@mulgrave> <yq0znfcjwh1.fsf@trained-monkey.org> <20031104093556.A24704@home.com> <1067964447.1792.116.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1067964447.1792.116.camel@mulgrave>; from James.Bottomley@steeleye.com on Tue, Nov 04, 2003 at 10:47:25AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 04, 2003 at 10:47:25AM -0600, James Bottomley wrote:
> On Tue, 2003-11-04 at 10:35, Matt Porter wrote:
> > This raises a question for me regarding these rules in 2.4 versus
> > 2.6.  While fixing a bug in PPC's 2.4 pci_map_page/pci_map_sg
> > implementations I noticed that a scatterlist created by the IDE
> > subsystem will pass nents by page struct reference with a
> > size > PAGE_SIZE.  Is this a 2.4ism resulting from allowing both
> > address and page reference scatterlist entries?  This isn't
> > explicitly mentioned in the DMA docs AFAICT.  I'm wondering
> > if this is the same expected behavior in 2.6 as well.  If
> > pci_map_page() is limited to size <= PAGE_SIZE then I would
> > expect pci_map_sg() to be limited as well (and vice versa).
> 
> Not really.  By design, the SG interface can handle entries that are
> physically contiguous.
> 
> If you have a limit on the length of your SG elements (because of the
> device hardware, say), you can express this to the block layer with the
> blk_queue_max_segment_size() API.

Ok, then to make this clear to implementers of the
pci_map_page()/pci_map_sg() APIs would the following
addition to the docs be correct?

-Matt

===== Documentation/DMA-mapping.txt 1.17 vs edited =====
--- 1.17/Documentation/DMA-mapping.txt  Sat Aug 16 11:46:50 2003
+++ edited/Documentation/DMA-mapping.txt        Tue Nov  4 09:59:53 2003
@@ -499,7 +499,8 @@
  
        pci_unmap_page(dev, dma_handle, size, direction);
  
-Here, "offset" means byte offset within the given page.
+Here, "offset" means byte offset within the given page. In addition,
+"size" must be <= PAGE_SIZE - offset.
  
 With scatterlists, you map a region gathered from several regions by:
  
@@ -520,6 +521,9 @@
 advantage for cards which either cannot do scatter-gather or have very
 limited number of scatter-gather entries) and returns the actual number
 of sg entries it mapped them to.
+
+Note: sglist entries are not limited to PAGE_SIZE, the pci_map_sg()
+implementation must handle entries with size > PAGE_SIZE.
  
 Then you should loop count times (note: this can be less than nents times)
 and use sg_dma_address() and sg_dma_len() macros where you previously
