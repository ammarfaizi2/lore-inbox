Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbULUTVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbULUTVi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 14:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbULUTVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 14:21:38 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:2002 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261253AbULUTVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 14:21:35 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] export PCI resources in sysfs
Date: Tue, 21 Dec 2004 11:09:03 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <200412210943.40101.jbarnes@engr.sgi.com> <20041221184355.GB8557@kroah.com>
In-Reply-To: <20041221184355.GB8557@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412211109.03826.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, December 21, 2004 10:43 am, Greg KH wrote:
> On Tue, Dec 21, 2004 at 09:43:39AM -0800, Jesse Barnes wrote:
> >  int pci_create_sysfs_dev_files (struct pci_dev *pdev)
> >  {
> > +#ifdef HAVE_PCI_MMAP
> > + int i;
> > +#endif
> > +
> >   if (!sysfs_initialized)
> >    return -EACCES;
> >
> > @@ -269,6 +300,31 @@
> >   else
> >    sysfs_create_bin_file(&pdev->dev.kobj, &pcie_config_attr);
> >
> > +#ifdef HAVE_PCI_MMAP
> > + /* Expose the PCI resources from this device as files */
> > + for (i = 0; i < PCI_ROM_RESOURCE; i++) {
> > +  struct bin_attribute *res_attr;
> > +
> > +  /* skip empty resources */
> > +  if (!pci_resource_len(pdev, i))
> > +   continue;
> > +
> > +  res_attr = kmalloc(sizeof(*res_attr) + 10, GFP_ATOMIC);
> > +  if (res_attr) {
> > +   pdev->res_attr[i] = res_attr;
> > +   /* Allocated above after the res_attr struct */
> > +   res_attr->attr.name = (char *)(res_attr + 1);
> > +   sprintf(res_attr->attr.name, "resource%d", i);
> > +   res_attr->size = pci_resource_len(pdev, i);
> > +   res_attr->attr.mode = S_IRUSR | S_IWUSR;
> > +   res_attr->attr.owner = THIS_MODULE;
> > +   res_attr->mmap = pci_mmap_resource;
> > +   res_attr->private = &pdev->resource[i];
> > +   sysfs_create_bin_file(&pdev->dev.kobj, res_attr);
> > +  }
> > + }
> > +#endif /* HAVE_PCI_MMAP */
>
> How about wrapping these two #ifdef blocks into one function, and moving
> it up in the file under the other #ifdef.  Do that for the other cleanup
> function, and it will drop a bunch of #ifdefs.

Yeah, that sounds good.  I really don't like adding these ifdefs, and limiting 
their scope to a function somewhere up above would be nicer.  I'll do that 
and respin.

Thanks,
Jesse
