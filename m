Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbTIYSTB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 14:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbTIYSS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 14:18:27 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:21638 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261657AbTIYSRP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 14:17:15 -0400
Message-ID: <3F73309B.4070908@us.ibm.com>
Date: Thu, 25 Sep 2003 11:14:51 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org, Greg KH <gregkh@us.ibm.com>
Subject: Re: [BUG/MEMLEAK?] struct pci_bus, child busses & bridges
References: <3F7237FB.8050509@us.ibm.com> <20030925095426.B30419@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Wed, Sep 24, 2003 at 05:34:03PM -0700, Matthew Dobson wrote:
> 
>>In pci_alloc_child_bus (drivers/pci/probe.c), the child bus is allocated 
>>and it's struct dev * is set to point to the struct dev belonging to the 
>>bridge that this bus is 'on', or 'behind'.  pci_alloc_child_bus is 
>>called in 3 places: pci_add_new_bus and twice in pci_scan_bridge.  The 
>>calls in pci_scan_bridge allocate a new struct pci_bus, but then seem to 
>>throw the references away, *without* freeing them.
> 
> 
> That is correct - they persist after they have been allocated until the
> bridge device is destroyed (if ever) - it's lifetime is directly equivalent
> to the lifetime of the bridge.
> 
> If you look carefully at pci_alloc_child_bus(), you will notice that
> bridge->subordinate is setup to point at the pci_bus, which provides
> a method to access the data held in the pci_bus later (eg, while we're
> freeing the structures.)

Ok, I see that now.  I guess my only remaining question is why do child 
busses not get their own struct device, but rather only a pointer to the 
bridge's struct device?  There's no refcounting done on this, ie: no 
pci_dev_get/put calls, but I guess that's kinda ok, since we're pretty 
sure that the child bus won't exist for longer than the bridge that owns 
it, right?  So using the bridge's struct dev allows the pci topology to 
look cleaner?  As in, there's no actual bus exposed in sysfs/procfs/etc, 
just devices that seem to be hanging off the bridge?

Cheers!

-Matt

