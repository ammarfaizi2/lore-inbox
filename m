Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315162AbSFDQa1>; Tue, 4 Jun 2002 12:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315191AbSFDQaD>; Tue, 4 Jun 2002 12:30:03 -0400
Received: from air-2.osdl.org ([65.201.151.6]:32902 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S315178AbSFDQ3Q>;
	Tue, 4 Jun 2002 12:29:16 -0400
Date: Tue, 4 Jun 2002 09:25:19 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: <linux-kernel@vger.kernel.org>
Subject: device model documentation 3/3
Message-ID: <Pine.LNX.4.33.0206040922310.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Docuemnt 3: binding.txt


Driver Binding

Driver binding is the process of associating a device with a device
driver that can control it. Bus drivers have typically handled this
because there have been bus-specific structures to represent the
devices and the drivers. With generic device and device driver
structures, most of the binding can take place using generic common
code.


The bus type structure contains a list of all devices that on that bus
type in the system. When device_register is called for a device, it is
inserted into the end of this list. The bus object also contains a
list of all drivers of that bus type. When driver_register is called
for a driver, it is inserted into the end of this list.

There are two events which trigger driver binding: when a new device
is added and when a new driver is added. When a new device is added,
the bus's list of drivers is iterated over to find one that supports
it. In order to determine that, the device ID of the device must match
one of the device IDs that the driver supports. The format and
semantics for comparing IDs is bus-specific. Instead of trying to
derive a complex state machine and matching algorithm, it is up to the
bus driver to provide a callback to compare a device against the IDs
of a driver. The bus returns 1 if a match was found; 0 otherwise.

int bind(struct device * dev, struct device_driver * drv);

If a match is found, the device's driver field is set to the driver
and the driver's probe callback is called. This gives the driver a
chance to verify that it really does support the hardware, and that
it's in a working state. 

The device is inserted into the driver's list of devices it supports. A
symlink is created in the driver's directory for the device that points to
its physical location. (Not implemented yet)


The process is almost identical for when a new driver is added. 
The bus's list of devices is iterated over to find a match. Devices
that already have a driver are skipped. All the devices are iterated
over, to bind as many devices as possible to the driver.


When a device is removed, the reference count for it will eventually
go to 0. When it does, the remove callback of the driver is called. It
is removed from the driver's list of devices and the reference count
of the driver is decremented. All symlinks between the two are removed.

When a driver is removed, the list of devices that it supports is
iterated over, and the driver's remove callback is called for each
one. The device is removed from that list and the symlinks removed. 



