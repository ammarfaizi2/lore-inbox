Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266237AbUBDBgz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 20:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266226AbUBDBgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 20:36:55 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:54686 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S266237AbUBDBgx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 20:36:53 -0500
Message-ID: <40204B7E.6030408@us.ibm.com>
Date: Tue, 03 Feb 2004 17:31:42 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Rose <johnrose@austin.ibm.com>
CC: greg KH <gregkh@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 probe.c "pcibus_class" Device Class, release function
References: <1075847619.28337.31.camel@verve>
Content-Type: multipart/mixed;
 boundary="------------070606000003080408050401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070606000003080408050401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

John Rose wrote:
> The function release_pcibus_dev() in probe.c defines the release procedure for
> device class pcibus_class.  I want to suggest that this function be scrapped :)
> 
> This release function is called in the code path of class_device_unregister().
> The pcibus_class devices aren't currently unregistered anywhere, from what I
> can tell, so this release function is currently unused.  The runtime removal of
> PCI buses from logical partitions on PPC64 requires the unregistration of these
> class devices.  The natural place to do this IMHO is in pci_remove_bus_device()
> in remove.c.  

You're right that the class device isn't currently unregistered, and 
that was an oversight in the patch I originally sent.  Attatched is a 
patch that remedies that situation.  pci_remove_bus_device() *is* the 
natural place to unregister the class_dev, and that's just what the 
patch does.


> The problem is that this calls pci_destroy_dev(), which calls put() on the same
> "bridge" device that the release function does.  This should only be done once
> in the course of removing a pci_bus, and I doubt that we want to change
> pci_destroy_dev().   The kfree() of the pci_bus struct is also done in both
> pci_remove_bus_device() and release_pcibus_dev().  

Yep.  The patch pulls the kfree() out of pci_remove_bus_device() and 
calls class_device_unregister() in it's place.  This will put() the 
bridge device and free the pci_bus as needed.  put() does need to be 
called twice because the bridge device is get()'d twice: once when the 
device is registered and once when it's bus device grabs a reference to it.


> So the only two operations in the release function are redundantly performed in
> the place where it makes sense to unregister.  For these reasons, I think we
> should scrap the release function altogether and set that pointer in the struct
> class to NULL.
> 
> Thoughts?
> John

Disagree, for the reasons above. ;)  Patch attatched.

Cheers!

-Matt


--------------070606000003080408050401
Content-Type: text/plain;
 name="pcibus_memleak-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcibus_memleak-fix.patch"

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.2-rc3/drivers/pci/remove.c linux-2.6.2-rc3+pcibus_memleak-fix/drivers/pci/remove.c
--- linux-2.6.2-rc3/drivers/pci/remove.c	Thu Jan  8 22:59:10 2004
+++ linux-2.6.2-rc3+pcibus_memleak-fix/drivers/pci/remove.c	Tue Feb  3 17:17:30 2004
@@ -83,7 +83,7 @@ void pci_remove_bus_device(struct pci_de
 		list_del(&b->node);
 		spin_unlock(&pci_bus_lock);
 
-		kfree(b);
+		class_device_unregister(&b->class_dev);
 		dev->subordinate = NULL;
 	}
 

--------------070606000003080408050401--

