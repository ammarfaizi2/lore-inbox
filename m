Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262697AbULQBCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262697AbULQBCu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 20:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262704AbULQBCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 20:02:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:56801 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262697AbULQAxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 19:53:47 -0500
Date: Thu, 16 Dec 2004 16:53:35 -0800
From: Chris Wright <chrisw@osdl.org>
To: Kylene Hall <kjhall@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, sailer@watson.ibm.com,
       leendert@watson.ibm.com, emilyr@us.ibm.com, toml@us.ibm.com,
       tpmdd-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/1] driver: Tpm hardware enablement --updated version
Message-ID: <20041216165335.Z469@build.pdx.osdl.net>
References: <Pine.LNX.4.58.0412081546470.24510@jo.austin.ibm.com> <Pine.LNX.4.58.0412161632200.4219@jo.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.58.0412161632200.4219@jo.austin.ibm.com>; from kjhall@us.ibm.com on Thu, Dec 16, 2004 at 04:37:34PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there no support for the crypto/key/rng/etc features, or am I
missing something?  I guess this is just to bring the hardware up?

* Kylene Hall (kjhall@us.ibm.com) wrote:
> diff -uprN linux-2.6.9/drivers/char/Makefile linux-2.6.9-tpm/drivers/char/Makefile
> --- linux-2.6.9/drivers/char/Makefile	2004-10-18 16:55:28.000000000 -0500
> +++ linux-2.6.9-tpm/drivers/char/Makefile	2004-12-16 13:35:57.000000000 -0600
> @@ -88,6 +88,9 @@ obj-$(CONFIG_PCMCIA) += pcmcia/
>  obj-$(CONFIG_IPMI_HANDLER) += ipmi/
>  
>  obj-$(CONFIG_HANGCHECK_TIMER) += hangcheck-timer.o
> +obj-$(CONFIG_TCG_TPM) += tpm.o
> +obj-$(CONFIG_TCG_NSC) += tpm_nsc.o
> +obj-$(CONFIG_TCG_ATMEL) += tpm_atmel.o

Any reason not to have a tpm/ driver dir?  Aren't there likely to be more tpm
chips?

> diff -uprN linux-2.6.9/drivers/char/tpm_atmel.c linux-2.6.9-tpm/drivers/char/tpm_atmel.c
> --- linux-2.6.9/drivers/char/tpm_atmel.c	1969-12-31 18:00:00.000000000 -0600
> +++ linux-2.6.9-tpm/drivers/char/tpm_atmel.c	2004-12-16 17:14:31.000000000 -0600
> @@ -0,0 +1,187 @@
> +/*
> + * Copyright (C) 2004 IBM Corporation
> + *
> + * Authors:
> + * Leendert van Doorn <leendert@watson.ibm.com>
> + * Reiner Sailer <sailer@watson.ibm.com>
> + * Dave Safford <safford@watson.ibm.com>
> + * Kylene Hall <kjhall@us.ibm.com>
> + *
> + * Maintained by: <tpmdd_devel@lists.sourceforge.net>
> + *
> + * Device driver for TCG/TCPA TPM (trusted platform module).
> + * Specifications at www.trustedcomputinggroup.org	 
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation, version 2 of the
> + * License.
> + * 
> + */
> +
> +#include "tpm.h"
> +
> +/* Atmel definitions */
> +#define	TPM_ATML_BASE			0x400
> +
> +/* write status bits */
> +#define	ATML_STATUS_ABORT		0x01
> +#define	ATML_STATUS_LASTBYTE		0x04
> +
> +/* read status bits */
> +#define	ATML_STATUS_BUSY		0x01
> +#define	ATML_STATUS_DATA_AVAIL		0x02
> +#define	ATML_STATUS_REWRITE		0x04
> +
> +
> +static int tpm_atml_recv(struct tpm_chip *chip, u8 * buf, size_t count)
> +{
> +	u8 status, *hdr = buf;
> +	u32 size;
> +	int i;
> +	__be32 *native_size;
> +
> +	/* start reading header */
> +	if (count < 6)
> +		return -EIO;
> +
> +	for (i = 0; i < 6; i++) {
> +		status = inb(chip->base + 1);
> +		if ((status & ATML_STATUS_DATA_AVAIL) == 0) {
> +			dev_err(&chip->pci_dev->dev,
> +				"error reading header\n");
> +			return -EIO;
> +		}
> +		*buf++ = inb(chip->base);
> +	}
> +
> +	/* size of the data received */
> +	native_size = (__force __be32 *) (hdr + 2);
> +	size = be32_to_cpu(*native_size);
> +
> +	if (count < size)
> +		return -EIO;
> +
> +	/* read all the data available */
> +	for (; i < size; i++) {
> +		status = inb(chip->base + 1);
> +		if ((status & ATML_STATUS_DATA_AVAIL) == 0) {
> +			dev_err(&chip->pci_dev->dev,
> +				"error reading data\n");
> +			return -EIO;
> +		}
> +		*buf++ = inb(chip->base);
> +	}
> +
> +	/* make sure data available is gone */
> +	status = inb(chip->base + 1);
> +	if (status & ATML_STATUS_DATA_AVAIL) {
> +		dev_err(&chip->pci_dev->dev, "data available is stuck\n");
> +		return -EIO;
> +	}
> +
> +	return size;
> +}
> +
> +static int tpm_atml_send(struct tpm_chip *chip, u8 * buf, size_t count)
> +{
> +	int i;
> +
> +	dev_dbg(&chip->pci_dev->dev, "tpm_atml_send: ");
> +	for (i = 0; i < count; i++)
> +		dev_dbg(&chip->pci_dev->dev, "0x%x(%d) ", buf[i], buf[i]);
> +
> +	for (i = 0; i < count; i++)
> +		outb(buf[i], chip->base);

This could be one loop.  And this too is unbounded.  So a write with a
large buffer will blowout base...erp, nm, I imagined base + i. 

> +
> +	return count;
> +}
> +
> +static void tpm_atml_cancel(struct tpm_chip *chip)
> +{
> +	outb(ATML_STATUS_ABORT, chip->base + 1);
> +}
> +
> +static struct file_operations atmel_ops = {
> +	.owner = THIS_MODULE,
> +};

This can be tpm_open, etc, right here.

