Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265396AbTCCRqq>; Mon, 3 Mar 2003 12:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268669AbTCCRqp>; Mon, 3 Mar 2003 12:46:45 -0500
Received: from smtp2.us.dell.com ([143.166.85.133]:4556 "EHLO
	smtp2.us.dell.com") by vger.kernel.org with ESMTP
	id <S265396AbTCCRqn>; Mon, 3 Mar 2003 12:46:43 -0500
Date: Mon, 3 Mar 2003 11:57:05 -0600 (CST)
From: Matt Domsch <Matt_Domsch@Dell.com>
X-X-Sender: mdomsch@humbolt.us.dell.com
Reply-To: Matt Domsch <Matt_Domsch@Dell.com>
To: linux-kernel@vger.kernel.org
cc: mochel@osdl.org, <greg@kroah.com>
Subject: Displaying/modifying PCI device id tables via sysfs
Message-ID: <20BF5713E14D5B48AA289F72BD372D680392F82C-100000@AUSXMPC122.aus.amer.dell.com>
X-GPG-Fingerprint: 17A4 17D0 81F5 4B5F DB1C  AEF8 21AB EEF7 92F0 FC09
X-GPG-Key: http://domsch.com/mdomsch_pub.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A lot of PCI drivers today use the pci_device_id table model to specify 
what IDs the driver supports.  I'd like to be able to do 2 things with 
this information:
1) display it in sysfs
2) Add new IDs at runtime and have the drivers probe for the new IDs.

To this end, I've started thinking about how to properly display the table 
via sysfs.  So far I've got:


/sys
|-- bus
|   |-- pci
|   |   `-- drivers
|   |       |-- 3c59x
|   |       |   `-- id_table
|   |       |-- PIIX IDE
|   |       |   `-- id_table
|   |       |-- RZ1000 IDE
|   |       |   `-- id_table
|   |       |-- aic7xxx
|   |       |   `-- id_table
|   |       |-- e100
|   |       |   `-- id_table
|   |       |-- e1000
|   |       |   `-- id_table
|   |       |-- eepro100
|   |       |   `-- id_table
|   |       `-- serial
|   |           `-- id_table


where id_table is a file that looks like:

  vendor,   device, subvendor, subdevice,    class, class_mask
00009004, ffffffff,  ffffffff,  ffffffff, 00010000,   00ffff00
00009005, ffffffff,  ffffffff,  ffffffff, 00010000,   00ffff00

Now, this isn't ideal.
a) It violates sysfs rule of one value per file
b) for drivers with lots of IDs (like 3c59x), it could be longer than
PAGE_SIZE.

So, I've thought about a directory model:


/sys
`-- bus
    `-- pci
        `-- drivers
            `-- 3c59x
                |-- dynamic_id_table
                |   |-- 0
                |   |   |-- class
                |   |   |-- class_mask
                |   |   |-- device
                |   |   |-- subdevice
                |   |   |-- subvendor
                |   |   `-- vendor
                |   `-- new_id
                `-- static_id_table
                    |-- 0
                    |   |-- class
                    |   |-- class_mask
                    |   |-- device
                    |   |-- subdevice
                    |   |-- subvendor
                    |   `-- vendor


The new_id file in the dynamic_id_table would be writable, used for
adding new IDs.

This solves a and b both, at the expense of adding two additional
directories to the hierarchy.

The current sysfs implementation doesn't cleanly handle this type of
data display however.  sysfs_create_dir() takes a kobject*, but I
don't think we want to instantiate kobjects which are simply 
groupings for attribute entries in a table, do we?

I've started down this road, but before I go too far want validation that 
I'm on the right track instantiating kobjects for these table entries.  
Something doesn't feel quite right about it.

I've so far had to:
a) add a struct kobject and a struct list_head (for the dynamic list) to 
pci_device_id.
b) add 2 struct kobjects and 1 struct list_head to struct pci_driver
c) create them all in drivers/pci/pci-sysfs.c.

I also think I need some type of ATTR_ATTR macro, as I don't have whole 
devices for these, just kobjects.  That's where it starts getting really 
weird.


Feedback requested.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


