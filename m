Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268552AbTBWTVx>; Sun, 23 Feb 2003 14:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268551AbTBWTVw>; Sun, 23 Feb 2003 14:21:52 -0500
Received: from franka.aracnet.com ([216.99.193.44]:52116 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268548AbTBWTVs>; Sun, 23 Feb 2003 14:21:48 -0500
Date: Sun, 23 Feb 2003 11:31:55 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Patrick Mochel <mochel@osdl.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Bug with (maybe not *in*) sysfs
Message-ID: <5480000.1046028715@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Customer is getting a panic from x440 w/ sysfs. May well not be
sysfs's fault ... but it's difficult to tell without knowing
what's meant to happen here ;-) debug is turned on.

Looks like kobject_register is just getting an error from kobject_add,
but as we don't see this:

        pr_debug("kobject %s: registering. parent: %s, set: %s\n",
                 kobj->name, parent ? parent->name : "<NULL>",
                 kobj->kset ? kobj->kset->kobj.name : "<NULL>" );

presumably we're hitting:

        if (!(kobj = kobject_get(kobj)))
                return -ENOENT;

But withh no real context on all the kobject stuff it's hard to tell what
that really means ;-)

M.


  Type:   Processor                          ANSI SCSI revision: 02

DEV: registering device: ID = '1:0:9:0', name = ZIBM     GNHv1 S2        0

kobject 1:0:9:0: registering. parent: 01:03.1, set: devices

bus scsi: add device 1:0:9:0

sysfs_create_link: depth = 3, size = 38

sysfs_create_link: path = '../../../devices/pci1/01:03.1/1:0:9:0'

(scsi1:A:12): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)

  Vendor: IBM-ESXS  Model: ST336607LC    F   Rev: B258

  Type:   Direct-Access                      ANSI SCSI revision: 03

DEV: registering device: ID = '1:0:12:0', name = SIBM-ESXSST336607LC    F
3JA0JR
4X000073235STN

kobject 1:0:12:0: registering. parent: 01:03.1, set: devices

bus scsi: add device 1:0:12:0

sysfs_create_link: depth = 3, size = 39

sysfs_create_link: path = '../../../devices/pci1/01:03.1/1:0:12:0'

scsi1:A:12:0: Tagged Queuing enabled.  Depth 32

(scsi1:A:13): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)

  Vendor: IBM-ESXS  Model: ST336607LC    F   Rev: B258

  Type:   Direct-Access                      ANSI SCSI revision: 03

DEV: registering device: ID = '1:0:13:0', name = SIBM-ESXSST336607LC    F
3JA0J7
EV000073235W9F

kobject 1:0:13:0: registering. parent: 01:03.1, set: devices

bus scsi: add device 1:0:13:0
(scsi1:A:13): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)

  Vendor: IBM-ESXS  Model: ST336607LC    F   Rev: B258

  Type:   Direct-Access                      ANSI SCSI revision: 03

DEV: registering device: ID = '1:0:13:0', name = SIBM-ESXSST336607LC    F
3JA0J7
EV000073235W9F

kobject 1:0:13:0: registering. parent: 01:03.1, set: devices

bus scsi: add device 1:0:13:0

sysfs_create_link: depth = 3, size = 39

sysfs_create_link: path = '../../../devices/pci1/01:03.1/1:0:13:0'

scsi1:A:13:0: Tagged Queuing enabled.  Depth 32

bus pci: add driver ips

kobject ips: registering. parent: <NULL>, set: drivers

bus pci: add driver ips

kobject ips: registering. parent: <NULL>, set: drivers

Badness in kobject_register at lib/kobject.c:152

Call Trace:

 [<c019a47b>] kobject_register+0x3b/0x50

 [<c01bf3f5>] bus_add_driver+0x65/0xe0

 [<c019cec6>] pci_register_driver+0x46/0x60

 [<c0209b8a>] ips_detect+0x8a/0xc0

 [<c01e82c6>] __scsi_add_host+0x56/0x70

 [<c01e8679>] scsi_register_host+0x39/0x80

 [<c01050ae>] init+0x4e/0x1c0

 [<c0105060>] init+0x0/0x1c0


