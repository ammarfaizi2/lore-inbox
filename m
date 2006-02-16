Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWBPTBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWBPTBd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 14:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWBPTBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 14:01:33 -0500
Received: from spirit.analogic.com ([204.178.40.4]:14605 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932175AbWBPTBc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 14:01:32 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <43F4B1C9.9070002@cfl.rr.com>
X-OriginalArrivalTime: 16 Feb 2006 19:01:29.0185 (UTC) FILETIME=[64A60510:01C6332B]
Content-class: urn:content-classes:message
Subject: Re: RFC: disk geometry via sysfs
Date: Thu, 16 Feb 2006 14:01:28 -0500
Message-ID: <Pine.LNX.4.61.0602161316100.23547@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RFC: disk geometry via sysfs
thread-index: AcYzK2StD1z3JoHgRpS0OWQbr508tw==
References: <43EC8FBA.1080307@bfh.ch> <43F0B484.3060603@cfl.rr.com> <43F0D7AD.8050909@bfh.ch> <43F0DF32.8060709@cfl.rr.com> <43F206E7.70601@bfh.ch> <43F21F21.1010509@cfl.rr.com> <43F2E8BA.90001@bfh.ch> <58cb370e0602150051w2f276banb7662394bef2c369@mail.gmail.com> <11 <Pine.LNX.4.61.0602161125580.23082@chaos.analogic.com> <43F4B1C9.9070002@cfl.rr.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Phillip Susi" <psusi@cfl.rr.com>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Seewer Philippe" <philippe.seewer@bfh.ch>,
       "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 Feb 2006, Phillip Susi wrote:

> linux-os (Dick Johnson) wrote:
>> I read it, and it's wrong. You don't bother to learn. I will
>> take one last hack at this and then drop it.
>>
>> When a disk is first accessed, the BIOS reads the disk capacity.
>> That's all. This disk capacity is in 512-byte things called "sectors".
>>
> You don't bother to mention HOW it is wrong, so it appears it is you who
> fail to learn.  I will attempt once more to explain.  When you call int
> 13 and ask it for C = 3, H = 4, S = 5, exactly which sector you get
> depends very much on what the bios thinks the geometry of the disk is,
> because the bios will translate 3/4/5 into a completely different value
> before sending it to the drive.  That translation is dependent entirely
> on which fake geometry the bios chooses to report the disk has.
>
> I illustrated this translation and you simply say it is wrong.  If that
> is the case then show how.

You sure are interested in arguing. The translation cannot be wrong
because the BIOS invented the translation which was created when
the BIOS did a "read capacity." That translation is stored in the
BIOS as a BPB, not on the disk, and it is accessed by any file-
systems that use the 16-bit Int 0x13 interface. If the file-
systems are not broken, they will NOT use the wrong translation
because they will read the current interpretation by reading
the BPB from the vector represented by int 0x64, or by executing
Int 0x13, function code 8 (read drive parameters). These parameters
are INVENTED upon startup as previously explained.

As previously explained, the fake geometry is not geometry at
all, but rather a translation key that was decided upon
startup after the capacity was determined. Its sole purpose
is to get a sector-offset through the limited register-set
in the 0x13 interface.

[FS offset]--->[encode KEY]--->[INT 0x13]--->[decode KEY]--->[drive offset]
                         |                             |
                         |-- anything that will fit ---|

This encode/decode key should have never been let out of its cage.
Unfortunately some DOS tools put it on the disks in a table
called the BPB.

DOS creates two software interrupt vectors, int 0x25, and
int 0x26, (absolute read and write), which perform this
translation using the stuff in the BPB. This means that
the caller (the file-system) doesn't have to worry about
these things.

Since the offsets are directly available when the BIOS is not
used, this BPB is useless.

Even when using dosemu, where a virtual 0x13 is available, the
key used to access this resource is obtained by reading the
capacity of the DOS file-system(s) and building a BPB for
each (virtual) disk.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5590.48 BogoMips).
Warning : 98.36% of all statistics are fiction.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
