Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268228AbUHYSpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268228AbUHYSpY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 14:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268230AbUHYSpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 14:45:24 -0400
Received: from web14922.mail.yahoo.com ([216.136.225.6]:44673 "HELO
	web14922.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268228AbUHYSpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 14:45:03 -0400
Message-ID: <20040825184502.71622.qmail@web14922.mail.yahoo.com>
Date: Wed, 25 Aug 2004 11:45:02 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
To: Greg KH <greg@kroah.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Martin Mares <mj@ucw.cz>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20040825181951.GA30125@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

it is related to this change drivers/pci/bus.c.
-               pci_proc_attach_device(dev);
-               pci_create_sysfs_dev_files(dev);

The pci subsystem was initializing proc and sysfs too early from bus.c.
Both of these calls always failed and the proc_initialized flag was
used to return the failure. These calls were never succeeding, they
were always getting error returns.

pci_proc_init and pci_sysfs_init run later at _initcall() time and
build proc/sys so these routines masked the initial failure in bus.c.

If you remove the calls in bus.s there is no need for the
proc_initialized flag.

--- Greg KH <greg@kroah.com> wrote:

> On Wed, Aug 25, 2004 at 11:06:06AM -0700, Jon Smirl wrote:
> > Final version, I hope, includes short decription and Signed-off-by
> at
> > top of patch.
> 
> Hm, one comment.  I must have missed something in all of the
> different
> versions of this patch, but why are you changing this code:
> 
> > diff -Nru a/drivers/pci/proc.c b/drivers/pci/proc.c
> > --- a/drivers/pci/proc.c	Wed Aug 25 13:56:18 2004
> > +++ b/drivers/pci/proc.c	Wed Aug 25 13:56:18 2004
> > @@ -16,7 +16,6 @@
> >  #include <asm/uaccess.h>
> >  #include <asm/byteorder.h>
> >  
> > -static int proc_initialized;	/* = 0 */
> >  
> >  static loff_t
> >  proc_bus_pci_lseek(struct file *file, loff_t off, int whence)
> > @@ -387,9 +386,6 @@
> >  	struct proc_dir_entry *de, *e;
> >  	char name[16];
> >  
> > -	if (!proc_initialized)
> > -		return -EACCES;
> > -
> >  	if (!(de = bus->procdir)) {
> >  		if (pci_name_bus(name, bus))
> >  			return -EEXIST;
> > @@ -425,9 +421,6 @@
> >  {
> >  	struct proc_dir_entry *de = bus->procdir;
> >  
> > -	if (!proc_initialized)
> > -		return -EACCES;
> > -
> >  	if (!de) {
> >  		char name[16];
> >  		sprintf(name, "%02x", bus->number);
> > @@ -583,6 +576,7 @@
> >  {
> >  	return seq_open(file, &proc_bus_pci_devices_op);
> >  }
> > +
> >  static struct file_operations proc_bus_pci_dev_operations = {
> >  	.open		= proc_bus_pci_dev_open,
> >  	.read		= seq_read,
> > @@ -593,16 +587,20 @@
> >  static int __init pci_proc_init(void)
> >  {
> >  	struct proc_dir_entry *entry;
> > -	struct pci_dev *dev = NULL;
> > +	struct pci_dev *pdev = NULL;
> > +
> >  	proc_bus_pci_dir = proc_mkdir("pci", proc_bus);
> > +
> >  	entry = create_proc_entry("devices", 0, proc_bus_pci_dir);
> >  	if (entry)
> >  		entry->proc_fops = &proc_bus_pci_dev_operations;
> > -	proc_initialized = 1;
> > -	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) !=
> NULL) {
> > -		pci_proc_attach_device(dev);
> > +
> > +	while ((pdev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) !=
> NULL) {
> > +		pci_proc_attach_device(pdev);
> >  	}
> > +
> >  	legacy_proc_init();
> > +
> >  	return 0;
> >  }
> 
> I see some gratitous whitespace changes, and the removal of the
> proc_initialized flag.  Why do we need to get rid of that flag?
> 
> thanks,
> 
> greg k-h
> 


=====
Jon Smirl
jonsmirl@yahoo.com


		
_______________________________
Do you Yahoo!?
Win 1 of 4,000 free domain names from Yahoo! Enter now.
http://promotions.yahoo.com/goldrush
