Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030372AbWGMWFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030372AbWGMWFg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 18:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030421AbWGMWFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 18:05:36 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:45495 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S1030372AbWGMWFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 18:05:35 -0400
Message-ID: <44B6C3AE.60009@vc.cvut.cz>
Date: Fri, 14 Jul 2006 00:05:34 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.7.13) Gecko/20060620 Debian/1.7.13-0.2
X-Accept-Language: cs, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?=22J=2EA=2E_Magall=F3n=22?= <jamagallon@ono.com>
CC: "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: AGP mem resource is 64 bits, so no X ?
References: <20060713001123.6d523a2f@werewolf.auna.net>
In-Reply-To: <20060713001123.6d523a2f@werewolf.auna.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallón wrote:
> Hi...
> 
> I have a box with a SuperMicro P4DCE+ mobo.
> After an upgrade to the latest bios (v1.3, DC6P6273.zip), the kernel
> (2.6.28-rc1-mm1) does not recognize the AGP card (an nvidia GeForce 6600 GT).
> The propierary 'nvidia' driver does not load beacuse it says:

It is not 64bit AGP resource problem...

> agpgart: Detected an Intel i860 Chipset.
> agpgart: AGP aperture is 128M @ 0xe8000000

> Hardware:
> 
> 00:01.0 PCI bridge: Intel Corporation 82850 850 (Tehama) Chipset AGP Bridge (rev 04) (prog-if 00 [Normal decode])
> 	Memory behind bridge: f0000000-f2ffffff
> 	Prefetchable memory behind bridge: d8000000-e7ffffff
> 
> 00:02.0 PCI bridge: Intel Corporation 82860 860 (Wombat) Chipset AGP Bridge (rev 04) (prog-if 00 [Normal decode])
> 	Memory behind bridge: f3000000-f4ffffff
> 	Prefetchable memory behind bridge: 50000000-501fffff
> 
> 01:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce 6600/GeForce 6600 GT] (rev a2) (prog-if 00 [VGA])
> 	Memory at f0000000 (32-bit, non-prefetchable) [size=16M]
> 	Memory at <ignored> (32-bit, prefetchable)
> 	Memory at f1000000 (32-bit, non-prefetchable) [size=16M]
> 	[virtual] Expansion ROM at d8000000 [disabled] [size=128K]
> 
> Parts of dmesg:
> 
> PCI: Cannot allocate resource region 1 of device 0000:01:00.0
> PCI: Failed to allocate mem resource #1:10000000@e0000000 for 0000:01:00.0
> 
> Any idea ?
> Anyone has a previous BIOS ;) to share ?

It is just fatally confused BIOS.  Your NVidia needs 256MB region for its 
framebuffer apperture, but BIOS assigned 256MB for it at 0xE0000000, and later 
it revoked second half of this assignment in favor of AGP aperture.  Which on 
electrical level means that only first 128MB of nvidia will be accessible from CPU.

While Windows will probably just complain loudly that from specified 256MB range 
only 128MB is routed down to the adapter, and maybe even nvidia driver will cope 
with it, using only 128MB of RAM, for Linux (rightly so) adapter is unusable, as 
it wanted 256MB allocation for BAR1, but kernel could satisfy only 128MB without 
redoing all PCI address space layout.

Besides going back to older BIOS I would recommend using different AGP aperture 
size in the BIOS - with 256MB aperture I believe that you'll not trigger this 
BIOS bug.

If it won't help, then you can try fiddling with pcibios_resource_survey() - if 
you'll disable it, all resources should be assigned from scratch by 
pci_assign_unassigned_resources.  This way kernel should be able to find 256MB 
chunk for adapter.  To be able to use this aproach you definitely want to 
disable legacy (or any...) support for USB in the BIOS, you do not want to use 
vesa framebuffer, and maybe some other problems as well - it can break constants 
encoded into ACPI tables :-(
							Petr Vandrovec

