Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263331AbTHVU07 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 16:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263406AbTHVU07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 16:26:59 -0400
Received: from fmr06.intel.com ([134.134.136.7]:22470 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263331AbTHVU0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 16:26:53 -0400
Date: Fri, 22 Aug 2003 11:25:36 -0700
From: long <tlnguyen@snoqualmie.dp.intel.com>
Message-Id: <200308221825.h7MIPa0Y020002@snoqualmie.dp.intel.com>
To: greg@kroah.com
Subject: Updated MSI Patches
Cc: jun.nakajima@intel.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Monday, August 11, 2003, Greg wrote:
>> There are two types of MSI capable devices: one supports the MSI 
>> capability structure and other supports the MSI-X capability structure.
>> The patches provide two APIs msix_alloc_vectors/msix_free_vectors for 
>> only devices, which support the MSI-X capability structure, to request
>> for additional messages. By default, each MSI/MSI-X capable device 
>> function is allocated with one vector for below reasons:
>> - To achieve a backward compatibility with existing drivers if possible.
>> - Due to the current implementation of vector assignment, all devices 
>>   that support the MSI-capability structure work with no more than one 
>>   allocated vector.
>> - The hardware devices, which support the MSI-X capability structure, 
>>   may indicate the maximum capable number of vectors supported (32 
>>   vectors as example). However, the device drivers may require only 
>>   four. With provided APIs, the optimization of MSI vector allocation 
>>   is achievable.
>> 
>> The existing driver is required to be modified if and only if its
>> hardware/software synchronization is not provided; that means, the 
>> hardware device may generate multiple messages from the same vector. 
>> These messages may be lost; the results may be unpredictable. To 
>> overcome this issue, the existing driver driver requires to provide 
>> the hardware/software synchronization to ask its hardware device to 
>> generate one message at a time.

>Ok, that makes a little more sense.  I'm guessing that new hardware will
>need to have their drivers modified to support this if it is needed.

Agree. Sorry for responding late to your comments. Also, I rearrange your
other comments below.

>> In summary, there are two options provided:
>> Option 1: Enable MSI on all MSI capable devices by default and use boot
>> parameter "device_nomsi=" to disable specific devices, which have bugs 
>> in MSI.

>Ok, that's almost acceptable.  How about fixing the bugs in MSI so this
>is not needed?  :)

Agree. Boot parameters "device_nomsi=" will be no longer needed finally.
It is IHVs' responsibility to fix the MSI bugs in their hardwares. 

>> Option 2 (default): Enable individual MSI capable devices as validation
>> purpose by using the boot parameter "device_msi=" to select which 
>> devices the kernel supports MSI.

>Ick.  How do you specify which "device" this option pertains to?  Do I
>have to know the pci id?  What about pci hotplug boxes which decide to
>re-arrange the pci ids every other time the box boots (yeah, I've seen
>this, no fun...)

The boot parameter "device_msi=" requires device ID and vendor ID as
mentioned in MSI-HOWTO.txt. I agree that this is no fun... because users
may not know the device ID and vendor ID of the hardware device. Like boot
parameter "device_nomsi=", "device_msi=" will be no longer needed finally.
It is IHVs' responsibility to fix the MSI bugs in their hardwares. 

Based on your comments, we reconstruct the kernel config parameters as
below. Option 1 & 2 as described above are provided only if 
CONFIG_MSI_DEBUG is set to 'Y'. This provides IHVs options to debug their
buggy hardware devices. Depending on how many MSI capable devices 
populated on their system, either option 1 or 2 can be selected to help
them to debug their own hardwares. 
Please let me know what you think...

CONFIG_PCI_USE_VECTOR	==> This implies to vector base enabled or not. 
			    If this is enabled, then MSI is also enabled by 
			    default to all MSI capable devices when MSI 
			    patch is installed along with vector base patch.
	CONFIG_MSI_DEBUG==> This implies when MSI patch is installed. By 
			    default, it is set to 'N'. This provides IHVs' 
			    option to debug their buggy hardwares. If this 
			    option is set, then MSI code handles boot 
			    parameters "device_nomsi="/"device_msi=" 
			    accordingly. Otherwise, the patch ignores
			    "device_nomsi="/"device_msi=". 