> +static struct tpm_chip_ops tpm_atmel = {
> +	.recv = tpm_atml_recv,
> +	.send = tpm_atml_send,
> +	.cancel = tpm_atml_cancel,
> +	.req_complete_mask = ATML_STATUS_BUSY | ATML_STATUS_DATA_AVAIL,
> +	.req_complete_val = ATML_STATUS_DATA_AVAIL,
> +	.miscdev.fops = &atmel_ops,
> +};
> +
> +static int __devinit tpm_atml_init(struct pci_dev *pci_dev,
> +				   const struct pci_device_id *pci_id)
> +{
> +	u8 version[4];
> +	int rc = 0;
> +
> +	if (pci_enable_device(pci_dev))
> +		return -EIO;
> +
> +	if (lpc_bus_init(pci_dev, TPM_ATML_BASE)) {
> +		rc = -ENODEV;
> +		goto out_err;
> +	}
> +
> +	/* verify that it is an Atmel part */
> +	if (rdx(4) != 'A' || rdx(5) != 'T' || rdx(6) != 'M'
> +	    || rdx(7) != 'L') {
> +		rc = -ENODEV;
> +		goto out_err;
> +	}
> +
> +
> +	/* query chip for its version number */
> +	if ((version[0] = rdx(0x00)) != 0xFF) {
> +		version[1] = rdx(0x01);
> +		version[2] = rdx(0x02);
> +		version[3] = rdx(0x03);
> +	} else {
> +		dev_info(&pci_dev->dev, "version query failed\n");
> +		rc = -ENODEV;
> +		goto out_err;
> +	}
> +
> +	if ((rc =
> +	     register_tpm_hardware(pci_dev, &tpm_atmel,
> +				   TPM_ATML_BASE)) < 0)
> +		goto out_err;
> +
> +	dev_info(&pci_dev->dev,
> +		 "Atmel TPM version %d.%d.%d.%d\n", version[0], version[1],
> +		 version[2], version[3]);
> +
> +	return 0;
> +out_err:
> +	pci_disable_device(pci_dev);
> +	return rc;
> +}
> +
> +static struct pci_driver atmel_pci_driver = {
> +	.name = "tpm_atmel",
> +	.probe = tpm_atml_init,
> +};
> +
> +static int __init init_atmel(void)
> +{
> +	return register_tpm_driver(&atmel_pci_driver);
> +}
> +
> +static void __exit cleanup_atmel(void)
> +{
> +	unregister_tpm_driver(&atmel_pci_driver);
> +}
> +
> +module_init(init_atmel);
> +module_exit(cleanup_atmel);
> +
> +MODULE_AUTHOR("Leendert van Doorn (leendert@watson.ibm.com)");
> +MODULE_DESCRIPTION("TPM Driver");
> +MODULE_VERSION("2.0");
> +MODULE_LICENSE("GPL");
> diff -uprN linux-2.6.9/drivers/char/tpm.c linux-2.6.9-tpm/drivers/char/tpm.c
> --- linux-2.6.9/drivers/char/tpm.c	1969-12-31 18:00:00.000000000 -0600
> +++ linux-2.6.9-tpm/drivers/char/tpm.c	2004-12-16 17:24:55.000000000 -0600
> @@ -0,0 +1,581 @@
> +/*
> + * Copyright (C) 2004 IBM Corporation
> + *
> + * Authors:
> + * Leendert van Doorn <leendert@watson.ibm.com>
> + * Reiner Sailer <sailer@watson.ibm.com>
> + * Dave Safford <safford@watson.ibm.com>
> + * Kylene Hall <kjhall@us.ibm.com>
> + *
> + * Maintained by: <tpmdd_devel@lists.sourceforge.net>
> + *
> + * Device driver for TCG/TCPA TPM (trusted platform module).
> + * Specifications at www.trustedcomputinggroup.org	 
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation, version 2 of the
> + * License.
> + * 
> + * Note, the TPM chip is not interrupt driven (only polling)
> + * and can have very long timeouts (minutes!). Hence the unusual
> + * calls to schedule_timeout.
> + *
> + */
> +
> +#include <linux/sched.h>
> +#include <linux/poll.h>
> +#include <linux/spinlock.h>
> +#include "tpm.h"
> +
> +#define	TPM_MINOR			224	/* officially assigned */
> +
> +#define	TPM_BUFSIZE			2048
> +
> +/* PCI configuration addresses */
> +#define	PCI_GEN_PMCON_1			0xA0
> +#define	PCI_GEN1_DEC			0xE4
> +#define	PCI_LPC_EN			0xE6
> +#define	PCI_GEN2_DEC			0xEC
> +
> +/* TPM addresses */
> +#define	TPM_ADDR			0x4E
> +#define	TPM_DATA			0x4F
> +
> +static struct list_head tpm_chip_list;
> +static spinlock_t driver_lock;
> +static int dev_mask[32];
> +
> +static void user_reader_timeout(unsigned long ptr)
> +{
> +	struct tpm_chip *chip = (struct tpm_chip *) ptr;
> +
> +	if (down_trylock(&chip->timer_mutex) == 0) {
> +		atomic_set(&chip->data_pending, 0);
> +		memset(chip->tpm_result_buffer, 0, TPM_BUFSIZE);
> +		up(&chip->user_mutex);
> +		up(&chip->timer_mutex);
> +	}
> +}
> +
> +void tpm_time_expired(unsigned long ptr)
> +{
> +	int *exp = (int *) ptr;
> +	*exp = 1;
> +}
> +
> +EXPORT_SYMBOL(tpm_time_expired);
> +
> +int rdx(int index)
> +{
> +	outb(index, TPM_ADDR);
> +	return inb(TPM_DATA) & 0xFF;
> +}
> +
> +EXPORT_SYMBOL(rdx);
> +
> +void wrx(int index, int value)
> +{
> +	outb(index, TPM_ADDR);
> +	outb(value & 0xFF, TPM_DATA);
> +}
> +
> +EXPORT_SYMBOL(wrx);

These (rdx/wrx) are not appropriate names for global namespace.  Must
they even be exported?  Could they not be made static inline in tpm.h?

