Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282099AbRK1Jds>; Wed, 28 Nov 2001 04:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282093AbRK1Jdi>; Wed, 28 Nov 2001 04:33:38 -0500
Received: from firewall.synchrotron.fr ([193.49.43.1]:15760 "HELO out.esrf.fr")
	by vger.kernel.org with SMTP id <S282099AbRK1Jd0>;
	Wed, 28 Nov 2001 04:33:26 -0500
Date: Wed, 28 Nov 2001 10:32:56 +0100
From: Samuel Maftoul <maftoul@esrf.fr>
To: linux-kernel@vger.kernel.org
Subject: Ieee1394
Message-ID: <20011128103256.A28083@pcmaftoul.esrf.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,
        Still me with my ieee1394 problems :)

Workaround: My goal is to make ieee1394 HardDisk  work in a production 
environment:
	User come on a machine, plug his disk, store his (experience 
	results) datas on it, unplugs it and go away with it in his home
	institute where he processes his datas.


Tests:
Boot with no devices plugged, no modules related to ieee1394 loaded
-load module ieee1394
-load module ohci1394
	gives a kernel warning: Get PHY Reg Timeout
keventd is up and running

plug of the HD gives in syslog kern.debug:
------------------------------------------------------
ohci1394_0: IntEvent: 00020010
ohci1394_0: irq_handler: Bus reset requested
ohci1394_0: Cancel request received
ohci1394_0: Got RQPkt interrupt status=0x00008409
ohci1394_0: Single packet rcv'd
ohci1394_0: Got phy packet ctx=0 ... discarded
ohci1394_0: IntEvent: 00000010
ohci1394_0: Got RQPkt interrupt status=0x00008409
ohci1394_0: Single packet rcv'd
ohci1394_0: Got phy packet ctx=0 ... discarded
ohci1394_0: Single packet rcv'd
ohci1394_0: Got phy packet ctx=0 ... discarded
------------------------------------------------------

unplug gives in kern.debug:
------------------------------------------------------
ohci1394_0: Got phy packet ctx=0 ... discarded
ohci1394_0: IntEvent: 00000010
ohci1394_0: Got RQPkt interrupt status=0x00008409
ohci1394_0: Single packet rcv'd
ohci1394_0: Got phy packet ctx=0 ... discarded
------------------------------------------------------

load module of sbp2, syslog says: 
------------------------------------------------------
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io = 1)
scsi2 : IEEE-1394 SBP-2 protocol driver
------------------------------------------------------
unplug of HD
replug of the HD
Gives quite the same message as above on plug and unplug


Reboot of the machine with the disk plugged in.
(Maybe reboot isn't needed)  
Modules are loaded manually. 

load of modules ieee1394, ohci1394
module ieee1394 doesn't give any message.
module ohci1394 gives a lot of message (in kern.debug), discuss with the
HD plugged in, gives info about it (30GB ..), loads the sbp2 module.
Here is what i have in kern.warn
------------------------------------------------------
Nov 28 08:19:27 test17-248 kernel: ieee1394: sbp2: Driver forced to serialize I/O (serialize_io = 1)
Nov 28 08:19:27 test17-248 kernel: ieee1394: sbp2: Node 1:1023: Max speed [S400] - Max payload [0x09/2048]
Nov 28 08:19:27 test17-248 kernel:   Vendor: FUJITSU   Model: MHN2300AT         Rev: 7255
Nov 28 08:19:27 test17-248 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 06
Nov 28 08:19:27 test17-248 kernel: Attached scsi disk sdb at scsi2, channel 0, id 0, lun 0
Nov 28 08:19:28 test17-248 kernel: SCSI device sdb: 58605120 512-byte hdwr sectors (30006 MB)
Nov 28 08:19:28 test17-248 kernel:  sdb1
------------------------------------------------------

Now plug 1 more disk on the 1 of the 2 left plug on the ieee1394 pci card: 
------------------------------------------------------
Nov 28 08:24:56 test17-248 kernel: ieee1394: ConfigROM quadlet transaction error for node 0:1023
Nov 28 08:24:57 test17-248 kernel: ieee1394: sbp2: Node 0:1023: Max speed [S400] - Max payload [0x09/2048]
Nov 28 08:25:12 test17-248 kernel: ieee1394: sbp2: Error logging into SBP-2 device - login timed-out
Nov 28 08:25:12 test17-248 kernel: ieee1394: sbp2: sbp2_login_device failed
Nov 28 08:25:12 test17-248 kernel: ieee1394: sbp2: Error reconnecting to SBP-2 device - reconnect failed
Nov 28 08:25:12 test17-248 kernel: ieee1394: sbp2: Node 2:1023: Max speed [S400] - Max payload [0x09/2048]
------------------------------------------------------

Now plug the last remainning slot:
------------------------------------------------------
Nov 28 08:32:09 test17-248 kernel: ieee1394: ConfigROM quadlet transaction error for node 0:1023
Nov 28 08:32:09 test17-248 kernel: ieee1394: sbp2: Node 1:1023: Max speed [S400] - Max payload [0x09/2048]
Nov 28 08:32:14 test17-248 kernel: ieee1394: sbp2: Node 0:1023: Max speed [S400] - Max payload [0x09/2048]
Nov 28 08:32:14 test17-248 kernel: ieee1394: sbp2: Node 2:1023: Max speed [S400] - Max payload [0x09/2048]
------------------------------------------------------

Now lets go for the unplug of the last plugged HD:
Nov 28 08:35:14 test17-248 kernel: ieee1394: sbp2: Node 1:1023: Max speed [S400] - Max payload [0x09/2048]

Now lets unplegged the next one:
Nov 28 08:36:01 test17-248 kernel: ieee1394: ConfigROM quadlet transaction error for node 1:1023
Nov 28 08:36:03 test17-248 kernel: ieee1394: sbp2: Node 0:1023: Max speed [S400] - Max payload [0x09/2048]

The unplug of the only working disk gives no message in kern.warn
The replug gives:
Nov 28 08:52:05 test17-248 kernel: ohci1394_0: SelfID received outside of bus reset sequence
Nov 28 08:52:10 test17-248 kernel: ieee1394: sbp2: Node 0:1023: Max speed [S400] - Max payload [0x09/2048]

Comments:
It seems that the hotplug is working only if the device is plugged before
the boot of the machine or loading the modules (just tested, don't need
to boot the machine with the devies plugged, just need to have plugged
the device before loading ohci1394 module).
This is not really hotplug, right ? Is this normal ?
The is really annoying because if I automatically load the module at boot
time, we need to have a device plugged on every machines what is really
not handy.
The other issue is that the only first device plugged is working.
This isn't really a problem because I need just 1 disk to be plugged but
is this normal (I think so)?
	Sam
