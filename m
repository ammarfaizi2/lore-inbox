Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263138AbVF3UfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263138AbVF3UfW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 16:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263127AbVF3UfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 16:35:10 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:15829 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S263131AbVF3Ubq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 16:31:46 -0400
Message-ID: <42C456B0.6010706@free.fr>
Date: Thu, 30 Jun 2005 22:31:44 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: device_remove_file and disconnect
References: <42C2D354.6060607@free.fr> <20050629184621.GA28447@kroah.com> <42C301F7.4010309@free.fr> <20050629224235.GC18462@kroah.com> <20050630072643.GA14703@mut38-1-82-67-62-65.fbx.proxad.net> <20050630170406.GA11334@kroah.com>
In-Reply-To: <20050630170406.GA11334@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Greg KH wrote:

>>>>Ok, but if we unplug a device, then disconnect will be called even if we 
>>>>opened a sysfs file.
>>>
>>>Yes but the device structure will still be in memory, so you will be ok.
>>>
>>
>>disconnect method isn't supposed to clear the device structure in memory ?
> 
> 
> It all depends on the bus you are talking about :)
> 
> 
usb, but should be for all bus that accept a hot remove of the device...
>>>>Couldn't be a race between the moment we read our private data and check 
>>>>it is valid and the moment we use it :
>>>>
>>>>Process A (read/write sysfs file) 		Process B (disconnect)
>>>>recover our private data from struct device
>>>>check it is valid
>>>>						free our private data
>>>>do operation on private data
>>>
>>>No, you should not be freeing your private data on your own.  You should
>>>do that in the device release function.
>>
>>But that's what I do !
> 
> 
> What type of driver?
> 
> 
a driver for an usb modem.
>>I free it in  device release function = usb_disconnect in my case =
>>Process B. Process A is call by sysfs and don't seem serialized with
>>Process B.
>>Is there another place where I could free my private data later : I don't
>>think so.
> 
> 
> For usb, no, you are correct.  I was referring to the driver core when
> you were mentioning the sysfs stuff, sorry.
> 
> Hm, in thinking about it, it might make more sense to rework the usb
> core to handle this better.  Possibly add a release() callback to the
> driver when the device is actually being freed.  Wouldn't be that hard
> to do so, and might cut down on some of the common locking errors.
> 
> 
So a diconnect when the device is removed and a released when the 
resource counter reach 0 ?


>>I believe some drivers expected that sysfs read/write callback are always
>>called when the device is plugged so they don't check if
>>to_usb_interface/usb_get_intfdata return valid pointer.
> 
> 
> Then they should be fixed.  Any specific examples?
> 
> 
I am a little lasy to list all, but some drivers in driver/usb should 
have this problem : the first driver I look : ./misc/phidgetkit.c do 
[1]. So sysfs read don't check if to_usb_interface or usb_get_intfdata 
return NULL pointer...
And it is a bit your fault, as many developper should have read your 
great tutorial [2] ;)

>>Also I always see driver free their privatre data in device disconnect,
>>so if read/write from sysfs aren't serialized with device disconnect
>>there are still a possible race like I show in my example.
> 
> 
> Yes, you are correct.  Again, any specific drivers you see with this
> problem?
I believe near all drivers that use sysfs via device_create_file, as I 
never see them use mutex in read/write in order to check there aren't in 
the same time in their disconnect that could free there private data 
when they do operation on it...


Couldn't be possible the make device_remove_file blocking until all the 
open file are closed ?

thanks,

Matthieu

[1]
#define show_input(value)       \
static ssize_t show_input##value(struct device *dev, char *buf) \
{                                                                       \
         struct usb_interface *intf = to_usb_interface(dev);             \
         struct phidget_interfacekit *kit = usb_get_intfdata(intf);      \
                                                                         \
         return sprintf(buf, "%d\n", kit->inputs[value - 1]);            \
}                                                                       \
static DEVICE_ATTR(input##value, S_IRUGO, show_input##value, NULL);

[2] http://www.linuxjournal.com/article/7353
