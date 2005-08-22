Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbVHVTuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbVHVTuq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 15:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbVHVTuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 15:50:46 -0400
Received: from mail.dvmed.net ([216.237.124.58]:42374 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750749AbVHVTup (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 15:50:45 -0400
Message-ID: <430A2C91.4060803@pobox.com>
Date: Mon, 22 Aug 2005 15:50:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: linux-ide@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: libata TODO: ioread/iowrite work (was Re: [PATCH libata:upstream]
 remove compiler warnings)
References: <20050822091129.GA15373@htj.dyndns.org>
In-Reply-To: <20050822091129.GA15373@htj.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
>  Hello, Jeff.
> 
>  This patch removes compiler warnings which are caused by using
> ioports values (unsigned long) for the address argument of
> read/write[bwl]() functions without casting.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

NAK...  These warnings exist as a reminder of the remaining 
ioread/iowrite() work that must occur.  Look at the 'iomap' and 
'iomap-step1' branches of libata-dev.git for incomplete examples of this 
work.

One must:

- create a data structure to store a bunch of I/O port values, as 
returned by pci_iomap() and ioport_map()
- update legacy PCI IDE (aka looks like ISA IDE) code path to use 
ioport_map() to obtain the I/O addresses we need
- update native mode PCI IDE (aka looks like PCI) code path to use 
pci_iomap()
- update all the other drivers that use ioremap() to use pci_iomap()
- change struct ata_ioports, s/unsigned long/void __iomem */
- fix up the last few bits in each driver, such as
	* eliminating the 'unsigned long base' variable in each
	  xxx_init_one() function
	* changing the xxx_setup_port() function to indicate
	  void __iomem * rather than unsigned long
- one last check for any last s/long/void iomem */ changes to be made
- install Linus's "sparse" source checker
- run 'make C=1' in the kernel tree, and make sure libata and drivers 
don't spew warnings


So... it's not as simple as just killing the warnings ;-)


