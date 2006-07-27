Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbWG0OZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWG0OZL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 10:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWG0OZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 10:25:11 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:8327
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S932230AbWG0OZI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 10:25:08 -0400
From: Michael Buesch <mb@bu3sch.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: [PATCH] fix Intel RNG detection
Date: Thu, 27 Jul 2006 16:23:47 +0200
User-Agent: KMail/1.9.1
References: <44C8BE63.76E4.0078.0@novell.com>
In-Reply-To: <44C8BE63.76E4.0078.0@novell.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200607271623.48023.mb@bu3sch.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 July 2006 13:23, Jan Beulich wrote:

> +#ifdef CONFIG_SMP
> +static volatile char __initdata waitflag;

I don't think we want to add yet another use of volatile
(see the kernel archives for why).
Use memory barriers instead, please.

> +static void __init intel_init_wait (void *unused)
> +{
> +	while (waitflag) {
> +		cpu_relax();
		rmb();
	}
> +}
> +#endif
> +
>  static int __init mod_init(void)
>  {
>  	int err = -ENODEV;
> +	unsigned i;
> +	struct pci_dev *dev = NULL;
>  	void __iomem *mem;
> -	u8 hw_status;
> -
> -	if (!pci_dev_present(pci_tbl))
> +	unsigned long flags;
> +	u8 bios_cntl_off, fwh_dec_en1_off;
> +	u8 bios_cntl_val = 0xff, fwh_dec_en1_val = 0xff;
> +	u8 hw_status, mfg, dvc;
> +
> +	for (i = 0; !dev && pci_tbl[i].vendor; ++i)
> +		dev = pci_get_device(pci_tbl[i].vendor,
> pci_tbl[i].device, NULL);
> +		
> +	if (!dev)
>  		goto out; /* Device not found. */
>  
> +	/* Check for Intel 82802 */
> +	if (dev->device < 0x2640) {
> +		fwh_dec_en1_off = 0xe3;
> +		bios_cntl_off = 0x4e;
> +	}
> +	else {
> +		fwh_dec_en1_off = 0xd9; /* high byte of 16-bit register
> */
> +		bios_cntl_off = 0xdc;
> +	}
> +
> +	pci_read_config_byte(dev, fwh_dec_en1_off, &fwh_dec_en1_val);
> +	pci_read_config_byte(dev, bios_cntl_off, &bios_cntl_val);
> +
> +	mem = ioremap_nocache(0xffff0000, 2);
> +	if (mem == NULL) {
> +		pci_dev_put(dev);
> +		err = -EBUSY;
> +		goto out;
> +	}
> +
> +#ifdef CONFIG_SMP
> +	waitflag = 1;
	wmb();
> +	if (smp_call_function(intel_init_wait, NULL, 1, 0) != 0) {
> +		waitflag = 0;
> +		pci_dev_put(dev);
> +		printk(KERN_ERR PFX "cannot run on all processors\n");
> +		err = -EAGAIN;
> +		goto err_unmap;
> +	}
> +#else
> +#define waitflag err

That's really confusing magic.

> +#endif
> +	local_irq_save(flags);
> +
> +	if (!(fwh_dec_en1_val & 0x80))
> +		pci_write_config_byte(dev, fwh_dec_en1_off,
> fwh_dec_en1_val | 0x80);
> +	if (!(bios_cntl_val & 0x03))
> +		pci_write_config_byte(dev, bios_cntl_off, bios_cntl_val
> | 0x01);
> +
> +	writeb(0xff, mem);
> +	writeb(0x90, mem);
> +	mfg = readb(mem + 0);
> +	dvc = readb(mem + 1);
> +	writeb(0xff, mem);

Do these magic registers have names? Possible to use #defines for it?

> +	if (!(bios_cntl_val & 0x03))
> +		pci_write_config_byte(dev, bios_cntl_off,
> bios_cntl_val);
> +	if (!(fwh_dec_en1_val & 0x80))
> +		pci_write_config_byte(dev, fwh_dec_en1_off,
> fwh_dec_en1_val);

Same for these magic bitmasks.

> +	local_irq_restore(flags);
> +	waitflag = 0;
	smp_wmb();
> +
> +	iounmap(mem);
> +	pci_dev_put(dev);
> +
> +	if (mfg != 0x89 || (dvc & ~0x01) != 0xac) {

magic values...

> +		printk(KERN_ERR PFX "FWH not detected\n");
> +		err = -ENODEV;
> +		goto out;
> +	}
> +
>  	err = -ENOMEM;
>  	mem = ioremap(INTEL_RNG_ADDR, INTEL_RNG_ADDR_LEN);
>  	if (!mem)
>  		goto out;
>  	intel_rng.priv = (unsigned long)mem;
>  
> -	/* Check for Intel 82802 */
> +	/* Check for Random Number Generator */
>  	err = -ENODEV;
>  	hw_status = hwstatus_get(mem);
>  	if ((hw_status & INTEL_RNG_PRESENT) == 0)

-- 
Greetings Michael.
