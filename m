Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbVAMSpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVAMSpT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 13:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbVAMSm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 13:42:27 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:4796 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261402AbVAMShi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 13:37:38 -0500
Date: Thu, 13 Jan 2005 10:37:30 -0800
From: Greg KH <greg@kroah.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: John Rose <johnrose@austin.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] release_pcibus_dev() crash
Message-ID: <20050113183729.GA25049@kroah.com>
References: <1105576756.8062.17.camel@sinatra.austin.ibm.com> <1105638551.30960.16.camel@sinatra.austin.ibm.com> <20050113181850.GA24952@kroah.com> <200501131021.19434.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501131021.19434.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 10:21:19AM -0800, Jesse Barnes wrote:
> On Thursday, January 13, 2005 10:18 am, Greg KH wrote:
> > On Thu, Jan 13, 2005 at 11:49:11AM -0600, John Rose wrote:
> > > > Maybe, did you read Documentation/filesystems/sysfs-pci.c?  You need to
> > > > do more than just enable HAVE_PCI_LEGACY, you also need to implement
> > > > some functions.
> > >
> > > This sounds like more than I bargained for.  I'll leave the patch as-is,
> > > since I don't currently have the means to test a fix for the legacy IO
> > > stuff.  Also because it doesn't crash on my architecture :)
> > >
> > > If you get some time, my suggestion is to scrap
> > > pci_remove_legacy_files(), and free the pci_bus->legacy_io field in
> > > pci_remove_bus().  The binary sysfs files will be cleaned up
> > > automatically as the class device is deleted, as described in the
> > > parent.
> >
> > No, don't rely on this please.  Explicitly clean up the files, it's
> > nicer that way, and when sysfs changes to not clean them up for you, it
> > will be less changes then.
> 
> So does the crash indicate that something is removing the directory, 
> containing the attributes to be removed, before it should?  How should the 
> oops be fixed?

Yes, this should be fixed, as it is incorrect, sorry in not seeing it
before.  Those files should be removed in the pci_remove_bus() function,
before the class_device_unregister() call.

So, does the patch below fix the problem for you?
(warning, not even compile tested)

thanks,

greg k-h

===== probe.c 1.91 vs edited =====
--- 1.91/drivers/pci/probe.c	2005-01-11 09:14:53 -08:00
+++ edited/probe.c	2005-01-13 10:34:43 -08:00
@@ -95,10 +95,6 @@ static void release_pcibus_dev(struct cl
 {
 	struct pci_bus *pci_bus = to_pci_bus(class_dev);
 
-	pci_remove_legacy_files(pci_bus);
-	class_device_remove_file(&pci_bus->class_dev,
-				 &class_device_attr_cpuaffinity);
-	sysfs_remove_link(&pci_bus->class_dev.kobj, "bridge");
 	if (pci_bus->bridge)
 		put_device(pci_bus->bridge);
 	kfree(pci_bus);
===== remove.c 1.10 vs edited =====
--- 1.10/drivers/pci/remove.c	2004-11-15 09:27:14 -08:00
+++ edited/remove.c	2005-01-13 10:36:23 -08:00
@@ -61,15 +61,19 @@ int pci_remove_device_safe(struct pci_de
 }
 EXPORT_SYMBOL(pci_remove_device_safe);
 
-void pci_remove_bus(struct pci_bus *b)
+void pci_remove_bus(struct pci_bus *pci_bus)
 {
-	pci_proc_detach_bus(b);
+	pci_proc_detach_bus(pci_bus);
 
 	spin_lock(&pci_bus_lock);
-	list_del(&b->node);
+	list_del(&pci_bus->node);
 	spin_unlock(&pci_bus_lock);
 
-	class_device_unregister(&b->class_dev);
+	pci_remove_legacy_files(pci_bus);
+	class_device_remove_file(&pci_bus->class_dev,
+				 &class_device_attr_cpuaffinity);
+	sysfs_remove_link(&pci_bus->class_dev.kobj, "bridge");
+	class_device_unregister(&pci_bus->class_dev);
 }
 EXPORT_SYMBOL(pci_remove_bus);
 
