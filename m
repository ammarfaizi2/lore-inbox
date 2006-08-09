Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWHITVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWHITVr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 15:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWHITVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 15:21:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:733 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751323AbWHITVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 15:21:46 -0400
Date: Wed, 9 Aug 2006 15:21:21 -0400
From: Dave Jones <davej@redhat.com>
To: Eric Anholt <eric@anholt.net>
Cc: linux-kernel@vger.kernel.org, Alan Hourihane <alanh@tungstengraphics.com>
Subject: Re: [PATCH] Add support for Intel i965G/Q GARTs.
Message-ID: <20060809192121.GJ10930@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Eric Anholt <eric@anholt.net>, linux-kernel@vger.kernel.org,
	Alan Hourihane <alanh@tungstengraphics.com>
References: <11551502672606-git-send-email-eric@anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11551502672606-git-send-email-eric@anholt.net>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 12:04:27PM -0700, Eric Anholt wrote:

 > 0bc75aab93ee69dcf547ca55a8afcd1464dbfc95
 > diff --git a/drivers/char/agp/intel-agp.c b/drivers/char/agp/intel-agp.c
 > index 61ac380..c51b365 100644
 > --- a/drivers/char/agp/intel-agp.c
 > +++ b/drivers/char/agp/intel-agp.c
 > @@ -8,8 +8,15 @@
 >   *
 >   * Intel(R) 915G/915GM support added by Alan Hourihane
 >   * <alanh@tungstengraphics.com>.
 > + *
 > + * Intel(R) 945G/945GM support added by Alan Hourihane
 > + * <alanh@tungstengraphics.com>.
 > + *
 > + * Intel(R) 946GZ/965Q/965G support added by Alan Hourihane
 > + * <alanh@tungstengraphics.com>.
 >   */

I think we should just strip out this whole credit section.
The attributions are stored in the SCM anyway, and this just
seems to grow and grow.

 > +#include <linux/version.h>

Unnecessary.

 > +/* Should be moved to include/linux/pci_ids.h */
 > +#define PCI_DEVICE_ID_INTEL_82946GZ_HB      0x2970
 > +#define PCI_DEVICE_ID_INTEL_82946GZ_IG      0x2972
 > +#define PCI_DEVICE_ID_INTEL_82965G_1_HB     0x2980
 > +#define PCI_DEVICE_ID_INTEL_82965G_1_IG     0x2982
 > +#define PCI_DEVICE_ID_INTEL_82965Q_HB       0x2990
 > +#define PCI_DEVICE_ID_INTEL_82965Q_IG       0x2992
 > +#define PCI_DEVICE_ID_INTEL_82965G_HB       0x29A0
 > +#define PCI_DEVICE_ID_INTEL_82965G_IG       0x29A2

Actually if this is the only place they're used, this is the right
place for them. Stuff should only go into linux/pci_ids.h if
theres another driver that uses the same ID.

 > +#define IS_I965 (agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82946GZ_HB || \
 > +                 agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82965G_1_HB || \
 > +                 agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82965Q_HB || \
 > +                 agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82965G_HB)
 > +

How about just doing this once during module init, and setting a global
'is_i965' variable ?

 > @@ -354,6 +379,7 @@ static struct aper_size_info_fixed intel
 >  	/* The 64M mode still requires a 128k gatt */
 >  	{64, 16384, 5},
 >  	{256, 65536, 6},
 > +        {512, 131072, 7},
 >  };

