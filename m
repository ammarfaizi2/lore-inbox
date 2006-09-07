Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751611AbWIGMLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbWIGMLl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 08:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbWIGMLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 08:11:41 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:16645 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751016AbWIGL7R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 07:59:17 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
x-originalarrivaltime: 07 Sep 2006 11:59:13.0965 (UTC) FILETIME=[09897DD0:01C6D275]
Content-class: urn:content-classes:message
Subject: Re: question regarding cacheline size
Date: Thu, 7 Sep 2006 07:59:13 -0400
Message-ID: <Pine.LNX.4.61.0609070748440.28174@chaos.analogic.com>
In-Reply-To: <44FFD8C6.8080802@gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: question regarding cacheline size
Thread-Index: AcbSdQmQqveb9/KFSBiTMHhfzt14Tg==
References: <44FFD8C6.8080802@gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Tejun Heo" <htejun@gmail.com>
Cc: <linux-pci@atrey.karlin.mff.cuni.cz>, "Greg KH" <greg@kroah.com>,
       "lkml" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 7 Sep 2006, Tejun Heo wrote:

> Hello,
>
> This is for PCMCIA (cardbus) version of Silicon Image 3124 SerialATA
> controller.  When cacheline size is configured, the controller uses Read
> Multiple commands.
>
> • Bit [07:00]: Cache Line Size (R/W). This bit field is used to specify
> the system cacheline size in terms of 32-bit words. The SiI3124, when
> initiating a read transaction, will issue the Read Multiple PCI command
> if empty space in its FIFO is greater than the value programmed in this
> register.
>
> As the BIOS doesn't run after hotplugging cardbus card, the cache line
> isn't configured and the controller ends up having 0 cache line size and
> always using Read command.  When that happens, write performance drops
> hard - the throughput is < 2Mbytes/s.
>
> http://thread.gmane.org/gmane.linux.ide/12908/focus=12908
>
> So, sata_sil24 driver has to program CLS if it's not already set, but
> I'm not sure which number to punch in.  FWIW, sil3124 doesn't seem to
> put restrictions on the values which can be used for CLS.  There are
> several candidates...
>
> * L1_CACHE_BYTES / 4 : this is used by init routine in yenta_socket.c.
> It seems to be a sane default but I'm not sure whether L1 cache line
> size always coincides with the size as seen from PCI bus.
>
> * pci_cache_line_size in drivers/pci/pci.c : this is used for
> pci_generic_prep_mwi() and can be overridden by arch specific code.
> this seems more appropriate but is not exported.
>
> For all involved commands - memory read line, memory read multiple and
> memory write and invalidate - a value larger than actual cacheline size
> doesn't hurt but a smaller value may.
>
> I'm thinking of implementing a query function for pci_cache_line_size,
> say, int pci_cacheline_size(struct pci_dev *pdev), and use it in the
> device init routine.  Does this sound sane?
>
> Thanks.
>
> --
> tejun

The cache line size specifies the system cache-line size in dword
increments. For most, (ix86) this would be 8, i.e., eight 32-bit
words or 32 bytes. This is from page 376, PCI System Architecture,
ISBN 0-201-30974-2. It also says that a device may limit the number
of cache cycles if an unsupported value is written there. In that
case, the device will act as if the value 0 was written (no write-and-
invalidate transactions), basically poor performance.

The L1 cache size shouldn't have anything to do with this, BTW.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.66 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
