Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271844AbTGYA6p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 20:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271851AbTGYA6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 20:58:45 -0400
Received: from devil.servak.biz ([209.124.81.2]:8855 "EHLO devil.servak.biz")
	by vger.kernel.org with ESMTP id S271844AbTGYA6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 20:58:43 -0400
Subject: Re: Firewire
From: Torrey Hoffman <thoffman@arnor.net>
To: Chris Ruvolo <chris+lkml@ruvolo.net>
Cc: Ben Collins <bcollins@debian.org>, gaxt <gaxt@rogers.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>
In-Reply-To: <20030724230928.GB23196@ruvolo.net>
References: <3F1FE06A.5030305@rogers.com>
	 <20030724223522.GA23196@ruvolo.net> <20030724223615.GN1512@phunnypharm.org>
	 <20030724230928.GB23196@ruvolo.net>
Content-Type: text/plain
Organization: 
Message-Id: <1059095616.1897.34.camel@torrey.et.myrio.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Jul 2003 18:13:37 -0700
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - devil.servak.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - arnor.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-24 at 16:09, Chris Ruvolo wrote:
...

> ieee1394: unsolicited response packet received - np
> ieee1394: contents: ffc00960 ffc00000 00000000 60f30404
> ieee1394: ConfigROM quadlet transaction error for node 00:1023

I have had problems like this with the SBP2 driver since ~2.5.75 when I
attach (or sometimes when I attempt to mount) my 250 GB external drive. 
This never used to happen with 2.5.73 or earlier though.  

Sometimes the driver seems to go into an loop of "unsolicted packet
received" messages and attempted resets.  Here's what the log looks like
when that happens:  (this was on 2.5.75)

Jul 24 16:04:37 torrey kernel: ieee1394: The root node is not cycle master capable; selecting a new root node and resetting...
Jul 24 16:04:37 torrey kernel: ieee1394: Node changed: 0-01:1023 -> 0-00:1023
Jul 24 16:04:37 torrey kernel: ieee1394: sbp2: Reconnected to SBP-2 device
Jul 24 16:04:37 torrey kernel: ieee1394: sbp2: Node[00:1023]: Max speed [S400] - Max payload [2048]
Jul 24 16:04:37 torrey kernel: ieee1394: unsolicited response packet received - np
Jul 24 16:04:37 torrey kernel: ieee1394: contents: ffc10160 ffc10000 00000000 7ee60404
Jul 24 16:04:38 torrey kernel: ieee1394: unsolicited response packet received - np
Jul 24 16:04:38 torrey kernel: ieee1394: contents: ffc10560 ffc10000 00000000 7ee60404
Jul 24 16:04:38 torrey kernel: ieee1394: unsolicited response packet received - np
Jul 24 16:04:38 torrey kernel: ieee1394: contents: ffc10960 ffc10000 00000000 7ee60404
Jul 24 16:04:39 torrey kernel: ieee1394: ConfigROM quadlet transaction error for node 01:1023
Jul 24 16:04:39 torrey kernel: ieee1394: The root node is not cycle master capable; selecting a new root node and resetting...

(this sequence repeats until I turn off or unplug the drive.)

I have not tried every kernel release along the way, so I don't know
exactly when the problem started.  It is also interesting that I have
not observed this problem when I use a 120 GB drive in the same firewire
enclosure.

Here's another snippet from the dmesg of my most recent boot, into
2.6.0-test1-ac3.  Luckily it didn't go into the infinite error loop this
time, but it did get one of those unsolicited packet errors:

SCSI subsystem initialized
ohci1394: $Rev: 986 $ Ben Collins <bcollins@debian.org>
PCI: Found IRQ 10 for device 0000:02:0b.0
PCI: Sharing IRQ 10 with 0000:02:01.0
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[10]  MMIO=[e8201000-e82017ff]  Max Packet=[2048]
scsi0 : SCSI emulation for IEEE-1394 SBP-2 Devices
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: sbp2: Node[00:1023]: Max speed [S400] - Max payload [2048]
  Vendor: Maxtor 4  Model: A250J8            Rev:
  Type:   Direct-Access                      ANSI SCSI revision: 06
ieee1394: Node added: ID:BUS[0-00:1023]  GUID[0004830000002cb3]
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc10160 ffc10000 00000000 7ee60404
ieee1394: Host added: ID:BUS[0-01:1023]  GUID[0040630000001c47]

... snipped loading other drivers ...

SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
sda: asking for cache data failed
sda: assuming drive cache: write through
 sda: sda1
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device sda1, size 8192, journal first block 18,
max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (sda1) for (sda1)
Using r5 hash to sort names
(end)


-- 
Torrey Hoffman <thoffman@arnor.net>

