Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270987AbTHLSXV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 14:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271038AbTHLSXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 14:23:21 -0400
Received: from [66.212.224.118] ([66.212.224.118]:5383 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S270987AbTHLSXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 14:23:20 -0400
Date: Tue, 12 Aug 2003 14:11:28 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       long <tlnguyen@snoqualmie.dp.intel.com>
Subject: RE: Updated MSI Patches
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E5024015416F5@orsmsx404.jf.intel.com>
Message-ID: <Pine.LNX.4.53.0308121342570.26153@montezuma.mastecende.com>
References: <C7AB9DA4D0B1F344BF2489FA165E5024015416F5@orsmsx404.jf.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your message would be easier to reply to and read if it was wrapped at 72 
characters, please look into fixing that for the sake of your recipients. 
Thanks.

On Tue, 12 Aug 2003, Nguyen, Tom L wrote:

> I understand that mixing up vector and irq is very confusing. However, 
> to support non-PCI legacy devices with IRQ less than 16, such as 
> keyboard and mouse for example, may be impossilbe to achieve without 
> mixing up. Some existing driver of legacy keyboard/mouse devices, for 
> example, may use fixed IO ranges and fixed IRQs (as assigned to 1 for 
> keyboard and 12 for mouse). If these device drivers use these fixed 
> legacy IRQs and the interrupt routings for these non-PCI legacy devices  
> use vectors, then the system may break. As you know, MSI support 
> requires vector allocation instead of IRQ allocation since MSI does not 
> require a support of BIOS IRQ table. Mixing vector with IRQ to be 
> compatible with non-PCI legacy devices must be achieved. Last time, 
> your suggestion of changing variable name from irq to vector is the 
> good approach. I am looking at restructuring the code of the 
> vector-base patch. I will send you an update when I am done for your 
> feedback.

For the legacy devices, an irq_vector mapping should be sufficient as you 
currently maintain. You could also possibly have a seperate do_MSI which 
gets a vector pushed to it and then uses mesc_desc instead to do the 
handlers. You then install the IDT entry using the seperate MSI interrupt 
stub; set_intr_gate(vector, msi_interrupt[msi_num]) where msi_interrupt is 
a NR_MSI sized array. This way you can avoid touching do_IRQ entirely.

> Since the code determinces whether this entry is NULL or not, I think any  
> locking for msi_desc may not be required.

Yes but there is other code which modifies msi_desc members. i think a per 
msi_desc lock is needed. You could also use a kmem_cache to allocate them, 
and perhaps utilise HWCACHE_ALIGN.

	Zwane

