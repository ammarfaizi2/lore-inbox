Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUCSBLN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 20:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbUCSBLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 20:11:13 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:33248 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261682AbUCSBLJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 20:11:09 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: linux-kernel@vger.kernel.org, zwane@linuxpower.ca
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
Date: Thu, 18 Mar 2004 17:11:05 -0800
User-Agent: KMail/1.6.1
References: <1079651064.8149.158.camel@arrakis> <9860000.1079653397@flay> <Pine.LNX.4.58.0403181956560.28447@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0403181956560.28447@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403181711.05546.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 March 2004 4:58 pm, Zwane Mwaikambo wrote:
> > It probably shouldn't have anything to do with PCI directly either,
> > so .... ;-) My former thought was that you might just want the most
> > local memory for DMAing into.
> 
> That knowledge should be in the dma api thing shouldn't it? But in it's
> current incarnation i don't see how that's possible.

Couldn't we mostly hide it under the covers (though obviously not in
the intentionally remote case I mentioned earlier):


===== arch/ia64/sn/io/machvec/pci_dma.c 1.28 vs edited =====
--- 1.28/arch/ia64/sn/io/machvec/pci_dma.c	Sun Mar 14 11:17:06 2004
+++ edited/arch/ia64/sn/io/machvec/pci_dma.c	Thu Mar 18 17:08:13 2004
@@ -130,13 +130,11 @@
 	device_sysdata = SN_DEVICE_SYSDATA(hwdev);
 	vhdl = device_sysdata->vhdl;
 
-	/*
-	 * Allocate the memory.
-	 * FIXME: We should be doing alloc_pages_node for the node closest
-	 *        to the PCI device.
-	 */
-	if (!(cpuaddr = (void *)__get_free_pages(GFP_ATOMIC, get_order(size))))
+	cpuaddr = alloc_pages_node(pci_to_node(hwdev), GFP_ATOMIC, (get_order(size)));
+	if (!cpuaddr)
 		return NULL;
+
+	cpuaddr = page_to_virt(cpuaddr);
 
 	memset(cpuaddr, 0x0, size);
 

