Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267235AbUGMXnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267235AbUGMXnD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 19:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267236AbUGMXnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 19:43:03 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:35466 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S267235AbUGMXm7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 19:42:59 -0400
Date: Wed, 14 Jul 2004 01:39:03 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Auzanneau Gregory <greg@reolight.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8-rc1 and before: IO-APIC + DRI + RTL8139 = Disabling Ethernet IRQ
Message-ID: <20040714013903.A21905@electric-eye.fr.zoreil.com>
References: <40F4635C.3090003@reolight.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40F4635C.3090003@reolight.net>; from greg@reolight.net on Wed, Jul 14, 2004 at 12:34:04AM +0200
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Auzanneau Gregory <greg@reolight.net> :
[...]
> [drm] Loading R200 Microcode
> irq 19: nobody cared!
>  [<c010732a>] __report_bad_irq+0x2a/0x8b
>  [<c0107414>] note_interrupt+0x6f/0x9f
>  [<c0107732>] do_IRQ+0x161/0x192
>  [<c0105a00>] common_interrupt+0x18/0x20
> handlers:
> [<c0245383>] (rtl8139_interrupt+0x0/0x207)
> Disabling IRQ #19
> 
> For the moment I can disabling IO-ACPI, but I'm thinking to change my
> processor with an processor w/HT. So IO-ACPI is enabling by default.
> 
> How solve that ?

Shot in the dark (+ quick look into drivers/char/drm):

drivers/char/drm/radeon_irq.c:
[...]
irqreturn_t DRM(irq_handler)( DRM_IRQ_ARGS )
{
        drm_device_t *dev = (drm_device_t *) arg;
        drm_radeon_private_t *dev_priv =
           (drm_radeon_private_t *)dev->dev_private;
        u32 stat;

        /* Only consider the bits we're interested in - others could be used
         * outside the DRM
         */
>       stat = RADEON_READ(RADEON_GEN_INT_STATUS)
>            & (RADEON_SW_INT_TEST | RADEON_CRTC_VBLANK_STAT);
>       if (!stat)
>               return IRQ_NONE;

Can you turn the ">" lines into:
	stat = RADEON_READ(RADEON_GEN_INT_STATUS);
	if (!(stat & (RADEON_SW_INT_TEST | RADEON_CRTC_VBLANK_STAT))) {
		int ret = IRQ_NONE;

		if (stat & ~(RADEON_SW_INT_TEST | RADEON_CRTC_VBLANK_STAT)) {
			DRM_INFO("Bingo !\n");
			ret = IRQ_HANDLED;
		}
		return ret;
	}

If it does not work, please send complete dmesg and lspci -vx.

--
Ueimor
