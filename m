Return-Path: <linux-kernel-owner+w=401wt.eu-S965115AbWLMT6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965115AbWLMT6P (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 14:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbWLMT6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 14:58:14 -0500
Received: from twinlark.arctic.org ([207.29.250.54]:52348 "EHLO
	twinlark.arctic.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965110AbWLMT6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 14:58:12 -0500
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 14:58:12 EST
Date: Wed, 13 Dec 2006 11:50:50 -0800 (PST)
From: dean gaudet <dean@arctic.org>
To: Jan Beulich <jbeulich@novell.com>
cc: Dave Jones <davej@redhat.com>, Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Michael Buesch <mb@bu3sch.de>,
       Metathronius Galabant <m.galabant@googlemail.com>, stable@kernel.org,
       Michael Krufky <mkrufky@linuxtv.org>,
       Justin Forbes <jmforbes@linuxtx.org>, alan@lxorguk.ukuu.org.uk,
       "Theodore Ts'o" <tytso@mit.edu>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
       torvalds@osdl.org, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wright <chrisw@sous-sol.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [stable] [PATCH 46/61] fix Intel RNG detection
In-Reply-To: <456D56E7.76E4.0078.0@novell.com>
Message-ID: <Pine.LNX.4.64.0612131145460.14936@twinlark.arctic.org>
References: <20061101053340.305569000@sous-sol.org> <20061101054343.623157000@sous-sol.org>
 <20061120234535.GD17736@redhat.com> <20061121022109.GF1397@sequoia.sous-sol.org>
 <4562D5DA.76E4.0078.0@novell.com> <20061122015046.GI1397@sequoia.sous-sol.org>
 <45640FF4.76E4.0078.0@novell.com> <20061124202729.GC29264@redhat.com>
 <456D56E7.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006, Jan Beulich wrote:

> >>> Dave Jones <davej@redhat.com> 24.11.06 21:27 >>>
> >On Wed, Nov 22, 2006 at 08:53:08AM +0100, Jan Beulich wrote:
> > > >It does appear to work w/out the patch.  I've asked for a small bit
> > > >of diagnostics (below), perhaps you've got something you'd rather see?
> > > >I expect this to be a 24C0 LPC Bridge.
> > > 
> > > Yes, that's what I'd have asked for. If it works, I expect the device
> > > code to be different, or both manufacturer and device code to be
> > > invalid. Depending on the outcome, perhaps we'll need an override
> > > option so that this test can be partially (i.e. just the device code
> > > part) or entirely (all the FWH detection) skipped.
> > > The base problem is the vague documentation of the whole
> > > detection mechanism - a lot of this I had to read between the lines.
> >
> >The bug report I referenced came back with this from that debug patch..
> >
> >intel_rng: no version for "struct_module" found: kernel tainted.
> >intel_rng: pci vendor:device 8086:24c0 fwh_dec_en1 80 bios_cntl_val 2 mfc cb dvc 88
> >intel_rng: FWH not detected
> 
> Any chance you could have them test below patch (perhaps before I
> actually submit it)? They should see the warning message added when
> not using any options, and they should then be able to use the
> no_fwh_detect option to get the thing to work again.
> 
> I'll meanwhile ask Intel about how they suppose to follow the RNG
> detection sequence when the BIOS locks out write access to the
> FWH interface.

just for the public record (i already communicated with Jan in private 
mail on this one)... i have a box which hangs hard starting at 2.6.18.2 
and 2.6.19 -- hangs hard during the intel hw rng tests (no sysrq 
response).  and the hang occurs prior to the printk so it took some 
digging to figure out which module was taking out the system.

Jan's patch gets the box past the hang... it seems like this should be in 
at least the next 2.6.19.x stable (and if there's going to be another 
2.6.18.x stable then it should be included there as well).

there is apparently no hw rng on this box (returns all 0xff).

thanks
-dean

> 
> Jan
> 
> Index: head-2006-11-21/drivers/char/hw_random/intel-rng.c
> ===================================================================
> --- head-2006-11-21.orig/drivers/char/hw_random/intel-rng.c	2006-11-21 10:36:15.000000000 +0100
> +++ head-2006-11-21/drivers/char/hw_random/intel-rng.c	2006-11-29 09:09:21.000000000 +0100
> @@ -143,6 +143,8 @@ static const struct pci_device_id pci_tb
>  };
>  MODULE_DEVICE_TABLE(pci, pci_tbl);
>  
> +static __initdata int no_fwh_detect;
> +module_param(no_fwh_detect, int, 0);
>  
>  static inline u8 hwstatus_get(void __iomem *mem)
>  {
> @@ -240,6 +242,11 @@ static int __init mod_init(void)
>  	if (!dev)
>  		goto out; /* Device not found. */
>  
> +	if (no_fwh_detect < 0) {
> +		pci_dev_put(dev);
> +		goto fwh_done;
> +	}
> +
>  	/* Check for Intel 82802 */
>  	if (dev->device < 0x2640) {
>  		fwh_dec_en1_off = FWH_DEC_EN1_REG_OLD;
> @@ -252,6 +259,23 @@ static int __init mod_init(void)
>  	pci_read_config_byte(dev, fwh_dec_en1_off, &fwh_dec_en1_val);
>  	pci_read_config_byte(dev, bios_cntl_off, &bios_cntl_val);
>  
> +	if ((bios_cntl_val &
> +	     (BIOS_CNTL_LOCK_ENABLE_MASK|BIOS_CNTL_WRITE_ENABLE_MASK))
> +	    == BIOS_CNTL_LOCK_ENABLE_MASK) {
> +		static __initdata /*const*/ char warning[] =
> +			KERN_WARNING PFX "Firmware space is locked read-only. If you can't or\n"
> +			KERN_WARNING PFX "don't want to disable this in firmware setup, and if\n"
> +			KERN_WARNING PFX "you are certain that your system has a functional\n"
> +			KERN_WARNING PFX "RNG, try using the 'no_fwh_detect' option.\n";
> +
> +		pci_dev_put(dev);
> +		if (no_fwh_detect)
> +			goto fwh_done;
> +		printk(warning);
> +		err = -EBUSY;
> +		goto out;
> +	}
> +
>  	mem = ioremap_nocache(INTEL_FWH_ADDR, INTEL_FWH_ADDR_LEN);
>  	if (mem == NULL) {
>  		pci_dev_put(dev);
> @@ -280,8 +304,7 @@ static int __init mod_init(void)
>  		pci_write_config_byte(dev,
>  		                      fwh_dec_en1_off,
>  		                      fwh_dec_en1_val | FWH_F8_EN_MASK);
> -	if (!(bios_cntl_val &
> -	      (BIOS_CNTL_LOCK_ENABLE_MASK|BIOS_CNTL_WRITE_ENABLE_MASK)))
> +	if (!(bios_cntl_val & BIOS_CNTL_WRITE_ENABLE_MASK))
>  		pci_write_config_byte(dev,
>  		                      bios_cntl_off,
>  		                      bios_cntl_val | BIOS_CNTL_WRITE_ENABLE_MASK);
> @@ -315,6 +338,8 @@ static int __init mod_init(void)
>  		goto out;
>  	}
>  
> +fwh_done:
> +
>  	err = -ENOMEM;
>  	mem = ioremap(INTEL_RNG_ADDR, INTEL_RNG_ADDR_LEN);
>  	if (!mem)
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
