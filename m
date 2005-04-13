Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbVDMPX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVDMPX1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 11:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVDMPX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 11:23:27 -0400
Received: from magic.adaptec.com ([216.52.22.17]:50399 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S261353AbVDMPWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 11:22:42 -0400
Message-ID: <425D392F.2080702@adaptec.com>
Date: Wed, 13 Apr 2005 11:22:23 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: andrew.patterson@hp.com, Eric.Moore@lsil.com, mike.miller@hp.com,
       dougg@torque.net, Madhuresh_Nagshain@adaptec.com,
       Sukanta_Ganguly@adaptec.com
Subject: [RFC] SAS domain layout for Linux sysfs
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Apr 2005 15:22:33.0825 (UTC) FILETIME=[9DB86510:01C5403C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is an RFC about a SAS domain layout for Linux sysfs.

The idea is to represent "what is out there" and "what we
see from this host adapter" in sysfs, so that a process can
show a picture of the storage network.

This gives a close representation of what the SAS
spec describes, so that more tools can be built on that,
like storage applications, user applications, etc.

The SAS LLDD registers with the SAS class, giving it
information about itself: phys, WWNs, etc.  The SAS class
does SAS domain discovery, representing its findings in the
syfs host domain and in the sysfs SAS domain (defined in the
RFC below).

SAS domain layout for Linux sysfs
=================================

0. Introduction

The use of SAS address and WWN are used interchangeably.

There are two domains which we want to represent in sysfs, in
order to eliminate redundancies.

            |     /-------------------\
+-------+   |    /  SAS_ADDR0          \
|ha0 [] =---|---(                       )
+---||||+   |    \                     /
            |     |       SAS_ADDR2   |
+-------+   |    /                     \
|ha1 [] =---|---(      SAS_ADDR1        )
+---||||+   |    \                     /
            |     \___________________/
            |
Host domain |         SAS Domain

     Figure 1. Domains represented by sysfs

The host domain (/sys/class/sas_ha/ha0/, etc) shows the SAS
domain as seen by the Host Adapter.  The sysfs SAS domain
(/sys/bus/sas/ ), shows the SAS domain as it exists
irrespectively of which HA (Host Adapter) you use to connect
to it (to a device).

           |                        |
+-------+  |  +-----+               |
|ha0 [] =--|--= ex0 =--.            |
+---||||+  |  +-----+   \  +-----+  |
           |             `-= ex2 =--|--> ta0
           |               |     =--|--> in2
           |             .-=     =--|--> ta2
+-------+  |  +-----+   /  +-----+  |
|ha1 [] =--|--= ex1 =--'            |
+---||||+  |  +-----+               |
           |                        |
Host domain| Sysfs SAS domain only  | Both domains

     Figure 2. Breakdown of sample storage setup

Host domain: /sys/class/sas_ha/haX
	Since its point of view is from the host where
	ha0 and ha1 are.

Sysfs SAS domain only: /sys/bus/sas/...
	Since it is part of the SDS and irrespective
	of the host.  I.e. another host could connect
	to ex1 or even to ex2, and see the same devices.

Both domains:
	Since those end devices are visible by all
	host SAS processes.

1 Host Domain
-------------

The host domain is a SAS domain as seen by a particular SAS
Host Adapter. It lives in /sys/class/sas_ha .

/sys/class/sas_ha/

Holds all Host Adapters.

/sys/class/sas_ha/ha0
/sys/class/sas_ha/ha1
..., etc.

Host adapter directories hold the attributes of the host
adapter, the phys and the ports. E.g.

/sys/class/sas_ha/ha0/device --> <PCI device directory>
/sys/class/sas_ha/ha0/driver --> <PCI driver directory>
/sys/class/sas_ha/ha0/phys/
/sys/class/sas_ha/ha0/ports/
/sys/class/sas_ha/ha0/device_name

device_name is a sysfs text file holding the SAS address of
the SAS host adapter.

phys/ lists the phys which are part of the HA (Host
      Adapter).

/sys/class/sas_ha/ha0/phys/0/
/sys/class/sas_ha/ha0/phys/1/
..., etc.

A phy has attributes which are stored in its directory,
e.g.:

/sys/class/sas_ha/ha0/phys/0/
/sys/class/sas_ha/ha0/phys/0/port --> ../../ports/<port id>
/sys/class/sas_ha/ha0/phys/0/id         (same as .)
/sys/class/sas_ha/ha0/phys/0/enabled
/sys/class/sas_ha/ha0/phys/0/class
/sys/class/sas_ha/ha0/phys/0/proto
/sys/class/sas_ha/ha0/phys/0/type
/sys/class/sas_ha/ha0/phys/0/role
/sys/class/sas_ha/ha0/phys/0/linkrate
/sys/class/sas_ha/ha0/phys/0/sas_address
	 (sas address as transmitted in IDENTIFY)

Those are standard attributes, SAS 1.1, chapter 4.

ports/ lists the ports which are part of the HA.

1.1 Directly attached end devices
---------------------------------

/sys/class/sas_ha/ha0/ports/<port id>/
/sys/class/sas_ha/ha0/ports/<port id>/class
/sys/class/sas_ha/ha0/ports/<port id>/port_identifier
/sys/class/sas_ha/ha0/ports/<port id>/attached_port_identifier -> ../../../../../bus/sas/<WWN_ta0>/ports/<port id>/port_identifier
/sys/class/sas_ha/ha0/ports/<port id>/phys/
/sys/class/sas_ha/ha0/ports/<port id>/phys/0 -> ../../../phys/0
/sys/class/sas_ha/ha0/ports/<port id>/phys/1 -> ../../../phys/1
/sys/class/sas_ha/ha0/ports/<port id>/devices/
/sys/class/sas_ha/ha0/ports/<port id>/devices/ta0 -> ../../../devices/ta0

<port id> is a positive integer starting from 0, which is
just a local port identifier.

port_identifier is a text file, which is the SAS port
identifier.

attached_port_identifier is a link to the other port's WWN.
It is a link to the port inside a device's directory
structure in the sysfs SAS domain.

phys/ is a directory with symlinks to phys of that adapter
which participate in this port.

devices/ is a directory of devices visible from this port,
In this case a single device directly attached.

1.2 Devices past expanders
--------------------------

/sys/class/sas_ha/ha0/ports/<port id>/
/sys/class/sas_ha/ha0/ports/<port id>/class
/sys/class/sas_ha/ha0/ports/<port id>/port_identifier
/sys/class/sas_ha/ha0/ports/<port id>/attached_port_identifier -> ../../../../../bus/sas/<WWN_ex0>/ports/<port id>/port_identifier
/sys/class/sas_ha/ha0/ports/<port id>/phys/
/sys/class/sas_ha/ha0/ports/<port id>/phys/0 -> ../../../phys/0
/sys/class/sas_ha/ha0/ports/<port id>/phys/1 -> ../../../phys/1
/sys/class/sas_ha/ha0/ports/<port id>/ex0 -> ../../../../../bus/sas/<WWN_ex0>
/sys/class/sas_ha/ha0/ports/<port id>/devices/
/sys/class/sas_ha/ha0/ports/<port id>/devices/ta1 -> ../../../devices/ta1
/sys/class/sas_ha/ha0/ports/<port id>/devices/in3 -> ../../../devices/in3

Using SMP DISCOVER for each phy of the expander
we find out ports (matching attached WWNs from the expander's
view point) and report them. See sysfs SAS domain below.


1.3 Host adapter directory
--------------------------

Host adapter directories would also hold a "cheat sheet"
of

/sys/class/sas_ha/ha0/devices/

The contents of this directory would be symbolic links to
the sysfs SAS domain.  The name used, two letters and an
integer, is per HA unique.

/sys/class/sas_ha/ha0/devices/ta0 -> ../../../../sas/bus/<WWN_ta0>
/sys/class/sas_ha/ha0/devices/ta1 -> ../../../../sas/bus/<WWN_ta1>
/sys/class/sas_ha/ha0/devices/in3 -> ../../../../sas/bus/<WWN_in3>

All those point to directories in the sysfs SAS domain,
where attributes of those devices are held.


2. Sysfs SAS Domain
-------------------

Represent everything which "sits out there" in the SAS
domain, irrespective of how you connect to it.

/sys/bus/sas/
/sys/bus/sas/<WWN_ta0>/
/sys/bus/sas/<WWN_ta0>/phys/

The ports/ directory is populated when different
initiators discover the device.  That is, for each HA which
can make a connection to the target, there's a port on the
target, we record those ports here.

/sys/bus/sas/<WWN_ta0>/ports/
/sys/bus/sas/<WWN_ta0>/ports/<port id>/port_identifer
/sys/bus/sas/<WWN_ta0>/ports/<port id>/attached_port_identifer -> ../../../../../class/sas_ha/ha0/ports/<port id>/port_identifier

port_identifier is a text file whose contents is the
WWN of the port.

/sys/bus/sas/<WWN_ta1>/
/sys/bus/sas/<WWN_in3>/
/sys/bus/sas/<WWN_ex2>/

/sys/bus/sas/<WWN_ex0>/
/sys/bus/sas/<WWN_ex0>/phys/
/sys/bus/sas/<WWN_ex0>/ports/
/sys/bus/sas/<WWN_ex0>/ports/<port id>/
/sys/bus/sas/<WWN_ex0>/ports/<port id>/port_identifier
/sys/bus/sas/<WWN_ex0>/ports/<port id>/attached_port_identifier -> ../../../../../class/sas_ha/ha0/ports/<port id>/port_identifier
/sys/bus/sas/<WWN_ex0>/devices/
/sys/bus/sas/<WWN_ex0>/devices/<WWN_ta1> -> ../../<WWN_ta1>
/sys/bus/sas/<WWN_ex0>/devices/<WWN_ta0> -> ../../<WWN_ta0>
	(in case connection to ta0 through ex0 is also
	possible)


Thanks,
	Luben

