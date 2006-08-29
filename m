Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWH2I2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWH2I2v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 04:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWH2I2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 04:28:51 -0400
Received: from gate.crashing.org ([63.228.1.57]:10673 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750834AbWH2I2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 04:28:50 -0400
Subject: Re: [PATCH] exit early in floppy_init when no floppy exists
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olaf@aepfle.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060829080738.GA22708@aepfle.de>
References: <20060829080738.GA22708@aepfle.de>
Content-Type: text/plain
Date: Tue, 29 Aug 2006 18:28:31 +1000
Message-Id: <1156840111.8433.534.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-29 at 10:07 +0200, Olaf Hering wrote:
> modprobe -v floppy on a Apple G5 writes incorrect stuff to dmesg:
> 
> Floppy drive(s): fd0 is 2.88M
> 
> The reason is that the legacy io check happens very late,
> when part of the floppy stuff is already initialized.
> check_legacy_ioport() returns either -ENODEV right away, or it walks
> the device-tree looking for a floppy node.
> 
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
> 
> Can this go into 2.6.18 please? Our installer parses dmesg to find
> floppy devices. Dont ask....
> 
> 
> 
> 
>  drivers/block/floppy.c |   12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> Index: linux-2.6.18-rc4/drivers/block/floppy.c
> ===================================================================
> --- linux-2.6.18-rc4.orig/drivers/block/floppy.c
> +++ linux-2.6.18-rc4/drivers/block/floppy.c
> @@ -4177,6 +4177,11 @@ static int __init floppy_init(void)
>  	int i, unit, drive;
>  	int err, dr;
>  
> +#if defined(CONFIG_PPC_MERGE)
> +	if (check_legacy_ioport(FDC1))
> +		return -ENODEV;
> +#endif
> +
>  	raw_cmd = NULL;
>  
>  	for (dr = 0; dr < N_DRIVE; dr++) {
> @@ -4234,13 +4239,6 @@ static int __init floppy_init(void)
>  	}
>  
>  	use_virtual_dma = can_use_virtual_dma & 1;
> -#if defined(CONFIG_PPC_MERGE)
> -	if (check_legacy_ioport(FDC1)) {
> -		del_timer(&fd_timeout);
> -		err = -ENODEV;
> -		goto out_unreg_region;
> -	}
> -#endif
>  	fdc_state[0].address = FDC1;
>  	if (fdc_state[0].address == -1) {
>  		del_timer(&fd_timeout);
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