>How about (if MSI is so troublesome), we just disable MSI all the time,
>and provide a sysfs file for MSI to be "enabled" for every device if it
>is wanted?  The init scripts could go and enable this as needed.  But
>I'm guessing that you can't switch interrupt modes in a device after it
>has been initialized, right?  Oh well...

Enabling MSI on an MSI capable device is done during PCI bus enumeration.
A sysfs file does not provide any benefits during system boot. Second
reason is as mentioned above it is IHVs' responsibility to fix the MSI 
bugs in their hardwares.
Yes, you can't switch interrupt modes after it has been initialized. 

>> Note that if this option is chosen, 
>> then the use of "device_nomsi" id no longer necessary. This is by 
>> default because users may not know how many MSI capable devices 
>> populated in their systems and how many of these have bugs in MSI.
>> 
>> Either one of these options is chosen, I do not think you have any 
>> issue of hot-adding the 33 MSI capable device.

So then there is no limit on the number of MSI devices if
CONFIG_PCI_MSI_ON_SPECIFIC_DEVICES is not selected?
Yes, there is no limit on the number of MSI devices if 
CONFIG_PCI_MSI_ON_SPECIFIC_DEVICES is not selected. This will also be
removed finally. 

>> > +u32 device_nomsi_list[DRIVER_NOMSI_MAX] = {0, };
>> 
>> >Shouldn't this be static?
>> 
>> > +u32 device_msi_list[DRIVER_NOMSI_MAX] = {0, };
>> 
>> >Same with this one?
>> 
>> In the initial design draft, I am thinking of defining
>> DRIVER_NOMSI_MAX as 32 since it may be impossible to have more than 32
>> MSI capable devices populated in the same system. I will add some
>> comments to it and look forward for your comments.
>>
> Um, I ment the variable is in the global symbol table, and it doesn't
> look like it needs to be.

Agree.

> But your comment about number of devices is also a good one.  Any way
> we can figure that out at run-time too? What happens when I hot-add 
> the 33 MSI capable device?  Or just boot with that many devices (I've 
> seen boxes with 100s of pci devices all attached to one system)?

I agree that processing data from boot parameter "device_nomsi=" can be done
at run-time during system boot, but not in the hot plug environment. Anyway,
this will be removed finally as mentioned above.

>> The defined variable DRIVER_NOMSI_MAX in device_msi_list[] and 
>> device_nomsi_list[] are used to serve mainly as debug purposes since 
>> most IHVs have not yet validated their hardware devices.

> Heh, but what if I have 33 of the same kind of card in a machine (and
> that card has already been "validated")?

The same kind of cards have the same vendor ID and device ID. If that card
has already been validated, leave CONFIG_PCI_MSI_ON_SPECIFIC_DEVICES to its
default 'N'. As mentioned above, the final patches will enable MSI to all
MSI capable devices automatically. All debug parameters are removed. It 
is IHVs' responsibility to fix the MSI bugs in their hardwares. 

>> If one of the system has more than 32 MSI capable devices, users can
>> enable MSI on all devices by default (by setting
>> CONFIG_PCI_MSI_ON_SPECIFIC_DEVICES to 'n') and use boot parameter
>> "device_nomsi=" to disable some devices, which have bugs in MSI.

>Ugh, I'm trying to get across the point that a user does _not_ want to
>have to reconfig their kernel.  Distros do not want to ship a whole
>different kernel just for this one option.  That's not acceptable if we
>can handle everything dynamically with no problems for the small boxes
>as well as the big ones.

Agree. The final patches will not provide any boot parameters. It is 
IHVs' responsibility to fix the MSI bugs in their hardwares.


Thanks,
Long
