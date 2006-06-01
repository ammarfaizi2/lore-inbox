Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964915AbWFARQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbWFARQE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 13:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbWFARQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 13:16:04 -0400
Received: from colo.lackof.org ([198.49.126.79]:2468 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S964915AbWFARQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 13:16:02 -0400
Date: Thu, 1 Jun 2006 11:15:59 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Rajesh Shah <rajesh.shah@intel.com>
Cc: "bibo,mao" <bibo.mao@intel.com>, akpm@osdl.org, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       kaneshige.kenji@jp.fujitsu.com
Subject: Re: [BUG](-mm)pci_disable_device function clear bars_enabled element
Message-ID: <20060601171559.GA16288@colo.lackof.org>
References: <447E91CE.7010705@intel.com> <20060601024611.A32490@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060601024611.A32490@unix-os.sc.intel.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2006 at 02:46:11AM -0700, Rajesh Shah wrote:
> This patch assumes that pci_request_region() will always be called
> after pci_enable_device() and pci_release_region() will always
> be called before pci_disable_device(). We cannot make this
> assumption,since it's perfectly legal to disable a device
> first and then release it's regions. So, I think that patch
> needs to change.

Patch below clarifies comments in Documentation/pci.txt.
Greg, can you apply?

(feel free to edit it a bit more)

thanks,
grant

Signed-off-by: Grant Grundler <grundler@parisc-linux.org>

--- a/Documentation/pci.txt
+++ b/Documentation/pci.txt
@@ -213,9 +213,17 @@ have been remapped by the kernel.
 
    See Documentation/IO-mapping.txt for how to access device memory.
 
-   You still need to call request_region() for I/O regions and
-request_mem_region() for memory regions to make sure nobody else is using the
-same device.
+   The device driver needs to call pci_request_region() to make sure
+no other device is already using the same resource. The driver is expected
+to determine MMIO and IO Port resource availability _before_ calling
+pci_enable_device().  Conversely, drivers should call pci_release_region()
+_after_ calling pci_disable_device(). The idea is to prevent two devices
+colliding on the same address range.
+
+Generic flavors of pci_request_region() are request_mem_region()
+(for MMIO ranges) and request_region() (for IO Port ranges).
+Use these for address resources that are not described by "normal" PCI
+interfaces (e.g. BAR).
 
    All interrupt handlers should be registered with SA_SHIRQ and use the devid
 to map IRQs to devices (remember that all PCI interrupts are shared).
