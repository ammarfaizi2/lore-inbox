Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWEGPdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWEGPdD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 11:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWEGPdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 11:33:03 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:30857
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S932182AbWEGPdB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 11:33:01 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [patch 3/6] New Generic HW RNG (#2)
Date: Sun, 7 May 2006 17:39:44 +0200
User-Agent: KMail/1.9.1
References: <20060507143806.465264000@pc1> <20060507144257.311084000@pc1> <20060507152206.GC14704@procyon.home>
In-Reply-To: <20060507152206.GC14704@procyon.home>
Cc: akpm@osdl.org, Deepak Saxena <dsaxena@plexity.net>,
       bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605071739.44443.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 May 2006 17:22, you wrote:
> On Sun, May 07, 2006 at 04:38:09PM +0200, Michael Buesch wrote:
> > Add a driver for the x86 RNG.
> > This driver is ported from the old hw_random.c
> > 
> [skip]
> > +static int __init intel_init(struct hwrng *rng)
> 
> Cannot be __init anymore - now rng->init could be called at any time.

Sure, will fix this.

> Also, there is another problem with putting this function into
> rng->init - if another RNG has been registered when this module is
> loaded, ->init will not be called during hwrng_register(), so the
> module load will succeed even if the chipset does not have RNG
> hardware.

Ok, I see. The question is, are we going to hwrng_register() the
intel, althought there is no device? We check for the PCI IDs.
Anyway. This should be fixed.
And I think this is also a good time to split the x86 driver,
so all this init-stuff is much cleaner.

> > +{
> > +	void __iomem *rng_mem;
> > +	int rc;
> > +	u8 hw_status;
> > +
> > +	DPRINTK ("ENTER\n");
> > +
> > +	rng_mem = ioremap (INTEL_RNG_ADDR, INTEL_RNG_ADDR_LEN);
> > +	if (rng_mem == NULL) {
> > +		printk (KERN_ERR PFX "cannot ioremap RNG Memory\n");
> > +		rc = -EBUSY;
> > +		goto err_out;
> > +	}
> > +	rng->priv = (unsigned long)rng_mem;
> > +
> > +	/* Check for Intel 82802 */
> > +	hw_status = intel_hwstatus (rng_mem);
> > +	if ((hw_status & INTEL_RNG_PRESENT) == 0) {
> > +		printk (KERN_ERR PFX "RNG not detected\n");
> > +		rc = -ENODEV;
> > +		goto err_out_free_map;
> > +	}
> > +
> > +	/* turn RNG h/w on, if it's off */
> > +	if ((hw_status & INTEL_RNG_ENABLED) == 0)
> > +		hw_status = intel_hwstatus_set (rng_mem, hw_status | INTEL_RNG_ENABLED);
> > +	if ((hw_status & INTEL_RNG_ENABLED) == 0) {
> > +		printk (KERN_ERR PFX "cannot enable RNG, aborting\n");
> > +		rc = -EIO;
> > +		goto err_out_free_map;
> > +	}
> > +
> > +	DPRINTK ("EXIT, returning 0\n");
> > +	return 0;
> > +
> > +err_out_free_map:
> > +	iounmap (rng_mem);
> > +err_out:
> > +	DPRINTK ("EXIT, returning %d\n", rc);
> > +	return rc;
> > +}
> > +
> [skip]
> > +static int __init amd_init(struct hwrng *rng)
> 
> Again, __init is wrong.
> 
> [skip]
> > +static int __init via_init(struct hwrng *rng)
> 
> This __init is wrong too.
> 
> [skip]
> 

Ah, and I found another bug in hwrng_unregister:
	current_rng = list_entry(rng_list.prev, struct hwrng, list);
current_rng->init() should be called here (if nonNULL). If that fails
current_rng = NULL;

Will fix that, too.

-- 
Greetings Michael.
