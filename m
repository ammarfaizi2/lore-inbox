Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265458AbTFMR1P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 13:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265459AbTFMR1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 13:27:14 -0400
Received: from main6.ezpublishing.com ([216.121.96.152]:17932 "EHLO
	main6.ezpublishing.com") by vger.kernel.org with ESMTP
	id S265458AbTFMR0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 13:26:11 -0400
Message-ID: <3EEA0DEC.5D2DF938@righthandtech.com>
Date: Fri, 13 Jun 2003 12:46:20 -0500
From: George Dotts <"gdotts<snipme>"@righthandtech.com>
X-Mailer: Mozilla 4.8 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PCI64 performance - intel e7500 - bus mastering
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Stumped,  Mystified by PCI (64) transfer rate problem.

This post relates to pci64 transfer rate problems with
a custom adapter card with 256MB sdram and 256MB flash
onboard with a FPGA controlled auto-copy of the sdram
to flash on a powerfail occurrence.  The adapter card
busmasters descriptors from and data to / from memory.
Transfer rates diminish rapidly as the number of buffers
used increases but only under very specific conditions.

You should skip the rest of this relatively long post if
you didn't find the introduction particularly interesting.

RedHat 7.3 or 8, several 2.4 kernels tested, 2G memory.
Supermicro P4DPE-G2 dual 2GHz Xenon, Intel E7500 chipset.


DMA BUFFERS MMAPPED THRU DRIVER
MEM   +-------------------------------+
AREA  | 64 BYTE DESCRIPTOR  '1'       |
ONE   +-----                          |
      | 64 BYTE DESCRIPTOR  '2'       |
      +-----                          |
      | .....                         |
      +-----                          |
      | 64 BYTE DESCRIPTOR  'N'       |
      +-------------------------------+

DMA BUFFERS MMAPED THRU DRIVER
pci_alloc_consistent()
SetPageReserved()
(etc)

4K    +-------------------------------+
ALIGN | 4K, 8K OR 16K DATA BUFFER '1' |
MEM   +-------------------------------+
AREA  | 4K, 8K OR 16K DATA BUFFER '2' |
TWO   +-------------------------------+
      | .....                         |
      +-----                          |
      | 4K, 8K OR 16K DATA BUFFER 'N' |
      +-------------------------------+

Descriptor physical addresses are pushed to the card (up
to 128 using a fifo).  The descriptors may spec a single
buffer transfer or may contain a chain address to the next
descriptor.  If chained the next descriptor is mastered
from PC memory. All descriptors in a chain are processed
before popping the next descriptor address from the task
fifo.  The buffer data physical address is specified in
the descriptor and buffer data is mastered.

When using 1, 2 or 3 buffers either chained or unchained
the card consistently transfers 190MB/s to 208MB/s for
multiple descriptors specifying 64MB to 128MB transfers
of the indicated 4, 8 or 16k buffers (larger bufs work too).
This is true even if the buffers are not consecutive and
not in any particular order.

Once 4 or more buffers are used to transfer data the rate
deteriorates rapidly to 120MB/s. 100MB/s, 90MB/s until at
8 buffers in use only 40MB/s is attained. This is true even
for single buffer descriptors.

Observing the PCI bus shows that once the descriptor that
specifies the 3rd buffer is processed subsequent access
to descriptors continually get retry (restart) responses
to bus transfer requests. Retry / restart responses to data
buffer transfer requests. The access to the descriptor is
held off on most cases by somewhere around 1.5ms and in some
cases by as much as 3.5 ms.

NO OTHER PCI TRAFFIC IS ACTIVE! The network is unplugged and
there are no other (non-system) processes running. There is
no disk activity.

Now for the really strange part ...
If our test app does not use the linux POLL call to wait
for descriptor complete interrupts ALL transfers go fast
regardless of the number of buffers involved. Interrupts
are not required to be handled for the data transfers to
continue. The card task fifo is more than 75% full with
pending transfers and the only thing the POLL is for is
to notify the app when the data has actually made it to
the card.  If the app spins on the card transfer status
or the card descriptor transfer count all transfers are
in the 190MB/s range.  If the app spins in an idle loop
and checks the completion status word in the descriptor
(which is written back by the card on completion) all
transfers are fast. The descriptor complete interrupt is
only fired on the last descriptor in a chain if chaining
is used.

The DMA buffers are statically allocated and reused as they
become free. The data buffers are statically initialized
and are not touched at any time by the test app. A test
that statically init'd the descriptors and never touched
them again for the duration of the test acts the same.

Has anyone got any clue what I am up against here ??

~GeoD
gdotts<junk/>@righthandtech.com


