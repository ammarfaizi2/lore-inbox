Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbTIYAga (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 20:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbTIYAga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 20:36:30 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:50667 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261621AbTIYAg2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 20:36:28 -0400
Message-ID: <3F7237FB.8050509@us.ibm.com>
Date: Wed, 24 Sep 2003 17:34:03 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: rmk@arm.linux.org.uk, Greg KH <gregkh@us.ibm.com>
Subject: [BUG/MEMLEAK?] struct pci_bus, child busses & bridges
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whilst working on what was supposed to be a fairly trivial patch, I 
stumbled across what looks to be a relatively significant bug in the way 
pci bridges are handled.  I could easily be wrong, as the pci code is 
far from anything I'd be willing to call an area of expertise.  That 
said, my description of the problem follows:

I am trying to add a file to the pci bus (ie: /sysfs/devices/pciXXXX:XX) 
directories in sysfs.  This led to the discovery that struct pci_bus 
(inlude/linux/pci.h) does not have an *actual* struct dev inside it, 
rather a pointer to a struct dev.  I found this interesting, as most 
device-type-thingies have an honest to goodness struct dev, allowing the 
use of container_of(), etc.  A quick perusal of the code offered no 
reason why struct pci_bus couldn't be changed to have the actual struct 
dev inside it, saving us kmalloc'ing and kfree'ing these, and generally 
keeping track of them.  I was wrong.

In pci_alloc_child_bus (drivers/pci/probe.c), the child bus is allocated 
and it's struct dev * is set to point to the struct dev belonging to the 
bridge that this bus is 'on', or 'behind'.  pci_alloc_child_bus is 
called in 3 places: pci_add_new_bus and twice in pci_scan_bridge.  The 
calls in pci_scan_bridge allocate a new struct pci_bus, but then seem to 
throw the references away, *without* freeing them.

It appears that these pseudo-busses are allocated and used as a kind of 
hack, to allow devices to be parented to pci bridge devices.  The 
pci_dev for the bridge is allocated and initialized, then a child bus is 
created, and it's *dev is pointed to the struct device belonging to the 
pci bridge.  There are no refcounts used for this, and it doesn't appear 
to be cleaned up in any way.  If anyone can offer any insight into this 
problem, or show me why I'm wrong, it would be greatly appreciated.

Thanks!

-Matt

