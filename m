Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316992AbSFQU1L>; Mon, 17 Jun 2002 16:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316979AbSFQU0L>; Mon, 17 Jun 2002 16:26:11 -0400
Received: from host194.steeleye.com ([216.33.1.194]:21766 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S316981AbSFQUZN>; Mon, 17 Jun 2002 16:25:13 -0400
Message-Id: <200206172025.g5HKP2m04371@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Patrick Mansfield <patmans@us.ibm.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Oliver Neukum <oliver@neukum.name>,
       David Brownell <david-b@pacbell.net>, Andries.Brouwer@cwi.nl,
       garloff@suse.de, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, sancho@dauskardt.de,
       linux-usb-devel@lists.sourceforge.net,
       linux1394-devel@lists.sourceforge.net, dougg@torque.net
Subject: Re: [linux-usb-devel] Re: /proc/scsi/map 
In-Reply-To: Message from Patrick Mansfield <patmans@us.ibm.com> 
   of "Mon, 17 Jun 2002 12:07:06 PDT." <20020617120706.A16275@eng2.beaverton.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 17 Jun 2002 15:25:02 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patmans@us.ibm.com said:
> Yes, legacy or broken devices need vendor specific code to get a
> unique serial number or uid, but it is not clear to me that putting
> the code in user space is better or worse than kernel space. Maybe we
> need to see some implementations. 

For me the advantage of doing this in user space is that we can use simple 
scripting to handle all the exceptions (and actually, allowing easy 
reconfiguration of the exceptions), but I agree, a reference implementation 
would be a useful demonstration.

> What happens at boot time? Do we now need special stripped copies of
> user space get-id commands to boot from scsi (for use with initrd)? Do
> we just wait until the system is booted before getting/setting the
> ID's? 

That depends on whether you really need the unique id at boot or not.  The 
boot code is really only looking for the root filesystem, which can be found 
by fs label, so there may not be a need to put all this in initrd.  However, 
if we have to it would go in as part of the diet{libc, hotplug} stuff.

If you don't put it in initrd, then you have an init script that runs to scan 
all the existing devices and configure them accordingly.

> If I build without sg or /proc, should SCSI ID's still be available? 

Without /proc, depending on how you do the sg<->sd mapping, possibly.  Without 
sg, no since I'd use that to formulate the SCSI cdb to get the ID.

> How can I efficiently handle multi-path code without overallocating N
> Scsi_Devices (where N is the number of paths to each Scsi_Device)? 

Since this is a one time configuration, is overallocation such a bad thing 
(particularly as the allocator is moving towards a much more dynamic model in 
2.5)?  You can allow the normal stuff to run and then trigger multi-path 
configuration adds as you see the same unique ID come in for different devices.

> For kernel implementations, we could add a special entry in the
> device_list or have a new list mapping vendor+product to a get-the-id
> function. 

device_list is what first got me thinking down this path:  I keep running into 
customer problems that boil down to XXX linux distribution doesn't find all 
the LUNS on my array.  The obvious answer is "that's because it isn't in 
device_list".  Now, I could solve the problem by giving the customer a kernel 
patch adding the device, but this runs into problems with inexpert users, or 
enterprise customers who won't deviate from the "standard" kernel.  Being 
lazy, the solution I ultimately adopted was to send them an init script that 
recognised the array from it's inquiry strings and used scsi-add-single-device 
to probe its LUNs.

James


