Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265627AbUBJULI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 15:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265620AbUBJULF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 15:11:05 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:25869 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S265627AbUBJUJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 15:09:33 -0500
Message-ID: <40293BEB.9010606@techsource.com>
Date: Tue, 10 Feb 2004 15:15:39 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Mike Bell <kernel@mikebell.org>
CC: Chris Friesen <cfriesen@nortelnetworks.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
References: <20040210113417.GD4421@tinyvaio.nome.ca> <20040210170157.GA27421@kroah.com> <20040210171337.GK4421@tinyvaio.nome.ca> <40291A73.7050503@nortelnetworks.com> <20040210192456.GB4814@tinyvaio.nome.ca>
In-Reply-To: <20040210192456.GB4814@tinyvaio.nome.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please forgive me for stepping into this conversation so late...

Mike Bell wrote:
> On Tue, Feb 10, 2004 at 12:52:51PM -0500, Chris Friesen wrote:
> 
>>What names would you use for your device files?  This is the key 
>>difference.  With udev it gets a notification that says "I have a new 
>>block device", it then looks it up, applies the rules, and creates a new 
>>entry.  The whole point is to move the naming scheme into userspace for 
>>easier management.
> 
> 
> Why does it make management easier to have no predictable name for a
> device?
> 

What's unpredictable about it?  udev can apply exactly the same rules 
that devfs uses, thereby coming up with the same names.  In that limited 
case, the advantage to udev is to move code out of the kernel.  Not only 
does that shrink the kernel, but it moves policy that affects user space 
into user space.

If udev had a "devfs" mode where it used a ramdisk for device nodes, and 
it produced exactly the same names as devfs, would you be happy with it?

Any device node you needed would have been generated well before you 
needed it, and being a filesystem node, it's no slower to actually USE 
the device than devfs, and you'd get all the same behavior you had 
before.  The ONLY difference is that the code isn't in the kernel.

You have the further advantage, for the embedded people, that you can 
eliminate udev, and create static device nodes, without having to modify 
the kernel in any way.

For the typical case, udev COULD produce the same device names as devfs, 
completely addressing your "predictability" issue.  It would be 
PERFECTLY predictable.  But it has the additional advantage of being 
able to keep a database in a file that it uses to also make device names 
CONSISTENT.  Thus, if you attach a USB device and then remove it and 
then attach it again later, udev has a simple way to compare that device 
against its history of known devices and give that device again exactly 
the same name.  Can devfs do that?  If so, where does it keep its history?


> 
>>You could have the kernel export a simple devfs with a hardcoded naming 
>>scheme based on similar ideas as what is in sysfs (which would then make 
>>sysfs and the daemon optional for tiny embedded setups), but the only 
>>advantage over just exporting the information in sysfs is to save a few 
>>bytes at the cost of yet another filesystem to maintain.
> 
> 
> I think the space savings are a pretty good reason alone. Add to that
> the fact I think devfs would be a good idea even if it cost MORE
> memory... You can mount a devfs on your RO root instead of needing to
> mount a tmpfs on /dev and then run udev on that. A devfs gives
> consistant names for devices in addition to the user's preferred
> user-space dictated naming scheme. A devfs means even with dynamic
> majors/minors, even if you have new hardware in your system, your /dev
> at least has the devices it needs.

How does devfs save space?  Device node information has to be stores 
SOMEWHERE.  Whether that's in filesystem nodes or in datastructures in 
the kernel that are dynamically made to LOOK like device nodes, you 
still need to take up memory.

As for dynamic major/minor numbers, I'm not sure how udev precludes 
that.  The fact that udev might keep minor numbers from changing over a 
reboot doesn't matter.  Dynamic major/minor numbers just means that they 
can be arbitrary.

