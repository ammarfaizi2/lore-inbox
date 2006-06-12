Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWFLTyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWFLTyL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 15:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWFLTyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 15:54:10 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:10142 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932172AbWFLTyJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 15:54:09 -0400
Date: Mon, 12 Jun 2006 14:54:04 -0500
To: Paul Mackerras <paulus@samba.org>, Adam Belay <ambx1@neo.rr.com>
Cc: Andrew Morton <akpm@osdl.org>, Ryan Lortie <desrt@desrt.ca>,
       linux-kernel@vger.kernel.org, mjg59@srcf.ucam.org, bcollins@ubuntu.com,
       Greg KH <greg@kroah.com>
Subject: Re: [ambx1@neo.rr.com: Re: pci_restore_state]
Message-ID: <20060612195404.GC7583@austin.ibm.com>
References: <17545.21437.203619.798273@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17545.21437.203619.798273@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.9i
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 08:55:57PM +1000, Paul Mackerras wrote:
> Any comments on Adam's patch, particularly as it relates to EEH?  Do
> we use dev->saved_config_space to restore the device after an EEH
> reset?

Thanks, I was out sick.

On PowerPC, we don't use this struct; we save to a private area 
hanging off the device nocde. The goal for PCI error recovery was to 
save PCI state as it was shortly after boot, before the device driver
has mucked with it. That way, when the device driver starts up, 
it finds the state to be more-or-less the same as it would be on 
discovery after a cold boot.

> Any comments on this patch as an alternative solution?
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114949711413176&w=2

One question/remark. The patch says:

+	command = conf->command & ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
+				    PCI_COMMAND_MASTER);
+
+	pci_write_config_word(dev, PCI_COMMAND, command);
+	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, conf->cacheline_size);
+	pci_write_config_byte(dev, PCI_LATENCY_TIMER, conf->latency_timer);
+	pci_write_config_byte(dev, PCI_INTERRUPT_PIN, conf->interrupt_pin);
+	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, conf->interrupt_line);
+
+	pci_restore_bars(dev);
 
-	for (i = 0; i < 16; i++)
-		pci_write_config_dword(dev,i * 4, dev->saved_config_space[i]);
 	pci_restore_msi_state(dev);
 	pci_restore_msix_state(dev);


First thing it does is disable bus mastering (which is probably good, 
you don't want the device going wild doing dma's till you're ready).
However, at some point, bus mastering needs to be re-enabled; does
some other power management code do this? Is the device driver 
supposed to notice something is amiss after a PM resume, and supposed
to set these?

--linas
