Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315611AbSFOVyX>; Sat, 15 Jun 2002 17:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315606AbSFOVyW>; Sat, 15 Jun 2002 17:54:22 -0400
Received: from hera.cwi.nl ([192.16.191.8]:17091 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S315599AbSFOVyU>;
	Sat, 15 Jun 2002 17:54:20 -0400
From: Andries.Brouwer@cwi.nl
Date: Sat, 15 Jun 2002 23:54:12 +0200 (MEST)
Message-Id: <UTC200206152154.g5FLsCI23053.aeb@smtp.cwi.nl>
To: garloff@suse.de, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        sancho@dauskardt.de
Subject: Re: /proc/scsi/map
Cc: linux-usb-devel@lists.sourceforge.net,
        linux1394-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    >Life would be easier if the scsi subsystem would just report which SCSI
    >device (uniquely identified by the controller,bus,target,unit tuple) belongs
    >to which high-level device. The information is available in the kernel.
    >
    >Attached patch does this:
    >garloff@pckurt:/raid5/Kernel/src $ cat /proc/scsi/map
    ># C,B,T,U       Type    onl     sg_nm   sg_dev  nm      dev(hex)
    >0,0,00,00       0x05    1       sg0     c:15:00 sr0     b:0b:00
    [...]

    Great, this was really missing badly.

    But how about adding another column: GUID.
    Most usb-storage and (all?) FireWire devices have such a unique identitiy.
    In contrast to native SCSI devices, these emulated SCSI devices on 
    hot-plugging busses will change their LUNs/IDs. Therefor the GUID is
    really a must to be able to create stable names (laptop suspend, etc.).

    Both usb-storage and iee1394-sbp2 know the GUID. It only needs to be 
    communicated..

The usb-storage GUID is just one random item of information.
One might wish for much more.

And: this information is already somewhere:

% cat /proc/scsi/sg/host_strs
SCSI host adapter emulation for IDE ATAPI devices
Iomega VPI2 (imm) interface
SCSI emulation for USB Mass Storage devices
SCSI emulation for USB Mass Storage devices
%

This tells me that host 0 will be in ide-scsi, host 1 in imm,
host 2 in usb-storage-0, host 3 in usb-storage-1.
And

% cat /proc/scsi/ide-scsi/0
SCSI host adapter emulation for IDE ATAPI devices
% cat /proc/scsi/imm/1
Version : 2.05 (for Linux 2.4.0)
Parport : parport0
Mode    : SPP
% cat /proc/scsi/usb-storage-0/2
   Host scsi2: usb-storage
       Vendor: DataFab Systems Inc.
      Product: USB CF+SM
Serial Number: 5DC69477C6
     Protocol: Transparent SCSI
    Transport: Datafab Bulk-Only
         GUID: 07c4a1090000005dc69477c6
     Attached: Yes
% cat /proc/scsi/usb-storage-1/3
   Host scsi3: usb-storage
       Vendor: SCM Microsystems Inc.
      Product: eUSB SmartMedia / CompactFlash 
Serial Number: None
     Protocol: Transparent SCSI
    Transport: Control/Bulk-EUSB/SDDR09
         GUID: 04e600050000000000000000
     Attached: Yes
%

A small utility that looks around in /proc is able to
find the GUID. Of course it would be better when fewer
heuristics were required.

Finally, the GUIDs you see here do not determine the LUN.
So, there is no well-defined line in /proc/scsi/map
where they would belong.

Andries