> +/*
> + * Initialize the LPC bus and enable the TPM ports
> + */
> +int lpc_bus_init(struct pci_dev *pci_dev, u16 base)
> +{
> +	u32 lpcenable, tmp;
> +	int is_lpcm = 0;
> +
> +	switch (pci_dev->vendor) {
> +	case PCI_VENDOR_ID_INTEL:

This doesn't look quite right to have device specific logic in the
core.  Shouldn't this go in the device specific driver logic?

> +		switch (pci_dev->device) {
> +		case PCI_DEVICE_ID_INTEL_82801CA_12:
> +		case PCI_DEVICE_ID_INTEL_82801DB_12:
> +			is_lpcm = 1;
> +			break;
> +		}
> +		/* init ICH (enable LPC) */
> +		pci_read_config_dword(pci_dev, PCI_GEN1_DEC, &lpcenable);
> +		lpcenable |= 0x20000000;
> +		pci_write_config_dword(pci_dev, PCI_GEN1_DEC, lpcenable);
> +
> +		if (is_lpcm) {
> +			pci_read_config_dword(pci_dev, PCI_GEN1_DEC,
> +					      &lpcenable);
> +			if ((lpcenable & 0x20000000) == 0) {
> +				dev_err(&pci_dev->dev,
> +					"cannot enable LPC\n");
> +				return -ENODEV;
> +			}
> +		}
> +
> +		/* initialize TPM registers */
> +		pci_read_config_dword(pci_dev, PCI_GEN2_DEC, &tmp);
> +
> +		if (!is_lpcm)
> +			tmp = (tmp & 0xFFFF0000) | (base & 0xFFF0);
> +		else
> +			tmp =
> +			    (tmp & 0xFFFF0000) | (base & 0xFFF0) |
> +			    0x00000001;
> +
> +		pci_write_config_dword(pci_dev, PCI_GEN2_DEC, tmp);
> +
> +		if (is_lpcm) {
> +			pci_read_config_dword(pci_dev, PCI_GEN_PMCON_1,
> +					      &tmp);
> +			tmp |= 0x00000004;	/* enable CLKRUN */
> +			pci_write_config_dword(pci_dev, PCI_GEN_PMCON_1,
> +					       tmp);
> +		}
> +		outb(0x0D, TPM_ADDR);	/* unlock 4F */
> +		outb(0x55, TPM_DATA);
> +		outb(0x0A, TPM_ADDR);	/* int disable */
> +		outb(0x00, TPM_DATA);
> +		outb(0x08, TPM_ADDR);	/* base addr lo */
> +		outb(base & 0xFF, TPM_DATA);
> +		outb(0x09, TPM_ADDR);	/* base addr hi */
> +		outb((base & 0xFF00) >> 8, TPM_DATA);
> +		outb(0x0D, TPM_ADDR);	/* lock 4F */
> +		outb(0xAA, TPM_DATA);

Hey, aren't these a bunch of those wdx's? ;-)

> +		break;
> +	case PCI_VENDOR_ID_AMD:
> +		/* nothing yet */
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +EXPORT_SYMBOL(lpc_bus_init);
> +
> +/*
> + * Internal kernel interface to transmit TPM commands
> + */
> +static ssize_t tpm_transmit(struct tpm_chip *chip, const char *buf,
> +			    size_t bufsiz)
> +{
> +	ssize_t len;
> +	u32 count;
> +	__be32 *native_size;
> +
> +	native_size = (__force __be32 *) (buf + 2);
> +	count = be32_to_cpu(*native_size);
> +
> +	if (count == 0)
> +		return -ENODATA;
> +	if (count > bufsiz) {
> +		dev_err(&chip->pci_dev->dev,
> +			"invalid count value %x %x \n", count, bufsiz);
> +		return -E2BIG;
> +	}
> +
> +	if ((len = chip->ops->send(chip, (u8 *) buf, count)) < 0) {
> +		dev_err(&chip->pci_dev->dev,
> +			"tpm_transmit: tpm_send: error %d\n", len);
> +		return len;
> +	}
> +
> +	down(&chip->sync_mutex);
> +	chip->tpm_time_expired = 0;
> +	init_timer(&chip->tpm_timer);
> +	chip->tpm_timer.function = tpm_time_expired;
> +	chip->tpm_timer.expires = jiffies + 2 * 60 * HZ;
> +	chip->tpm_timer.data = (unsigned long) &chip->tpm_time_expired;
> +	add_timer(&chip->tpm_timer);
> +	up(&chip->sync_mutex);
> +
> +	do {
> +		u8 status = inb(chip->base + 1);

Is this guaranteed to be status location on all chips?  Perhaps a
status() callback is better.

> +		if ((status & chip->ops->req_complete_mask) ==
> +		    chip->ops->req_complete_val) {
> +			down(&chip->sync_mutex);
> +			del_singleshot_timer_sync(&chip->tpm_timer);
> +			up(&chip->sync_mutex);
> +			goto out_recv;
> +		}
> +		schedule_timeout(TPM_TIMEOUT);
> +		rmb();
> +	} while (!chip->tpm_time_expired);
> +
> +
> +	chip->ops->cancel(chip);
> +	dev_err(&chip->pci_dev->dev, "Time expired\n");
> +	return -EIO;
> +
> +out_recv:
> +	len = chip->ops->recv(chip, (u8 *) buf, bufsiz);
> +	if (len < 0)
> +		dev_err(&chip->pci_dev->dev,
> +			"tpm_transmit: tpm_recv: error %d\n", len);
> +	return len;
> +}
> +
> +/*
> + * Device file system interface to the TPM
> + */
> +static int tpm_open(struct inode *inode, struct file *file)
> +{
> +	int rc = 0, minor = iminor(inode);
> +	struct tpm_chip *chip = NULL, *pos;
> +
> +	spin_lock(&driver_lock);
> +
> +	list_for_each_entry(pos, &tpm_chip_list, list) {
> +		if (pos->ops->miscdev.minor == minor) {
> +			chip = pos;
> +			break;
> +		}
> +	}
> +	if (chip == NULL) {
> +		rc = -ENODEV;
> +		goto err_out;
> +	}
> +
> +	if (chip->num_opens) {
> +		dev_dbg(&chip->pci_dev->dev,
> +			"Another process owns this TPM\n");
> +		rc = -EBUSY;
> +		goto err_out;
> +	}
> +
> +	chip->num_opens++;

Hmm, looks a bit like it's just a mutex.

> +	pci_dev_get(chip->pci_dev);
> +
> +	spin_unlock(&driver_lock);
> +
> +	chip->tpm_result_buffer =
> +	    kmalloc(TPM_BUFSIZE * sizeof(u8), GFP_KERNEL);
> +	if (chip->tpm_result_buffer == NULL) {
> +		chip->num_opens--;
> +		pci_dev_put(chip->pci_dev);
> +		return -ENOMEM;
> +	}
> +
> +	atomic_set(&chip->data_pending, 0);
> +
> +	file->private_data = chip;
> +	return 0;
> +
> +err_out:
> +	spin_unlock(&driver_lock);
> +	return rc;
> +}
> +
> +static int tpm_release(struct inode *inode, struct file *file)
> +{
> +	struct tpm_chip *chip = file->private_data;
> +
> +	if (chip == NULL)
> +		return -ENODEV;

Don't think that'll ever happen?

> +
> +	spin_lock(&driver_lock);
> +	chip->num_opens--;
> +	if (chip->num_opens == 0) {

Is there a case where num_opens-- != 0?  I thought you were making sure
there was only one open?

> +		down(&chip->sync_mutex);
> +		if (timer_pending(&chip->user_read_timer))
> +			del_singleshot_timer_sync(&chip->user_read_timer);
> +		else if (timer_pending(&chip->tpm_timer))
> +			del_singleshot_timer_sync(&chip->tpm_timer);
> +		up(&chip->sync_mutex);
> +		kfree(chip->tpm_result_buffer);
> +		atomic_set(&chip->data_pending, 0);
> +	}
> +
> +	pci_dev_put(chip->pci_dev);
> +	file->private_data = NULL;
> +	spin_unlock(&driver_lock);
> +	return 0;
> +}
> +
> +static ssize_t tpm_write(struct file *file, const char __user * buf,
> +			 size_t size, loff_t * off)
> +{
> +	struct tpm_chip *chip = file->private_data;
> +	int out_size;
> +
> +	if (chip == NULL)
> +		return -ENODEV;

Don't think that'll ever happen?

> +
> +	down(&chip->user_mutex);

What is this protecting?

> +
> +	if (copy_from_user
> +	    (chip->tpm_result_buffer, (void __user *) buf, size)) {
> +		up(&chip->user_mutex);
> +		return -EFAULT;
> +	}

This is a buffer overflow waiting to happen.

> +	out_size =
> +	    tpm_transmit(chip, chip->tpm_result_buffer, TPM_BUFSIZE);

How does device distinguish from leftover garbage in buffer when size <
TPM_BUFSIZE?  Wonder if you could read this back from tpm (and leak
kernel memory to userspace that way)?

> +	down(&chip->sync_mutex);
> +	init_timer(&chip->user_read_timer);
> +	chip->user_read_timer.function = user_reader_timeout;
> +	chip->user_read_timer.data = (unsigned long) chip;
> +	chip->user_read_timer.expires = jiffies + (60 * HZ);
> +	add_timer(&chip->user_read_timer);
> +	up(&chip->sync_mutex);
> +
> +	atomic_set(&chip->data_pending, out_size);
> +
> +	return size;
> +}
> +
> +static ssize_t tpm_read(struct file *file, char __user * buf,
> +			size_t size, loff_t * off)
> +{
> +	struct tpm_chip *chip = file->private_data;
> +	int write_size;
> +
> +	if (chip == NULL)
> +		return -ENODEV;

Don't think that'll happen?

> +	if (down_trylock(&chip->timer_mutex) != 0) {
> +		dev_err(&chip->pci_dev->dev, "Timeout occured\n");
> +		return -ETIME;
> +	}
> +
> +	write_size = atomic_read(&chip->data_pending);
> +	atomic_set(&chip->data_pending, 0);
> +
> +	if (write_size == 0) {
> +		dev_err(&chip->pci_dev->dev, "No data pending\n");
> +		up(&chip->timer_mutex);
> +		return -ENODATA;
> +	}
> +
> +	down(&chip->sync_mutex);
> +	del_singleshot_timer_sync(&chip->user_read_timer);
> +	up(&chip->sync_mutex);
> +
> +	up(&chip->timer_mutex);
> +
> +	if (write_size < 0)
> +		goto out;
> +
> +	if (size < write_size)
> +		write_size = size;
> +
> +	if (copy_to_user
> +	    ((void __user *) buf, chip->tpm_result_buffer, write_size)) {
> +		write_size = -EFAULT;
> +		goto out;
> +	}
> +
> +out:
> +	up(&chip->user_mutex);
> +	return write_size;
> +}
> +
> +static void __devexit tpm_remove(struct pci_dev *pci_dev)
> +{
> +	struct tpm_chip *chip = pci_get_drvdata(pci_dev);
> +
> +	if (chip == NULL) {
> +		dev_err(&pci_dev->dev, "No device data found\n");
> +		return;
> +	}
> +
> +	spin_lock(&driver_lock);
> +
> +	if (chip->num_opens != 0) {

Won't module refcount care for this?

> +		dev_err(&chip->pci_dev->dev,
> +			"Device still open (%d times) in userspace\n",
> +			chip->num_opens);
> +		spin_unlock(&driver_lock);
> +		return;
> +	}
> +
> +	list_del(&chip->list);
> +
> +	pci_set_drvdata(pci_dev, NULL);
> +	misc_deregister(&chip->ops->miscdev);
> +	spin_unlock(&driver_lock);
> +
> +	pci_disable_device(pci_dev);
> +
> +	dev_mask[chip->dev_num / 32] &= !(1 << (chip->dev_num % 32));
> +
> +	kfree(chip);
> +
> +	pci_dev_put(pci_dev);
> +}
> +
> +static u8 savestate[] = {
> +	0, 193,			/* TPM_TAG_RQU_COMMAND */
> +	0, 0, 0, 10,		/* blob length (in bytes) */
> +	0, 0, 0, 152		/* TPM_ORD_SaveState */
> +};
> +
> +/*
> + * We are about to suspend. Save the TPM state
> + * so that it can be restored.
> + */
> +static int tpm_pm_suspend(struct pci_dev *pci_dev, u32 pm_state)
> +{
> +	struct tpm_chip *chip = pci_get_drvdata(pci_dev);
> +	if (chip == NULL)
> +		return -ENODEV;
> +
> +	tpm_transmit(chip, savestate, sizeof(savestate));
> +	return 0;
> +}
> +
> +/*
> + * Resume from a power safe. The BIOS already restored
> + * the TPM state.
> + */
> +static int tpm_pm_resume(struct pci_dev *pci_dev)
> +{
> +	struct tpm_chip *chip = pci_get_drvdata(pci_dev);
> +	if (chip == NULL)
> +		return -ENODEV;
> +
> +	spin_lock(&driver_lock);
> +	lpc_bus_init(pci_dev, chip->base);
> +	spin_unlock(&driver_lock);
> +
> +	return 0;
> +}
> +
> +static struct pci_device_id tpm_pci_tbl[] __devinitdata = {
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0)},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12)},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_0)},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_12)},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_0)},
> +	{PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8111_LPC)},
> +	{0,}
> +};
> +
> +MODULE_DEVICE_TABLE(pci, tpm_pci_tbl);
> +
> +/*
> + * Vendor specific TPMs will have a unique name and probe function.
> + * Those fields should be populated prior to calling this function in
> + * tpm_<specific>.c's module init function.
> + */
> +int register_tpm_driver(struct pci_driver *drv)
> +{
> +	drv->id_table = tpm_pci_tbl;
> +	drv->remove = __devexit_p(tpm_remove);
> +	drv->suspend = tpm_pm_suspend;
> +	drv->resume = tpm_pm_resume;
> +
> +	return pci_register_driver(drv);
> +}
> +
> +EXPORT_SYMBOL(register_tpm_driver);
> +
> +void unregister_tpm_driver(struct pci_driver *drv)
> +{
> +	pci_unregister_driver(drv);
> +}
> +
> +EXPORT_SYMBOL(unregister_tpm_driver);
> +
> +/*
> + * Called from tpm_<specific>.c probe function only for devices 
> + * the driver has determined it should claim.  Prior to calling
> + * this function the specific probe function has called pci_enable_device
> + * upon errant exit from this function specific probe function should call
> + * pci_disable_device
> + */
> +int register_tpm_hardware(struct pci_dev *pci_dev,
> +			  struct tpm_chip_ops *entry, u16 base)
> +{
> +	char devname[7];
> +	struct tpm_chip *chip;
> +	int i, j;
> +
> +	/* Driver specific per-device data */
> +	chip = kmalloc(sizeof(*chip), GFP_KERNEL);
> +	if (chip == NULL)
> +		return -ENOMEM;
> +
> +	memset(chip, 0, sizeof(struct tpm_chip));
> +
> +	init_MUTEX(&chip->user_mutex);
> +	init_MUTEX(&chip->timer_mutex);
> +	init_MUTEX(&chip->sync_mutex);
> +	INIT_LIST_HEAD(&chip->list);
> +	chip->base = base;
> +
> +	chip->ops = entry;
> +
> +	chip->dev_num = -1;
> +
> +	for (i = 0; i < 32; i++)
> +		for (j = 0; j < 8; j++)
> +			if ((dev_mask[i] & (1 << j)) == 0) {
> +				chip->dev_num = i * 32 + j;
> +				dev_mask[i] |= 1 << j;
> +				goto dev_num_search_complete;
> +			}
> +
> +dev_num_search_complete:
> +	if (chip->dev_num < 0) {
> +		dev_err(&pci_dev->dev, "No available tpm device numbers\n");
> +		kfree(chip);
> +		return -ENODEV;
> +	} else if (chip->dev_num == 0)
> +		chip->ops->miscdev.minor = TPM_MINOR;
> +	else
> +		chip->ops->miscdev.minor = MISC_DYNAMIC_MINOR;
> +
> +	snprintf(devname, sizeof(devname), "%s%d", "tpm", chip->dev_num);
> +	chip->ops->miscdev.name = devname;
> +
> +	chip->ops->miscdev.fops->llseek = no_llseek;
> +	chip->ops->miscdev.fops->open = tpm_open;
> +	chip->ops->miscdev.fops->read = tpm_read;
> +	chip->ops->miscdev.fops->write = tpm_write;
> +	chip->ops->miscdev.fops->release = tpm_release;

This is usually done statically, entry is passed in after all.

> +	chip->ops->miscdev.dev = &(pci_dev->dev);
> +	chip->pci_dev = pci_dev_get(pci_dev);
> +
> +	spin_lock(&driver_lock);
> +
> +	if (misc_register(&chip->ops->miscdev)) {
> +		dev_err(&chip->pci_dev->dev,
> +			"unable to misc_register %s, minor %d\n",
> +			chip->ops->miscdev.name, chip->ops->miscdev.minor);
> +		pci_dev_put(pci_dev);
> +		spin_unlock(&driver_lock);
> +		kfree(chip);
> +		dev_mask[i] &= !(1 << j);
> +		return -ENODEV;
> +	}
> +
> +	pci_set_drvdata(pci_dev, chip);
> +
> +	list_add(&chip->list, &tpm_chip_list);
> +	spin_unlock(&driver_lock);
> +	return 0;
> +}
> +
> +EXPORT_SYMBOL(register_tpm_hardware);
> +
> +static int __init init_tpm(void)
> +{
> +	INIT_LIST_HEAD(&tpm_chip_list);
> +	spin_lock_init(&driver_lock);

These can be done statically.

> +	return 0;
> +}
> +
> +static void __exit cleanup_tpm(void)
> +{
> +
> +}
> +
> +module_init(init_tpm);
> +module_exit(cleanup_tpm);
> +
> +MODULE_AUTHOR("Leendert van Doorn (leendert@watson.ibm.com)");
> +MODULE_DESCRIPTION("TPM Driver");
> +MODULE_VERSION("2.0");
> +MODULE_LICENSE("GPL");
> diff -uprN linux-2.6.9/drivers/char/tpm.h linux-2.6.9-tpm/drivers/char/tpm.h
> --- linux-2.6.9/drivers/char/tpm.h	1969-12-31 18:00:00.000000000 -0600
> +++ linux-2.6.9-tpm/drivers/char/tpm.h	2004-12-16 17:16:50.000000000 -0600
> @@ -0,0 +1,69 @@
> +/*
> + * Copyright (C) 2004 IBM Corporation
> + *
> + * Authors:
> + * Leendert van Doorn <leendert@watson.ibm.com>
> + * Reiner Sailer <sailer@watson.ibm.com>
> + * Dave Safford <safford@watson.ibm.com>
> + * Kylene Hall <kjhall@us.ibm.com>
> + *
> + * Maintained by: <tpmdd_devel@lists.sourceforge.net>
> + *
> + * Device driver for TCG/TCPA TPM (trusted platform module).
> + * Specifications at www.trustedcomputinggroup.org	 
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation, version 2 of the
> + * License.
> + * 
> + */
> +#include <linux/module.h>
> +#include <linux/version.h>
> +#include <linux/pci.h>
> +#include <linux/delay.h>
> +#include <linux/miscdevice.h>
> +
> +#define TPM_TIMEOUT msecs_to_jiffies(5)
> +
> +struct tpm_chip;
> +
> +struct tpm_chip_ops {
> +	u8 req_complete_mask;
> +	u8 req_complete_val;

ops are usually ops only.

> +
> +	int (*recv) (struct tpm_chip *, u8 *, size_t);
> +	int (*send) (struct tpm_chip *, u8 *, size_t);
> +	void (*cancel) (struct tpm_chip *);
> +	struct miscdevice miscdev;
> +};
> +
> +struct tpm_chip {
> +	struct pci_dev *pci_dev;	/* PCI device stuff */
> +	int dev_num;
> +	u16 base;		/* TPM base address */
> +
> +	u8 *tpm_result_buffer;
> +	atomic_t data_pending;
> +	int num_opens;
> +	struct timer_list user_read_timer;
> +	struct timer_list tpm_timer;
> +	struct semaphore user_mutex;
> +	struct semaphore timer_mutex;
> +	struct semaphore sync_mutex;

Wow, three mutexes for this little data strucutre?

> +	int tpm_time_expired;
> +	struct list_head list;
> +
> +	struct tpm_chip_ops *ops;
> +};
> +
> +extern void tpm_time_expired(unsigned long);
> +extern int rdx(int);
> +extern void wrx(int, int);
> +extern int lpc_bus_init(struct pci_dev *, u16);
> +
> +extern int register_tpm_driver(struct pci_driver *);
> +extern void unregister_tpm_driver(struct pci_driver *);
> +extern int register_tpm_hardware(struct pci_dev *, struct tpm_chip_ops *,
> +				 u16);
> diff -uprN linux-2.6.9/drivers/char/tpm_nsc.c linux-2.6.9-tpm/drivers/char/tpm_nsc.c
> --- linux-2.6.9/drivers/char/tpm_nsc.c	1969-12-31 18:00:00.000000000 -0600
> +++ linux-2.6.9-tpm/drivers/char/tpm_nsc.c	2004-12-16 17:14:31.000000000 -0600
> @@ -0,0 +1,343 @@
> +/*
> + * Copyright (C) 2004 IBM Corporation
> + *
> + * Authors:
> + * Leendert van Doorn <leendert@watson.ibm.com>
> + * Reiner Sailer <sailer@watson.ibm.com>
> + * Dave Safford <safford@watson.ibm.com>
> + * Kylene Hall <kjhall@us.ibm.com>
> + *
> + * Maintained by: <tpmdd_devel@lists.sourceforge.net>
> + *
> + * Device driver for TCG/TCPA TPM (trusted platform module).
> + * Specifications at www.trustedcomputinggroup.org	 
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation, version 2 of the
> + * License.
> + * 
> + */
> +
> +#include "tpm.h"
> +
> +/* National definitions */
> +#define	TPM_NSC_BASE			0x360
> +#define	TPM_NSC_IRQ			0x07
> +
> +#define	NSC_LDN_INDEX			0x07
> +#define	NSC_SID_INDEX			0x20
> +#define	NSC_LDC_INDEX			0x30
> +#define	NSC_DIO_INDEX			0x60
> +#define	NSC_CIO_INDEX			0x62
> +#define	NSC_IRQ_INDEX			0x70
> +#define	NSC_ITS_INDEX			0x71
> +
> +#define	NSC_STATUS			0x01
> +#define	NSC_COMMAND			0x01
> +#define	NSC_DATA			0x00
> +
> +/* status bits */
> +#define	NSC_STATUS_OBF			0x01	/* output buffer full */
> +#define	NSC_STATUS_IBF			0x02	/* input buffer full */
> +#define	NSC_STATUS_F0			0x04	/* F0 */
> +#define	NSC_STATUS_A2			0x08	/* A2 */
> +#define	NSC_STATUS_RDY			0x10	/* ready to receive command */
> +#define	NSC_STATUS_IBR			0x20	/* ready to receive data */
> +
> +/* command bits */
> +#define	NSC_COMMAND_NORMAL		0x01	/* normal mode */
> +#define	NSC_COMMAND_BURST		0x81	/* burst mode */

