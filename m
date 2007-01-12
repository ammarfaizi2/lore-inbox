Return-Path: <linux-kernel-owner+w=401wt.eu-S964794AbXALRYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbXALRYe (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 12:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbXALRYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 12:24:34 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:41589 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932333AbXALRYd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 12:24:33 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Le+GzQJhw216n7ZiurSBLwLnB14+HNIaUaqVG3MnTpiblt6zZ7aOEoeefSY0weBMmFPWsSp5iM3dtxGM9XdUmssYWje27HtlVEz67Rn7+wRuIE/mVNXc3C1u0iKUjjNMbCoH7CxhkKLomAzskM96Xae40P78o907e4d2loBSnCU=
Message-ID: <58cb370e0701120924u7f8d0e32ta57b983ad10c502c@mail.gmail.com>
Date: Fri, 12 Jan 2007 18:24:31 +0100
From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 18/19] ide: add ide_use_fast_pio() helper
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20070112151629.00c17327@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
	 <20070112042800.28794.95095.sendpatchset@localhost.localdomain>
	 <20070112100836.58738dbc@localhost.localdomain>
	 <58cb370e0701120600pc65b237w4865c9637fc1b6e6@mail.gmail.com>
	 <20070112143037.7d5bf10f@localhost.localdomain>
	 <58cb370e0701120643l5274bd5bn9d9f3661808a455c@mail.gmail.com>
	 <20070112151629.00c17327@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/07, Alan <alan@lxorguk.ukuu.org.uk> wrote:
> > It seems that it821x_tune_chipset() is buggy since it sends SET FEATURES
> > command even when in smart mode.  Shouldn't there be "don't tune" flag
> > in it812x_fixups() to tell it821x_tune_chipset() to not send SET FEATURES
> > commands?
>
> It's itdev->smart but falls through to ide_config_drive_speed while it
> should probably just copy bits of the code from it. Thats all fixed in
> the libata driver which allows chip specific mode setup.

ide_config_drive_speed() does the following things:
1. disables host DMA
2. sends SET FEATURES command (in polling mode)
3. re-enables host DMA (only if DMA mode was set)
4. updates drive->id->dma_{ultra,mword,1word}
5. updates drive->{current,init}_speed

1. and 2. should really go to higher layers
3. obviously shouldn't be done for itdev->smart
4. also shouldn't be done for itdev>smart
   (we are not changing speed mode)
5. should be done once outside of it821x_tune_chipset()

Therefore current TODO looks like:
* moving DMA fiddling code out of ide_config_drive_speed()
* setting drive->{current,init} speed in it821x_fixups()
* fixing it821x not to call ide_config_drive_speed() for itdev->smart

Fixing user space generated requests requires more work
(i.e. adding ->set_mode method)...

I'll try to cook up some patches later unless somebody beats me to it.

Thanks,
Bart
