Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751669AbWIGLLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbWIGLLZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 07:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751672AbWIGLLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 07:11:24 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:59080 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1751666AbWIGLLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 07:11:21 -0400
Date: Thu, 7 Sep 2006 05:11:20 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Tejun Heo <htejun@gmail.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: question regarding cacheline size
Message-ID: <20060907111120.GL2558@parisc-linux.org>
References: <44FFD8C6.8080802@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44FFD8C6.8080802@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 10:31:02AM +0200, Tejun Heo wrote:
> As the BIOS doesn't run after hotplugging cardbus card, the cache line 
> isn't configured and the controller ends up having 0 cache line size and 
> always using Read command.  When that happens, write performance drops 
> hard - the throughput is < 2Mbytes/s.
> 
> http://thread.gmane.org/gmane.linux.ide/12908/focus=12908
> 
> So, sata_sil24 driver has to program CLS if it's not already set, but 
> I'm not sure which number to punch in.  FWIW, sil3124 doesn't seem to 
> put restrictions on the values which can be used for CLS.  There are 
> several candidates...
> 
> * L1_CACHE_BYTES / 4 : this is used by init routine in yenta_socket.c. 
> It seems to be a sane default but I'm not sure whether L1 cache line 
> size always coincides with the size as seen from PCI bus.
> 
> * pci_cache_line_size in drivers/pci/pci.c : this is used for 
> pci_generic_prep_mwi() and can be overridden by arch specific code. 
> this seems more appropriate but is not exported.
> 
> For all involved commands - memory read line, memory read multiple and 
> memory write and invalidate - a value larger than actual cacheline size 
> doesn't hurt but a smaller value may.

Just call pci_set_mwi(), that'll make sure the cache line size is set
correctly.
