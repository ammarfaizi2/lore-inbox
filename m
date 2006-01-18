Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030231AbWARLkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbWARLkY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 06:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbWARLkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 06:40:24 -0500
Received: from uproxy.gmail.com ([66.249.92.206]:6524 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030232AbWARLkY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 06:40:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WsYZfCEqG9JuDcHA5TRGaAfKaw0Z79hgTPxAsbnOyJPrQjDG8FcPcjDgTF/8VTOv5e/WPY3v7jpfsA9MTXjGC1FsYqNeB5d70yF6a4exzaKa6crWkewKHJsL9xFW9nZYnxOw1dwo4PVBUDetGdd9DQ0PRTLP//0/gCOnQUhNoFw=
Message-ID: <58cb370e0601180340v529c04fdq5dc962285a6fc1c0@mail.gmail.com>
Date: Wed, 18 Jan 2006 12:40:22 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: (For review) Teach libata to tune master/slave seperately
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com
In-Reply-To: <1137531678.14135.105.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1137531678.14135.105.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Patch looks fine some comments below:

On 1/17/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> This also adds a filter hook which allows drives to veto modes by drive
> specific detail. This is preferable to the more obvious 'have the driver
> change the speed itself' approach because we have a combination of
> constraints some known by the driver and some (such as PHY limits) by
> the core code. We don't want drivers overriding constraints due to lack
> of knowledge and setting unsafe/invalid modes.

Yep.

> The core logic is unchanged, it's merely had a re-order and the mode

The core logic is changed (in the positive way): ata_pio_modes()
is finally used for obtaining PIO mask to be used.

Please update the patch description or make it a separate change.

The other functional change is the ordering of programming host/devices:

previously:
* program PIO for device 0 [host]
* program PIO for device 1 [host]
* program DMA for device 0 [host]
* program DMA for device 1 [host]
* program xfer mode for device 0 [device]
* program xfer mode for device 1 [device]

now:
* program PIO for device 0 [host]
* program DMA for device 0 [host]
* program xfer mode for device 0 [device]
* program PIO for device 1 [host]
* program DMA for device 1 [host]
* program xfer mode for device 0 [device]

This change is OK but I wonder what is the reason for it?

> decision is made twice instead of once only. Another important change in
> the re-order which makes driver writers life much easier for PATA is
> that both drive speeds decisions are made *before* the driver is called.
>
> This is essential to your sanity when programming the many controllers
> that do not use the device select bit to switch between address setup
> times.
>
> Tested in my patches for a while and seems to work for the combinations
> I have. Introduces no new bugs I've found but obviously piix secondary
> slave doesn't reliably work with or without this change because of the
> current piix driver bug.

I thought it was merged already (it is obviously correct)?

Thanks,
Bartlomiej
