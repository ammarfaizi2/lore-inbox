Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbVD0MiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVD0MiT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 08:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVD0MiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 08:38:19 -0400
Received: from zorg.st.net.au ([203.16.233.9]:37581 "EHLO borg.st.net.au")
	by vger.kernel.org with ESMTP id S261536AbVD0MiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 08:38:08 -0400
Message-ID: <426F86D3.4070909@torque.net>
Date: Wed, 27 Apr 2005 22:34:27 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luben Tuikov <luben_tuikov@adaptec.com>
CC: Christoph Hellwig <hch@infradead.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       andrew.patterson@hp.com, Eric.Moore@lsil.com, mike.miller@hp.com,
       Madhuresh_Nagshain@adaptec.com
Subject: Re: [RFC] SAS domain layout for Linux sysfs
References: <425D392F.2080702@adaptec.com> <20050424111908.GA23010@infradead.org> <426D1572.70508@adaptec.com> <20050425161411.GA11938@infradead.org> <426D2723.8070308@adaptec.com> <20050425181831.GA14190@infradead.org> <426E5BAF.4040003@adaptec.com>
In-Reply-To: <426E5BAF.4040003@adaptec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The SAS/sysfs discussion seems to have run aground
so I'll try a different example in order to find
some common ground.

Below is a diagram with one SAS HBA (also known as
HA) with two phys in use. One is connected directly
to a SAS dual ported disk and the other phy goes via
a SAS expander to the other "side" of the same disk:


+---------+  |                     |  +-----------+
|scsi0 [] =--|---------------------|--= sda       |
|         |  |                     |  |           |
|         |  |    +-----+          |  |           |
|scsi1 [] =--|----= ex1 =----------|--= sdb       |
+-----||||+  |    +-----+          |  +-----------+
              |                     |
1 HBA(HA)    | 2 service delivery  |   1 dual ported
                subsystems              SAS disk
               (2 SAS domains)

SCSI analysis
-------------
Even though there is one HBA and one SCSI initiator
we have two SCSI initiator ports. In Linux we name
initiator ports (according to scsi_mid_low_api.txt)
rather than an initiator device, hence scsi0 and scsi1.
Each SCSI initiator port is connected to an independent
service delivery subsystem. There is one target device
which contains two ports and one lu (lun=0). Those target
ports are connected to separate service delivery subsystems.

Since we name by path, the dual ported disk has two linux
device names: sda and sdb. The tuple for sda is
<scsi0,0,upper_target_port_sas_address,0>. The third element
is a 64 bit SAS address which may need to be mapped to
small integer to fit the linux scsi subsystem.

The VPD device identification page will show that the lu
name of both sda and sdb is the same. This becomes the
responsibility of multipath-tools to sort out.

SAS analysis
------------
The two phys in the HBA do _not_ form a wide port since
the other ends have different SAS addresses (sda's port
address is different from the ex1's address). Hence we
have 2 narrow ports (where 1 phy corresponds to 1 initiator
port).

Dual ported SAS disks have different SAS addresses on
each phy so that each phy will be a (narrow) target
port.

With or without the expander (ex1) there would be two
SAS domains. From the initiator's point of view the
difference between its two ports is that the silicon
state machines can see sda but not sdb (scsi1's state
machine sees ex1 instead).

sysfs and SAS discovery
-----------------------
It seems reasonable that sda should be visible in sysfs
since the silicon in the HBA (for scsi0) knows about it.
However the silicon for scsi1 knows about ex1 (and
nothing beyond that). SAS defines the Serial Management
Protocol (SMP) for the purpose of probing what (else) is
connected to an expander. SMP is similar to a SCSI command
set and SMP frames need to be sent via scsi1 to ex1.
Note that ex1 is _not_ a SCSI device (it is
part of the service delivery subsystem) and we have no
representation currently for it in sysfs. [Fibre channel
switches are architecturally similar to SAS expanders.]

It has been stated that the SAS discovery algorithm (i.e. the
recursive use of SMP) should be implemented once in the SAS
transport layer so that all SAS LLDs can use it. Putting
the SAS discovery algorithm in the user space may be
even more politically correct.

Once the SAS discovery algorithm has been run should we
show its results in sysfs?? We probably want to know
about SCSI target devices (like we do for other transports).
The SAS discovery algorithm may have found other interesting
things:
    - other expanders (beyond what the silicon has seen)
    - other initiators (implies a multi initiator environment)
    - miswired SAS domains (since SAS expander routing rules
      have restrictions)

Other tools may want to access SMP (and SCSI log pages
in SCSI target devices) to identify bottlenecks and access
vendor extensions.


Are there disagreements with the example and its analysis?
Other comments?

Doug Gilbert