Hmm, unused.  Is it for a dma type interface?

> +#define	NSC_COMMAND_EOC			0x03
> +#define	NSC_COMMAND_CANCEL		0x22
> +
> +/*
> + * Wait for a certain status to appear
> + */
> +static int wait_for_stat(struct tpm_chip *chip, u8 mask, u8 val, u8 * data)
> +{
> +	int expired = 0;
> +	struct timer_list status_timer =
> +	    TIMER_INITIALIZER(tpm_time_expired, jiffies + 10 * HZ,
> +			      (unsigned long) &expired);
> +
> +	/* status immediately available check */
> +	*data = inb(chip->base + 1);

Isn't this base + NSC_STATUS?  Nice to use constants where possible.

> +	if ((*data & mask) == val)
> +		return 0;
> +
> +	/* wait for status */
> +	add_timer(&status_timer);
> +	do {
> +		schedule_timeout(TPM_TIMEOUT);
> +		*data = inb(chip->base + 1);
> +		if ((*data & mask) == val) {
> +			del_singleshot_timer_sync(&status_timer);
> +			return 0;
> +		}
> +	}
> +	while (!expired);
> +
> +	return -EBUSY;
> +}
> +
> +static int nsc_wait_for_ready(struct tpm_chip *chip)
> +{
> +	int status;
> +	int expired = 0;
> +	struct timer_list status_timer =
> +	    TIMER_INITIALIZER(tpm_time_expired, jiffies + 100,
> +			      (unsigned long) &expired);
> +
> +	/* status immediately available check */
> +	status = inb(chip->base + NSC_STATUS);
> +	if (status & NSC_STATUS_OBF)
> +		status = inb(chip->base + NSC_DATA);
> +	if (status & NSC_STATUS_RDY)
> +		return 0;
> +
> +	/* wait for status */
> +	add_timer(&status_timer);
> +	do {
> +		schedule_timeout(TPM_TIMEOUT);
> +		status = inb(chip->base + NSC_STATUS);
> +		if (status & NSC_STATUS_OBF)
> +			status = inb(chip->base + NSC_DATA);
> +		if (status & NSC_STATUS_RDY) {
> +			del_singleshot_timer_sync(&status_timer);
> +			return 0;
> +		}
> +	}
> +	while (!expired);
> +
> +	dev_info(&chip->pci_dev->dev, "wait for ready failed\n");
> +	return -EBUSY;
> +}
> +
> +
> +static int tpm_nsc_recv(struct tpm_chip *chip, u8 * buf, size_t count)
> +{
> +	u8 *buffer = buf;
> +	u8 data, *p;
> +	u32 size;
> +	__be32 *native_size;
> +
> +	if (count < 6)
> +		return -EIO;
> +
> +	if (wait_for_stat(chip, NSC_STATUS_F0, NSC_STATUS_F0, &data) < 0) {
> +		dev_err(&chip->pci_dev->dev, "F0 timeout\n");
> +		return -EIO;
> +	}
> +	if ((data = inb(chip->base + NSC_DATA)) != NSC_COMMAND_NORMAL) {
> +		dev_err(&chip->pci_dev->dev, "not in normal mode (0x%x)\n",
> +			data);
> +		return -EIO;
> +	}
> +
> +	/* read the whole packet */
> +	for (p = buffer; p < &buffer[count]; p++) {
> +		if (wait_for_stat
> +		    (chip, NSC_STATUS_OBF, NSC_STATUS_OBF, &data) < 0) {
> +			dev_err(&chip->pci_dev->dev,
> +				"OBF timeout (while reading data)\n");
> +			return -EIO;
> +		}
> +		if (data & NSC_STATUS_F0)
> +			break;
> +		*p = inb(chip->base + NSC_DATA);
> +	}
> +
> +	if ((data & NSC_STATUS_F0) == 0) {
> +		dev_err(&chip->pci_dev->dev, "F0 not set\n");
> +		return -EIO;
> +	}
> +	if ((data = inb(chip->base + NSC_DATA)) != NSC_COMMAND_EOC) {
> +		dev_err(&chip->pci_dev->dev,
> +			"expected end of command(0x%x)\n", data);
> +		return -EIO;
> +	}
> +
> +	native_size = (__force __be32 *) (buf + 2);
> +	size = be32_to_cpu(*native_size);
> +
> +	if (count < size)
> +		return -EIO;
> +
> +	return size;
> +}
> +
> +static int tpm_nsc_send(struct tpm_chip *chip, u8 * buf, size_t count)
> +{
> +	u8 data;
> +	int i;
> +
> +	/*
> +	 * If we hit the chip with back to back commands it locks up
> +	 * and never set IBF. Hitting it with this "hammer" seems to
> +	 * fix it. Not sure why this is needed, we followed the flow
> +	 * chart in the manual to the letter.
> +	 */
> +	outb(NSC_COMMAND_CANCEL, chip->base + NSC_COMMAND);
> +
> +	if (nsc_wait_for_ready(chip) != 0)
> +		return -EIO;
> +
> +	if (wait_for_stat(chip, NSC_STATUS_IBF, 0, &data) < 0) {
> +		dev_err(&chip->pci_dev->dev, "IBF timeout\n");
> +		return -EIO;
> +	}
> +
> +	outb(NSC_COMMAND_NORMAL, chip->base + NSC_COMMAND);
> +	if (wait_for_stat(chip, NSC_STATUS_IBR, NSC_STATUS_IBR, &data) < 0) {
> +		dev_err(&chip->pci_dev->dev, "IBR timeout\n");
> +		return -EIO;
> +	}
> +
> +	for (i = 0; i < count; i++) {
> +		if (wait_for_stat(chip, NSC_STATUS_IBF, 0, &data) < 0) {
> +			dev_err(&chip->pci_dev->dev,
> +				"IBF timeout (while writing data)\n");
> +			return -EIO;
> +		}
> +		outb(buf[i], chip->base + NSC_DATA);
> +	}
> +
> +	if (wait_for_stat(chip, NSC_STATUS_IBF, 0, &data) < 0) {
> +		dev_err(&chip->pci_dev->dev, "IBF timeout\n");
> +		return -EIO;
> +	}
> +	outb(NSC_COMMAND_EOC, chip->base + NSC_COMMAND);
> +
> +	return count;
> +}
> +
> +static void tpm_nsc_cancel(struct tpm_chip *chip)
> +{
> +	outb(NSC_COMMAND_CANCEL, chip->base + NSC_COMMAND);
> +}
> +
> +static struct file_operations nsc_ops = {
> +	.owner = THIS_MODULE,
> +};
> +
> +static struct tpm_chip_ops tpm_nsc = {
> +	.recv = tpm_nsc_recv,
> +	.send = tpm_nsc_send,
> +	.cancel = tpm_nsc_cancel,
> +	.req_complete_mask = NSC_STATUS_OBF,
> +	.req_complete_val = NSC_STATUS_OBF,
> +	.miscdev.fops = &nsc_ops,
> +};
> +
> +static int __devinit tpm_nsc_init(struct pci_dev *pci_dev,
> +				  const struct pci_device_id *pci_id)
> +{
> +	int rc = 0;
> +
> +	if (pci_enable_device(pci_dev))
> +		return -EIO;
> +
> +	if (lpc_bus_init(pci_dev, TPM_NSC_BASE)) {
> +		rc = -ENODEV;
> +		goto out_err;
> +	}
> +
> +	/* verify that it is a National part (SID) */
> +	if (rdx(NSC_SID_INDEX) != 0xEF) {
> +		rc = -ENODEV;
> +		goto out_err;
> +	}
> +
> +	dev_dbg(&pci_dev->dev, "NSC TPM detected\n");
> +	dev_dbg(&pci_dev->dev,
> +		"NSC LDN 0x%x, SID 0x%x, SRID 0x%x\n", rdx(0x07),
> +		rdx(0x20), rdx(0x27));
> +	dev_dbg(&pci_dev->dev,
> +		"NSC SIOCF1 0x%x SIOCF5 0x%x SIOCF6 0x%x SIOCF8 0x%x\n",
> +		rdx(0x21), rdx(0x25), rdx(0x26), rdx(0x28));
> +	dev_dbg(&pci_dev->dev, "NSC IO Base0 0x%x\n",
> +		(rdx(0x60) << 8) | rdx(0x61));
> +	dev_dbg(&pci_dev->dev, "NSC IO Base1 0x%x\n",
> +		(rdx(0x62) << 8) | rdx(0x63));
> +	dev_dbg(&pci_dev->dev,
> +		"NSC Interrupt number and wakeup 0x%x\n", rdx(0x70));
> +	dev_dbg(&pci_dev->dev, "NSC IRQ type select 0x%x\n", rdx(0x71));
> +	dev_dbg(&pci_dev->dev,
> +		"NSC DMA channel select0 0x%x, select1 0x%x\n", rdx(0x74),
> +		rdx(0x75));
> +	dev_dbg(&pci_dev->dev,
> +		"NSC Config "
> +		"0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x\n",
> +		rdx(0xF0), rdx(0xF1), rdx(0xF2), rdx(0xF3), rdx(0xF4),
> +		rdx(0xF5), rdx(0xF6), rdx(0xF7), rdx(0xF8), rdx(0xF9));
> +
> +	dev_info(&pci_dev->dev,
> +		 "NSC PC21100 TPM revision %d\n", rdx(0x27) & 0x1F);
> +
> +	if (rdx(NSC_LDC_INDEX) == 0)
> +		dev_info(&pci_dev->dev, ": NSC TPM not active\n");
> +
> +	/* select PM channel 1 */
> +	wrx(NSC_LDN_INDEX, 0x12);
> +	rdx(NSC_LDN_INDEX);
> +
> +	/* disable the DPM module */
> +	wrx(NSC_LDC_INDEX, 0);
> +	rdx(NSC_LDC_INDEX);
> +
> +	/* set the data register base addresses */
> +	wrx(NSC_DIO_INDEX, TPM_NSC_BASE >> 8);
> +	wrx(NSC_DIO_INDEX + 1, TPM_NSC_BASE);
> +	rdx(NSC_DIO_INDEX);
> +	rdx(NSC_DIO_INDEX + 1);
> +
> +	/* set the command register base addresses */
> +	wrx(NSC_CIO_INDEX, (TPM_NSC_BASE + 1) >> 8);
> +	wrx(NSC_CIO_INDEX + 1, (TPM_NSC_BASE + 1));
> +	rdx(NSC_DIO_INDEX);
> +	rdx(NSC_DIO_INDEX + 1);
> +
> +	/* set the interrupt number to be used for the host interface */
> +	wrx(NSC_IRQ_INDEX, TPM_NSC_IRQ);
> +	wrx(NSC_ITS_INDEX, 0x00);
> +	rdx(NSC_IRQ_INDEX);
> +
> +	/* enable the DPM module */
> +	wrx(NSC_LDC_INDEX, 0x01);
> +	rdx(NSC_LDC_INDEX);
> +
> +	if ((rc =
> +	     register_tpm_hardware(pci_dev, &tpm_nsc, TPM_NSC_BASE)) < 0)
> +		goto out_err;
> +
> +	return 0;
> +
> +out_err:
> +	pci_disable_device(pci_dev);
> +	return rc;
> +}
> +
> +static struct pci_driver nsc_pci_driver = {
> +	.name = "tpm_nsc",
> +	.probe = tpm_nsc_init,
> +};
> +
> +static int __init init_nsc(void)
> +{
> +	return register_tpm_driver(&nsc_pci_driver);
> +
> +}
> +
> +static void __exit cleanup_nsc(void)
> +{
> +	unregister_tpm_driver(&nsc_pci_driver);
> +}
> +
> +module_init(init_nsc);
> +module_exit(cleanup_nsc);
> +
> +MODULE_AUTHOR("Leendert van Doorn (leendert@watson.ibm.com)");
> +MODULE_DESCRIPTION("TPM Driver");
> +MODULE_VERSION("2.0");
> +MODULE_LICENSE("GPL");
> diff -uprN linux-2.6.9/include/linux/pci_ids.h linux-2.6.9-tpm/include/linux/pci_ids.h
> --- linux-2.6.9/include/linux/pci_ids.h	2004-12-06 16:53:35.000000000 -0600
> +++ linux-2.6.9-tpm/include/linux/pci_ids.h	2004-12-06 14:27:05.000000000 -0600
> @@ -494,6 +494,7 @@
>  #define PCI_DEVICE_ID_AMD_OPUS_7449	0x7449
>  #	define PCI_DEVICE_ID_AMD_VIPER_7449	PCI_DEVICE_ID_AMD_OPUS_7449
>  #define PCI_DEVICE_ID_AMD_8111_LAN	0x7462
> +#define PCI_DEVICE_ID_AMD_8111_LPC	0x7468
>  #define PCI_DEVICE_ID_AMD_8111_IDE	0x7469
>  #define PCI_DEVICE_ID_AMD_8111_AUDIO	0x746d
>  #define PCI_DEVICE_ID_AMD_8151_0	0x7454
> diff -uprN linux-2.6.9/MAINTAINERS linux-2.6.9-tpm/MAINTAINERS
> --- linux-2.6.9/MAINTAINERS	2004-10-18 16:54:37.000000000 -0500
> +++ linux-2.6.9-tpm/MAINTAINERS	2004-12-07 12:39:10.000000000 -0600
> @@ -2144,6 +2144,12 @@ L:	tlinux-users@tce.toshiba-dme.co.jp
>  W:	http://www.buzzard.org.uk/toshiba/
>  S:	Maintained
>  
> +TPM DRIVER
> +P:	Kylene Hall
> +M:	tpmdd-devel@lists.sourceforge.net
> +L:	tpmdd-devel@lists.sourceforge.net
> +S:	Maintained
> +
>  TRIDENT 4DWAVE/SIS 7018 PCI AUDIO CORE
>  P:	Muli Ben-Yehuda
>  M:	mulix@mulix.org
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
