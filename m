Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274920AbRJRMNP>; Thu, 18 Oct 2001 08:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274972AbRJRMNG>; Thu, 18 Oct 2001 08:13:06 -0400
Received: from s2.relay.oleane.net ([195.25.12.49]:53007 "HELO
	s2.relay.oleane.net") by vger.kernel.org with SMTP
	id <S274920AbRJRMM4>; Thu, 18 Oct 2001 08:12:56 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Patrick Mochel <mochelp@infinity.powertie.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] New Driver Model for 2.5
Date: Thu, 18 Oct 2001 14:13:18 +0200
Message-Id: <20011018121318.17949@smtp.adsl.oleane.com>
In-Reply-To: <3BCE7568.1DAB9FF0@mandrakesoft.com>
In-Reply-To: <3BCE7568.1DAB9FF0@mandrakesoft.com>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 
>> struct device {
>>         struct list_head        bus_list;
>>         struct io_bus           *parent;
>>         struct io_bus           *subordinate;
>> 
>>         char                    name[DEVICE_NAME_SIZE];
>>         char                    bus_id[BUS_ID_SIZE];
>> 
>>         struct dentry           *dentry;
>>         struct list_head        files;
>> 
>>         struct  semaphore       lock;
>> 
>>         struct device_driver    *driver;
>>         void                    *driver_data;
>>         void                    *platform_data;
>> 
>>         u32                     current_state;
>>         unsigned char           *saved_state;
>> };

Hi Patrick ! Nice to see this happening ;)

I would add to the generic structure device, a "uuid" string field.
This field would contain a "munged" unique identifier composed of
the bus type followed which whatever bus-specific unique ID is
provided by the driver. If the driver don't provide one, it defaults
to a copy of the busID.

What I have in mind here is to have a common place to look for the
best possible unique identification for a device. Typical example are
ieee1394 hard disks which do have a unique ID, and so can be properly
tracked between insertion removal.

Also, I'd like to see a simple ability for the arch code to add
entries to the exposed device filesystem nodes. The main reason for
this is that on machines like PPC with OpenFirmware or Sun with
OpenBoot, it makes a lot of sense (and is very useful for bootloader
configuration among others) to be able to know the firmware "path"
corresponding to a given device. On PPC, the generic PCI code can
do the convertion between an Open Firmware device node an a PCI
device in the kernel, but doing so from userland is a lot more
tricky. The device filesystem is a very good way to fix that problem
once for all.

>The preferred way of doing things (IMHO) is to do some simply sanity
>checking of the h/w device at probe time, and then perform lots of
>initialization and such at device/interface open time.  You ideally want
>a device driver lifecycle to look like
>
>probe:
>	register interface
>	sanity check h/w to make sure it's there and alive
>	stop DMA/interrupts/etc., just in case
>	start timer to powerdown h/w in N seconds
>
>dev_open:
>	wake up device, if necessary
>	init device
>
>dev_close:
>	stop DMA/interrupts/etc.

I completely agree there as well. In some case, the suspend (or powerdown)
of the device can even be triggered on an open device with an idle timer.
Good candidates are hard disks and sound (which is often kept open
all the  time by the userland mixer).

However, there is another important point about power management I
discovered the "hard way", which is memory allocation vs. turning
off of swapping devices (that is the swap device itself or any device
on which you may have mmap'ed files).

For "transcient" power management (that is dynamically putting a
subsystem to sleep when idle until it gets a new request), there
is no real problem provided that the driver can do the wakeup without
allocating memory.

For system power sleep, where you actually shut down everything,
the problem happens when you start shutting down those "swap" devices.
Once done, you may be in a situation where another device, to be shut
down or to wake up properly, need to allocate memory (see for example
USB devices that need to allocate urb's). This may cause requests
to swap_out which will block indefinitely if trying to swap out
pages to an already sleeping device.

I "work around" this in the PowerBook sleep code in a bit dumb way
which work in 99% of the case but is probably broken as well if you
are really near oom. Basically, instead of calling only the "suspend"
callbacks of devices, I have an additional "suspend requested"
one that is sent to every driver using my specific PM scheme _before_
starting the real round of "suspend" callbacks. Drivers that need 
a significant amount of backup memory (like some framebuffers) will
do the necessary allocations from this early callback.

Another issue with suspend and resume is with interrupt sharing and
some bad devices that unconditionally assert their interrupt line
when put to any PM state. On the contrary, some drivers, in order
to properly block any new request in it's queues and wait for any
pending one to complete, may need to operate with interrupt still
running. I discussed that a bit with Alan, and it seem that we really
need 2 rounds of "suspend" callbacks in this case (at least for
system suspend), one with interrupts still enabled, one with interrupts
disabled.

Finally, I have another need for which I'm not sure how to react
with either the current scheme or the new scheme. On "desktop"
Apple systems (at least all the recent G4 ones), the PCI bus will
be effectively powered down during system sleep. That means that
we must (at least that's what both MacOS and MacOS X do) prevent
the complete system sleep when at least one PCI slot contains a
card for which the driver can't properly restore the state after
a complete shutdown. This frequently happens, for example, with
video cards that rely on some initial chip & pll configuration
to be done by the firmware. We may be able to fallback to some 
kind of "light suspend" where we suspend any device we can but
not the motherboard, but that mean that the "main" PM code has
to know about the problem and need some way to know if a given
node in the device tree can or cannot be revived from a given
power state (in this case, we might consider beeing powered down
as equivalent to D3 state). My current solution is to not allow
system sleep at all on those desktop machines.

Regards,
Ben.


