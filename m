Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbTIYIyb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 04:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbTIYIyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 04:54:31 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26382 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261661AbTIYIya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 04:54:30 -0400
Date: Thu, 25 Sep 2003 09:54:27 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Greg KH <gregkh@us.ibm.com>
Subject: Re: [BUG/MEMLEAK?] struct pci_bus, child busses & bridges
Message-ID: <20030925095426.B30419@flint.arm.linux.org.uk>
Mail-Followup-To: Matthew Dobson <colpatch@us.ibm.com>,
	linux-kernel@vger.kernel.org, Greg KH <gregkh@us.ibm.com>
References: <3F7237FB.8050509@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F7237FB.8050509@us.ibm.com>; from colpatch@us.ibm.com on Wed, Sep 24, 2003 at 05:34:03PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 24, 2003 at 05:34:03PM -0700, Matthew Dobson wrote:
> In pci_alloc_child_bus (drivers/pci/probe.c), the child bus is allocated 
> and it's struct dev * is set to point to the struct dev belonging to the 
> bridge that this bus is 'on', or 'behind'.  pci_alloc_child_bus is 
> called in 3 places: pci_add_new_bus and twice in pci_scan_bridge.  The 
> calls in pci_scan_bridge allocate a new struct pci_bus, but then seem to 
> throw the references away, *without* freeing them.

That is correct - they persist after they have been allocated until the
bridge device is destroyed (if ever) - it's lifetime is directly equivalent
to the lifetime of the bridge.

If you look carefully at pci_alloc_child_bus(), you will notice that
bridge->subordinate is setup to point at the pci_bus, which provides
a method to access the data held in the pci_bus later (eg, while we're
freeing the structures.)

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
      Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
      maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                      2.6 Serial core
