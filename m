Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261868AbTCDEpu>; Mon, 3 Mar 2003 23:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262418AbTCDEpu>; Mon, 3 Mar 2003 23:45:50 -0500
Received: from cs2893-136.austin.rr.com ([24.28.93.136]:42738 "EHLO
	iguana.localdomain") by vger.kernel.org with ESMTP
	id <S261868AbTCDEps>; Mon, 3 Mar 2003 23:45:48 -0500
Subject: Re: Displaying/modifying PCI device id tables via sysfs
From: Matt Domsch <Matt_Domsch@dell.com>
To: Greg KH <greg@kroah.com>, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, mochel@osdl.org
In-Reply-To: <20030304003120.GB19721@kroah.com>
References: <20030303182553.GG16741@kroah.com>
	<20BF5713E14D5B48AA289F72BD372D6803945AB6-100000@AUSXMPC122.aus.amer.dell.co
	m>  <20030304003120.GB19721@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Mar 2003 22:56:15 -0600
Message-Id: <1046753776.12441.92.camel@iguana>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd like to see what your patch looks like to add this kind of support.

I don't have any code that I'm proud enough of to post quite yet, I'm
just trying to get the overall design concept right first.  Your
feedback is appreciated.

Jeff said:
> Field-replacement of PCI id tables is a todo item for a while now :)

Replacement, or addition?  I've been picturing addition, not
modification or replacement.  For modification, we would have to export
the entries via sysfs, which Greg had just convinced me I didn't need to
do. :-)

As far as the sysfs layout could go, here's what I've in mind for
simplicity sake.

/sys
`-- bus
    `-- pci
        `-- drivers
            `-- 3c59x
                |-- dynamic_id_0  (these are simple DRIVER_ATTRs)
                |-- dynamic_id_1
                |-- dynamic_id_2
                `-- new_id

Where dynamic_id_[012] are new dynamic entries, created by writing
values into new_id.  Both file types would be of the format (analogous
to pci_show_resources):
echo "0x0000 0x0000 0x0000 0x0000 0x0000 0x0000" > new_id
with fields being vendor, device, subvendor, subdevice, class,
class_mask.

To be safe, the store method for new_id should walk the static table and
the dynamic ID table, ensuring it's not creating a duplicate.

The new entries would get added to a new list in struct pci_driver, and
struct pci_id_table would grow a struct list_head so new list entries
could be easily created and added to the list.  The N in dynamic_id_N
would be a per-driver atomic_t, monotonically increasing as new IDs are
given.

It's then simple to have a script run at shutdown/startup to
save/restore IDs if desired.

The next step is to get the system to probe for devices matching the new
IDs.  Two new functions similar to pci_device_probe() and
pci_match_device() need implementing, where given a struct pci_driver
and a struct pci_device_id, it would probe.  The logic of
pci_match_device could be used with two wrappers, one to walk the static
ID table, one to match a new ID.


If you'd prefer to see this:
3c59x/
`-- dynamic_id_table
    |-- 0
    |   |-- class
    |   |-- class_mask
    |   |-- device
    |   |-- subdevice
    |   |-- subvendor
    |   `-- vendor
    `-- new_id

then there needs to be a simple way in sysfs to export an attribute
hierarchy, beneath an object in the kobject hierarchy.  Right now it's
assumed that each kobject can have multiple attributes, but all are at a
single level.  Pat, is this hard to do?


How far off base am I? :-)

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


