Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318851AbSHETLx>; Mon, 5 Aug 2002 15:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318850AbSHETLv>; Mon, 5 Aug 2002 15:11:51 -0400
Received: from air-2.osdl.org ([65.172.181.6]:6058 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S318847AbSHETLm>;
	Mon, 5 Aug 2002 15:11:42 -0400
Date: Mon, 5 Aug 2002 12:17:13 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: linux-kernel@vger.kernel.org
Subject: driverfs API Updates
Message-ID: <Pine.LNX.4.44.0208051216090.1241-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A series of driverfs changes went into Linus' tree last Friday. This is a 
short summary of those changes, and some notes on how to use them. 

Firstly, I changed the name of the structure that must be declared
from struct driver_file_entry to struct device_attribute. This more
accurately represents what is going on. 


I've also created a macro[1] for defining device attributes, that goes
like this:

DEVICE_ATTR(name,"strname",mode,show,store);

This will create a structure by the name of 'dev_attr_##name', where
##name is the first parameter, which can then be passed to
device_create_file(). [2]


The definition of device_remove_file has changed to:

void device_remove_file(struct device * dev, struct device_attribute * 
attr);

(The second parameter is now the same type as what is passed to
device_create_file, for consistency's sake (instead of a char *)).


I've added support for bus and device driver attributes. The mechanism
for manipulating them is analogous to that of device attributes. To
declare them, you do:

BUS_ATTR(name,"strname",mode,show,store);
DRIVER_ATTR(name,"strname",mode,show,store);

which create the objects 

struct bus_attribute bus_attr_##name;

and 

struct driver_attribute driver_attr_##name;

respectively.

You can then use 

int bus_create_file(struct bus_type *, struct bus_attribute *);
void bus_remove_file(struct bus_type *, struct bus_attribute *);

int driver_create_file(struct device_driver *, struct driver_attribute *);
void driver_remove_file(struct device_driver *, struct driver_attribute 
*);

To add and remove them.

Bus attribute files appear in the bus's directory (bus/<bus>/ under
the driverfs mountpoint).

Driver attributes appear in the driver's directory
(bus/<bus>/<driver>/ under the driverfs mountpoint).


The bus show and store routines are identical to the device show and
store routines, though they take a pointer of type struct bus_type as
the first parameter.

Similarly for drivers; they take a struct device_driver * as the first
parameter. 

Please see include/linux/device.h for the structure definitions, and
drivers/base/fs/*.c for implementation details. 


driverfs now has the ability to support attributes for any object
type. I've updated the documentation
(Documentation/filesystems/driverfs.txt) to hopefully include enough
information to hack on it. I'm also open to all questions and
suggestions, so please feel free to ask. 



Thanks,

	-pat




[1]: The reason for the macro is because the driverfs internals
have changed enough to be able to support attributes of any type. In
order to do this in a type-safe manner, we have a generic object type
(struct attribute) that we use. We pass this to an intermediate layer
that does a container_of() on that object to obtain the specific
attribute type. 

This means the specific attribute types have an embedded struct
attribute in them, making the initializers kinda ugly. I played with
anonymous structs and unions to have something that could
theoretically work, but they apparently don't like named
initializers. 


[2]: I wanted to consolidate the first two parameters, but I couldn't
find a way to stringify ##name (or un-stringify "strname"). Is that
even possible? 

