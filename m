Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262218AbULQWtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbULQWtt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 17:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbULQWtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 17:49:49 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:58876 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262218AbULQWr3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 17:47:29 -0500
Subject: Re: [tpmdd-devel] Re: [PATCH 1/1] driver: Tpm hardware enablement
	--updated version
From: Kylene Hall <kjhall@us.ibm.com>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, sailer@watson.ibm.com,
       leendert@watson.ibm.com, Emily Ratliff <emilyr@us.ibm.com>,
       Tom Lendacky <toml@us.ibm.com>, tpmdd-devel@lists.sourceforge.net
In-Reply-To: <20041216165335.Z469@build.pdx.osdl.net>
References: <Pine.LNX.4.58.0412081546470.24510@jo.austin.ibm.com>
	 <Pine.LNX.4.58.0412161632200.4219@jo.austin.ibm.com>
	 <20041216165335.Z469@build.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1103323631.3780.110.camel@jo.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 17 Dec 2004 16:47:11 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-16 at 18:53, Chris Wright wrote:
Thanks for your help.  Addressing your questions here, new patch to
follow.

> Is there no support for the crypto/key/rng/etc features, or am I
> missing something?  I guess this is just to bring the hardware up?
Yes the TPM chip supports all those functions.  Those functions are
managed/exported by the TSS (Trusted Software Stack) a library that
implements another part of the TCG specification.  A linux
implementation of the TSS called trousers is available at
http://sourceforge.net/projects/trousers.  Does that answer your
question?  This is just the driver to interface between that library and
the device.

> 
> * Kylene Hall (kjhall@us.ibm.com) wrote:
> > diff -uprN linux-2.6.9/drivers/char/Makefile linux-2.6.9-tpm/drivers/char/Makefile
> > --- linux-2.6.9/drivers/char/Makefile	2004-10-18 16:55:28.000000000 -0500
> > +++ linux-2.6.9-tpm/drivers/char/Makefile	2004-12-16 13:35:57.000000000 -0600
> > @@ -88,6 +88,9 @@ obj-$(CONFIG_PCMCIA) += pcmcia/
> >  obj-$(CONFIG_IPMI_HANDLER) += ipmi/
> >  
> >  obj-$(CONFIG_HANGCHECK_TIMER) += hangcheck-timer.o
> > +obj-$(CONFIG_TCG_TPM) += tpm.o
> > +obj-$(CONFIG_TCG_NSC) += tpm_nsc.o
> > +obj-$(CONFIG_TCG_ATMEL) += tpm_atmel.o
> 
> Any reason not to have a tpm/ driver dir?  Aren't there likely to be more tpm
> chips?
No reason, a tpm driver directory will be created in the next version.


> > +	dev_dbg(&chip->pci_dev->dev, "tpm_atml_send: ");
> > +	for (i = 0; i < count; i++)
> > +		dev_dbg(&chip->pci_dev->dev, "0x%x(%d) ", buf[i], buf[i]);
> > +
> > +	for (i = 0; i < count; i++)
> > +		outb(buf[i], chip->base);
> 
> This could be one loop.  And this too is unbounded.  So a write with a
> large buffer will blowout base...erp, nm, I imagined base + i. 
> 
Agreed.

> > +static struct file_operations atmel_ops = {
> > +	.owner = THIS_MODULE,
> > +};
> 
> This can be tpm_open, etc, right here.
OK
> > +	outb(index, TPM_ADDR);
> > +	return inb(TPM_DATA) & 0xFF;
> > +}
> > +
> > +EXPORT_SYMBOL(rdx);
> > +
> > +void wrx(int index, int value)
> > +{
> > +	outb(index, TPM_ADDR);
> > +	outb(value & 0xFF, TPM_DATA);
> > +}
> > +
> > +EXPORT_SYMBOL(wrx);
> 
> These (rdx/wrx) are not appropriate names for global namespace.  Must
> they even be exported?  Could they not be made static inline in tpm.h?
> 
Taken care of by making them inline in the header.

> > +/*
> > + * Initialize the LPC bus and enable the TPM ports
> > + */
> > +int lpc_bus_init(struct pci_dev *pci_dev, u16 base)
> > +{
> > +	u32 lpcenable, tmp;
> > +	int is_lpcm = 0;
> > +
> > +	switch (pci_dev->vendor) {
> > +	case PCI_VENDOR_ID_INTEL:
> 
> This doesn't look quite right to have device specific logic in the
> core.  Shouldn't this go in the device specific driver logic?
> 
Currently we are relying on bus ids because the chip doesn't have a
unique id so this is needed by both specific drivers.

> 			       tmp);
> > +		}
> > +		outb(0x0D, TPM_ADDR);	/* unlock 4F */
> > +		outb(0x55, TPM_DATA);
> > +		outb(0x0A, TPM_ADDR);	/* int disable */
> > +		outb(0x00, TPM_DATA);
> > +		outb(0x08, TPM_ADDR);	/* base addr lo */
> > +		outb(base & 0xFF, TPM_DATA);
> > +		outb(0x09, TPM_ADDR);	/* base addr hi */
> > +		outb((base & 0xFF00) >> 8, TPM_DATA);
> > +		outb(0x0D, TPM_ADDR);	/* lock 4F */
> > +		outb(0xAA, TPM_DATA);
> 
> Hey, aren't these a bunch of those wdx's? ;-)
> 
Fixed in subsequent version.

