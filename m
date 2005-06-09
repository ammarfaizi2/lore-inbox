Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVFIAbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVFIAbg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 20:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbVFIAbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 20:31:06 -0400
Received: from umbar.esa.informatik.tu-darmstadt.de ([130.83.163.30]:10880
	"EHLO umbar.esa.informatik.tu-darmstadt.de") by vger.kernel.org
	with ESMTP id S261408AbVFIA3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 20:29:05 -0400
Date: Thu, 9 Jun 2005 02:29:03 +0200
From: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>,
       Linus Torvalds <torvalds@osdl.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
Message-ID: <20050609002903.GA14972@erebor.esa.informatik.tu-darmstadt.de>
References: <20050604013311.GA30151@erebor.esa.informatik.tu-darmstadt.de> <Pine.LNX.4.58.0506031851220.1876@ppc970.osdl.org> <20050604022600.GA8221@erebor.esa.informatik.tu-darmstadt.de> <Pine.LNX.4.58.0506032149130.1876@ppc970.osdl.org> <20050604155742.GA14384@erebor.esa.informatik.tu-darmstadt.de> <20050605204645.A28422@jurassic.park.msu.ru> <20050606002739.GA943@erebor.esa.informatik.tu-darmstadt.de> <20050606184335.A30338@jurassic.park.msu.ru> <20050608173409.GA32004@erebor.esa.informatik.tu-darmstadt.de> <20050609023639.A7067@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050609023639.A7067@jurassic.park.msu.ru>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2005 at 02:36:39AM +0400, Ivan Kokshaysky wrote:
> On Wed, Jun 08, 2005 at 07:34:09PM +0200, Andreas Koch wrote:
> > However, after pci_assign_unassigned_resources() has been called, the
> > MEM and PREFETCH regions of the bridge 0000:00:1e.0 (bridge 1) _remain_
> > invalid at 0x00000000.
> 
> I believe it was _IO_ and PREFETCH (unused windows of that bridge).
> Indeed, IO at 0 is fatal...

I haven't tried the patch yet, but had time to check the debug output
again.  And for the bridge 0000:00:1e.0, it definitely lists all
_three_ characteristics (IO, MEM and PREFETCH) as zero.  I'll let you
know how the patch turns out.

Andreas

> 
> Here is additional patch which ensures unused windows of the transparent
> bridge are disabled. 
> 
> Ivan.
> 
> --- linux/drivers/pci/setup-bus.c~	Sun Jun  5 18:37:57 2005
> +++ linux/drivers/pci/setup-bus.c	Thu Jun  9 01:28:42 2005
> @@ -156,7 +156,7 @@ pci_setup_bridge(struct pci_bus *bus)
>  
>  	/* Set up the top and bottom of the PCI I/O segment for this bus. */
>  	pcibios_resource_to_bus(bridge, &region, &b_res[0]);
> -	if (b_res[0].flags & IORESOURCE_IO) {
> +	if ((b_res[0].flags & IORESOURCE_IO) && (region.end > region.start)) {
>  		pci_read_config_dword(bridge, PCI_IO_BASE, &l);
>  		l &= 0xffff0000;
>  		l |= (region.start >> 8) & 0x00f0;
> @@ -182,7 +182,7 @@ pci_setup_bridge(struct pci_bus *bus)
>  	/* Set up the top and bottom of the PCI Memory segment
>  	   for this bus. */
>  	pcibios_resource_to_bus(bridge, &region, &b_res[1]);
> -	if (b_res[1].flags & IORESOURCE_MEM) {
> +	if ((b_res[1].flags & IORESOURCE_MEM) && (region.end > region.start)) {
>  		l = (region.start >> 16) & 0xfff0;
>  		l |= region.end & 0xfff00000;
>  		DBG(KERN_INFO "  MEM window: %08lx-%08lx\n",
> @@ -201,7 +201,8 @@ pci_setup_bridge(struct pci_bus *bus)
>  
>  	/* Set up PREF base/limit. */
>  	pcibios_resource_to_bus(bridge, &region, &b_res[2]);
> -	if (b_res[2].flags & IORESOURCE_PREFETCH) {
> +	if ((b_res[2].flags & IORESOURCE_PREFETCH) &&
> +	    (region.end > region.start)) {
>  		l = (region.start >> 16) & 0xfff0;
>  		l |= region.end & 0xfff00000;
>  		DBG(KERN_INFO "  PREFETCH window: %08lx-%08lx\n",

-- 
Prof. Dr. Andreas Koch                     koch@esa.informatik.tu-darmstadt.de
Technische Universitaet Darmstadt, FB20           Phone  : x49-6151-16-4378
FG Embedded Systems and their Applications (ESA)  FAX    : x49-6151-16-5472
Hochschulstr. 10, D-64289 Darmstadt, Germany             * PGP key available *
