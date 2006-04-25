Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWDYPA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWDYPA7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 11:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWDYPA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 11:00:59 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:42763 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932246AbWDYPA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 11:00:59 -0400
Date: Tue, 25 Apr 2006 16:00:50 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ram <vshrirama@gmail.com>
Cc: linux-kernel@vger.kernel.org, Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: sd cards : OCR busy?
Message-ID: <20060425150050.GB18113@flint.arm.linux.org.uk>
Mail-Followup-To: Ram <vshrirama@gmail.com>, linux-kernel@vger.kernel.org,
	Pierre Ossman <drzeus-list@drzeus.cx>
References: <8bf247760604250741l5ee1267cg7745ef5934f48497@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bf247760604250741l5ee1267cg7745ef5934f48497@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 07:41:04AM -0700, Ram wrote:
>    I am using Linux 2.6.15.
> 
>    I am getting OCR busy Error. The driver works on some sd cards and
> does not work
>    on some other cards. i really cant figure out what the problem is.

It seems that your kernel is doing something different from the code I
have in front of me.

> mmc_detect_change:
> mmc_rescan:
> __mmc_claim_host:
> mmc_setup:
> mmc_power_up:
> MMC1: set_ios: clock 400000Hz busmode 1 powermode 1 Vdd 0.21
> mmc_delay:
> MMC1: set_ios: clock 400000Hz busmode 1 powermode 2 Vdd 0.21
> mmc_delay:
> mmc_idle_cards:
> MMC1: set_ios: clock 400000Hz busmode 1 powermode 2 Vdd 0.21

Card inserted - okay.

> mmc_delay:
> mmc_wait_for_cmd:
> mmc_wait_for_req:
> mmc_omap_start_command:MMC1: CMD0, argument 0x00000000
> mmc_omap_irq:MMC IRQ 0001 (CMD 0): EOC
> MMC1: End request, err 0

Card told to go to idle state - okay.

> mmc_delay:
> MMC1: set_ios: clock 400000Hz busmode 1 powermode 2 Vdd 0.21
> mmc_delay:
> mmc_send_app_op_cond:
> mmc_wait_for_app_cmd:
> mmc_wait_for_req:
> mmc_omap_start_command:MMC1: CMD55, argument 0x00000000, 32-bit response,
> CRC
> mmc_omap_irq:MMC IRQ 1001 (CMD 55): EOC OCRB
> MMC1: OCR busy error, CMD55
> MMC1: Response 00000000
> MMC1: End request, err 0

Sent MMC_APP_CMD, got told "OCR busy" - this is bogus.  APP_CMD does _not_
return an OCR.  No idea why your OMAP host thinks it does.

Nevertheless, we have a zero response, but the card _did_ apparantly
respond.  So we decide APP commands aren't supported.

> mmc_setup:No MMC cards found
> mmc_send_op_cond:
> mmc_wait_for_cmd:
> mmc_wait_for_req:
> mmc_omap_start_command:MMC1: CMD1, argument 0x00000000, 32-bit response
> mmc_omap_irq:MMC IRQ 1001 (CMD 1): EOC OCRB
> MMC1: Response 00000000
> MMC1: End request, err 0

We send a CMD1 to probe for the OCR.  Get zero back.  Zero back from a card
means "I don't support any voltage what so ever", so...

> mmc_select_voltage: ocr - 0
> mmc_release_host:
> mmc_power_off:

We power down.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
