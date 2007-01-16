Return-Path: <linux-kernel-owner+w=401wt.eu-S1751242AbXAPPQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbXAPPQc (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 10:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbXAPPQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 10:16:31 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:2712 "EHLO
	odyssey.analogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242AbXAPPQa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 10:16:30 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 16 Jan 2007 15:16:26.0972 (UTC) FILETIME=[4AAC51C0:01C73981]
Content-class: urn:content-classes:message
Subject: Re: What does this scsi error mean ?
Date: Tue, 16 Jan 2007 10:16:22 -0500
Message-ID: <Pine.LNX.4.61.0701160959450.8079@chaos.analogic.com>
In-Reply-To: <20070115214503.GA56952@dspnet.fr.eu.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: What does this scsi error mean ?
Thread-Index: Acc5gUq1xmne+QdgRaq2DjXXnNxLog==
References: <20070115171602.GA23661@dspnet.fr.eu.org> <20070115184540.2b3c4f78@localhost.localdomain> <20070115214503.GA56952@dspnet.fr.eu.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Olivier Galibert" <galibert@pobox.com>
Cc: "Hack inc." <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 15 Jan 2007, Olivier Galibert wrote:

> On Mon, Jan 15, 2007 at 06:45:40PM +0000, Alan wrote:
>> On Mon, 15 Jan 2007 18:16:02 +0100
>> Olivier Galibert <galibert@pobox.com> wrote:
>>
>>> sd 0:0:0:0: SCSI error: return code = 0x08000002
>>> sda: Current: sense key: Hardware Error
>>>     ASC=0x42 ASCQ=0x0
>>
>> I'll give you a clue: The words "Hardware Error".
>>
>> Run a SCSI verify pass on the drive with some drive utilities and see
>> what happens. If you are lucky it'll just reallocate blocks and decide
>> the drive is ok, if not well see what the smart data thinks.
>
> Both smart and the internal blade diagnostics say "everything is a-ok
> with the drive, there hasn't been any error ever except a bunch of
> corrected ECC ones, and no more than with a similar drive in another
> working blade".  Hence my initial post.  "Hardware error" is kinda
> imprecise, so I was wondering whether it was unexpected controller
> answer, detected transmission error, block write error, sector not
> found...  Is there a way to have more information?
>
>  OG.

Correctable SCSI errors show that the data in a sector was not properly
read, but the device was able to fix the data error because of the
redundancy in the CRC. The error could be permanently fixed is you
rewrote the sector. You probably don't know where the bad sector is
without adding a printk() to driver code. Some BIOS SCSI utilities
(Adaptec) have the capability of reading an entire drive and fixing
bad sectors either by rewrite or relocation. Since drives can be
accessed as files, you could write a utility that opens the RAW
device with in NOT mounted, reads a bunch of sectors, then writes
them back. To do this, you need to verify that lseek() works on
your particular drive because you need to write the data back to
the same offset that you read it from. I mention this because
the raw r/w of an early Adaptec (aha1542) driver, didn't impliment
lseek, just returned 'okay'. You can imagine the mess I made of
a drive with that controller!

Once you verify that lseek works, the rest of the code is trivial.
I suggest reading then writing 64 kilobytes at a time. It will seem
to take 'forever', but the retries on these relatively short groups
of sectors (128 sectors), will be short when errors are encountered.

Make sure the drive is either not mounted or mounted r/o.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.67 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
