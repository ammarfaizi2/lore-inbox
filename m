Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261621AbSJQBpL>; Wed, 16 Oct 2002 21:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261622AbSJQBpK>; Wed, 16 Oct 2002 21:45:10 -0400
Received: from h-64-105-35-139.SNVACAID.covad.net ([64.105.35.139]:30337 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261621AbSJQBpG>; Wed, 16 Oct 2002 21:45:06 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 16 Oct 2002 18:50:44 -0700
Message-Id: <200210170150.SAA06074@adam.yggdrasil.com>
To: ebiederm@xmission.com
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
Cc: eblade@blackmagik.dynup.net, linux-kernel@vger.kernel.org, mochel@osdl.org,
       rmk@arm.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Beiderman wrote:
>[snip details on a lot of hot plug code]
>
>No major comment except that I know for compact pci you can just
>walk up and unplug it.  As we have several compact pci boards here
>at work.
>
>But thank you for the clarification that a only on badly designed
>hardware a newly plugged in device will

	From the previously referenced MindShare book, it looks like
CompactPCI has pins of different lengths to ensure that the interrupt
indicating card removal will never later than the other contacts being
broken, to avoid races in code like this:

		control = inb(dev->base + CONTROL_PORT);
		data = inb(dev->base + CONTROL_PORT);
		if (dev->was_removed)
			return -ENODEV;
		...

static void remove_interrupt(struct device *dev)
{
	dev->was_removed = 1;
	unref_hardware(dev);
}
static inline void unref_hardware(struct device *dev)
{
	/* hw_ref_count is:
		- set 1 when driver is attached
		- incremented when a device or network interface is opened
		- decremented when a device or network interface is closed
		- decremented when hardware is removed or driver is detached
	*/
	if (atomic_dec(&dev->hw_ref_count))
		(*dev->driver->removed)(dev);
}


>> 	Besides, you have not identified a safe way that a combined
>> ->remove() function can detect such situations more reliably than
>> separate ->quiet() and ->removed(), which at least have the benefit of
>> knowing what the kernel currently thinks the situation is.  So, you
>> really have no basis for saying "Splitting ->remove() into quiet() and
>> ->removed() will be racy."

>O.k. Let me attempt a clarification, of what I was thinking.
>Currently pseudo code for remove does:

>remove() {
>	if (device_present()) {
		XXXXXXXXXXXX
>		device_be_quiet()
>	}
>	device_free(device_strucutres);
>}

	The device could still be removed where I put the "XXXXXXXXXX"
or in the midst of device_be_quiet().  You appear to be trying to
narrow the window of vulnerability because you apparently don't know
how to eliminate it.  That's fine if you cannot eliminate it, but, for
almost all if not all busses designed for hot plugging I believe you
can eliminate it entirely.

	You should not just be bracketing code that attempts
transactions with a device inside of a test of the device's presence.
Instead, you should look understand the behavior that occurs when
device is gone and program for that.  For example, if removal of a
device that is mapped to IO and memory space (PCMCIA, PCI, etc.) an
initial notification interrupt followed by writes to the previously
mapped areas being ignored and reads returning garbage, then you can
write code like:

static int foodev_send(struct foodev *dev, dma_addr_t ptr, int len)
{
	outl(dev->dma_addr, ptr);
	outl(dev->send_len, len);
	outw(dev->control_port, GET_READY_TO_SEND);
	/* Notice we did not check if the device is present until now. */
	return (dev->device.is_removed) ? -ENODEV : 0;
}

	In general, as long as you know that the addresses that your
driver is using will not be reassigned until your driver releases
them, you can do operations and just be prepared to handle the defined
error that occurs when you send do a transaction to a non-existant
device.  The driver typically only has to check for the device's
presence for things like taking some externally visible action or is
in some kind of wait loop awaiting an event that won't occur if the
device has been removed.  This is true device not mapped to the memory
and IO busses as well, such as USB, FireWire or SCSI (SCSI devices
that support hot plugging have assignable addresses).


>The way I imagined the split up:
>if (device->present()) {
>        device->be_quiet();
>}
>device->free_resources();


	device->present() is usually not specific to a device, but
rather to the parent bus, and that usually involves just checking the
internal information that it already has as to whether it has received
some kind of interrupt.  More importantly, the generators of requests
to power down a device and notification that the device is removed are
usually separate and they usually one want one of those functions.
There is really very little reason to group them into the same
function.  Typically, the callers will look like this:


void
foobus_interrupt(void *arg;)
{
	struct foobus *foobus = arg;
	event = inb(foobus_intr_register) & EVENT_MASK;
	arg = inb(foobus_slow_register);
	switch(event) {
		case FOOBUS_REMOVE:
			slot = arg & SLOT_MASK;
			unref_hardware(foobus->devs[slot]);
			break;
		...
	}
	outb(foobus_intr_acknlowledge, 1);
}

foobus_powerdown(usb_device *dev)
{
	(*dev->device->driver->quiet)(dev);
}

>Doing device_be_quiet() without the device_present() check is racy,
>because devices can be physically removed at arbitrary times.

	Your code definitely is racy.  I can see how to write these
things without races, which is something that I don't think you really
understand.

	Engineers think about these things when they design busses for
hot plugging.  I notice that programmers often have trouble really
grasping that other people might be much better than them in a
particular skill area.  Here I think you are really assuming a too low
of a competence level among those who design these busses.  I'm not
asking you to assume no mistakes have been made in the support of hot
plugging in these busses, but it's clear that you're assuming that
obvious mistakes have been made, and that assumption doesn't check
out.  If you think there is a race in a particular bus, show me a
clear example.


[...]
>I cannot imagine freeing data structures will noticeably slow a reboot
>down, so unless we actually need to tell a device to be quiet for
>other reasons besides driver removal, and machine reboot I do not see
>a point in adding complexity by changing the interface.

	Changing the interface will reduce complexity as only the code
that needs to be executed will be called.  Since your current
->remove() function can potentially do blocking IO to turn off a
device, it can potentially take a long time.  Also, you apparently
did not read this part of my previous message to Eric Blade in this thread:

|	1. When something has gone wrong with a device driver, you generally
|	   gather what information you can and then try a warm reboot,
|	   especially when one is working remotely.  Data structures in
|	   device drivers can often corrupted under these circumstances.
|	   So it is important that warm reboots reboot the system as
|	   simply as they can with reliability.  That means only executing
|	   the special shutdown code that really needs to be executed.
|
|	2. For small platforms, I can about keeping the __devexit code out
|	   of the kernel footprint.  I don't want Linux to lose the
|	   competition small embedded devices (grated such decisions do not
|	   pivot on __devexit alone, but a cultrue of wastefulness leads
|	   creates bloat in steps such like this one).
|
|	3. I do care that reboot goes fast.  Optimizations for speed and
|	   space generally come about by making lots of little clean ups.
|	   The standard power on self-test takes ages on most PCs, but
|	   it doesn't have to be that way, and it isn't necessarily that
|	   way on other platforms.  I'd linux not to be an impedement
|	   to having systems where you don't even see the screen go black
|	   when you reboot.


>There may be
>a valid argument in the suspend to swap case, but I will cross that
>bridge when i come to it. 

>For my thinking on how this should be handled:

>Except in some very select special instances, I do not know
>of a single device where it is safe to assume the hardware is in a
>sane state at any random given moment when we decide to reboot.

	I don't know what you mean by "sane state."  If you mean that
it's in a state that the reboot code can handle, I think almost all
hardware typically is.  If that were not the case, warm reboots from
2.4.x would not work.

[...]
>For 2.5 calling remove on reboot may not fix any issues, but it is
>certainly a correct thing to do.

	Here you go again, trying to make a circular argument by
arguing a definition of "correct" instead of show concrete advantages.
You're just wasting your time and any other reader's when you do that.

>And even if it does not fix issues
>today, it allows bugs to be fixed, as the come up.  And it allows
>the code to be tested by just doing a modular build and inserting
>and removing the module.

	You are confused.  I never said that the module removal code
should not quiet the hardware that it is talking to.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
`h
