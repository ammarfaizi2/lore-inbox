Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbVBAHuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVBAHuQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 02:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbVBAHru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 02:47:50 -0500
Received: from colo.lackof.org ([198.49.126.79]:52884 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261716AbVBAHqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 02:46:40 -0500
Date: Tue, 1 Feb 2005 00:46:57 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Brian King <brking@us.ibm.com>
Cc: Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-arch@vger.kernel.org
Subject: Re: pci: Arch hook to determine config space size
Message-ID: <20050201074657.GA548@colo.lackof.org>
References: <200501281456.j0SEuI12020454@d01av01.pok.ibm.com> <20050128185234.GB21760@infradead.org> <20050129040647.GA6261@kroah.com> <41FE82B6.9060407@us.ibm.com> <41FE8994.4040802@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FE8994.4040802@us.ibm.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2005 at 01:40:04PM -0600, Brian King wrote:
> CC'ing the linux-pci mailing list...

thanks...

> > This patch adds an arch hook so
> > that individual archs can indicate if the underlying system supports
> > expanded config space accesses or not.

> >@@ -653,6 +653,8 @@ static int pci_cfg_space_size(struct pci
> > 			goto fail;
> > 	}
> > 
> >+	if (!pcibios_exp_cfg_space(dev))
> >+		goto fail;
> > 	if (pci_read_config_dword(dev, 256, &status) != PCIBIOS_SUCCESSFUL)
> > 		goto fail;

pci_read_config_dword lands in arch specific code.
See drivers/pci/access.c:PCI_OP_READ() macro.

I'm missing what pcibios_exp_cfg_space() does that can't be handled by
the bus_ops supplied by pci_scan_bus().

I would expect the pci_read_config_dword to fail for being out of bounds.
Is that wrong?
Or is bus_ops not feasible in this case because pcibios needs access
to pci_dev?

If it's feasible, maybe the right place to add this hook is to
pci_read_config_dword which is also handed the pci_dev. And add
another function pointer to bus_ops (which could be NULL) to check
chipset support for Expanded Config space before calling
pci_bus_read_config_dword. Thats cleaner than adding a hook
before each use of pci_read_config_dword.

hth,
grant
