Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030325AbVIITaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030325AbVIITaw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 15:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030321AbVIITav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 15:30:51 -0400
Received: from magic.adaptec.com ([216.52.22.17]:33220 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1030318AbVIITau (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 15:30:50 -0400
Message-ID: <4321E2E3.30006@adaptec.com>
Date: Fri, 09 Sep 2005 15:30:43 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: [ANNOUNCE 1/2] Serial Attached SCSI (SAS) support for the Linux kernel
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2005 19:30:49.0008 (UTC) FILETIME=[FB7DB300:01C5B574]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This email shows an example of two domains.
The first domain has only two devices: the SAS initiator
and a SAS end device (a disk).
The second domain has expanders, SAS disks, a SATA II disk
and a SATAPI disk.

A succinct and full listings of the sysfs tree are shown
using the tree(1) program.

Sample configuration
--------------------

Directly attached devices, cascaded expanders and
wide ports

1. SAS disk on HA phy 0, forming a narrow port, port 0.

2. Expander on HA phys 4, 5, 6, and 7, forming
   a wide port, port 1.

3. Port 0, narrow, of phy 0, is formed between
   the host adapter and a SAS end device with SAS port identifier
   (aua/aka, SAS address) 500000e000031c12.  This device
   has a single LU, with LUN 0, which is a disk device.

4. Port 1, wide, of phys 4, 5, 6 and 7, is formed between
   the Host adapter's phys 4-7 and the expander with SAS
   address 50001c1716010600, Expander A.

5. Expander A, 50001c1716010600, has 4 devices attached to it:
   - An expander with SAS address 50001c1071609c00,
     expander B (using a 2 link wide port, see below).
   - A SATA II disk, 50001c1716010603, using the expanders'
     STP/SATA bridge.
   - An SES device, LUN 0 of 50001c171601060d.
   - And a SAS disk, LUN 0 of 5000c50000513329.

6. Expander B, 50001c1071609c00, has 3 devices attached to it:
   - A SATAPI device, 50001c1071609c02, using the expander's
     STP/SATA bridge.
   - A SAS disk, LUN 0 of 5000c50000102a65.
   - And an expander, 5005076a000001e0, expander C,
     (using a 2 link wide port, see below).

7. Expander C, 5005076a000001e0, has 3 devices attached to it:
   - A SAS disk, LUN 0 of 5000c50000513385.
   - An SES device, LUN 0 of 5005076a000001ed.
   - A SAS disk, LUN 0 of 5c50000000409c11.

Succinct listing of the tree
----------------------------

tree -d /sys/devices/pci0000\:01/0000\:01\:04.0/host11/sas/ha 

/sys/devices/pci0000:01/0000:01:04.0/host11/sas/ha
|-- phys
|   |-- 0
|   |   `-- port -> ../../../../../../../../devices/pci0000:01/0000:01:04.0/host11/sas/ha/ports/0
|   |-- 1
|   |-- 2
|   |-- 3
|   |-- 4
|   |   `-- port -> ../../../../../../../../devices/pci0000:01/0000:01:04.0/host11/sas/ha/ports/1
|   |-- 5
|   |   `-- port -> ../../../../../../../../devices/pci0000:01/0000:01:04.0/host11/sas/ha/ports/1
|   |-- 6
|   |   `-- port -> ../../../../../../../../devices/pci0000:01/0000:01:04.0/host11/sas/ha/ports/1
|   `-- 7
|       `-- port -> ../../../../../../../../devices/pci0000:01/0000:01:04.0/host11/sas/ha/ports/1
`-- ports
    |-- 0
    |   |-- domain
    |   |   `-- 500000e000031c12
    |   |       `-- LUNS
    |   |           `-- 0000000000000000
    |   `-- phys
    |       `-- 0 -> ../../../../../../../../../devices/pci0000:01/0000:01:04.0/host11/sas/ha/phys/0
    `-- 1
        |-- domain
        |   `-- 50001c1716010600
        |       |-- 50001c1071609c00
        |       |   |-- 50001c1071609c02
        |       |   |-- 5000c50000102a65
        |       |   |   `-- LUNS
        |       |   |       `-- 0000000000000000
        |       |   `-- 5005076a000001e0
        |       |       |-- 5000c50000513385
        |       |       |   `-- LUNS
        |       |       |       `-- 0000000000000000
        |       |       |-- 5005076a000001ed
        |       |       |   `-- LUNS
        |       |       |       `-- 0000000000000000
        |       |       `-- 5c50000000409c11
        |       |           `-- LUNS
        |       |               `-- 0000000000000000
        |       |-- 50001c1716010603
        |       |-- 50001c171601060d
        |       |   `-- LUNS
        |       |       `-- 0000000000000000
        |       `-- 5000c50000513329
        |           `-- LUNS
        |               `-- 0000000000000000
        `-- phys
            |-- 4 -> ../../../../../../../../../devices/pci0000:01/0000:01:04.0/host11/sas/ha/phys/4
            |-- 5 -> ../../../../../../../../../devices/pci0000:01/0000:01:04.0/host11/sas/ha/phys/5
            |-- 6 -> ../../../../../../../../../devices/pci0000:01/0000:01:04.0/host11/sas/ha/phys/6
            `-- 7 -> ../../../../../../../../../devices/pci0000:01/0000:01:04.0/host11/sas/ha/phys/7

52 directories

Full listing of the tree
------------------------

tree /sys/devices/pci0000\:01/0000\:01\:04.0/host11/sas/ha
/sys/devices/pci0000:01/0000:01:04.0/host11/sas/ha
|-- device_name
|-- ha_name
|-- phys
|   |-- 0
|   |   |-- class
|   |   |-- enabled
|   |   |-- id
|   |   |-- iproto
|   |   |-- linkrate
|   |   |-- oob_mode
|   |   |-- port -> ../../../../../../../../devices/pci0000:01/0000:01:04.0/host11/sas/ha/ports/0
|   |   |-- role
|   |   |-- sas_addr
|   |   |-- tproto
|   |   `-- type
|   |-- 1
|   |   |-- class
|   |   |-- enabled
|   |   |-- id
|   |   |-- iproto
|   |   |-- linkrate
|   |   |-- oob_mode
|   |   |-- role
|   |   |-- sas_addr
|   |   |-- tproto
|   |   `-- type
|   |-- 2
|   |   |-- class
|   |   |-- enabled
|   |   |-- id
|   |   |-- iproto
|   |   |-- linkrate
|   |   |-- oob_mode
|   |   |-- role
|   |   |-- sas_addr
|   |   |-- tproto
|   |   `-- type
|   |-- 3
|   |   |-- class
|   |   |-- enabled
|   |   |-- id
|   |   |-- iproto
|   |   |-- linkrate
|   |   |-- oob_mode
|   |   |-- role
|   |   |-- sas_addr
|   |   |-- tproto
|   |   `-- type
|   |-- 4
|   |   |-- class
|   |   |-- enabled
|   |   |-- id
|   |   |-- iproto
|   |   |-- linkrate
|   |   |-- oob_mode
|   |   |-- port -> ../../../../../../../../devices/pci0000:01/0000:01:04.0/host11/sas/ha/ports/1
|   |   |-- role
|   |   |-- sas_addr
|   |   |-- tproto
|   |   `-- type
|   |-- 5
|   |   |-- class
|   |   |-- enabled
|   |   |-- id
|   |   |-- iproto
|   |   |-- linkrate
|   |   |-- oob_mode
|   |   |-- port -> ../../../../../../../../devices/pci0000:01/0000:01:04.0/host11/sas/ha/ports/1
|   |   |-- role
|   |   |-- sas_addr
|   |   |-- tproto
|   |   `-- type
|   |-- 6
|   |   |-- class
|   |   |-- enabled
|   |   |-- id
|   |   |-- iproto
|   |   |-- linkrate
|   |   |-- oob_mode
|   |   |-- port -> ../../../../../../../../devices/pci0000:01/0000:01:04.0/host11/sas/ha/ports/1
|   |   |-- role
|   |   |-- sas_addr
|   |   |-- tproto
|   |   `-- type
|   `-- 7
|       |-- class
|       |-- enabled
|       |-- id
|       |-- iproto
|       |-- linkrate
|       |-- oob_mode
|       |-- port -> ../../../../../../../../devices/pci0000:01/0000:01:04.0/host11/sas/ha/ports/1
|       |-- role
|       |-- sas_addr
|       |-- tproto
|       `-- type
`-- ports
    |-- 0
    |   |-- attached_port_identifier
    |   |-- class
    |   |-- domain
    |   |   `-- 500000e000031c12
    |   |       |-- LUNS
    |   |       |   `-- 0000000000000000
    |   |       |       |-- channel
    |   |       |       |-- id
    |   |       |       |-- inquiry_data
    |   |       |       |-- lun
    |   |       |       `-- task_management
    |   |       |-- dev_type
    |   |       |-- iproto
    |   |       |-- iresp_timeout
    |   |       |-- itnl_timeout
    |   |       |-- linkrate
    |   |       |-- max_linkrate
    |   |       |-- min_linkrate
    |   |       |-- pathways
    |   |       |-- ready_led_meaning
    |   |       |-- rl_wlun
    |   |       |-- sas_addr
    |   |       `-- tproto
    |   |-- id
    |   |-- iproto
    |   |-- oob_mode
    |   |-- phys
    |   |   `-- 0 -> ../../../../../../../../../devices/pci0000:01/0000:01:04.0/host11/sas/ha/phys/0
    |   |-- port_identifier
    |   `-- tproto
    `-- 1
        |-- attached_port_identifier
        |-- class
        |-- domain
        |   `-- 50001c1716010600
        |       |-- 50001c1071609c00
        |       |   |-- 50001c1071609c02
        |       |   |   |-- command_set
        |       |   |   |-- dev_type
        |       |   |   |-- firmware_rev
        |       |   |   |-- identify_device
        |       |   |   |-- identify_packet_device
        |       |   |   |-- iproto
        |       |   |   |-- linkrate
        |       |   |   |-- max_linkrate
        |       |   |   |-- min_linkrate
        |       |   |   |-- model_number
        |       |   |   |-- port_no
        |       |   |   |-- report_phy_sata_resp
        |       |   |   |-- sas_addr
        |       |   |   |-- serial_number
        |       |   |   `-- tproto
        |       |   |-- 5000c50000102a65
        |       |   |   |-- LUNS
        |       |   |   |   `-- 0000000000000000
        |       |   |   |       |-- channel
        |       |   |   |       |-- id
        |       |   |   |       |-- inquiry_data
        |       |   |   |       |-- lun
        |       |   |   |       `-- task_management
        |       |   |   |-- dev_type
        |       |   |   |-- iproto
        |       |   |   |-- iresp_timeout
        |       |   |   |-- itnl_timeout
        |       |   |   |-- linkrate
        |       |   |   |-- max_linkrate
        |       |   |   |-- min_linkrate
        |       |   |   |-- pathways
        |       |   |   |-- ready_led_meaning
        |       |   |   |-- rl_wlun
        |       |   |   |-- sas_addr
        |       |   |   `-- tproto
        |       |   |-- 5005076a000001e0
        |       |   |   |-- 5000c50000513385
        |       |   |   |   |-- LUNS
        |       |   |   |   |   `-- 0000000000000000
        |       |   |   |   |       |-- channel
        |       |   |   |   |       |-- id
        |       |   |   |   |       |-- inquiry_data
        |       |   |   |   |       |-- lun
        |       |   |   |   |       `-- task_management
        |       |   |   |   |-- dev_type
        |       |   |   |   |-- iproto
        |       |   |   |   |-- iresp_timeout
        |       |   |   |   |-- itnl_timeout
        |       |   |   |   |-- linkrate
        |       |   |   |   |-- max_linkrate
        |       |   |   |   |-- min_linkrate
        |       |   |   |   |-- pathways
        |       |   |   |   |-- ready_led_meaning
        |       |   |   |   |-- rl_wlun
        |       |   |   |   |-- sas_addr
        |       |   |   |   `-- tproto
        |       |   |   |-- 5005076a000001ed
        |       |   |   |   |-- LUNS
        |       |   |   |   |   `-- 0000000000000000
        |       |   |   |   |       |-- channel
        |       |   |   |   |       |-- id
        |       |   |   |   |       |-- inquiry_data
        |       |   |   |   |       |-- lun
        |       |   |   |   |       `-- task_management
        |       |   |   |   |-- dev_type
        |       |   |   |   |-- iproto
        |       |   |   |   |-- iresp_timeout
        |       |   |   |   |-- itnl_timeout
        |       |   |   |   |-- linkrate
        |       |   |   |   |-- max_linkrate
        |       |   |   |   |-- min_linkrate
        |       |   |   |   |-- pathways
        |       |   |   |   |-- ready_led_meaning
        |       |   |   |   |-- rl_wlun
        |       |   |   |   |-- sas_addr
        |       |   |   |   `-- tproto
        |       |   |   |-- 5c50000000409c11
        |       |   |   |   |-- LUNS
        |       |   |   |   |   `-- 0000000000000000
        |       |   |   |   |       |-- channel
        |       |   |   |   |       |-- id
        |       |   |   |   |       |-- inquiry_data
        |       |   |   |   |       |-- lun
        |       |   |   |   |       `-- task_management
        |       |   |   |   |-- dev_type
        |       |   |   |   |-- iproto
        |       |   |   |   |-- iresp_timeout
        |       |   |   |   |-- itnl_timeout
        |       |   |   |   |-- linkrate
        |       |   |   |   |-- max_linkrate
        |       |   |   |   |-- min_linkrate
        |       |   |   |   |-- pathways
        |       |   |   |   |-- ready_led_meaning
        |       |   |   |   |-- rl_wlun
        |       |   |   |   |-- sas_addr
        |       |   |   |   `-- tproto
        |       |   |   |-- change_count
        |       |   |   |-- component_id
        |       |   |   |-- component_revision_id
        |       |   |   |-- component_vendor_id
        |       |   |   |-- conf_route_table
        |       |   |   |-- configuring
        |       |   |   |-- dev_type
        |       |   |   |-- enclosure_logical_id
        |       |   |   |-- iproto
        |       |   |   |-- linkrate
        |       |   |   |-- max_linkrate
        |       |   |   |-- max_route_indexes
        |       |   |   |-- min_linkrate
        |       |   |   |-- num_phys
        |       |   |   |-- pathways
        |       |   |   |-- product_id
        |       |   |   |-- product_rev
        |       |   |   |-- sas_addr
        |       |   |   |-- smp_portal
        |       |   |   |-- tproto
        |       |   |   `-- vendor_id
        |       |   |-- change_count
        |       |   |-- component_id
        |       |   |-- component_revision_id
        |       |   |-- component_vendor_id
        |       |   |-- conf_route_table
        |       |   |-- configuring
        |       |   |-- dev_type
        |       |   |-- enclosure_logical_id
        |       |   |-- iproto
        |       |   |-- linkrate
        |       |   |-- max_linkrate
        |       |   |-- max_route_indexes
        |       |   |-- min_linkrate
        |       |   |-- num_phys
        |       |   |-- pathways
        |       |   |-- product_id
        |       |   |-- product_rev
        |       |   |-- sas_addr
        |       |   |-- smp_portal
        |       |   |-- tproto
        |       |   `-- vendor_id
        |       |-- 50001c1716010603
        |       |   |-- command_set
        |       |   |-- dev_type
        |       |   |-- firmware_rev
        |       |   |-- identify_device
        |       |   |-- identify_packet_device
        |       |   |-- iproto
        |       |   |-- linkrate
        |       |   |-- max_linkrate
        |       |   |-- min_linkrate
        |       |   |-- model_number
        |       |   |-- port_no
        |       |   |-- report_phy_sata_resp
        |       |   |-- sas_addr
        |       |   |-- serial_number
        |       |   `-- tproto
        |       |-- 50001c171601060d
        |       |   |-- LUNS
        |       |   |   `-- 0000000000000000
        |       |   |       |-- channel
        |       |   |       |-- id
        |       |   |       |-- inquiry_data
        |       |   |       |-- lun
        |       |   |       `-- task_management
        |       |   |-- dev_type
        |       |   |-- iproto
        |       |   |-- iresp_timeout
        |       |   |-- itnl_timeout
        |       |   |-- linkrate
        |       |   |-- max_linkrate
        |       |   |-- min_linkrate
        |       |   |-- pathways
        |       |   |-- ready_led_meaning
        |       |   |-- rl_wlun
        |       |   |-- sas_addr
        |       |   `-- tproto
        |       |-- 5000c50000513329
        |       |   |-- LUNS
        |       |   |   `-- 0000000000000000
        |       |   |       |-- channel
        |       |   |       |-- id
        |       |   |       |-- inquiry_data
        |       |   |       |-- lun
        |       |   |       `-- task_management
        |       |   |-- dev_type
        |       |   |-- iproto
        |       |   |-- iresp_timeout
        |       |   |-- itnl_timeout
        |       |   |-- linkrate
        |       |   |-- max_linkrate
        |       |   |-- min_linkrate
        |       |   |-- pathways
        |       |   |-- ready_led_meaning
        |       |   |-- rl_wlun
        |       |   |-- sas_addr
        |       |   `-- tproto
        |       |-- change_count
        |       |-- component_id
        |       |-- component_revision_id
        |       |-- component_vendor_id
        |       |-- conf_route_table
        |       |-- configuring
        |       |-- dev_type
        |       |-- enclosure_logical_id
        |       |-- iproto
        |       |-- linkrate
        |       |-- max_linkrate
        |       |-- max_route_indexes
        |       |-- min_linkrate
        |       |-- num_phys
        |       |-- pathways
        |       |-- product_id
        |       |-- product_rev
        |       |-- sas_addr
        |       |-- smp_portal
        |       |-- tproto
        |       `-- vendor_id
        |-- id
        |-- iproto
        |-- oob_mode
        |-- phys
        |   |-- 4 -> ../../../../../../../../../devices/pci0000:01/0000:01:04.0/host11/sas/ha/phys/4
        |   |-- 5 -> ../../../../../../../../../devices/pci0000:01/0000:01:04.0/host11/sas/ha/phys/5
        |   |-- 6 -> ../../../../../../../../../devices/pci0000:01/0000:01:04.0/host11/sas/ha/phys/6
        |   `-- 7 -> ../../../../../../../../../devices/pci0000:01/0000:01:04.0/host11/sas/ha/phys/7
        |-- port_identifier
        `-- tproto

52 directories, 308 files



