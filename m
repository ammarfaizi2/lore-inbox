Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281199AbRKEQBz>; Mon, 5 Nov 2001 11:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281200AbRKEQBp>; Mon, 5 Nov 2001 11:01:45 -0500
Received: from zero.tech9.net ([209.61.188.187]:63758 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S281199AbRKEQBa>;
	Mon, 5 Nov 2001 11:01:30 -0500
Subject: Re: [PATCH]agp for i820 chipset
From: Robert Love <rml@tech9.net>
To: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3BE6B50A.5010806@epfl.ch>
In-Reply-To: <3BE6B50A.5010806@epfl.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.28.13.59 (Preview Release)
Date: 05 Nov 2001 11:01:29 -0500
Message-Id: <1004976089.934.12.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-11-05 at 10:49, Nicolas Aspert wrote:
> Here is an unpdated version of the patch I posted last week that enables 
> AGP support for i820 chipset. This one has been done against 2.4.13-ac7, 
> _but_ not tested under this kernel. However, it works fine under 2.4.9 
> Redhat's kernel (i.e. close to a 2.4.9-ac kernel I think). Xfree-4.1, 
> openGL apps and Quake3 are running smoothly.
> [...]

Hey, very good.  I don't have an i820 but I am working with the AGPGART
driver so I can say everything looks good.  I am actually working on a
rewrite; I find it ridiculous we need all these specific 820 functions. 
I am have a design where we load a lookup table, index by the enum, with
the register information and then a generic function can load in the
right value.  I really working on cleaning the cruft up ...

I do have two comments, though.  I would suggest if you don't hear
anything negative and the patch works for you to go ahead and send it to
Alan and Linus, although you should make sure it is diffed against their
newest trees.


> @@ -200,6 +203,9 @@
>  #ifndef PCI_DEVICE_ID_INTEL_810_1
>  #define PCI_DEVICE_ID_INTEL_810_1       0x7121
>  #endif
> +#ifndef PCI_DEVICE_ID_INTEL_820_1
> +#define PCI_DEVICE_ID_INTEL_820_1       0x250f
> +#endif

I'm not too sure why you need this.  I see other chipsets have their
device 0:01 defined but I can't reason why.  When I add AGP drivers I
never add it.  If you remove it, I think you will find everything still
works.

> +static int intel_820_fetch_size(void)
> +{
> +	int i;
> +	u8 temp;
> +	aper_size_info_16 *values;
> +
> +	pci_read_config_byte(agp_bridge.dev, INTEL_APSIZE, &temp);
> +	values = A_SIZE_16(agp_bridge.aperture_sizes);
> +
> +	for (i = 0; i < agp_bridge.num_aperture_sizes; i++) {
> +		if (temp == (u8)(values[i].size_value)) {
> +			agp_bridge.previous_size =
> +			    agp_bridge.current_size = (void *) (values + i);
> +			agp_bridge.aperture_size_idx = i;
> +			return values[i].size;
> +		}
> +	}
> +
> +	return 0;
> +}

You can just use intel_generic_fetch_size or even one of the
i840-specific or whatever versions, here.  Note you don't use anything
specific to the i820, so reduce the footprint and ditch it.

	Robert Love

