Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268185AbUHYSVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268185AbUHYSVP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 14:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268186AbUHYSVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 14:21:15 -0400
Received: from mail.kroah.org ([69.55.234.183]:29843 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268185AbUHYSVI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 14:21:08 -0400
Date: Wed, 25 Aug 2004 11:19:51 -0700
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Martin Mares <mj@ucw.cz>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Message-ID: <20040825181951.GA30125@kroah.com>
References: <20040825174238.GA26714@kroah.com> <20040825180607.10858.qmail@web14930.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040825180607.10858.qmail@web14930.mail.yahoo.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 11:06:06AM -0700, Jon Smirl wrote:
> Final version, I hope, includes short decription and Signed-off-by at
> top of patch.

Hm, one comment.  I must have missed something in all of the different
versions of this patch, but why are you changing this code:

> diff -Nru a/drivers/pci/proc.c b/drivers/pci/proc.c
> --- a/drivers/pci/proc.c	Wed Aug 25 13:56:18 2004
> +++ b/drivers/pci/proc.c	Wed Aug 25 13:56:18 2004
> @@ -16,7 +16,6 @@
>  #include <asm/uaccess.h>
>  #include <asm/byteorder.h>
>  
> -static int proc_initialized;	/* = 0 */
>  
>  static loff_t
>  proc_bus_pci_lseek(struct file *file, loff_t off, int whence)
> @@ -387,9 +386,6 @@
>  	struct proc_dir_entry *de, *e;
>  	char name[16];
>  
> -	if (!proc_initialized)
> -		return -EACCES;
> -
>  	if (!(de = bus->procdir)) {
>  		if (pci_name_bus(name, bus))
>  			return -EEXIST;
> @@ -425,9 +421,6 @@
>  {
>  	struct proc_dir_entry *de = bus->procdir;
>  
> -	if (!proc_initialized)
> -		return -EACCES;
> -
>  	if (!de) {
>  		char name[16];
>  		sprintf(name, "%02x", bus->number);
> @@ -583,6 +576,7 @@
>  {
>  	return seq_open(file, &proc_bus_pci_devices_op);
>  }
> +
>  static struct file_operations proc_bus_pci_dev_operations = {
>  	.open		= proc_bus_pci_dev_open,
>  	.read		= seq_read,
> @@ -593,16 +587,20 @@
>  static int __init pci_proc_init(void)
>  {
>  	struct proc_dir_entry *entry;
> -	struct pci_dev *dev = NULL;
> +	struct pci_dev *pdev = NULL;
> +
>  	proc_bus_pci_dir = proc_mkdir("pci", proc_bus);
> +
>  	entry = create_proc_entry("devices", 0, proc_bus_pci_dir);
>  	if (entry)
>  		entry->proc_fops = &proc_bus_pci_dev_operations;
> -	proc_initialized = 1;
> -	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
> -		pci_proc_attach_device(dev);
> +
> +	while ((pdev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL) {
> +		pci_proc_attach_device(pdev);
>  	}
> +
>  	legacy_proc_init();
> +
>  	return 0;
>  }

I see some gratitous whitespace changes, and the removal of the
proc_initialized flag.  Why do we need to get rid of that flag?

thanks,

greg k-h
