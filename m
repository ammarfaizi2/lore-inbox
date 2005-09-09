Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030317AbVIITaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030317AbVIITaR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 15:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030318AbVIITaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 15:30:17 -0400
Received: from magic.adaptec.com ([216.52.22.17]:21700 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1030317AbVIITaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 15:30:15 -0400
Message-ID: <4321E2C1.7080507@adaptec.com>
Date: Fri, 09 Sep 2005 15:30:09 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: [ANNOUNCE 0/2] Serial Attached SCSI (SAS) support for the Linux kernel
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2005 19:30:14.0820 (UTC) FILETIME=[E71D0640:01C5B574]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following announcements and patches introduce 
Serial Attached SCSI (SAS) support for the Linux kernel.
Everything is supported.

The infrastructure is broken into
	* SAS LLDD,
	* SAS Layer.

The SAS LLDD does phy/OOB management, and generates SAS events
to the SAS Layer.  Those events are *the only way* a SAS LLDD
communicates with the SAS Layer.  If you can generate 2 types
of event, then you can use this infrastructure.  The first two
are, loosely, "link was severed", "bytes were dmaed".  The third
kind is "received a primitive", used for domain revalidation.

A SAS LLDD should implement the Execute Command SCSI RPC and
at least one SCSI TMF (Task Management Function), in order for
the SAS Layer to communicate with the SAS LLDD.

The SAS Layer is concerned with
      * SAS Phy/Port/HA event management (LLDD generates,
        SAS Layer processes),
      * SAS Port management (creation/destruction),
      * SAS Domain discovery and revalidation,
      * SAS Domain device management,
      * SCSI Host registration/deregistration,
      * Device registration with SCSI Core (SAS) or libata
        (SATA/PI), and
      * Expander management and exporting expander control
        to user space.

The SAS Layer uses the Execute Command SCSI RPC, and the TMFs
implemented by the SAS LLDD in order to manage the domain and
the domain devices.

For details please see drivers/scsi/sas-class/README.

The SAS Layer represents the SAS domain in sysfs.  For each
object represented, its parent is the physical entity it attaches
to in the physical world.  So in effect, kobject_get, gets
the whole chain up on which that object depends on.

In effect, the sysfs representation of the SAS domain(s)
is what you'd see in the physical world.

Hot plugging and hot unplugging of devices, domains and subdomains
is supported.  Repeated hot plugging and hot unplugging is
also supported, naturally.

SAS introduces a new physical entity, an expander.
Expanders are _not_ SAS devices, and thus are _not_ SCSI devices.
Expanders are part of the Service Delivery Subsystem, in this case
SAS.

Expanders are controlled using the Serial Management Protocol (SMP).
Complete control is given to user space of all expanders found
in the domain, using an "smp_portal".  More of this in the second
and third email in this series.

A user space program, "expander_conf.c" is also presented to show
how one controls expanders in the domain.  It is located here:
drivers/scsi/sas-class/expanders_conf.c

The second email in this series shows an example of SAS domains
and their representation in sysfs.

The third email in this series shows an example of using the
"expander_conf.c" program to query all expanders in the domain,
showing their attributes, their phys, and their routing tables.

If you have the hardware, please give it a try.  If you have
expander(s) it would be even more interesting.

Patches of the SAS Layer and of the AIC94XX SAS LLDD follow.

	Luben
P.S. You can also download the patches from
http://www.geocities.com/ltuikov/

