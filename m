Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266164AbUBCWgx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 17:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266165AbUBCWgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 17:36:53 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:19611 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S266164AbUBCWgq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 17:36:46 -0500
Subject: 2.6 probe.c "pcibus_class" Device Class, release function
From: John Rose <johnrose@austin.ibm.com>
To: colpatch@us.ibm.com, greg KH <gregkh@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1075847619.28337.31.camel@verve>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 03 Feb 2004 16:33:39 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The function release_pcibus_dev() in probe.c defines the release procedure for
device class pcibus_class.  I want to suggest that this function be scrapped :)

This release function is called in the code path of class_device_unregister().
The pcibus_class devices aren't currently unregistered anywhere, from what I
can tell, so this release function is currently unused.  The runtime removal of
PCI buses from logical partitions on PPC64 requires the unregistration of these
class devices.  The natural place to do this IMHO is in pci_remove_bus_device()
in remove.c.  

The problem is that this calls pci_destroy_dev(), which calls put() on the same
"bridge" device that the release function does.  This should only be done once
in the course of removing a pci_bus, and I doubt that we want to change
pci_destroy_dev().   The kfree() of the pci_bus struct is also done in both
pci_remove_bus_device() and release_pcibus_dev().  

So the only two operations in the release function are redundantly performed in
the place where it makes sense to unregister.  For these reasons, I think we
should scrap the release function altogether and set that pointer in the struct
class to NULL.

Thoughts?
John

