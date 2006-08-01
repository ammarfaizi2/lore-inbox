Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161066AbWHAFgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161066AbWHAFgI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 01:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161074AbWHAFgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 01:36:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54930 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161066AbWHAFgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 01:36:07 -0400
Date: Mon, 31 Jul 2006 22:35:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Beulich <jbeulich@novell.com>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, mb@bu3sch.de
Subject: Re: [PATCH] fix Intel RNG detection (take 2)
Message-Id: <20060731223559.2ac944e8.akpm@osdl.org>
In-Reply-To: <200607311241.36306.jbeulich@novell.com>
References: <200607311241.36306.jbeulich@novell.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006 12:41:36 +0200
Jan Beulich <jbeulich@novell.com> wrote:

> Previously, since determination whether there was an Intel random
> number generator was based on a single bit, on systems with a matching
> bridge device but without a firmware hub, there was a 50% chance that
> the code would incorrectly decide that the system had an RNG. This
> patch adds detection of the firmware hub to better qualify the
> existence of an RNG.
> 
> There is one issue with the patch: I was unable to determine the LPC
> equivalent for the PCI bridge 8086:2430 (since the old code didn't
> care about which of the many devices provided by the ICH/ESB it was
> chose to use the PCI bridge device, but the FWH settings live in the
> LPC device, so the device list needed to be changed).
> 
>  
> ...
>  
> +#ifdef CONFIG_SMP
> +static char __initdata waitflag;
> +
> +static void __init intel_init_wait (void *unused)

No space before the (, please.

> +{
> +	while (waitflag) {
> +		cpu_relax();
> +		smp_rmb();
> +	}

I believe we decided that cpu_relax() implies a barrier.

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
> +	u8 hw_status, mfc, dvc;
> +
> +	for (i = 0; !dev && pci_tbl[i].vendor; ++i)
> +		dev = pci_get_device(pci_tbl[i].vendor, pci_tbl[i].device, NULL);
> +		
> +	if (!dev)
>  		goto out; /* Device not found. */
>  
> +	/* Check for Intel 82802 */
> +	if (dev->device < 0x2640) {
> +		fwh_dec_en1_off = FWH_DEC_EN1_REG_OLD;
> +		bios_cntl_off = BIOS_CNTL_REG_OLD;
> +	}
> +	else {

Please do

	} else {


> +		fwh_dec_en1_off = FWH_DEC_EN1_REG_NEW;
> +		bios_cntl_off = BIOS_CNTL_REG_NEW;
> +	}
> +
> +	pci_read_config_byte(dev, fwh_dec_en1_off, &fwh_dec_en1_val);
> +	pci_read_config_byte(dev, bios_cntl_off, &bios_cntl_val);
> +
> +	mem = ioremap_nocache(INTEL_FWH_ADDR, INTEL_FWH_ADDR_LEN);
> +	if (mem == NULL) {
> +		pci_dev_put(dev);
> +		err = -EBUSY;
> +		goto out;
> +	}
> +
> +#ifdef CONFIG_SMP
> +	waitflag = 1;
> +	smp_wmb();
> +	if (smp_call_function(intel_init_wait, NULL, 1, 0) != 0) {
> +		waitflag = 0;
> +		smp_wmb();
> +		pci_dev_put(dev);
> +		printk(KERN_ERR PFX "cannot run on all processors\n");
> +		err = -EAGAIN;
> +		goto err_unmap;
> +	}
> +#else
> +#define waitflag err
> +#endif

awww man, this is nasty.  We're #defining the name of a file-global
variable to that it puns a local?  On uniproc only?

Please, not in Linux.   Let's find a better way.


> +	local_irq_save(flags);

I think the code needs a comment explaining the local_irq_save().  Its
reasoning is not apparent from reading the implementation.

> +	if (!(fwh_dec_en1_val & FWH_F8_EN_MASK))
> +		pci_write_config_byte(dev,
> +		                      fwh_dec_en1_off,
> +		                      fwh_dec_en1_val | FWH_F8_EN_MASK);
> +	if (!(bios_cntl_val
> +	      & (BIOS_CNTL_LOCK_ENABLE_MASK|BIOS_CNTL_WRITE_ENABLE_MASK)))
> +		pci_write_config_byte(dev,
> +		                      bios_cntl_off,
> +		                      bios_cntl_val | BIOS_CNTL_WRITE_ENABLE_MASK);
> +
> +	writeb(INTEL_FWH_RESET_CMD, mem);
> +	writeb(INTEL_FWH_READ_ID_CMD, mem);
> +	mfc = readb(mem + INTEL_FWH_MANUFACTURER_CODE_ADDRESS);
> +	dvc = readb(mem + INTEL_FWH_DEVICE_CODE_ADDRESS);
> +	writeb(INTEL_FWH_RESET_CMD, mem);
> +
> +	if (!(bios_cntl_val
> +	      & (BIOS_CNTL_LOCK_ENABLE_MASK|BIOS_CNTL_WRITE_ENABLE_MASK)))

It would be (a little) more conventional to do

	if (!(bios_cntl_val &

> +		pci_write_config_byte(dev, bios_cntl_off, bios_cntl_val);
> +	if (!(fwh_dec_en1_val & FWH_F8_EN_MASK))
> +		pci_write_config_byte(dev, fwh_dec_en1_off, fwh_dec_en1_val);
> +
> +	local_irq_restore(flags);
> +	waitflag = 0;
> +	smp_wmb();

Again, the barrier is hard to understand.  Pretty much all open-coded
barriers should have an explanatory comment.

> +	iounmap(mem);
> +	pci_dev_put(dev);
> +
> +	if (mfc != INTEL_FWH_MANUFACTURER_CODE
> +	    || (dvc != INTEL_FWH_DEVICE_CODE_8M
> +	        && dvc != INTEL_FWH_DEVICE_CODE_4M)) {

Again,

	if (mfc != INTEL_FWH_MANUFACTURER_CODE ||
	      (dvc != INTEL_FWH_DEVICE_CODE_8M &&
	          dvc != INTEL_FWH_DEVICE_CODE_4M)) {

would be more typical.

