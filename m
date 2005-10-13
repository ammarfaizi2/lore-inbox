Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932502AbVJMWlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbVJMWlb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 18:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbVJMWlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 18:41:31 -0400
Received: from mail.kroah.org ([69.55.234.183]:28803 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932503AbVJMWlb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 18:41:31 -0400
Date: Thu, 13 Oct 2005 15:40:42 -0700
From: Greg KH <greg@kroah.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Mark Gross <mgross@linux.intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Sebastien.Bouchard@ca.kontron.com,
       mark.gross@intel.com
Subject: Re: Fwd: Telecom Clock Driver for MPCBL0010 ATCA computer blade
Message-ID: <20051013224042.GB3266@kroah.com>
References: <200510060803.21470.mgross@linux.intel.com> <200510121636.29821.mgross@linux.intel.com> <20051013011451.GA28844@kroah.com> <200510131436.06718.mgross@linux.intel.com> <9a8748490510131508r49a048cau7e08d77ef1d614ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490510131508r49a048cau7e08d77ef1d614ad@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2005 at 12:08:28AM +0200, Jesper Juhl wrote:
> 
> I just took a new look at your patch and I have (again) a few small comments...
> 
> 
> +static int tlclk_open(struct inode *inode, struct file *filp)
> +{
> +	int result;
> +
> +	/* Make sure there is no interrupt pending while
> +	 * initialising interrupt handler */
> +	inb(TLCLK_REG6);
> +
> +	/* This device is wired through the FPGA IO space of the ATCA blade
> +	 * we can't share this IRQ */
> +	result = request_irq(telclk_interrupt, &tlclk_interrupt,
> +			     SA_INTERRUPT, "telco_clock", tlclk_interrupt);
> +	if (result == -EBUSY) {
> +		printk(KERN_ERR "telco_clock: Interrupt can't be reserved!\n");
> +		return -EBUSY;
> +	}
> +	inb(TLCLK_REG6);	/* Clear interrupt events */
> +
> +	return 0;
> +}
> 
> It seems to me that you can get rid of the "result" variable here by
> rewriting the funcion like this :
> 
> static int tlclk_open(struct inode *inode, struct file *filp)
> {
> 	/* Make sure there is no interrupt pending while
> 	 * initialising interrupt handler */
> 	inb(TLCLK_REG6);
> 
> 	/* This device is wired through the FPGA IO space of the ATCA blade
> 	 * we can't share this IRQ */
> 	if (-EBUSY == request_irq(telclk_interrupt, &tlclk_interrupt,
> 			     SA_INTERRUPT, "telco_clock", tlclk_interrupt)) {

Ick, no, that's a mess.  Stick with the original version.

Don't call functions within a if() statement, it's harder to read.

> +	unsigned long tmp;
> +	unsigned char val;
> +	unsigned long flags;
> +
> +	sscanf(buf, "%lX", &tmp);
> +	dev_dbg(d, "tmp = 0x%lX\n", tmp);
> +
> +	val = (unsigned char)tmp;
> 
> You do this a lot, I'm wondering why you don't read directly into
> "val" and then get rid of the "tmp" variable?

Because you want to cast it.

thanks,

greg k-h
