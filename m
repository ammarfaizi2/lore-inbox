Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755138AbWKVPbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755138AbWKVPbv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 10:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755146AbWKVPbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 10:31:51 -0500
Received: from wx-out-0506.google.com ([66.249.82.233]:60531 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1755138AbWKVPbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 10:31:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XLFHN79o9wpdQ1e9ZwT/lv91Hsn1WJ2UTD2qCbeZI8XPSOJS0Evov0q92JqJJi6woHbbad+LyNFPfv2X39Zl8KfHGIW/shCF2TTEtQDNpYw3o3QXUNwy8sf673GiEfbeznChAY26O8C54/MhSjgN8bAIy3PLljdrIW29+H7pBM4=
Message-ID: <e6babb600611220731p67b15e51q95f524683070ae80@mail.gmail.com>
Date: Wed, 22 Nov 2006 08:31:47 -0700
From: "Robert Crocombe" <rcrocomb@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       linux1394-devel <linux1394-devel@lists.sourceforge.net>
Subject: ieee1394: host adapter disappears on 1394 bus reset
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an Opteron-based machine that has 1 Unibrain Fireboard 800 and
1 Indigita IDT804 card (4 separate 1394 controllers).  Sometimes upon
bus reset, one of the controllers is lost.  By lost, I mean that
debugging printouts in /var/log/messages which are usually prefixed
"fw-hostXYZ" are gone.  Additionally, I have software that (among
other things) installs a bus reset handler for each port that it uses,
and the handler is never called after the controller vanishes from the
log.  However, the problem can occur without my ever loading that
software: it's just a handy way of confirming that the controller is
missing.  Note that all ports show up with a raw1394_new_handle() and
raw1394_get_port_info(), etc., and a raw1394_set_port() succeeds.

I originally noticed this under 2.6.16-rt29, but have had the same
results with both plain 2.6.16 and 2.6.18 (though it was much harder
to reproduce with the non-rt kernels).  It appears to be timing
related, in that it doesn't appear possible to predict on which bus
reset it might occur.  On the -rt kernel, I've had it appear as
quickly as the 2nd bus reset after boot, but with 2.6.18 it's taken
perhaps 40 resets to cause the problem.  I cause the resets using a
DAP Firespy, which has a GUI button for causing a bus reset.

I'm appending a bit of the /var/log/messages from the machine.  I am
running with the excessive debugging info, and the problem always
occurs sometime after the statement "PhyReqFilter=000..." is printed.
The hosts that continue to work always print "IntEvent: 00020010"
thereafter, but never the broken one.

It is possible to restore functionality to the lost port by rmmod'ing
ohci1394 and then modprobing it.

Please let me know what I can do to help track this down and fix it.

-- 
Robert Crocombe
rcrocomb@gmail.com

This log is from a bus with 18 nodes on it.  As noted, there are 5
ports on the machine.  At the point when this occurred, I was clicking
the bus reset button on the analyzer like a chimp.  "fw-host3" is the
host that is lost: host0 is the single port on the Fireboard, and 1-4
are on the Indigita.  Which port is lost varies from occurrence to
occurrence, but it actually had never been anything other than 2 or 4
until it happened to 3 on this attempt.  This problem has occurred
with several different machines (even after swapping to different
Indigita cards).

Nov 22 07:59:54 spanky kernel: ohci1394: fw-host0: IntEvent: 00020010
Nov 22 07:59:54 spanky kernel: ohci1394: fw-host4: IntEvent: 00020000
Nov 22 07:59:54 spanky kernel: ohci1394: fw-host4: irq_handler: Bus
reset requested
Nov 22 07:59:54 spanky kernel: ohci1394: fw-host4: Cancel request received
Nov 22 07:59:54 spanky kernel: ohci1394: fw-host1: IntEvent: 00020010
Nov 22 07:59:54 spanky kernel: ohci1394: fw-host1: irq_handler: Bus
reset requested
Nov 22 07:59:54 spanky kernel: ohci1394: fw-host1: Cancel request received
Nov 22 07:59:54 spanky kernel: ohci1394: fw-host4: IntEvent: 00000010
Nov 22 07:59:54 spanky kernel: ohci1394: fw-host1: Got RQPkt interrupt
status=0x00008409
Nov 22 07:59:54 spanky kernel: ohci1394: fw-host4: Got RQPkt interrupt
status=0x00008409
Nov 22 07:59:54 spanky kernel: ohci1394: fw-host2: IntEvent: 00020010
Nov 22 07:59:54 spanky kernel: ohci1394: fw-host0: irq_handler: Bus
reset requested
Nov 22 07:59:54 spanky kernel: ohci1394: fw-host0: Cancel request received
Nov 22 07:59:54 spanky kernel: ohci1394: fw-host2: irq_handler: Bus
reset requested
Nov 22 07:59:54 spanky kernel: ohci1394: fw-host2: Cancel request received
Nov 22 07:59:54 spanky kernel: ohci1394: fw-host0: Got RQPkt interrupt
status=0x00008409
Nov 22 07:59:54 spanky kernel: ohci1394: fw-host3: IntEvent: 00020010
Nov 22 07:59:54 spanky kernel: ohci1394: fw-host3: irq_handler: Bus
reset requested
Nov 22 07:59:54 spanky kernel: ohci1394: fw-host3: Cancel request received
Nov 22 07:59:54 spanky kernel: ohci1394: fw-host2: Got RQPkt interrupt
status=0x00008409
Nov 22 07:59:54 spanky kernel: ohci1394: fw-host2: Single packet rcv'd
Nov 22 07:59:54 spanky kernel: ohci1394: fw-host2: Single packet rcv'd
Nov 22 07:59:54 spanky kernel: ohci1394: fw-host4: Single packet rcv'd
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host3: Got RQPkt interrupt
status=0x00008409
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host3: Single packet rcv'd
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host3: Single packet rcv'd
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host0: Single packet rcv'd
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host1: Single packet rcv'd
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host1: Single packet rcv'd
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host4: Single packet rcv'd
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host0: IntEvent: 00010000
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host0: SelfID interrupt
received (phyid 8, not root)
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host1: IntEvent: 00010000
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host1: SelfID interrupt
received (phyid 5, not root)
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host4: IntEvent: 00010000
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host4: SelfID interrupt
received (phyid 6, not root)
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host1: SelfID packet
0x803fc094 received
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host4: SelfID packet
0x803fc094 received
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host4: SelfID packet
0x817fc494 received
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host4: SelfID packet
0x823fc4f8 received
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host4: SelfID packet
0x837fc494 received
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host4: SelfID packet
0x843fc4f8 received
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host4: SelfID packet
0x857fc494 received
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host4: SelfID packet
0x867fc494 received
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host4: SelfID for this
node is 0x867fc494
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host4: SelfID packet
0x873fc4f8 received
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host4: SelfID packet
0x887fc45a received
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host4: SelfID packet
0x893fc458 received
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host4: SelfID packet
0x8a3fc4da received
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host4: SelfID packet
0x8b3fc496 received
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host4: SelfID packet
0x8c3fc4bc received
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host4: SelfID packet
0x8d3fc49c received
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host4: SelfID packet
0x8e3fc4bc received
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host4: SelfID packet
0x8f3fc4fa received
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host4: SelfID packet
0x903fc494 received
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host4: SelfID packet
0x913fc4fc received
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host4: SelfID complete
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host4: PhyReqFilter=0000000000000000
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host1: SelfID packet
0x817fc494 received
Nov 22 07:59:55 spanky kernel: ohci1394: fw-host1: SelfID packet
0x823fc4f8 received
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host1: SelfID packet
0x837fc494 received
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host1: SelfID packet
0x843fc4f8 received
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host1: SelfID packet
0x857fc494 received
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host1: SelfID for this
node is 0x857fc494
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host1: SelfID packet
0x867fc494 received
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host1: SelfID packet
0x873fc4f8 received
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host1: SelfID packet
0x887fc45a received
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host1: SelfID packet
0x893fc458 received
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host1: SelfID packet
0x8a3fc4da received
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host1: SelfID packet
0x8b3fc496 received
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host1: SelfID packet
0x8c3fc4bc received
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host1: SelfID packet
0x8d3fc49c received
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host2: IntEvent: 00010000
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host2: SelfID interrupt
received (phyid 1, not root)
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host1: SelfID packet
0x8e3fc4bc received
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host2: SelfID packet
0x803fc094 received
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host2: SelfID packet
0x817fc494 received
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host2: SelfID for this
node is 0x817fc494
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host2: SelfID packet
0x823fc4f8 received
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host2: SelfID packet
0x837fc494 received
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host2: SelfID packet
0x843fc4f8 received
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host2: SelfID packet
0x857fc494 received
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host2: SelfID packet
0x867fc494 received
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host2: SelfID packet
0x873fc4f8 received
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host2: SelfID packet
0x887fc45a received
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host2: SelfID packet
0x893fc458 received
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host2: SelfID packet
0x8a3fc4da received
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host2: SelfID packet
0x8b3fc496 received
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host2: SelfID packet
0x8c3fc4bc received
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host2: SelfID packet
0x8d3fc49c received
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host2: SelfID packet
0x8e3fc4bc received
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host2: SelfID packet
0x8f3fc4fa received
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host2: SelfID packet
0x903fc494 received
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host2: SelfID packet
0x913fc4fc received
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host2: SelfID complete
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host2: PhyReqFilter=0000000000000000
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host1: SelfID packet
0x8f3fc4fa received
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host1: SelfID packet
0x903fc494 received
Nov 22 07:59:56 spanky kernel: ohci1394: fw-host1: SelfID packet
0x913fc4fc received
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host1: SelfID complete
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host1: PhyReqFilter=0000000000000000
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host0: SelfID packet
0x803fc094 received
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host0: SelfID packet
0x817fc494 received
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host0: SelfID packet
0x823fc4f8 received
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host0: SelfID packet
0x837fc494 received
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host0: SelfID packet
0x843fc4f8 received
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host0: SelfID packet
0x857fc494 received
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host0: SelfID packet
0x867fc494 received
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host0: SelfID packet
0x873fc4f8 received
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host0: SelfID packet
0x887fc45a received
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host0: SelfID for this
node is 0x887fc45a
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host0: SelfID packet
0x893fc458 received
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host0: SelfID packet
0x8a3fc4da received
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host0: SelfID packet
0x8b3fc496 received
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host0: SelfID packet
0x8c3fc4bc received
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host0: SelfID packet
0x8d3fc49c received
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host0: SelfID packet
0x8e3fc4bc received
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host0: SelfID packet
0x8f3fc4fa received
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host0: SelfID packet
0x903fc494 received
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host0: SelfID packet
0x913fc4fc received
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host0: SelfID complete
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host0: PhyReqFilter=0000000000000000
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host3: IntEvent: 00010000
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host3: SelfID interrupt
received (phyid 3, not root)
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host3: SelfID packet
0x803fc094 received
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host3: SelfID packet
0x817fc494 received
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host3: SelfID packet
0x823fc4f8 received
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host3: SelfID packet
0x837fc494 received
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host3: SelfID for this
node is 0x837fc494
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host3: SelfID packet
0x843fc4f8 received
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host3: SelfID packet
0x857fc494 received
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host3: SelfID packet
0x867fc494 received
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host3: SelfID packet
0x873fc4f8 received
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host3: SelfID packet
0x887fc45a received
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host3: SelfID packet
0x893fc458 received
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host3: SelfID packet
0x8a3fc4da received
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host3: SelfID packet
0x8b3fc496 received
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host3: SelfID packet
0x8c3fc4bc received
Nov 22 07:59:57 spanky kernel: ohci1394: fw-host3: SelfID packet
0x8d3fc49c received
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host3: SelfID packet
0x8e3fc4bc received
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host3: SelfID packet
0x8f3fc4fa received
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host3: SelfID packet
0x903fc494 received
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host3: SelfID packet
0x913fc4fc received
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host3: SelfID complete
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host3: PhyReqFilter=0000000000000000
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host4: IntEvent: 00020010
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host1: IntEvent: 00020010
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host1: irq_handler: Bus
reset requested
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host1: Cancel request received
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host4: irq_handler: Bus
reset requested
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host4: Cancel request received
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host1: Got RQPkt interrupt
status=0x00008409
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host4: Got RQPkt interrupt
status=0x00008409
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host0: IntEvent: 00020010
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host0: irq_handler: Bus
reset requested
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host0: Cancel request received
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host2: IntEvent: 00020010
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host0: Got RQPkt interrupt
status=0x00008409
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host2: irq_handler: Bus
reset requested
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host2: Cancel request received
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host3: IntEvent: 00020010
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host3: irq_handler: Bus
reset requested
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host3: Cancel request received
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host3: Got RQPkt interrupt
status=0x00008409
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host2: Got RQPkt interrupt
status=0x00008409
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host3: Single packet rcv'd
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host2: Single packet rcv'd
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host4: Single packet rcv'd
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host0: Single packet rcv'd
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host1: Single packet rcv'd
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host0: IntEvent: 00010000
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host0: SelfID interrupt
received (phyid 11, not root)
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host0: SelfID packet
0x807fc494 received
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host1: IntEvent: 00010000
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host4: IntEvent: 00010000
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host1: SelfID interrupt
received (phyid 0, not root)
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host4: SelfID interrupt
received (phyid 1, not root)
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host4: SelfID packet
0x807fc494 received
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host1: SelfID packet
0x807fc494 received
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host1: SelfID for this
node is 0x807fc494
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host1: SelfID packet
0x817fc494 received
Nov 22 07:59:58 spanky kernel: ohci1394: fw-host1: SelfID packet
0x823fc4f8 received
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host1: SelfID packet
0x833fc096 received
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host1: SelfID packet
0x847fc494 received
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host1: SelfID packet
0x853fc4f8 received
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host1: SelfID packet
0x867fc494 received
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host1: SelfID packet
0x873fc4f8 received
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host1: SelfID packet
0x883fc494 received
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host1: SelfID packet
0x893fc4ec received
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host1: SelfID packet
0x8a3fc4ec received
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host1: SelfID packet
0x8b7fc458 received
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host1: SelfID packet
0x8c3fc4f8 received
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host1: SelfID packet
0x8d3fc4d8 received
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host1: SelfID packet
0x8e3fc458 received
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host1: SelfID packet
0x8f3fc4d8 received
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host1: SelfID packet
0x903fc494 received
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host1: SelfID packet
0x913fc4fc received
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host1: SelfID complete
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host1: PhyReqFilter=0000000000000000
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host4: SelfID packet
0x817fc494 received
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host4: SelfID for this
node is 0x817fc494
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host4: SelfID packet
0x823fc4f8 received
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host4: SelfID packet
0x833fc096 received
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host4: SelfID packet
0x847fc494 received
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host4: SelfID packet
0x853fc4f8 received
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host4: SelfID packet
0x867fc494 received
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host4: SelfID packet
0x873fc4f8 received
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host4: SelfID packet
0x883fc494 received
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host4: SelfID packet
0x893fc4ec received
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host4: SelfID packet
0x8a3fc4ec received
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host4: SelfID packet
0x8b7fc458 received
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host4: SelfID packet
0x8c3fc4f8 received
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host4: SelfID packet
0x8d3fc4d8 received
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host0: SelfID packet
0x817fc494 received
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host0: SelfID packet
0x823fc4f8 received
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host0: SelfID packet
0x833fc096 received
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host0: SelfID packet
0x847fc494 received
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host0: SelfID packet
0x853fc4f8 received
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host0: SelfID packet
0x867fc494 received
Nov 22 07:59:59 spanky kernel: ohci1394: fw-host0: SelfID packet
0x873fc4f8 received
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host0: SelfID packet
0x883fc494 received
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host0: SelfID packet
0x893fc4ec received
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host0: SelfID packet
0x8a3fc4ec received
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host0: SelfID packet
0x8b7fc458 received
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host0: SelfID for this
node is 0x8b7fc458
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host0: SelfID packet
0x8c3fc4f8 received
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host0: SelfID packet
0x8d3fc4d8 received
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host0: SelfID packet
0x8e3fc458 received
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host0: SelfID packet
0x8f3fc4d8 received
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host0: SelfID packet
0x903fc494 received
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host0: SelfID packet
0x913fc4fc received
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host0: SelfID complete
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host0: PhyReqFilter=0000000000000000
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host4: SelfID packet
0x8e3fc458 received
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host4: SelfID packet
0x8f3fc4d8 received
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host4: SelfID packet
0x903fc494 received
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host4: SelfID packet
0x913fc4fc received
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host4: SelfID complete
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host4: PhyReqFilter=0000000000000000
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host3: IntEvent: 00010000
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host3: SelfID interrupt
received (phyid 6, not root)
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host3: SelfID packet
0x807fc494 received
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host3: SelfID packet
0x817fc494 received
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host3: SelfID packet
0x823fc4f8 received
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host3: SelfID packet
0x833fc096 received
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host3: SelfID packet
0x847fc494 received
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host3: SelfID packet
0x853fc4f8 received
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host2: IntEvent: 00010000
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host3: SelfID packet
0x867fc494 received
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host2: SelfID interrupt
received (phyid 4, not root)
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host2: SelfID packet
0x807fc494 received
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host2: SelfID packet
0x817fc494 received
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host2: SelfID packet
0x823fc4f8 received
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host2: SelfID packet
0x833fc096 received
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host2: SelfID packet
0x847fc494 received
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host2: SelfID for this
node is 0x847fc494
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host2: SelfID packet
0x853fc4f8 received
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host2: SelfID packet
0x867fc494 received
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host2: SelfID packet
0x873fc4f8 received
Nov 22 08:00:00 spanky kernel: ohci1394: fw-host2: SelfID packet
0x883fc494 received
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host2: SelfID packet
0x893fc4ec received
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host2: SelfID packet
0x8a3fc4ec received
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host2: SelfID packet
0x8b7fc458 received
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host2: SelfID packet
0x8c3fc4f8 received
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host2: SelfID packet
0x8d3fc4d8 received
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host2: SelfID packet
0x8e3fc458 received
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host2: SelfID packet
0x8f3fc4d8 received
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host2: SelfID packet
0x903fc494 received
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host2: SelfID packet
0x913fc4fc received
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host2: SelfID complete
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host2: PhyReqFilter=0000000000000000
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host3: SelfID for this
node is 0x867fc494
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host3: SelfID packet
0x873fc4f8 received
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host3: SelfID packet
0x883fc494 received
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host3: SelfID packet
0x893fc4ec received
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host3: SelfID packet
0x8a3fc4ec received
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host3: SelfID packet
0x8b7fc458 received
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host3: SelfID packet
0x8c3fc4f8 received
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host3: SelfID packet
0x8d3fc4d8 received
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host3: SelfID packet
0x8e3fc458 received
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host3: SelfID packet
0x8f3fc4d8 received
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host3: SelfID packet
0x903fc494 received
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host3: SelfID packet
0x913fc4fc received
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host3: SelfID complete
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host3: PhyReqFilter=0000000000000000
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host4: IntEvent: 00020010
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host4: irq_handler: Bus
reset requested
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host4: Cancel request received
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host1: IntEvent: 00020010
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host1: irq_handler: Bus
reset requested
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host1: Cancel request received
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host4: Got RQPkt interrupt
status=0x00008409
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host1: Got RQPkt interrupt
status=0x00008409
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host2: IntEvent: 00020010
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host0: IntEvent: 00020010
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host0: irq_handler: Bus
reset requested
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host0: Cancel request received
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host2: irq_handler: Bus
reset requested
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host0: Got RQPkt interrupt
status=0x00008409
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host2: Cancel request received
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host3: IntEvent: 00020010
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host3: irq_handler: Bus
reset requested
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host3: Cancel request received
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host2: Got RQPkt interrupt
status=0x00008409
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host3: Got RQPkt interrupt
status=0x00008409
Nov 22 08:00:01 spanky kernel: ohci1394: fw-host2: Single packet rcv'd
Nov 22 08:00:02 spanky kernel: ohci1394: fw-host3: Single packet rcv'd
Nov 22 08:00:02 spanky kernel: ohci1394: fw-host3: Single packet rcv'd
Nov 22 08:00:02 spanky kernel: ohci1394: fw-host0: Single packet rcv'd
Nov 22 08:00:02 spanky kernel: ohci1394: fw-host1: Single packet rcv'd
Nov 22 08:00:02 spanky kernel: ohci1394: fw-host1: Single packet rcv'd
Nov 22 08:00:02 spanky kernel: ohci1394: fw-host2: Single packet rcv'd
Nov 22 08:00:02 spanky kernel: ohci1394: fw-host4: Single packet rcv'd
Nov 22 08:00:02 spanky kernel: ohci1394: fw-host4: Single packet rcv'd
Nov 22 08:00:02 spanky kernel: ohci1394: fw-host0: IntEvent: 00010000
Nov 22 08:00:02 spanky kernel: ohci1394: fw-host0: SelfID interrupt
received (phyid 7, not root)
Nov 22 08:00:02 spanky kernel: ohci1394: fw-host1: IntEvent: 00010000
Nov 22 08:00:02 spanky kernel: ohci1394: fw-host4: IntEvent: 00010000
Nov 22 08:00:02 spanky kernel: ohci1394: fw-host1: SelfID interrupt
received (phyid 4, not root)
Nov 22 08:00:02 spanky kernel: ohci1394: fw-host4: SelfID interrupt
received (phyid 5, not root)
Nov 22 08:00:02 spanky kernel: ohci1394: fw-host4: SelfID packet
0x803fc094 received
Nov 22 08:00:02 spanky kernel: ohci1394: fw-host1: SelfID packet
0x803fc094 received
Nov 22 08:00:02 spanky kernel: ohci1394: fw-host1: SelfID packet
0x817fc494 received
Nov 22 08:00:02 spanky kernel: ohci1394: fw-host1: SelfID packet
0x823fc4f8 received
Nov 22 08:00:02 spanky kernel: ohci1394: fw-host1: SelfID packet
0x837fc494 received
Nov 22 08:00:02 spanky kernel: ohci1394: fw-host1: SelfID packet
0x847fc494 received
Nov 22 08:00:02 spanky kernel: ohci1394: fw-host1: SelfID for this
node is 0x847fc494
Nov 22 08:00:02 spanky kernel: ohci1394: fw-host1: SelfID packet
0x857fc494 received
Nov 22 08:00:02 spanky kernel: ohci1394: fw-host1: SelfID packet
0x863fc4f8 received
Nov 22 08:00:02 spanky kernel: ohci1394: fw-host1: SelfID packet
0x877fc45a received
Nov 22 08:00:02 spanky kernel: ohci1394: fw-host1: SelfID packet
0x883fc458 received
Nov 22 08:00:02 spanky kernel: ohci1394: fw-host1: SelfID packet
0x893fc4da received
Nov 22 08:00:02 spanky kernel: ohci1394: fw-host1: SelfID packet
0x8a3fc496 received
Nov 22 08:00:02 spanky kernel: ohci1394: fw-host1: SelfID packet
0x8b3fc4bc received
Nov 22 08:00:02 spanky kernel: ohci1394: fw-host1: SelfID packet
0x8c3fc49c received
Nov 22 08:00:02 spanky kernel: ohci1394: fw-host1: SelfID packet
0x8d3fc4bc received
Nov 22 08:00:02 spanky kernel: ohci1394: fw-host1: SelfID packet
0x8e3fc4fa received
Nov 22 08:00:02 spanky kernel: ohci1394: fw-host1: SelfID packet
0x8f3fc494 received
Nov 22 08:00:02 spanky kernel: ohci1394: fw-host1: SelfID packet
0x903fc4bc received
Nov 22 08:00:02 spanky kernel: ohci1394: fw-host1: SelfID packet
0x913fc4fc received
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host1: SelfID complete
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host1: PhyReqFilter=0000000000000000
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host4: SelfID packet
0x817fc494 received
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host4: SelfID packet
0x823fc4f8 received
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host4: SelfID packet
0x837fc494 received
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host4: SelfID packet
0x847fc494 received
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host4: SelfID packet
0x857fc494 received
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host4: SelfID for this
node is 0x857fc494
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host4: SelfID packet
0x863fc4f8 received
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host4: SelfID packet
0x877fc45a received
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host4: SelfID packet
0x883fc458 received
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host4: SelfID packet
0x893fc4da received
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host4: SelfID packet
0x8a3fc496 received
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host4: SelfID packet
0x8b3fc4bc received
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host4: SelfID packet
0x8c3fc49c received
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host4: SelfID packet
0x8d3fc4bc received
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host0: SelfID packet
0x803fc094 received
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host0: SelfID packet
0x817fc494 received
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host0: SelfID packet
0x823fc4f8 received
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host0: SelfID packet
0x837fc494 received
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host0: SelfID packet
0x847fc494 received
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host0: SelfID packet
0x857fc494 received
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host0: SelfID packet
0x863fc4f8 received
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host0: SelfID packet
0x877fc45a received
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host0: SelfID for this
node is 0x877fc45a
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host0: SelfID packet
0x883fc458 received
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host0: SelfID packet
0x893fc4da received
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host0: SelfID packet
0x8a3fc496 received
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host0: SelfID packet
0x8b3fc4bc received
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host0: SelfID packet
0x8c3fc49c received
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host0: SelfID packet
0x8d3fc4bc received
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host0: SelfID packet
0x8e3fc4fa received
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host0: SelfID packet
0x8f3fc494 received
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host0: SelfID packet
0x903fc4bc received
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host0: SelfID packet
0x913fc4fc received
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host0: SelfID complete
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host0: PhyReqFilter=0000000000000000
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host4: SelfID packet
0x8e3fc4fa received
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host4: SelfID packet
0x8f3fc494 received
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host4: SelfID packet
0x903fc4bc received
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host4: SelfID packet
0x913fc4fc received
Nov 22 08:00:03 spanky kernel: ohci1394: fw-host4: SelfID complete
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host4: PhyReqFilter=0000000000000000
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host3: IntEvent: 00010000
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host3: SelfID interrupt
received (phyid 3, not root)
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host3: SelfID packet
0x803fc094 received
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host3: SelfID packet
0x817fc494 received
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host3: SelfID packet
0x823fc4f8 received
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host3: SelfID packet
0x837fc494 received
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host3: SelfID for this
node is 0x837fc494
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host3: SelfID packet
0x847fc494 received
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host2: IntEvent: 00010000
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host3: SelfID packet
0x857fc494 received
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host2: SelfID interrupt
received (phyid 1, not root)
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host2: SelfID packet
0x803fc094 received
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host2: SelfID packet
0x817fc494 received
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host2: SelfID for this
node is 0x817fc494
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host2: SelfID packet
0x823fc4f8 received
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host2: SelfID packet
0x837fc494 received
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host2: SelfID packet
0x847fc494 received
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host2: SelfID packet
0x857fc494 received
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host2: SelfID packet
0x863fc4f8 received
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host2: SelfID packet
0x877fc45a received
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host2: SelfID packet
0x883fc458 received
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host2: SelfID packet
0x893fc4da received
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host2: SelfID packet
0x8a3fc496 received
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host2: SelfID packet
0x8b3fc4bc received
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host2: SelfID packet
0x8c3fc49c received
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host2: SelfID packet
0x8d3fc4bc received
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host2: SelfID packet
0x8e3fc4fa received
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host2: SelfID packet
0x8f3fc494 received
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host2: SelfID packet
0x903fc4bc received
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host2: SelfID packet
0x913fc4fc received
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host2: SelfID complete
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host2: PhyReqFilter=0000000000000000
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host3: SelfID packet
0x863fc4f8 received
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host3: SelfID packet
0x877fc45a received
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host3: SelfID packet
0x883fc458 received
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host3: SelfID packet
0x893fc4da received
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host3: SelfID packet
0x8a3fc496 received
Nov 22 08:00:04 spanky kernel: ohci1394: fw-host3: SelfID packet
0x8b3fc4bc received
Nov 22 08:00:05 spanky kernel: ohci1394: fw-host3: SelfID packet
0x8c3fc49c received
Nov 22 08:00:05 spanky kernel: ohci1394: fw-host3: SelfID packet
0x8d3fc4bc received
Nov 22 08:00:05 spanky kernel: ohci1394: fw-host3: SelfID packet
0x8e3fc4fa received
Nov 22 08:00:05 spanky kernel: ohci1394: fw-host3: SelfID packet
0x8f3fc494 received
Nov 22 08:00:05 spanky kernel: ohci1394: fw-host3: SelfID packet
0x903fc4bc received
Nov 22 08:00:05 spanky kernel: ohci1394: fw-host3: SelfID packet
0x913fc4fc received
Nov 22 08:00:05 spanky kernel: ohci1394: fw-host3: SelfID complete
Nov 22 08:00:05 spanky kernel: ohci1394: fw-host3: PhyReqFilter=0000000000000000
Nov 22 08:00:05 spanky kernel: ohci1394: fw-host4: IntEvent: 00020010
Nov 22 08:00:05 spanky kernel: ohci1394: fw-host1: IntEvent: 00020010
Nov 22 08:00:05 spanky kernel: ohci1394: fw-host1: irq_handler: Bus
reset requested
Nov 22 08:00:05 spanky kernel: ohci1394: fw-host1: Cancel request received
Nov 22 08:00:05 spanky kernel: ohci1394: fw-host4: irq_handler: Bus
reset requested
Nov 22 08:00:05 spanky kernel: ohci1394: fw-host4: Cancel request received
Nov 22 08:00:05 spanky kernel: ohci1394: fw-host1: Got RQPkt interrupt
status=0x00008409
Nov 22 08:00:05 spanky kernel: ohci1394: fw-host4: Got RQPkt interrupt
status=0x00008409
Nov 22 08:00:05 spanky kernel: ohci1394: fw-host0: IntEvent: 00020010
Nov 22 08:00:05 spanky kernel: ohci1394: fw-host0: irq_handler: Bus
reset requested
Nov 22 08:00:05 spanky kernel: ohci1394: fw-host0: Cancel request received
Nov 22 08:00:05 spanky kernel: ohci1394: fw-host2: IntEvent: 00020010
Nov 22 08:00:05 spanky kernel: ohci1394: fw-host2: irq_handler: Bus
reset requested
Nov 22 08:00:05 spanky kernel: ohci1394: fw-host2: Cancel request received
Nov 22 08:00:05 spanky kernel: ohci1394: fw-host2: Got RQPkt interrupt
status=0x00008409
Nov 22 08:00:05 spanky kernel: ohci1394: fw-host0: Got RQPkt interrupt
status=0x00008409
Nov 22 08:00:05 spanky kernel: ohci1394: fw-host0: Single packet rcv'd
Nov 22 08:00:05 spanky kernel: ohci1394: fw-host2: Single packet rcv'd
Nov 22 08:00:05 spanky kernel: ohci1394: fw-host4: Single packet rcv'd
Nov 22 08:00:05 spanky kernel: ohci1394: fw-host1: Single packet rcv'd
Nov 22 08:00:05 spanky kernel: ohci1394: fw-host0: IntEvent: 00010000
Nov 22 08:00:05 spanky kernel: ohci1394: fw-host0: SelfID interrupt
received (phyid 11, not root)
Nov 22 08:00:05 spanky kernel: ohci1394: fw-host0: SelfID packet
0x807fc494 received
Nov 22 08:00:05 spanky kernel: ohci1394: fw-host1: IntEvent: 00010000
Nov 22 08:00:05 spanky kernel: ohci1394: fw-host1: SelfID interrupt
received (phyid 0, not root)
Nov 22 08:00:05 spanky kernel: ohci1394: fw-host4: IntEvent: 00010000
Nov 22 08:00:05 spanky kernel: ohci1394: fw-host4: SelfID interrupt
received (phyid 1, not root)
Nov 22 08:00:05 spanky kernel: ohci1394: fw-host1: SelfID packet
0x807fc494 received


There is nothing from fw-host3 until I rmmod ohci1394 later:

Nov 22 08:12:32 spanky kernel: ohci1394: fw-host4: Soft reset finished
Nov 22 08:12:32 spanky kernel: ohci1394: fw-host1: IntEvent: 00020010
Nov 22 08:12:32 spanky kernel: ohci1394: fw-host1: irq_handler: Bus
reset requested
Nov 22 08:12:32 spanky kernel: ohci1394: fw-host2: IntEvent: 00020010
Nov 22 08:12:32 spanky kernel: ohci1394: fw-host1: Cancel request received
Nov 22 08:12:32 spanky kernel: ohci1394: fw-host2: irq_handler: Bus
reset requested
Nov 22 08:12:32 spanky kernel: ohci1394: fw-host2: Cancel request received
Nov 22 08:12:32 spanky kernel: ohci1394: fw-host1: Got RQPkt interrupt
status=0x00008409
Nov 22 08:12:32 spanky kernel: ohci1394: fw-host4: Freeing dma_rcv_ctx 0
Nov 22 08:12:32 spanky kernel: ohci1394: fw-host2: Got RQPkt interrupt
status=0x00008409
Nov 22 08:12:32 spanky kernel: ohci1394: fw-host1: Single packet rcv'd
Nov 22 08:12:32 spanky kernel: ohci1394: fw-host4: Freeing dma_rcv_ctx 0
Nov 22 08:12:32 spanky kernel: ohci1394: fw-host0: IntEvent: 00020010
Nov 22 08:12:32 spanky kernel: ohci1394: fw-host4: Freeing dma_trm_ctx 0
Nov 22 08:12:32 spanky kernel: ohci1394: fw-host0: irq_handler: Bus
reset requested
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host0: Cancel request received
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host0: Got RQPkt interrupt
status=0x00008409
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host0: Single packet rcv'd
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host4: Freeing dma_trm_ctx 1
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host4: Freeing dma_rcv_ctx 0
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host2: Single packet rcv'd
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host2: IntEvent: 00010000
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host0: IntEvent: 00010000
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host2: SelfID interrupt
received (phyid 4, not root)
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host0: SelfID interrupt
received (phyid 11, not root)
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host2: SelfID packet
0x807fc494 received
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host2: SelfID packet
0x813fc496 received
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host2: SelfID packet
0x823fc4f8 received
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host2: SelfID packet
0x833fc094 received
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host2: SelfID packet
0x847fc494 received
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host2: SelfID for this
node is 0x847fc494
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host2: SelfID packet
0x853fc4f8 received
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host2: SelfID packet
0x867fc494 received
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host2: SelfID packet
0x873fc4f8 received
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host2: SelfID packet
0x883fc494 received
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host2: SelfID packet
0x893fc4ec received
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host2: SelfID packet
0x8a3fc4ec received
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host2: SelfID packet
0x8b7fc458 received
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host2: SelfID packet
0x8c3fc458 received
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host2: SelfID packet
0x8d3fc4d8 received
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host2: SelfID packet
0x8e3fc494 received
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host2: SelfID packet
0x8f3fc4bc received
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host2: SelfID packet
0x903fc49c received
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host2: SelfID packet
0x913fc4fc received
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host2: SelfID complete
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host0: SelfID packet
0x807fc494 received
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host2: PhyReqFilter=0000000000000000
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host0: SelfID packet
0x813fc496 received
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host0: SelfID packet
0x823fc4f8 received
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host0: SelfID packet
0x833fc094 received
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host0: SelfID packet
0x847fc494 received
Nov 22 08:12:33 spanky kernel: ohci1394: fw-host0: SelfID packet
0x853fc4f8 received
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host0: SelfID packet
0x867fc494 received
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host0: SelfID packet
0x873fc4f8 received
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host0: SelfID packet
0x883fc494 received
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host0: SelfID packet
0x893fc4ec received
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host0: SelfID packet
0x8a3fc4ec received
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host0: SelfID packet
0x8b7fc458 received
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host0: SelfID for this
node is 0x8b7fc458
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host0: SelfID packet
0x8c3fc458 received
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host0: SelfID packet
0x8d3fc4d8 received
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host0: SelfID packet
0x8e3fc494 received
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host0: SelfID packet
0x8f3fc4bc received
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host0: SelfID packet
0x903fc49c received
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host0: SelfID packet
0x913fc4fc received
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host0: SelfID complete
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host1: IntEvent: 00010000
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host0: PhyReqFilter=0000000000000000
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host1: SelfID interrupt
received (phyid 0, not root)
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host1: SelfID packet
0x807fc494 received
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host1: SelfID for this
node is 0x807fc494
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host1: SelfID packet
0x813fc496 received
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host1: SelfID packet
0x823fc4f8 received
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host1: SelfID packet
0x833fc094 received
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host1: SelfID packet
0x847fc494 received
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host1: SelfID packet
0x853fc4f8 received
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host1: SelfID packet
0x867fc494 received
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host1: SelfID packet
0x873fc4f8 received
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host1: SelfID packet
0x883fc494 received
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host1: SelfID packet
0x893fc4ec received
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host1: SelfID packet
0x8a3fc4ec received
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host1: SelfID packet
0x8b7fc458 received
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host1: SelfID packet
0x8c3fc458 received
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host1: SelfID packet
0x8d3fc4d8 received
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host1: SelfID packet
0x8e3fc494 received
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host1: SelfID packet
0x8f3fc4bc received
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host1: SelfID packet
0x903fc49c received
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host1: SelfID packet
0x913fc4fc received
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host1: SelfID complete
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host1: PhyReqFilter=0000000000000000
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host3: Soft reset finished
Nov 22 08:12:34 spanky kernel: ohci1394: fw-host0: IntEvent: 00020010
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host2: IntEvent: 00020010
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host0: irq_handler: Bus
reset requested
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host2: irq_handler: Bus
reset requested
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host0: Cancel request received
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host2: Cancel request received
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host0: Got RQPkt interrupt
status=0x00008409
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host3: Freeing dma_rcv_ctx 0
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host0: Single packet rcv'd
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host2: Got RQPkt interrupt
status=0x00008409
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host1: IntEvent: 00020010
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host3: Freeing dma_rcv_ctx 0
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host1: irq_handler: Bus
reset requested
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host3: Freeing dma_trm_ctx 0
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host1: Cancel request received
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host3: Freeing dma_trm_ctx 1
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host1: Got RQPkt interrupt
status=0x00008409
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host3: Freeing dma_rcv_ctx 0
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host1: Single packet rcv'd
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host2: Single packet rcv'd
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host2: Soft reset finished
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host1: IntEvent: 00000010
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host0: IntEvent: 00000010
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host1: Got RQPkt interrupt
status=0x00008409
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host0: Got RQPkt interrupt
status=0x00008409
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host1: Single packet rcv'd
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host1: Single packet rcv'd
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host2: Freeing dma_rcv_ctx 0
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host0: Single packet rcv'd
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host2: Freeing dma_rcv_ctx 0
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host2: Freeing dma_trm_ctx 0
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host2: Freeing dma_trm_ctx 1
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host2: Freeing dma_rcv_ctx 0
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host1: Soft reset finished
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host1: Freeing dma_rcv_ctx 0
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host1: Freeing dma_rcv_ctx 0
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host1: Freeing dma_trm_ctx 0
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host1: Freeing dma_trm_ctx 1
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host1: Freeing dma_rcv_ctx 0
Nov 22 08:12:35 spanky kernel: ohci1394: fw-host0: IntEvent: 00010000
