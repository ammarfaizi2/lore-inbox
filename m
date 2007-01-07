Return-Path: <linux-kernel-owner+w=401wt.eu-S965017AbXAGToU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965017AbXAGToU (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 14:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbXAGToU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 14:44:20 -0500
Received: from outbound-mail-22.bluehost.com ([69.89.21.17]:37227 "HELO
	outbound-mail-22.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965017AbXAGToT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 14:44:19 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] update MMConfig patches w/915 support
Date: Sun, 7 Jan 2007 11:44:16 -0800
User-Agent: KMail/1.9.5
Cc: Olivier Galibert <galibert@pobox.com>,
       Arjan van de Ven <arjan@infradead.org>
References: <200701071142.09428.jbarnes@virtuousgeek.org>
In-Reply-To: <200701071142.09428.jbarnes@virtuousgeek.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701071144.16045.jbarnes@virtuousgeek.org>
X-Identified-User: {642:box128.bluehost.com:virtuous:virtuousgeek.org} {sentby:smtp auth 67.161.73.10 authed with jbarnes@virtuousgeek.org}
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, January 07, 2007 11:42 am, Jesse Barnes wrote:
> This patch updates Oliver's MMConfig bridge detection patches with
> support for 915G bridges.  It seems to work ok on my 915GM laptop.
>
> I also tried adding 965 support, but it doesn't work (at least not on my
> G965 box).  When I enable MMConfig support when the register value is
> 0xf00000003 (should be a 256M enabled window at 0xf0000000) the box
> hangs at boot, so I'm not sure what I'm doing wrong...

For reference, here's the probe routine I tried for 965, probably something 
dumb wrong with it that I'm not seeing atm.

static __init const char *pci_mmcfg_intel_965(void)
{
	u64 pciexbar, mask = 0, len = 0;
	u32 lo, hi;

	pci_mmcfg_config_num = 1;

	pci_conf1_read(0, 0, PCI_DEVFN(0,0), 0x60, 4, &lo);
	pci_conf1_read(0, 0, PCI_DEVFN(0,0), 0x64, 4, &hi);
	pciexbar = ((u64)hi << 32) | lo;

	/* Enable bit */
	if (!(pciexbar & 1))
		pci_mmcfg_config_num = 0;

	/* Size bits */
	switch ((pciexbar >> 1) & 3) {
	case 0:
		mask = 0xff0000000UL;
		len  = 0x10000000U;
		break;
	case 1:
		mask = 0xff8000000UL;
		len  = 0x08000000U;
		break;
	case 2:
		mask = 0xffc000000UL;
		len  = 0x04000000U;
		break;
	default:
		pci_mmcfg_config_num = 0;
	}

	if (pci_mmcfg_config_num) {
		pci_mmcfg_config = kzalloc(sizeof(pci_mmcfg_config[0]),
					   GFP_KERNEL);
		pci_mmcfg_config[0].base_address = pciexbar & mask;
		pci_mmcfg_config[0].pci_segment_group_number = 0;
		pci_mmcfg_config[0].start_bus_number = 0;
		pci_mmcfg_config[0].end_bus_number = (len >> 20) - 1;
	}

	return "Intel Corporation G965 Express Memory Controller Hub";
}

Thanks,
Jesse

P.S.  Hooray for Intel for publishing their bridge specs!  Makes stuff like 
this a bit easier.
