Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267798AbUG3TZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267798AbUG3TZc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 15:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267801AbUG3TZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 15:25:32 -0400
Received: from web14922.mail.yahoo.com ([216.136.225.6]:44944 "HELO
	web14922.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267798AbUG3TZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 15:25:11 -0400
Message-ID: <20040730192510.74857.qmail@web14922.mail.yahoo.com>
Date: Fri, 30 Jul 2004 12:25:10 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Exposing ROM's though sysfs
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200407301010.29807.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-985079121-1091215510=:72997"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-985079121-1091215510=:72997
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

--- Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> How about this patch?

Here's the ROM access code I've been using but it's not in the form
that we need.

We do need a standard scheme for the radeon situation of having a bug
in the ROM access logic. Is it ok to put the fix for this in the radeon
driver? So if you read the ROM before the driver is loaded it won't be
there (proabably FFFF's). After the driver loads the fix will run as
part of the driver init and the ROM access functions will work right. 

=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
Yahoo! Mail Address AutoComplete - You start. We finish.
http://promotions.yahoo.com/new_mail 
--0-985079121-1091215510=:72997
Content-Type: text/x-csrc; name="rom.c"
Content-Description: rom.c
Content-Disposition: inline; filename="rom.c"

/*
 * Return a copy of the VBIOS ROM
 */
int DRM(getvbios)( DRM_IOCTL_ARGS ) {
	DRM_DEVICE;
	drm_file_t *filp_priv;
	drm_get_vbios_t gb;
	struct resource *r;
	unsigned char *rom;
	int sigok;
	drm_map_t *mmio = NULL;

	DRM_DEBUG("\n");

	DRM_GET_PRIV_WITH_RETURN( filp_priv, filp );

	DRM_COPY_FROM_USER_IOCTL( gb, ( drm_get_vbios_t* )data, sizeof( gb ) );
				  
	/* Input length of zero is a request for the length */
	if (gb.length == 0) {
		DRM_DEBUG("get length\n");
		gb.length = pci_resource_len( dev->pdev, PCI_ROM_RESOURCE );
		DRM_COPY_TO_USER_IOCTL( (drm_get_vbios_t *)data, gb, sizeof(gb) );
		DRM_DEBUG("length is %lx\n", gb.length);
		return 0;
	}

	DRM_FIND_MAP( mmio, pci_resource_start( dev->pdev, 2 ) );
	if(!mmio) {
		DRM_ERROR("could not find mmio region map!\n");
		return DRM_ERR(EINVAL);
	}
              
	DRIVER_ROMBUG(mmio); /* used to fix a bug in the ATI BIOS */                    
                                                                                                        
	/* no need to search for the ROM, just ask the card where it is. */
	r = &dev->pdev->resource[PCI_ROM_RESOURCE];
	
	/* assign the ROM an address if it doesn't have one */
	if (r->parent == NULL)
		pci_assign_resource(dev->pdev, PCI_ROM_RESOURCE);
	
	/* enable if needed */
	if (!(r->flags & PCI_ROM_ADDRESS_ENABLE)) {
		u32 loc, size;
		pci_read_config_dword(dev->pdev, PCI_ROM_ADDRESS, &loc);
		pci_write_config_dword(dev->pdev, PCI_ROM_ADDRESS, ~PCI_ROM_ADDRESS_ENABLE);
		pci_read_config_dword(dev->pdev, PCI_ROM_ADDRESS, &size);
		pci_write_config_dword(dev->pdev, PCI_ROM_ADDRESS, loc);
		size = pci_size(loc, size, PCI_ROM_ADDRESS_MASK);
		DRM_DEBUG("VROM base is %08x %08x\n", loc, size );
		pci_write_config_dword(dev->pdev, PCI_ROM_ADDRESS, r->start | PCI_ROM_ADDRESS_ENABLE);
		r->flags |= PCI_ROM_ADDRESS_ENABLE;
		DRM_DEBUG("Address start/end is %08lx %08lx\n", r->start, r->end );
		pci_read_config_dword(dev->pdev, PCI_ROM_ADDRESS, &loc);
		DRM_DEBUG("VROM enable is %08x\n", loc );
	}
	
	gb.length = min( gb.length, pci_resource_len( dev->pdev, PCI_ROM_RESOURCE ));
	rom = ioremap(r->start, r->end - r->start + 1);
	if (rom) {
	
		sigok = ((readb(rom) == 0x55) && (readb(rom + 1) == 0xAA));

		if (sigok)
			DRM_COPY_TO_USER( gb.data, rom, gb.length);
		else
			DRM_DEBUG("VROM signature wrong %02x %02x\n", *(unsigned char *)rom, *((unsigned char *)rom+1) );
		
		iounmap(rom);
		
		if (r->parent) {
			release_resource(r);
			r->flags &= ~PCI_ROM_ADDRESS_ENABLE;
			r->end -= r->start;
			r->start = 0;
		}
		/* This will disable and set address to unassigned */
		pci_write_config_dword(dev->pdev, PCI_ROM_ADDRESS, 0);
		
		if (sigok) {
			DRM_COPY_TO_USER_IOCTL( (drm_get_vbios_t *)data, gb, sizeof(gb) );
			return 0;
		}
	} else 
		DRM_DEBUG("VROM failed to map\n");

	DRM_DEBUG("Using VROM copy at C000\n");
	rom = ioremap(0xC0000, r->end - r->start + 1);
	DRM_COPY_TO_USER( gb.data, rom, gb.length);
	DRM_COPY_TO_USER_IOCTL( (drm_get_vbios_t *)data, gb, sizeof(gb) );
	iounmap(rom);
	return 0;
/*	
	DRM_DEBUG("radeonfb: ROM failed to map\n");
	gb.length = 0;
	DRM_COPY_TO_USER_IOCTL( (drm_get_vbios_t *)data, gb, sizeof(gb) );
	return -1;
*/
}

--0-985079121-1091215510=:72997--
