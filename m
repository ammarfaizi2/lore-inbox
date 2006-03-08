Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWCHHLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWCHHLt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 02:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWCHHLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 02:11:49 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:4415 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752089AbWCHHLs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 02:11:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R1v07W36hJgcJjxiNBSb89CUBhxphaVF/DNTDBBBUPuKVLrrRux7kgv4/lWQNXN1xsUB5gBhSCi82z854J1fZ16maObVerpTS1i1SDBPdyKsLR4fZbsPlPccRdZ2zauFaNQn7DA7GVaIkPi7Q2ru2lurLqjMoOw3ULR62eH8aaU=
Message-ID: <756b48450603072311g2c604738h3972b3ddd720266d@mail.gmail.com>
Date: Wed, 8 Mar 2006 15:11:47 +0800
From: "Jaya Kumar" <jayakumar.acpi@gmail.com>
To: "Yu, Luming" <luming.yu@intel.com>
Subject: Re: [PATCH 2.6.15.3 1/1] ACPI: Atlas ACPI driver
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <3ACA40606221794F80A5670F0AF15F840B22AA1D@pdsmsx403>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3ACA40606221794F80A5670F0AF15F840B22AA1D@pdsmsx403>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/06, Yu, Luming <luming.yu@intel.com> wrote:
> I think video.c is NOT a right solution for your problem.

Cool. I agree with you there.

> You have dedicated ACPI device and method for brightness control.
> So hotkey.c is the right place for support Device LCD.

I'm confused by what you are saying. The only actual input mechanism
that is physically hooked up on this Atlas board, as far as I can
tell, is ASIM which is connected to the buttons on the board. None of
the other capabilities of the actual chips are actually physically
hooked up on the actual board. There is no keyboard, no USB, etc. When
I press the physical buttons on the board, I get events such as the
following:

evregion-0303 [19] ev_address_space_dispa: No handler for Region
[ASI2] (cf7809fc) [user_defined_region]
 exfldio-0284: *** Error: Region user_defined_region(81) has no handler
 psparse-0508: *** Error: Method execution failed [\BNSV] (Node
cf789d48), AE_NOT_EXIST
 psparse-0508: *** Error: Method execution failed [\_GPE._L15] (Node
cf789888), AE_NOT_EXIST
   evgpe-0549: *** Error: AE_NOT_EXIST while evaluating method [_L15]
for GPE[ 0]
evregion-0303 [19] ev_address_space_dispa: No handler for Region
[ASI2] (cf7809fc) [user_defined_region]
 exfldio-0284: *** Error: Region user_defined_region(81) has no handler
 psparse-0508: *** Error: Method execution failed [\BNSV] (Node
cf789d48), AE_NOT_EXIST
 psparse-0508: *** Error: Method execution failed [\_GPE._L15] (Node
cf789888), AE_NOT_EXIST
   evgpe-0549: *** Error: AE_NOT_EXIST while evaluating method [_L15]
for GPE[ 0]

>
> As for Device ASIM, I don't understand this code in your patch,
> Care to explain. It looks strange to me.

Sure. As per the dmesg above, the button presses are generating
something from region 81. So my solution to that was to hookup an
address space handler for region 81 for the ASIM HID and then generate
the corresponding button events in the handler. That's the code that
you see below:

I hope what I've explained above makes sense. To reiterate, if you
want me to do something with respect to hotkey, I still don't
understand how and where hotkey is involved. Perhaps you could help me
by elaborating further.

Thanks,
jayakumar


>
> +static acpi_status acpi_atlas_button_handler(u32 function,
> +                     acpi_physical_address address,
> +                     u32 bit_width, acpi_integer * value,
> +                     void *handler_context, void *region_context)
> +{
> +       acpi_status status;
> +       struct acpi_device *dev;
> +
> +       dev = (struct acpi_device *) handler_context;
> +       if (function == ACPI_WRITE)
> +               status = acpi_bus_generate_event(dev, 0x80, address);
> +       else {
> +               printk(KERN_WARNING "atlas: shrugged on unexpected
> function"
> +                       ":function=%x,address=%x,value=%x\n",
> +                       function, (u32)address, (u32)*value);
> +               status = -EINVAL;
> +       }
> +
> +       return status ;
> +}
> +
> +static int atlas_acpi_button_add(struct acpi_device *device)
> +{
> +
> +       /* hookup button handler */
> +       return acpi_install_address_space_handler(device->handle,
> +                               0x81, &acpi_atlas_button_handler,
> +                               &acpi_atlas_button_setup, device);
> +}
> +
>
