Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262075AbSIYTXy>; Wed, 25 Sep 2002 15:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262077AbSIYTXy>; Wed, 25 Sep 2002 15:23:54 -0400
Received: from ausadmmsrr502.aus.amer.dell.com ([143.166.83.89]:57101 "HELO
	AUSADMMSRR502.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S262075AbSIYTXx>; Wed, 25 Sep 2002 15:23:53 -0400
X-Server-Uuid: 586817ae-3c88-41be-85af-53e6e1fe1fc5
Message-ID: <20BF5713E14D5B48AA289F72BD372D68C1E8BD@AUSXMPC122.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: mochel@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: devicefs requests
Date: Wed, 25 Sep 2002 14:28:57 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 118CD10A832079-02-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pat,

1)  As new drivers pick up the model, check that all xxx_bus_type objects
get EXPORT_SYMBOLd and included in a include/xxxx header somewhere - My BIOS
EDD code walks the list of bus types looking for attached devices to compare
against (pci, ide, scsi, usb, ...).
ide_bus_type is in include/linux/ide.h but isn't EXPORT_SYMBOL;
usb_bus_type is in include/linux/usb.h but isn't EXPORT_SYMBOL;

Alternately, keep the list of registered bus types accessible via a
list_for_each type macro.  I like the exported symbols myself, it lets me
do:

struct edd_known_bus_types_s {
	struct bus_type *bus;
	const char *edd_type;
	int (*match)(struct device *edd_dev, struct device *dev);
};

static const struct edd_known_bus_types_s edd_known_bus_types[] = {
	{bus:&scsi_driverfs_bus_type, edd_type: "SCSI", match:
edd_match_scsidev},
//	{bus:&ide_bus_type,           edd_type: "ATA",  match: NULL},
//	{bus:&usb_bus_type,           edd_type: "USB",  match: NULL},
	{bus:NULL,                    edd_type: NULL,   match: NULL},
};

so I can supply my own match functions which match one type of device (e.g.
EDD's idea of a SCSI device) to that of the standard device.  I could
accomplish the same using well-known names for bus_type I suppose, and doing
a list_for_each until I find it.  Just a different thing getting exported, a
well-known name and a lookup method rather than the symbol itself.


2) bus_for_each_dev() is really restrictive right now due to all the locking
mechanisms in place.  In my code I'd like to, given a struct device *, walk
a list of devices on a given bus and compare each device with the given
device, returning a match, or not.  As it stands, bus_for_each_dev returns
either success (the callback worked for each device on the list), or failure
(the callback failed for some device on the list), but I don't see a
mechanism to return which device failed without excessive abuse of the
void*.  For now I've made a private copy of bus_for_each_dev which I've
mucked with the return the properly matching device, and wonder if this
couldn't be made more generic somehow.

Thoughts?

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

