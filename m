Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbVBIVVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbVBIVVa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 16:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbVBIVVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 16:21:30 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:62456 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S261927AbVBIVVM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 16:21:12 -0500
Message-ID: <420A826B.A4360D24@gte.net>
Date: Wed, 09 Feb 2005 13:36:43 -0800
From: Bukie Mabayoje <bukiemab@gte.net>
X-Mailer: Mozilla 4.78 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Corey Minyard <minyard@acm.org>
CC: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Update to IPMI driver to support old DMI spec
References: <420A474B.2030608@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [66.199.68.159] at Wed, 9 Feb 2005 15:21:11 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Corey Minyard wrote:

> BTW, I'm also working with the person who had the trouble with the I2C
> non-blocking driver updates, but we haven't figured it out yet.
> Hopefully soon.  (Though that has nothing to do with this patch.)
>
> Thanks,
>
> -Corey
>
>                                                   -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> The 1999 version of the DMI spec had a different configuration
> than the newer versions for the IPMI configuration information.

Are you referring to the System Management BIOS Reference Specification  version 2.3.1 16 March 1999?

>
> This patch handles the differences between the two.
>
> Signed-off-by: Corey Minyard <minyard@acm.org>
>
> Index: linux-2.6.11-rc3/drivers/char/ipmi/ipmi_si_intf.c
> ===================================================================
> --- linux-2.6.11-rc3.orig/drivers/char/ipmi/ipmi_si_intf.c
> +++ linux-2.6.11-rc3/drivers/char/ipmi/ipmi_si_intf.c
> @@ -1578,46 +1578,53 @@
>         u8              *data = (u8 *)dm;
>         unsigned long   base_addr;
>         u8              reg_spacing;
> +       u8              len = dm->length;
>         dmi_ipmi_data_t *ipmi_data = dmi_data+intf_num;
>
>         ipmi_data->type = data[4];
>
>         memcpy(&base_addr, data+8, sizeof(unsigned long));
> -       if (base_addr & 1) {
> -               /* I/O */
> -               base_addr &= 0xFFFE;
> +       if (len >= 0x11) {
> +               if (base_addr & 1) {
> +                       /* I/O */
> +                       base_addr &= 0xFFFE;
> +                       ipmi_data->addr_space = IPMI_IO_ADDR_SPACE;
> +               }
> +               else {
> +                       /* Memory */
> +                       ipmi_data->addr_space = IPMI_MEM_ADDR_SPACE;
> +               }
> +               /* If bit 4 of byte 0x10 is set, then the lsb for the address
> +                  is odd. */
> +               ipmi_data->base_addr = base_addr | ((data[0x10] & 0x10) >> 4);
> +
> +               ipmi_data->irq = data[0x11];
> +
> +               /* The top two bits of byte 0x10 hold the register spacing. */
> +               reg_spacing = (data[0x10] & 0xC0) >> 6;
> +               switch(reg_spacing){
> +               case 0x00: /* Byte boundaries */
> +                   ipmi_data->offset = 1;
> +                   break;
> +               case 0x01: /* 32-bit boundaries */
> +                   ipmi_data->offset = 4;
> +                   break;
> +               case 0x02: /* 16-byte boundaries */
> +                   ipmi_data->offset = 16;
> +                   break;
> +               default:
> +                   /* Some other interface, just ignore it. */
> +                   return -EIO;
> +               }
> +       } else {
> +               /* Old DMI spec. */
> +               ipmi_data->base_addr = base_addr;
>                 ipmi_data->addr_space = IPMI_IO_ADDR_SPACE;
> -       }
> -       else {
> -               /* Memory */
> -               ipmi_data->addr_space = IPMI_MEM_ADDR_SPACE;
> -       }
> -
> -       /* The top two bits of byte 0x10 hold the register spacing. */
> -       reg_spacing = (data[0x10] & 0xC0) >> 6;
> -       switch(reg_spacing){
> -       case 0x00: /* Byte boundaries */
>                 ipmi_data->offset = 1;
> -               break;
> -       case 0x01: /* 32-bit boundaries */
> -               ipmi_data->offset = 4;
> -               break;
> -       case 0x02: /* 16-byte boundaries */
> -               ipmi_data->offset = 16;
> -               break;
> -       default:
> -               /* Some other interface, just ignore it. */
> -               return -EIO;
>         }
>
>         ipmi_data->slave_addr = data[6];
>
> -       /* If bit 4 of byte 0x10 is set, then the lsb for the address
> -          is odd. */
> -       ipmi_data->base_addr = base_addr | ((data[0x10] & 0x10) >> 4);
> -
> -       ipmi_data->irq = data[0x11];
> -
>         if (is_new_interface(-1, ipmi_data->addr_space,ipmi_data->base_addr)) {
>                 dmi_data_entries++;
>                 return 0;