> > +		u8 status = inb(chip->base + 1);
> 
> Is this guaranteed to be status location on all chips?  Perhaps a
> status() callback is better.
> 
As far as I know this is where status will always be found.  If it
changes I think the easiest thing to do would be to add the status
address to the tpm_vendor_specific struct like the base address is
currently.


> > +	if (chip->num_opens) {
> > +		dev_dbg(&chip->pci_dev->dev,
> > +			"Another process owns this TPM\n");
> > +		rc = -EBUSY;
> > +		goto err_out;
> > +	}
> > +
> > +	chip->num_opens++;
> 
> Hmm, looks a bit like it's just a mutex.
Yes we are only allowing one open at a time as the specification states
that only the TSS can access the device.  Would it be better to use a
mutex rather than a count in this case?

> > +
> > +	if (chip == NULL)
> > +		return -ENODEV;
> 
> Don't think that'll ever happen?
> 
Removed.

> > +
> > +	spin_lock(&driver_lock);
> > +	chip->num_opens--;
> > +	if (chip->num_opens == 0) {
> 
> Is there a case where num_opens-- != 0?  I thought you were making sure
> there was only one open?
> 
Removed.

> > +
> > +	if (chip == NULL)
> > +		return -ENODEV;

> Don't think that'll ever happen?
> 
Removed.

> > +
> > +	down(&chip->user_mutex);
> 
> What is this protecting?
The writes and reads have to be serialized so this was sort of
protecting the tpm_result_buffer.  I have fixed this to be clearer and
reduced the number of mutexes.

> 
> > +
> > +	if (copy_from_user
> > +	    (chip->tpm_result_buffer, (void __user *) buf, size)) {
> > +		up(&chip->user_mutex);
> > +		return -EFAULT;
> > +	}
> 
> This is a buffer overflow waiting to happen.
Fixed
> 
> > +	out_size =
> > +	    tpm_transmit(chip, chip->tpm_result_buffer, TPM_BUFSIZE);
> 
> How does device distinguish from leftover garbage in buffer when size <
> TPM_BUFSIZE?  Wonder if you could read this back from tpm (and leak
> kernel memory to userspace that way)?
> 
The transmit uses the fact that it knows the layout of the data packet
passed into (set by the spec) and looks at the length field.  That is
all that is transmited to the TPM and also back to the user on the read.

> > +	if (chip == NULL)
> > +		return -ENODEV;
> 
> Don't think that'll happen?
> 
Removed.

> > +
> > +	if (chip->num_opens != 0) {
> 
> Won't module refcount care for this?
Removed.


> > +	chip->ops->miscdev.name = devname;
> > +
> > +	chip->ops->miscdev.fops->llseek = no_llseek;
> > +	chip->ops->miscdev.fops->open = tpm_open;
> > +	chip->ops->miscdev.fops->read = tpm_read;
> > +	chip->ops->miscdev.fops->write = tpm_write;
> > +	chip->ops->miscdev.fops->release = tpm_release;
> 
> This is usually done statically, entry is passed in after all.
> 
Fixed


> > +static int __init init_tpm(void)
> > +{
> > +	INIT_LIST_HEAD(&tpm_chip_list);
> > +	spin_lock_init(&driver_lock);
> 
> These can be done statically.
> 
Fixed

> > +	struct semaphore user_mutex;
> > +	struct semaphore timer_mutex;
> > +	struct semaphore sync_mutex;

> Wow, three mutexes for this little data strucutre?
> 
For the user_mutex and timer_mutex I was able to collapse these into one
(and give it a better name).  The sync_mutex was added so I could call
timer_pending in the release function to decide if timers were pending
and needed to be canceled when the device is being closed.  I notice
that del_timer can be called on an inactive timer, I could maybe use
this and drop this extra mutex?  However, someone had suggested I use
del_singleshot_timer_sync which doesn't look like is safe to call on an
inactive timer.  Do you know if del_singleshot_time_sync is necessary in
this case.



> > +/* command bits */
> > +#define	NSC_COMMAND_NORMAL		0x01	/* normal mode */
> > +#define	NSC_COMMAND_BURST		0x81	/* burst mode */
> 
> Hmm, unused.  Is it for a dma type interface?
Dropped.

> > +
> > +	/* status immediately available check */
> > +	*data = inb(chip->base + 1);
> 
> Isn't this base + NSC_STATUS?  Nice to use constants where possible.
> 
Fixed