Broken indentation

 >  static struct _intel_i830_private {
 > @@ -377,7 +403,11 @@ static void intel_i830_init_gtt_entries(
 >  	/* We obtain the size of the GTT, which is also stored (for some
 >  	 * reason) at the top of stolen memory. Then we add 4KB to that
 >  	 * for the video BIOS popup, which is also stored in there. */
 > -	size = agp_bridge->driver->fetch_size() + 4;
 > +
 > +       if (IS_I965)
 > +               size = 512 + 4;
 > +       else
 > +               size = agp_bridge->driver->fetch_size() + 4;

ditto. (Use tabs, not spaces).

 > @@ -736,7 +766,7 @@ static int intel_i915_remove_entries(str
 >  static int intel_i915_fetch_size(void)
 >  {
 >  	struct aper_size_info_fixed *values;
 > -	u32 temp, offset;
 > +	u32 temp, offset = 0;
 >  
 >  #define I915_256MB_ADDRESS_MASK (1<<27)

Unnecessary. We never read this before we write to it.

 > +/* The intel i965 automatically initializes the agp aperture during POST.
 > ++ * Use the memory already set aside for in the GTT.
 > ++ */
 > +static int intel_i965_create_gatt_table(struct agp_bridge_data *bridge)
 > +{
 > +       int page_order;
 > +       struct aper_size_info_fixed *size;
 > +       int num_entries;
 > +       u32 temp;
 > +
 > +       size = agp_bridge->current_size;
 > +       page_order = size->page_order;
 > +       num_entries = size->num_entries;
 > +       agp_bridge->gatt_table_real = NULL;
 > +
 > +       pci_read_config_dword(intel_i830_private.i830_dev, I915_MMADDR, &temp);
 > +
 > +       temp &= 0xfff00000;
 > +       intel_i830_private.gtt = ioremap((temp + (512 * 1024)) , 512 * 1024);
 > +
 > +       if (!intel_i830_private.gtt)
 > +               return -ENOMEM;
 > +
 > +
 > +       intel_i830_private.registers = ioremap(temp,128 * 4096);
 > +       if (!intel_i830_private.registers)
 > +               return -ENOMEM;
 > +
 > +       temp = readl(intel_i830_private.registers+I810_PGETBL_CTL) & 0xfffff000;
 > +       global_cache_flush();   /* FIXME: ? */

After we spent quite a while cleaning up all the uses of this a few months back,
it'd be a shame to add more fixme's related to this.

 >  static int intel_fetch_size(void)
 >  {
 > @@ -1469,7 +1570,7 @@ static struct agp_bridge_driver intel_91
 >  	.owner			= THIS_MODULE,
 >  	.aperture_sizes		= intel_i830_sizes,
 >  	.size_type		= FIXED_APER_SIZE,
 > -	.num_aperture_sizes	= 3,
 > +	.num_aperture_sizes	= 4,
 >  	.needs_scratch_page	= TRUE,
 >  	.configure		= intel_i915_configure,
 >  	.fetch_size		= intel_i915_fetch_size,

This is ok with all the other chipsets that use intel_915_driver ?

 > @@ -1684,6 +1808,35 @@ static int __devinit agp_intel_probe(str
 >  			bridge->driver = &intel_845_driver;
 >  		name = "945GM";
 >  		break;
 > +       case PCI_DEVICE_ID_INTEL_82946GZ_HB:
 > +               if (find_i830(PCI_DEVICE_ID_INTEL_82946GZ_IG))
 > +                       bridge->driver = &intel_i965_driver;
 > +               else
 > +                       bridge->driver = &intel_845_driver;
 > +               name = "946GZ";
 > +               break;
 > +       case PCI_DEVICE_ID_INTEL_82965G_1_HB:
 > +               if (find_i830(PCI_DEVICE_ID_INTEL_82965G_1_IG))
 > +                       bridge->driver = &intel_i965_driver;
 > +               else
 > +                       bridge->driver = &intel_845_driver;
 > +               name = "965G";
 > +               break;
 > +       case PCI_DEVICE_ID_INTEL_82965Q_HB:
 > +               if (find_i830(PCI_DEVICE_ID_INTEL_82965Q_IG))
 > +                       bridge->driver = &intel_i965_driver;
 > +               else
 > +                       bridge->driver = &intel_845_driver;
 > +               name = "965Q";
 > +               break;
 > +       case PCI_DEVICE_ID_INTEL_82965G_HB:
 > +               if (find_i830(PCI_DEVICE_ID_INTEL_82965G_IG))
 > +                       bridge->driver = &intel_i965_driver;
 > +               else
 > +                       bridge->driver = &intel_845_driver;
 > +               name = "965G";
 > +               break;

This switch just keeps getting more and more horrific.
It'd be nice to have this converted to be somehow table-driven
at some point.

 > @@ -1825,6 +1978,10 @@ #define ID(x)						\
 >  	ID(PCI_DEVICE_ID_INTEL_82915GM_HB),
 >  	ID(PCI_DEVICE_ID_INTEL_82945G_HB),
 >  	ID(PCI_DEVICE_ID_INTEL_82945GM_HB),
 > +        ID(PCI_DEVICE_ID_INTEL_82946GZ_HB),
 > +        ID(PCI_DEVICE_ID_INTEL_82965G_1_HB),
 > +        ID(PCI_DEVICE_ID_INTEL_82965Q_HB),
 > +        ID(PCI_DEVICE_ID_INTEL_82965G_HB),
 >  	{ }

Indendation again.

		Dave

-- 
http://www.codemonkey.org.uk
