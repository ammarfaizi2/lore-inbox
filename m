Return-Path: <linux-kernel-owner+w=401wt.eu-S1753030AbXACBrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030AbXACBrr (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 20:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753103AbXACBrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 20:47:46 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:35563 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092AbXACBrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 20:47:45 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <459B0B38.3010901@s5r6.in-berlin.de>
Date: Wed, 03 Jan 2007 02:47:36 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: linux1394-user@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org
Subject: announce: ls1394 - tool to list connected FireWire devices
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I wrote a small utility which works similar to lspci, lsscsi, and lsusb:

	http://me.in-berlin.de/~s5r6/linux1394/ls1394/

Usage: ls1394 [options]
List FireWire devices

Options:
  -h, --help
      Show this help
  -v, --verbose
      Increase verbosity
  -s [[bus]:][node]
      Show only devices at selected bus (in decimal) and/or with specified
      node number (node ID or physical ID, in hexadecimal)
  -d [companyid:][guid]
      Show only devices with specified company ID or GUID (in hexadecimal)
  -a, --active
      Show only nodes with active link and general ROM
  -r, --remote
      Show only remote nodes
  -i file
      Use specified company ID (OUI) database instead of
      /usr/share/misc/oui.db
  --fetch-oui-db
      Read http://standards.ieee.org/regauth/oui/oui.txt and save
      /usr/share/misc/oui.db; required for translation of company IDs to
      company names; location of oui.db can be overridden by -i file
  -V, --version
      Show version of program

This is a preliminary version. Notably, a big missing feature is the
listing of each node's unit directories.

ls1394 is written as a bash script and only uses sysfs information. I.e.
its only driver requirements are ieee1394 and ohci1394. There are no
libraries required. ls1394 can be used by unprivileged users.

In order to get the full functionality of ls1394, you need to run it once
with the --fetch-oui-db option. This requires that you have "sed" and one
of "wget" or "curl" installed. Alternatively, you can let ls1394 access
/usr/src/linux/drivers/ieee1394/oui.db if you have kernel sources installed.
However this file will probably no longer be available from Linux 2.6.21
onwards. If you don't install a oui.db (systemwide or in a user directory),
ls1394 won't translate company IDs into human-readable vendor names, but
everything else will still work.


Example output:
$ ls1394
0:ffc0 00027a0e010020c2 IOI Technology Corporation 'CD-ROM GCR-8520B' '91021U2         '
0:ffc1 0030e0a5e0080293 OXFORD SEMICONDUCTOR LTD. 'S8001'
0:ffc2 080028560000319b Texas Instruments (local)
1:ffc0 0001042033000e16 DVICO Co., Ltd. 'MOMOBAY FX-3A'
1:ffc1 0010dc5600fed2d4 MICRO-STAR INTERNATIONAL CO., LTD. (local)
1:ffc2 0001041010004beb DVICO Co., Ltd. 'MOMOBAY CX-1'
1:ffc3 unknown
1:ffc4 00301bac00002ba4 SHUTTLE, INC.

This is from a PC with two FireWire cards which are marked as "(local)".
Node 3 on bus 1 is a hub without configuration ROM. Node 4 on bus 1 is a
remote PC.

The first column contains the number of host adapter (card) and node ID. The
second column contains the GUID. Next come the company name, names of unit
directories enclosed in '' if any exist, and the (local) flag if appropriate.
Note, the company name should be the one of the manufacturer of the device or
author of the device's firmware. But sometimes the manufacturer choses a
company ID which he doesn't own. For example, the company ID of the node 0:ffc2
should rather be the one of Sunix, not of Texas Instruments, as it is a Sunix
card (although with a TI chip.)

$ ls1394 -ar
0:ffc0 00027a0e010020c2 IOI Technology Corporation 'CD-ROM GCR-8520B' '91021U2         '
0:ffc1 0030e0a5e0080293 OXFORD SEMICONDUCTOR LTD. 'S8001'
1:ffc0 0001042033000e16 DVICO Co., Ltd. 'MOMOBAY FX-3A'
1:ffc2 0001041010004beb DVICO Co., Ltd. 'MOMOBAY CX-1'
1:ffc4 00301bac00002ba4 SHUTTLE, INC.

The local nodes (host adapters) and the hub are suppressed in this example.

$ ls1394 -s 0:0 -v
0:ffc0 00027a0e010020c2 IOI Technology Corporation 'CD-ROM GCR-8520B' '91021U2         '
        IRMC(0) CMC(0) ISC(0) BMC(0) PMC(0) GEN(0)
        LSPD(3) MAX_REC(4096) MAX_ROM(0) CYC_CLK_ACC(255)
        capabilities: 0x0083c0
        vendor_id: 0x00027a IOI Technology Corporation
        vendor_name_kv: IOI

Here, bus 0 and physical ID 0 is selected. This could also be written as
ls1394 -s 0:ffc0. The -v option adds further information. The device in this
example is a node with two unit directories. The units are named
'CD-ROM GCR-8520B' and '91021U2         ' respectively. All other nodes had
only one unit directory each.

$ ls1394 -d 000104: -v
1:ffc0 0001042033000e16 DVICO Co., Ltd. 'MOMOBAY FX-3A'
        IRMC(0) CMC(0) ISC(0) BMC(0) PMC(0) GEN(0)
        LSPD(2) MAX_REC(2048) MAX_ROM(0) CYC_CLK_ACC(255)
        capabilities: 0x0083c0
        vendor_id: 0x000104 DVICO Co., Ltd.
        vendor_name_kv:  DViCO

1:ffc2 0001041010004beb DVICO Co., Ltd. 'MOMOBAY CX-1'
        IRMC(0) CMC(0) ISC(0) BMC(0) PMC(0) GEN(0)
        LSPD(2) MAX_REC(2048) MAX_ROM(0) CYC_CLK_ACC(255)
        capabilities: 0x0083c0
        vendor_id: 0x000104 DVICO Co., Ltd.
        vendor_name_kv: "DViCO"

In this example, nodes were selected per company ID (first 6 digits of the
GUID, IOW the 24 high bits of the EUI-64).
-- 
Stefan Richter
-=====-=-=== ---= ---==
http://arcgraph.de/sr/
