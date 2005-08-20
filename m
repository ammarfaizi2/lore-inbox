Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbVHTJqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbVHTJqe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 05:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbVHTJqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 05:46:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:10134 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751078AbVHTJqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 05:46:34 -0400
Date: Sat, 20 Aug 2005 10:46:32 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Brent Casavant <bcasavan@sgi.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2] external interrupts: abstraction layer
Message-ID: <20050820094632.GC21698@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Brent Casavant <bcasavan@sgi.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <20050819161054.I87000@chenjesu.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050819161054.I87000@chenjesu.americas.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/drivers/char/extint.c b/drivers/char/extint.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/char/extint.c
> @@ -0,0 +1,673 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2005 Silicon Graphics, Inc.  All Rights Reserved.
> + */
> +
> +/* This file provides an abstraction for lowlevel external interrupt
> + * operation.
> + *
> + * External interrupts are hardware mechanisms to generate or ingest
> + * a simple interrupt signal.
> + *
> + * Generation typically involves driving an output circuit voltage
> + * level, with a variety of single or recurring waveforms (e.g.
> + * a one-shot pulse, a square wave, etc.)  The repetition period
> + * for recurring waveforms can be set within hardware restrictions.
> + *
> + * Ingest typically involves responding to an input circuit voltage
> + * level or transition.  Multiple input sources may be available.
> + *
> + * 2005.07.27	Brent Casavant <bcasavan@sgi.com> Initial code
> + */
> +
> +#include <linux/module.h>
> +#include <linux/fs.h>
> +#include <linux/cdev.h>
> +#include <linux/ctype.h>
> +#include <linux/err.h>
> +#include <linux/extint.h>
> +#include <linux/gfp.h>
> +#include <linux/init.h>
> +#include <linux/kallsyms.h>
> +#include <linux/device.h>
> +#include <linux/poll.h>
> +
> +/**********************
> + * Module global data *
> + **********************/
> +
> +/* Device numbers */
> +#define EXTINT_NUMDEVS	255	/* Number of minor devices to reserve */
> +static dev_t firstdev;		/* Start of dynamic range */
> +static dev_t nextdev;		/* Next number to assign */
> +static DEFINE_SPINLOCK(nextdev_lock);
> +
> +/* Device status.  Controls whether new callouts can be registered. */
> +enum extint_state {
> +	EXTINT_COMING,
> +	EXTINT_ALIVE,
> +	EXTINT_GOING,
> +	EXTINT_DEAD
> +};
> +
> +/**********************
> + * Abstracted devices *
> + **********************/
> +
> +static struct page *extint_counter_vma_nopage(struct vm_area_struct *vma,
> +					      unsigned long address, int *type)
> +{
> +	struct extint_device *ed = vma->vm_private_data;
> +	struct page *page;
> +
> +	/* Only a single page is ever mapped */
> +	if (address >= vma->vm_start + PAGE_SIZE)
> +		return NOPAGE_SIGBUS;
> +
> +	/* virt_to_page can be expensive, but this is executed
> +	 * only once each time the counter page is mapped.
> +	 */
> +	page = virt_to_page(ed->counter_page);

I think you should store both the struct page pointer and the virtual
address in struct extint_device.  This avoids doing the virt_to_page
at every pagefauls.  It's also cleaner as you an juse use alloc_page()
and the page_address() to get the kernel virtual address.

> +	get_page(page);
> +
> +	if (type)
> +		*type = VM_FAULT_MINOR;
> +
> +	return page;
> +}
> +
> +static struct vm_operations_struct extint_counter_vm_ops = {
> +	.nopage = extint_counter_vma_nopage,
> +};
> +
> +static int extint_counter_open(struct inode *inode, struct file *filp)
> +{
> +	struct extint_device *ed = file_to_extint_device(filp);

you don't need the file but just the inode (strictly speaking the cdev),
and doing this based on the file is rather confusing to the reader because
the struct file passed to ->open has just been allocated.

> +
> +	/* Counter is always read-only */
> +	if (filp->f_mode & FMODE_WRITE)
> +		return -EPERM;
> +
> +	/* Prevent low-level module from unloading while
> +	 * corresponding abstracted device is open
> +	 */
> +	if (!try_module_get(ed->props->owner))
> +		return -ENXIO;
> +
> +	/* Snapshot initial value, for later use by poll */
> +	filp->private_data = (void *)*ed->counter_page;

What about storing the whole extint_device pointer in file->private_data?
That's get rid of a lot of casting and would make possible future additions
easier.

> +
> +	return 0;
> +}
> +
> +static int extint_counter_release(struct inode *inode, struct file *filp)
> +{
> +	struct extint_device *ed = file_to_extint_device(filp);
> +
> +	/* Allow low-level module to unload now that the
> +	 * corresponding abstracted device is really closed.
> +	 */
> +	module_put(ed->props->owner);
> +
> +	return 0;
> +}
> +
> +static ssize_t
> +extint_counter_read(struct file *filp, char *buff, size_t count, loff_t * offp)
> +{
> +	struct extint_device *ed = file_to_extint_device(filp);
> +	char outbuff[21];	/* 20 chars for value of 2^64, plus \0 */
> +
> +	/* Snapshot last value read, for later use by poll */
> +	memset(outbuff, 0, 21);
> +	filp->private_data = (void *)*ed->counter_page;
> +	snprintf(outbuff, 21, "%ld", (unsigned long)filp->private_data);
> +	outbuff[20] = '\0';
> +
> +	return simple_read_from_buffer(buff, count, offp, outbuff,
> +				       strlen(outbuff));
> +}
> +
> +static int extint_counter_mmap(struct file *filp, struct vm_area_struct *vma)
> +{
> +	struct extint_device *ed = file_to_extint_device(filp);
> +
> +	if ((PAGE_SIZE != vma->vm_end - vma->vm_start) || (0 != vma->vm_pgoff))
> +		return -EINVAL;
> +
> +	vma->vm_ops = &extint_counter_vm_ops;
> +	vma->vm_flags |= VM_RESERVED;
> +	vma->vm_flags &= ~(VM_WRITE | VM_MAYWRITE);	/* Read-only */
> +	vma->vm_private_data = ed;
> +	return 0;
> +}
> +
> +static unsigned int
> +extint_counter_poll(struct file *filp, struct poll_table_struct *wait)
> +{
> +	struct extint_device *ed = file_to_extint_device(filp);
> +
> +	poll_wait(filp, &ed->counter_queue, wait);
> +
> +	/* Check counter against last value read from it */
> +	if (*ed->counter_page != (unsigned long)filp->private_data)
> +		return (POLLIN | POLLRDNORM);
> +
> +	return 0;
> +}
> +
> +static struct file_operations extint_fops = {
> +	.owner = THIS_MODULE,
> +	.open = extint_counter_open,
> +	.release = extint_counter_release,
> +	.read = extint_counter_read,
> +	.mmap = extint_counter_mmap,
> +	.poll = extint_counter_poll,
> +};
> +
> +static int extint_device_create(struct extint_device *ed)
> +{
> +	int ret;
> +
> +	/* Allocate counter page */
> +	ed->counter_page = (unsigned long *)get_zeroed_page(GFP_KERNEL);
> +	if (!ed->counter_page) {
> +		printk(KERN_WARNING
> +		       "%s: failed to allocate extint counter page.\n",
> +		       __FUNCTION__);
> +		ret = -ENOMEM;
> +		goto out_page;
> +	}
> +
> +	/* Set up device */
> +	init_waitqueue_head(&ed->counter_queue);
> +	cdev_init(&ed->counter_cdev, &extint_fops);
> +	ed->counter_cdev.owner = THIS_MODULE;
> +	kobject_set_name(&ed->counter_cdev.kobj, "extint_counter%d",
> +			 MINOR(ed->devt));
> +	ret = cdev_add(&ed->counter_cdev, ed->devt, 1);
> +	if (ret) {
> +		printk(KERN_WARNING
> +		       "%s: failed to add cdev for extint_counter%d.\n",
> +		       __FUNCTION__, MINOR(ed->devt));
> +		goto out_cdev;
> +	}
> +
> +	return 0;
> +
> +out_cdev:
> +	kobject_put(&ed->counter_cdev.kobj);
> +	free_page((unsigned long)ed->counter_page);
> +out_page:
> +	return ret;
> +}
> +
> +static void extint_device_destroy(struct extint_device *ed)
> +{
> +	BUG_ON(waitqueue_active(&ed->counter_queue));
> +	cdev_del(&ed->counter_cdev);
> +}
> +
> +/**************************
> + * Misc. class attributes *
> + **************************/
> +
> +static ssize_t extint_show_dev(struct class_device *cdev, char *buf)
> +{
> +	struct extint_device *ed = class_get_devdata(cdev);
> +
> +	return print_dev_t(buf, ed->devt);
> +}
> +
> +/********************************
> + * Abstracted device attributes *
> + ********************************/
> +
> +#define classdev_to_extint_device(obj)	\
> +	container_of(obj, struct extint_device, class_dev)
> +
> +/* Gets current mode (shape) of interrupt generation */
> +static ssize_t extint_show_mode(struct class_device *cdev, char *buf)
> +{
> +	int rc;
> +	struct extint_device *ed = classdev_to_extint_device(cdev);
> +
> +	down(&ed->sem);
> +	if (likely(ed->props && ed->props->get_mode))
> +		rc = ed->props->get_mode(ed, buf);
> +	else
> +		rc = -ENXIO;
> +	up(&ed->sem);
> +
> +	return rc;
> +}
> +
> +/* Sets the mode (shape) of interrupt generation */
> +static ssize_t extint_store_mode(struct class_device *cdev, const char *buf,
> +				 size_t count)
> +{
> +	int rc;
> +	struct extint_device *ed = classdev_to_extint_device(cdev);
> +
> +	down(&ed->sem);
> +	if (likely(ed->props && ed->props->set_mode))
> +		rc = ed->props->set_mode(ed, buf, count);
> +	else
> +		rc = -ENXIO;
> +	up(&ed->sem);
> +
> +	return rc;
> +}
> +
> +/* Gets available modes of interrupt generation */
> +static ssize_t extint_show_modelist(struct class_device *cdev, char *buf)
> +{
> +	int rc;
> +	struct extint_device *ed = classdev_to_extint_device(cdev);
> +
> +	down(&ed->sem);
> +	if (likely(ed->props && ed->props->get_modelist))
> +		rc = ed->props->get_modelist(ed, buf);
> +	else
> +		rc = -ENXIO;
> +	up(&ed->sem);
> +
> +	return rc;
> +}
> +
> +/* Gets period (nanoseconds) of periodic modes of interrupt generation */
> +static ssize_t extint_show_period(struct class_device *cdev, char *buf)
> +{
> +	int rc;
> +	struct extint_device *ed = classdev_to_extint_device(cdev);
> +
> +	down(&ed->sem);
> +	if (likely(ed->props && ed->props->get_period))
> +		rc = sprintf(buf, "%ld\n", ed->props->get_period(ed));
> +	else
> +		rc = -ENXIO;
> +	up(&ed->sem);
> +
> +	return rc;
> +}
> +
> +static ssize_t extint_show_provider(struct class_device *cdev, char *buf)
> +{
> +	int rc;
> +	struct extint_device *ed = classdev_to_extint_device(cdev);
> +
> +	down(&ed->sem);
> +	if (likely(ed->props && ed->props->get_provider))
> +		rc = ed->props->get_provider(ed, buf);
> +	else
> +		rc = -ENXIO;
> +	up(&ed->sem);
> +
> +	return rc;
> +}
> +
> +/* Sets period (nanoseconds) of periodic modes of interrupt generation */
> +static ssize_t extint_store_period(struct class_device *cdev, const char *buf,
> +				   size_t count)
> +{
> +	int rc;
> +	char *endp;
> +	unsigned long period;
> +	struct extint_device *ed = classdev_to_extint_device(cdev);
> +
> +	period = simple_strtoul(buf, &endp, 0);
> +	if (*endp && !isspace(*endp))
> +		return -EINVAL;
> +
> +	down(&ed->sem);
> +	if (likely(ed->props && ed->props->set_period)) {
> +		rc = ed->props->set_period(ed, period);
> +		if (!rc)
> +			rc = count;	/* Swallow entire input */
> +	} else
> +		rc = -ENXIO;
> +	up(&ed->sem);
> +
> +	return rc;
> +}
> +
> +/* Gets rounding increment for interrupt generation periodic modes */
> +static ssize_t extint_show_quantum(struct class_device *cdev, char *buf)
> +{
> +	int rc;
> +	struct extint_device *ed = classdev_to_extint_device(cdev);
> +
> +	down(&ed->sem);
> +	if (likely(ed->props))
> +		rc = sprintf(buf, "%ld\n", ed->props->get_quantum(ed));
> +	else
> +		rc = -ENXIO;
> +	up(&ed->sem);
> +
> +	return rc;
> +}
> +
> +/* Gets current source of interrupt ingest */
> +static ssize_t extint_show_source(struct class_device *cdev, char *buf)
> +{
> +	int rc;
> +	struct extint_device *ed = classdev_to_extint_device(cdev);
> +
> +	down(&ed->sem);
> +	if (likely(ed->props && ed->props->get_source))
> +		rc = ed->props->get_source(ed, buf);
> +	else
> +		rc = -ENXIO;
> +	up(&ed->sem);
> +
> +	return rc;
> +}
> +
> +/* Sets source of interrupt ingest */
> +static ssize_t extint_store_source(struct class_device *cdev, const char *buf,
> +				   size_t count)
> +{
> +	int rc;
> +	struct extint_device *ed = classdev_to_extint_device(cdev);
> +
> +	down(&ed->sem);
> +	if (likely(ed->props && ed->props->set_source))
> +		rc = ed->props->set_source(ed, buf, count);
> +	else
> +		rc = -ENXIO;
> +	up(&ed->sem);
> +
> +	return rc;
> +}
> +
> +/* Gets list of available sources of interrupt ingest */
> +static ssize_t extint_show_sourcelist(struct class_device *cdev, char *buf)
> +{
> +	int rc;
> +	struct extint_device *ed = classdev_to_extint_device(cdev);
> +
> +	down(&ed->sem);
> +	if (likely(ed->props && ed->props->get_sourcelist))
> +		rc = ed->props->get_sourcelist(ed, buf);
> +	else
> +		rc = -ENXIO;
> +	up(&ed->sem);
> +
> +	return rc;
> +}
> +
> +/* Release allocated memory when last reference to a device goes away */
> +static void extint_class_release(struct class_device *cdev)
> +{
> +	struct extint_device *ed = classdev_to_extint_device(cdev);
> +
> +	BUG_ON(ed->state != EXTINT_DEAD);
> +	BUG_ON(!list_empty(&ed->callouts));
> +	kfree(ed);
> +}
> +
> +static struct class extint_class = {
> +	.name = "extint",
> +	.release = extint_class_release,
> +};
> +
> +#define DECLARE_ATTR(_name,_mode,_show,_store)	\
> +{					 	\
> +	.attr	= { .name = __stringify(_name),	\
> +		    .mode = _mode,		\
> +		    .owner = THIS_MODULE },	\
> +	.show	= _show,			\
> +	.store	= _store,			\
> +}
> +
> +static struct class_device_attribute extint_class_device_attributes[] = {
> +	DECLARE_ATTR(dev, 0444, extint_show_dev, NULL),
> +	DECLARE_ATTR(mode, 0644, extint_show_mode, extint_store_mode),
> +	DECLARE_ATTR(modelist, 0444, extint_show_modelist, NULL),
> +	DECLARE_ATTR(period, 0644, extint_show_period, extint_store_period),
> +	DECLARE_ATTR(provider, 0444, extint_show_provider, NULL),
> +	DECLARE_ATTR(quantum, 0444, extint_show_quantum, NULL),
> +	DECLARE_ATTR(source, 0644, extint_show_source, extint_store_source),
> +	DECLARE_ATTR(sourcelist, 0444, extint_show_sourcelist, NULL),
> +};
> +
> +/*************
> + * Interface *
> + *************/
> +
> +/* Register a low-level driver with the abstraction layer */
> +struct extint_device *extint_device_register(struct extint_properties *ep,
> +					     void *devdata)
> +{
> +	struct extint_device *ed;
> +	int rc;
> +	int i;
> +
> +	/* Create new control structure and initialize */
> +	ed = kmalloc(sizeof(struct extint_device), GFP_KERNEL);
> +	if (unlikely(!ed))
> +		return ERR_PTR(-ENOMEM);
> +	memset(ed, 0, sizeof(struct extint_device));
> +
> +	ed->state = EXTINT_COMING;
> +	init_MUTEX(&ed->sem);
> +	ed->props = ep;
> +	INIT_LIST_HEAD(&ed->callouts);
> +	spin_lock_init(&ed->callouts_lock);
> +	extint_set_devdata(ed, devdata);
> +
> +	/* Allocate device number */
> +	spin_lock(&nextdev_lock);
> +	ed->devt = nextdev++;
> +	spin_unlock(&nextdev_lock);
> +	if (ed->devt > (firstdev + EXTINT_NUMDEVS)) {
> +		rc = -ENOSPC;
> +		goto out_devnum;
> +	}
> +
> +	/* Add this device to the class */
> +	ed->class_dev.class = &extint_class;
> +	snprintf(ed->class_dev.class_id, BUS_ID_SIZE, "extint%d",
> +		 MINOR(ed->devt));
> +	class_set_devdata(&ed->class_dev, ed);
> +	rc = class_device_register(&ed->class_dev);
> +	if (rc)
> +		goto out_class;
> +
> +	/* Create character device */
> +	rc = extint_device_create(ed);
> +	if (rc)
> +		goto out_device;
> +
> +	/* Create attributes */
> +	for (i = 0; i < ARRAY_SIZE(extint_class_device_attributes); i++) {
> +		rc = class_device_create_file(&ed->class_dev,
> +					      &extint_class_device_attributes
> +					      [i]);
> +		if (rc)
> +			goto out_attr;
> +	}
> +
> +	ed->state = EXTINT_ALIVE;
> +	return ed;
> +
> +out_class:
> +out_devnum:
> +	ed->state = EXTINT_DEAD;
> +	kfree(ed);
> +	return ERR_PTR(rc);
> +
> +out_attr:
> +	while (--i >= 0)
> +		class_device_remove_file(&ed->class_dev,
> +					 &extint_class_device_attributes[i]);
> +out_device:
> +	ed->state = EXTINT_DEAD;
> +	class_device_unregister(&ed->class_dev);
> +	/* extint_class_release frees ed for us */
> +	return ERR_PTR(rc);
> +}
> +
> +EXPORT_SYMBOL(extint_device_register);
> +
> +/* Unregister a previously registered low-level driver */
> +void extint_device_unregister(struct extint_device *ed)
> +{
> +	int i;
> +
> +	if (!ed)
> +		return;
> +
> +	/* Remove counter device */
> +	ed->state = EXTINT_GOING;
> +	BUG_ON(!list_empty(&ed->callouts));
> +	extint_device_destroy(ed);
> +
> +	/* Remove all abstracted attributes */
> +	for (i = 0; i < ARRAY_SIZE(extint_class_device_attributes); i++)
> +		class_device_remove_file(&ed->class_dev,
> +					 &extint_class_device_attributes[i]);
> +
> +	/* Make sure device-specific functions are never invoked again */
> +	down(&ed->sem);
> +	ed->props = NULL;
> +	up(&ed->sem);
> +	ed->state = EXTINT_DEAD;
> +
> +	/* Remove this device from the class */
> +	class_device_unregister(&ed->class_dev);
> +}
> +
> +EXPORT_SYMBOL(extint_device_unregister);
> +
> +/* Obtain extint_device structure from an open file */
> +struct extint_device *file_to_extint_device(const struct file *filp)
> +{
> +	/* Validate that this really is an extint device file */
> +	if (filp->f_dentry->d_inode->i_cdev->dev < firstdev ||
> +	    filp->f_dentry->d_inode->i_cdev->dev > (firstdev + EXTINT_NUMDEVS))
> +		return ERR_PTR(-EINVAL);
> +
> +	return container_of(filp->f_dentry->d_inode->i_cdev,
> +			    struct extint_device, counter_cdev);
> +}
> +
> +EXPORT_SYMBOL(file_to_extint_device);

