Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266842AbUFYTM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266842AbUFYTM6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 15:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266847AbUFYTM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 15:12:57 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:3555 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266842AbUFYTMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 15:12:06 -0400
Date: Fri, 25 Jun 2004 12:12:04 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: linux-kernel@vger.kernel.org
Subject: [RFC] ioremap() clarification && ioremap_resource()
Message-ID: <20040625191204.GA14246@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is the general consensus among folks on using ioremap() for
non-PCI devices?  Looking at IO-mapping.txt (which is really really 
oudated) and io.h for various architectures, there really does not 
seem to be any agreement on what the cookie going into ioremap() means. 
IO-mapping.txt just states that it is a bus address. The reason I am
asking is b/c I have a system that breaks the following assumption 
in IO-mapping.txt by having different bus address domains.


 - bus address. This is the address of memory as seen by OTHER devices, 
   not the CPU. Now, in theory there could be many different bus 
   addresses, with each device seeing memory in some device-specific way, 
   but happily most hardware designers aren't actually actively trying to 
   make things any more complex than necessary, so you can assume that all 
   external hardware sees the memory the same way. 

The system I am working on has a 32-bit SOC with many on-chip devices
and SDRAM taking up over 2G of CPU bus ("physical") address space. In 
addition, there is about 3.5GB worth of devices on the PCI bus. The SOC 
has an in direct PCI access mechanism via command/data registers, so there 
is no need to map any PCI devices into kernel VM. ioremap() can simply 
return the incoming value and read*/write* can use the PCI control 
registers on the SOC to perform PCI mem accesses. This does mean that
PCI mmap won't work, but that's not a requirement on this system.

The problem I have is that since some of the on-chip devices have
overlapping CPU bus addresses with devices on the PCI bus, there is no way 
for ioremap() to tell if the incoming address is a PCI bus address or a 
CPU bus address. Therefore, ioremap() does not know if really needs to
map the incoming region into VM or whether it should simply return
the value it was given. The same issue exists with read*/write* since 
there are non-PCI drivers that use these interfaces. [1]

I can easilly get around this issue by having my SOC-specific drivers
call the low level ARM __ioremap() which is defined as taking a CPU
physaddr and have my ioremap() assume that it is used only for PCI
devices, but it seems that we really need a consistent interface for
mapping devices regardless of the bus they are on.  There's been some 
discussion before on providing a ioremap_resource() [2], but it 
looks like the discussion just kind of died off and there were 
still some unresolved issues such as whether this interface should 
take a device pointer or not. 

One thing to note is that simply having a ioremap_resource() is not
enough and we also need someway of telling read*/write* what bus/device
we are accessing. In my situation, the PCI address for a device that
is passed to and returned by ioremap_resource() could easilly overlap
with the virtual address for a real VM-mapped device or even something 
in the PHYS_OFFSET -> VMALLOC_START region, so I can't just have 
readl/writel assume that it is a PCI address..or are readl/writel only
supposed to be used with PCI devices? 

What I'd like to propose is something that looks like the following
from the driver writer's perspective:

	cookie = dev_remap(dev, resource, offset, len);
	value = dev_readl(dev, cookie + register_offset);
	dev_writel(dev, cookie + offset, value);
	...
	dev_unmap(dev, cookie);

Is anyone else still interested in an API similar to ioremap_resource()
or am I the only one who really needs this ATM? Is this something that's 
is acceptalbe in 2.6 if we update drivers as needed (I only need e100 and 
e1000 for now) and make the generic case on systems that don't need the 
resource default to ioremap() or is this a 2.7 only change? 

Regardless of the answer, I'll try to throw together a patch in the
next few days.

~Deepak

[1] See drivers/serial/8250.c for ioremap && read*/write* on non-PCI

[2] http://www.uwsg.iu.edu/hypermail/linux/kernel/0309.0/1117.html

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment and
 will die here like rotten cabbages." - Number 6
