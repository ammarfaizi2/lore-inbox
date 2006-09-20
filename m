Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWITURY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWITURY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 16:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWITURY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 16:17:24 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:61190 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750725AbWITURX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 16:17:23 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 20 Sep 2006 20:17:22.0083 (UTC) FILETIME=[C79D1F30:01C6DCF1]
Content-class: urn:content-classes:message
Subject: Re: Flushing writes to PCI devices
Date: Wed, 20 Sep 2006 16:17:21 -0400
Message-ID: <Pine.LNX.4.61.0609201608010.26230@chaos.analogic.com>
In-Reply-To: <6263h29e4o17ok032m8rv11p4u6547ngk0@4ax.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Flushing writes to PCI devices
thread-index: Acbc8cekJjc7oFGyTemuFjI+PI+UGQ==
References: <fa.gbsNbubc34pqWPOxWCntrwUyt68@ifi.uio.no> <Pine.LNX.4.44L0.0609201423480.7265-100000@iolanthe.rowland.org> <fa.V4O8HKrhUddxYm5+ixVbyZzPybE@ifi.uio.no> <6263h29e4o17ok032m8rv11p4u6547ngk0@4ax.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Bill Waddington" <william.waddington@beezmo.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 20 Sep 2006, Bill Waddington wrote:

> On Wed, 20 Sep 2006 19:10:55 UTC, in fa.linux.kernel you wrote:
>
>>
>> On Wed, 20 Sep 2006, Alan Stern wrote:
>>
>>> I've heard that to insure proper synchronization it's necessary to flush
>>> MMIO writes (writel, writew, writeb) to PCI devices by reading from the
>>> same area.  Is this equally true for I/O-space writes (inl, inw, inb)?
>>> What about configuration space writes (pci_write_config_dword etc.)?
>>>
>>> Alan Stern
>>
>> Writes to I/O space are not queued through a FIFO so there is
>> no need to flush the FIFO. Configuration space uses special
>> configuration cycles which are handshakes with the devices. They
>> cannot be queued, therefore don't need to be flushed either.
>>
>> Flushing PCI space writes shouldn't be done until you want
>> whatever you've been planning to happen __now__. Otherwise
>> the advantages of queued writes go away. In other words, one
>> should NOT attach a read to every PCI space write! Typically
>> use of the flushing read might be in the case of setting up
>> hardware for a DMA transfer. You write all the data, source
>> address, destination address, byte-count, DMA type, etc., then
>> after the last instruction, the one should should start the DMA,
>> you issue a read.
>
> Are there ever any issues with out-of-order writes from the posting
> buffer on supported architectures?  I can (barely) imagine a device
> that has the register with the start bit lower in the register address
> space than the count/address registers.  Out-of-order writes from
> the cache/non-fifo/posting buffer (maybe to assemble a burst) could
> make the occasional mess.
>
> Just wondering,
> Bill
> --
> William D Waddington
> william.waddington@beezmo.com
> "Even bugs...are unexpected signposts on
> the long road of creativity..." - Ken Burtch
>

People who make PCI interface chips like PLX would never make
devices that couldn't work on the PCI bus. However, it is possible
for somebody to make byte-wide or word-wide setup registers on
their local bus, accessed through an interface chip such as the PLX,
that might suffer because of write-combining. However, such defective
designs shouldn't make it to production.

Also, the PLX and other such interface chips don't rely upon
initialization order (like the PC 8237A DMA chips) when setting
up for a DMA transfer. They have a specific instruction to start
the transfer.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.66 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
