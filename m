Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030421AbWAGMH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030421AbWAGMH6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 07:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030426AbWAGMH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 07:07:58 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:30664 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1030421AbWAGMH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 07:07:57 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <43BFAEE9.7090707@s5r6.in-berlin.de>
Date: Sat, 07 Jan 2006 13:07:05 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux1394-devel@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org
Subject: sbp2 address space
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-0.713) AWL,BAYES_20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

sbp2 currently puts its status FIFO at the address range of 
0xfffe_0000_0000 ... 0xfffe_0000_0220 (FireWire bus addresses, i.e. 
addresses according to ISO/IEC 13213). This range must not fall into the 
"physical range" of OHCI host adapters (OHCI 1.1 figure 1-2, see also 
OHCI 1.1 sections 12 and 5.15).

Most OHCI implementations hardwire the physical range to 
0x0000_0000_0000 ... 0x0000_ffff_ffff. A few however implement a 
writable PhysicalUpperBound register. Ohci1394 sets this register to the 
maximum allowed value which extends the physical range to 
0x0000_0000_0000 ... 0xfffe_ffff_ffff.

Sbp2 has never worked with the latter kind of host adapters, except if 
physical DMA was disabled. Else sbp2 always ended up in an alleged login 
timeout. http://marc.theaimsgroup.com/?t=113639033500002

What is the solution?
  - Modify ohci1394 to keep the physical range below sbp2's status FIFO?
Or
  - move sbp2's status FIFO into the "upper address space" (OHCI 1.1
    figure 1-2), between 0xffff_0000_0000 and the CSR space, i.e. below
    0xffff_f000_0000?

Are any FireWire protocols or important application programs already 
using the upper address space? If we move sbp2's status FIFO, we don't 
want to break other software. No other 1394 high-level driver is using 
the upper address space. Oracle's Endpoint (SBP-2 target) seems not to 
use it either. What about applications like AV/C "targets"?

Or is it better to leave sbp2 as it is but restrict ohci1394 to use the 
same physical range on _all_ controllers, i.e. 0x0000_0000_0000 ... 
0x0000_ffff_ffff == 4 GB?

Does PCIe provide a bigger host bus address space than PCI?
-- 
Stefan Richter
-=====-=-==- ---= --===
http://arcgraph.de/sr/
