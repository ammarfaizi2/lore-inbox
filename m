Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317058AbSHOOuo>; Thu, 15 Aug 2002 10:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317063AbSHOOuo>; Thu, 15 Aug 2002 10:50:44 -0400
Received: from imo-d07.mx.aol.com ([205.188.157.39]:31139 "EHLO
	imo-d07.mx.aol.com") by vger.kernel.org with ESMTP
	id <S317058AbSHOOum>; Thu, 15 Aug 2002 10:50:42 -0400
Message-ID: <3D5B8923.9000609@netscape.net>
Date: Thu, 15 Aug 2002 10:57:39 +0000
From: Adam Belay <ambx1@netscape.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: driverfs: [PATCH] remove bus and improve driver management (2.5.30)
References: <3D5AD6BF.8060609@netscape.net> <20020815050419.GB30226@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: Unknown (No Version)
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



greg@kroah.com wrote:

>Hi,
>
>On Wed, Aug 14, 2002 at 10:16:31PM +0000, Adam Belay wrote:
>
>>   This patch removes bus.c from the Driver Model and replaces it with 
>>a more advanced and scaleable driver subsystem.  
>>
>
>Hm, I'm a bit slow, but even with your second drawings, I still don't
>understand this.  Can you add | and - lines to the drawing, it would
>help me understand what you are trying to show here.
>
Sorry about the confusing diagram, I'll just write out paths.  3rd time 
is a charm.

my old driver tree:
/driverfs/bus
/driverfs/bus/pci
/driverfs/bus/pci/drivers/agpgart
/driverfs/bus/pci/drivers/cardbus
/driverfs/bus/pci/drivers/parport_pc
/driverfs/bus/usb
my new tree now:
/driverfs/driver/
/driverfs/driver/pci
/driverfs/driver/pci/agpgart
/driverfs/driver/pci/cardbus
/driverfs/driver/pci/parport_pc

a possibility for my tree when drivers that need it convert to my 
changes  and the driver model in general:
/driverfs/driver/
/driverfs/driver/pci
/driverfs/driver/pci/agpgart
/driverfs/driver/pci/cardbus
/driverfs/driver/pci/parport_pc
/driverfs/driver/pci/parport_pc/lp
/driverfs/driver/pci/usb
/driverfs/driver/pci/usb/hid

* I am not saying that usb has to be done this way but if you notice in 
the first diagram (the old implementation) usb does not have any driver 
representation with pci or if it does it is not displayed.  The lp 
driver is significant because it is imposible to cleanly implement 3 
levels of drivers in the current Driver Model.

>
>
>>   Notice that this implementation not only solves the problems listed 
>>earlier but also it is more scalable because it lists the drivers by 
>>thier true relationship to one another.  These changes actually reduce 
>>the total amount of code as well as the complexity of the entire system 
>>resulting in better efficiency and perhaps even less memory consumption.
>>
>
>But what's the problem you are trying to solve?  How the devices
>interact in the global device tree?  That's already shown properly.  Or
>am I missing something here?
>
    As you can now see in my new diagrams the problem I am trying to 
solve is not how devices are represented but rather how drivers are 
represented.  Sorry I wasn't clear.  I have completely removed bus and 
replaced it with a driver interface.  This is better because a bus does 
not deserve special implementations as it is a driver too.  My more 
scaleable interface can handle both buses and drivers.

>
>
>>   `This patch also provides user level driver management support 
>>through the advanced features of the new interface.  It creates a file 
>>entry named "driver" for each device.
>>To attach a driver simply echo the name of the driver you want to 
>>attach.  For example:
>>#cd ./root/pci0/00:00.0
>>#echo "agpgart" > driver
>>
>
>Hm, how does this bind the driver to the device?  What if the driver
>doesn't want to bind to this device?  And how does userspace know what
>pci device to bind to what driver?  Does it use the information in the
>modules.*map file?  If so, that comes directly from the drivers
>themselves, which are the ones knowing what devices they _should_ be
>bound to, so why not let the driver themselves do the work (well
>actually the very small function at
>drivers/pci/pci-driver.c:pci_match_device() does the work).
>
This feature is well designed, if a driver doesn't want to bind to the 
device the request will fail.  Check the code yourself.  This is simply 
a userspace override for the Driver Model.  This is useful because it 
provides the user with more control over driver management.  If two 
drivers can support the same device and the driver model selects one the 
user doesn't want to use the user can change it.  This could even happen 
now with ALSA and Open Sound.  Since it calls both probe and match it is 
also a great debugging tool.  I'm currently working on a user level 
utility that will take full advantage of this and other driver 
management features.

>
>
>>To remove a driver simply echo remove to the driver file while a driver 
>>is loaded.  For example:
>>#echo "remove" > driver
>>
>
>Again, why?  And does this force the ->remove() function to be called?
>
Yes this does call ->remove() among other things.  In fact it calls 
do_driver_detach.
Why is above.

>
>
>>If you read the driver file you will get the name of the loaded driver 
>>if a driver is loaded.  For example:
>>#cat driver
>>output: agpgart
>>
>
>Now this is a nice idea.  But I was thinking of moving the symlink from
>the bus/pci/devices to be under the specific driver in
>bus/pci/drivers/foo_driver.  That would show you at a simple glance
>which driver is bound to which device.  But putting the name in the
>device entry in the /root tree would be good enough too.
>
There are many ways to go about it.  I even left in a few extra 
fucntions in fs.c for other options.  The question is what's the best 
way to do it?

>
>
>>This patch is against 2.5.30.  The following still needs to be done:
>>1.) port to 2.5.31
>>
>
>Watch out, there are lots of driver model changes already in Linus's
>tree (post 2.5.31.)
>
:-(

If you have any questions feel free to ask.

Thanks,
Adam



