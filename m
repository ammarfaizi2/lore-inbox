Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266544AbUFQP2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266544AbUFQP2s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 11:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266541AbUFQP2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 11:28:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64669 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266536AbUFQP2T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 11:28:19 -0400
Date: Thu, 17 Jun 2004 16:28:18 +0100
From: Matthew Wilcox <willy@debian.org>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: Proposal for new generic device API: dma_get_required_mask()
Message-ID: <20040617152818.GZ20511@parcelfarce.linux.theplanet.co.uk>
References: <1087481331.2210.27.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1087481331.2210.27.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 09:08:51AM -0500, James Bottomley wrote:
> We have a large number of devices in scsi: aacraid, aic7xxx, qla1280,
> qla2xxx which can all do full 64 bit DMA, but which pay a performance
> penalty for using the larger descriptors (aic7xxx is stranger in that it
> has three modes of operation: 32 bit, 39 bit and 64 bit each with an
> increasing performance penalty).

sym2 too -- 32, 40 and 64-bit, but with the restriction of the 64-bit
mode that it's limited to accessing 16 4GB segments.

> Once the driver has the platform's optimal mask, it can use this to
> decide on the correct descriptor size.

Sounds good to me.  

So let's look at the sym2 implementation to see how this would work.
A straight diff -u is not terribly helpful, So let's try a more verbose
context diff:

*** 1625,1657 ****
   */
  static int sym_setup_bus_dma_mask(struct sym_hcb *np)
  {
! #if   SYM_CONF_DMA_ADDRESSING_MODE == 0
!       if (pci_set_dma_mask(np->s.device, 0xffffffffUL))
!               goto out_err32;
! #else
! #if   SYM_CONF_DMA_ADDRESSING_MODE == 1
! #define       PciDmaMask      0xffffffffffULL
! #elif SYM_CONF_DMA_ADDRESSING_MODE == 2
! #define       PciDmaMask      0xffffffffffffffffULL
! #endif
        if (np->features & FE_DAC) {
!               if (!pci_set_dma_mask(np->s.device, PciDmaMask)) {
!                       np->use_dac = 1;
!                       printf_info("%s: using 64 bit DMA addressing\n",
!                                       sym_name(np));
!               } else {
!                       if (pci_set_dma_mask(np->s.device, 0xffffffffUL))
!                               goto out_err32;
!               }
        }
! #undef        PciDmaMask
! #endif
        return 0;
  
! out_err32:
!       printf_warning("%s: 32 BIT DMA ADDRESSING NOT SUPPORTED\n",
!                       sym_name(np));
!       return -1;
  }
  
  /*
--- 1625,1645 ----
   */
  static int sym_setup_bus_dma_mask(struct sym_hcb *np)
  {
!       struct pci_dev *pdev = &np->s.device;
! 
        if (np->features & FE_DAC) {
!               u64 required_mask = dma_set_mask(&pdev->dev, 0xffffffffffULL);
!               if (required_mask > 0xffffffffUL)
!                       goto use_dac;
        }
! 
!       dma_set_mask(&pdev->dev, 0xffffffffUL);
        return 0;
  
!  use_dac:
!       np->use_dac = 1;
!       printf_info("%s: using 64 bit DMA addressing\n", sym_name(np));
!       return 0;
  }
  
  /*

There's an obvious problem here -- no error checking on the second
dma_set_mask().  How were we going to indicate "I can't do that"
errors again?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
