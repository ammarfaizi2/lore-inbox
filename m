Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbUD2AiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbUD2AiR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 20:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbUD2AiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 20:38:17 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:47315 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262215AbUD2AiO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 20:38:14 -0400
Message-ID: <40904E72.7020308@us.ibm.com>
Date: Wed, 28 Apr 2004 19:38:10 -0500
From: Brian King <brking@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: userspace pci config space accesses
References: <409026CE.8050905@us.ibm.com> <20040428225236.GA27250@kroah.com> <40903DBD.1000704@us.ibm.com> <20040428233812.GA365@kroah.com>
In-Reply-To: <20040428233812.GA365@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
>>>What driver is doing this?
>>
>>The ipr driver, a scsi device driver for ppc64.
>>
>>http://marc.theaimsgroup.com/?l=linux-scsi&m=108144942527994&w=2
>>
>>The driver runs BIST at device initialization time to ensure that the device
>>is in a clean state.
> 
> 
> Ick.  It sounds like "clean state" isn't always true if userspace can
> mess the device up by simply reading its config space :)

Yeah, its not so much the device, bus the way pSeries PCI bridges work. 
Other adapters would have the same problem, but after a quick grep it 
doesn't look like running BIST is a very common thing to do in most 
Linux drivers.

> Worse case thing, stop the whole machine while doing BIST if you want to
> prevent this from happening (not that I'm actually suggesting you do it,
> but if you really think it's the only way...)

Yeah, mdelay(2000) kind of sticks out in a code review;)

> Is there any way you can not run BIST all the time, except when
> explicitly asked for from the user?

Not really. The times when told to explicitly by the user are actually
in the minority. Here are the times when BIST currently gets run and why:

1. module load time. Ensure the adapter is ready to accepts commands. I 
might be able to remove this one, but would need to talk with the system 
firmware folks to make sure they can guarantee the adapter will be in a 
clean state. At one point there was some talk that this couldn't be 
guaranteed, but that may have changed.

2. Fatal adapter error. The adapter signals an interrupt to the driver 
and the driver needs to run BIST to recover.

3. scsi_eh_host_reset. The adapter is having problems and commands are 
probably timing out. Last resort ERP.

4. Module unload time. This is required since there are kernel buffers 
that the adapter thinks it owns that must be freed and the only way to 
relinquish ownership of them from the adapter is to run BIST. Ugly, but 
we are stuck with it.

5. Microcode download. User initiated update of adapter microcode.

6. User writes an adapter reset sysfs file.


Two ideas I had would either be to create interfaces in the pci layer 
that a device driver could call to disable all pci adapter accesses and 
one to re-enable them. We could probably just make all pci accesses fail 
when disabled. These interfaces could then grab the lock and set the 
state on the pci_dev, then the read/write interfaces would check the 
state after acquiring the lock.

The other idea would be to create an async interface in the pci layer to 
run BIST for me and have it manage the locking in a similar manner.


thanks

-Brian