Why is this exported?  Also normally having helpers ontop of the file
so you've already read them when looking at their users helps understanding
a little.

> +/* Register a callout function to invoke when an interrupt is ingested */
> +int extint_callout_register(struct extint_device *ed, struct extint_callout *ec)
> +{
> +	int ret;
> +	unsigned long flags;
> +
> +	/* Disallow unload of callout owner */
> +	if (!try_module_get(ec->owner))
> +		return -ENXIO;
> +
> +	/* Disallow unload of low-level driver */
> +	if (!try_module_get(ed->props->owner)) {
> +		module_put(ec->owner);
> +		return -ENXIO;
> +	}
> +
> +	spin_lock_irqsave(&ed->callouts_lock, flags);
> +	switch (ed->state) {
> +	case EXTINT_COMING:
> +		ret = -EAGAIN;
> +		module_put(ed->props->owner);
> +		module_put(ec->owner);
> +		break;
> +	case EXTINT_ALIVE:
> +		list_add(&ec->list, &ed->callouts);
> +		ret = 0;
> +		break;
> +	default:
> +		ret = -EBUSY;
> +		module_put(ed->props->owner);
> +		module_put(ec->owner);
> +		break;
> +	}
> +	spin_unlock_irqrestore(&ed->callouts_lock, flags);
> +
> +	return ret;
> +}
> +
> +EXPORT_SYMBOL(extint_callout_register);

I've not seen any users of the in-kernel extint consumer interface in
your previous posting or this one.  Do you plan to submit a patch to
use them soon?  Else please keep the interface out for now, we can easily
add it when it's nessecary.

Also callout isn't really a name we use a lot in linux, unlike other
unix variants.

> +static inline void* extint_get_devdata(const struct extint_device *ed) {
> +	return ed->devdata;
> +}

minimal style nipick, please put the opening brace on a line of it's own.

