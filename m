Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265998AbSLST3j>; Thu, 19 Dec 2002 14:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266038AbSLST3j>; Thu, 19 Dec 2002 14:29:39 -0500
Received: from h-64-105-34-78.SNVACAID.covad.net ([64.105.34.78]:41164 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265998AbSLST3h>; Thu, 19 Dec 2002 14:29:37 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 19 Dec 2002 11:36:10 -0800
Message-Id: <200212191936.LAA06204@adam.yggdrasil.com>
To: mochel@osdl.org
Subject: RFC: bus_type and device_class merge (or partial merge)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	If there is a more specific mailing list than lkml for discussing
the generic driver model, please feel free to redirect me.

	I'm thinking about trying to embed struct device_class into
struct bus_type or perhaps just eliminate the separate struct
bus_type.  The two structures are almost identical, especially
considering that device_class.devnum appears not to be used by
anything.

struct bus_type {
	char			* name;

	struct subsystem	subsys;
	struct subsystem	drvsubsys;
	struct subsystem	devsubsys;
	struct list_head	devices;
	struct list_head	drivers;

	int		(*match)(struct device * dev, struct device_driver * drv);
	struct device * (*add)	(struct device * parent, char * bus_id);
	int		(*hotplug) (struct device *dev, char **envp, 
				    int num_envp, char *buffer, int buffer_size);
};

struct device_class {
	char			* name;
	u32			devnum;

	struct subsystem	subsys;
	struct subsystem	devsubsys;
	struct subsystem	drvsubsys;
	struct list_head	drivers;
	struct list_head	devices;

	int	(*add_device)(struct device *);
	void	(*remove_device)(struct device *);
	int	(*hotplug)(struct device *dev, char **envp, 
			   int num_envp, char *buffer, int buffer_size);
};


	At first appearance, a bus_type (PCI, USB, etc.) and a
device_class (network devices, input, block devices), may seem like
opposite ends of the device driver abstraction, but really I think
these are basically the same, and, more importantly, there can be many
layers of these interfaces, and the decision about which are bus_types
and which are device_classes is causing unnecessary coplexity.  For
example, SCSI defines both.  SCSI can be a hardware bus, bus it also
needs device_class so that scsi_debug (and eventually scsi generic) can
use the struct interface mechanism.

	If you look at the five places where a struct device_class is
actually defined in 2.5.52, you'll see that either the device_class is
not referenced by anything else or it has no bus type.  So, there
seems to be little use of the distinction.

device_class variable   Referenced elsewhere?           bus_type?

cpu_devclass            No                              system_bus_type
memblk_devclass         No                              system_bus_type
node_devclass           No                              system_bus_type
input_devclass          Yes (mousedev, tsdev)           (None)
shost_devclass          Yes (scsi_debug)                (None)


	Also, merging device_class and bus_type could also enable a
little more consolidation between struct device_interface and struct
device_driver (as with device_class.devnum, device_interface.devnum
does not appear to be used currently).

	Anyhow, I think this could shrink the drivers/base a bit and
make it slightly more understandable.  I'd be interested in knowing if
anyone else is contemplating or developing this or wants to point out
issues to watch out for.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
