Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262918AbUKRT2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262918AbUKRT2t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 14:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262917AbUKRTOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 14:14:44 -0500
Received: from fmr12.intel.com ([134.134.136.15]:40064 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S262905AbUKRTJD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 14:09:03 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Bonding-devel][PATCH]Zero Copy Transmit Support (Update)
Date: Thu, 18 Nov 2004 11:02:12 -0800
Message-ID: <F760B14C9561B941B89469F59BA3A847083183FE@orsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Bonding-devel][PATCH]Zero Copy Transmit Support (Update)
Thread-Index: AcTITHNPBHIfGinGQ8GOOQILPIIIqQFUYiww
From: "Godse, Radheka" <radheka.godse@intel.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: <bonding-devel@lists.sourceforge.net>, <fubar@us.ibm.com>,
       <ctindel@users.sourceforge.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Nov 2004 19:02:14.0292 (UTC) FILETIME=[1D948D40:01C4CDA1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -
> + 
> +	/* We let the bond device publish all hardware
> +	 * acceleration features possible. This is OK,
> +	 * since if an skb is passed from the bond to
> +	 * a slave that doesn't support one of those
> +	 * features, everything is fixed in the
> +	 * dev_queue_xmit() function (e.g. calculate
> +	 * check sum, linearize the skb, etc.).
> +	 */

This is very inefficient if the bond slaves don't
support these features.

I believe you when you say you saw improvement in the
case where the slaves do support TSO, but if you test
a non-TSO slave case I bet you'll see a marked
decrease in system utilization at least.
...

Note: 2.6.2 patch enables Zero Copy Transmit support by default while
registering the bond device... but, I continue to see better CPU
utilization (~50% improvement) when this patch was tested in various
scenarios(see data below). Test results are from a dual Itanium 2 1.4GHz
system but I saw a similar trend on a PIII Xeon 550MHz x 8 system.
 
bond-patch-2.6.1 and 82546EB Copper NICs with hardware acceleration
support, 
Test results with TSO on and off
ETH1  ETH2  Throughput/Performance  System Utilization
on    off  1870                    35 %
on   on   1870                    35 %
off   off   1871                    34 %

bond-patch-2.6.2 and 82546EB Copper NICs with hardware acceleration
support, 
Test results with TSO on and off
ETH1  ETH2  Throughput/Performance  System Utilization
on    off  1879                    14 %
on   on   1880                    14.08 %
off   off   1879                    13 %
------------------------------------------------------------------

bond-patch-2.6.1 and 82543GC NICs without hardware support for TSO
ETH1  ETH2  Throughput/Performance  System Utilization
off   off   1815                    36.85 %
 
bond-patch-2.6.2 and 82543GC NICs without hardware support for TSO
ETH1  ETH2  Throughput/Performance  System Utilization
off   off   1848                    11.85 %
------------------------------------------------------------------

bond-patch-2.6.1, and one 82546EB NIC with & one 82543GC NIC without
hardware support for TSO 
ETH1  ETH2  Throughput/Performance  System Utilization

on    off   1817                    30.69 %

bond-patch-2.6.2, and one 82546EB NIC with & one 82543GC NIC without
hardware support for TSO 
ETH1  ETH2  Throughput/Performance  System Utilization
on    off   1836                    24.54 %
------------------------------------------------------------------

bond-patch-2.6.1 and 82543GC NICs
Test results with all HW acceleration bits on for 1 NIC and turned off
for the other NIC
ETH1  ETH2  Throughput/Performance  System Utilization
on    off  1851                    35 %

bond-patch-2.6.2 and 82543GC NICs
Test results with all HW acceleration bits on for 1 NIC and turned off
for the other NIC
ETH1  ETH2  Throughput/Performance  System Utilization
on    off  1822                    17 %
------------------------------------------------------------------

bond-patch-2.6.1 and 82543GC NICs
Test results with all HW acceleration bits turned off for both NICs
ETH1  ETH2  Throughput/Performance  System Utilization
off    off  1816                    35 %
 
bond-patch-2.6.2 and 82543GC NICs
Test results with all HW acceleration bits turned off for both NICs
ETH1  ETH2  Throughput/Performance  System Utilization
off    off  1604                    16.23 %
