Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbUFJRvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbUFJRvH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 13:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbUFJRvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 13:51:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54420 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262114AbUFJRu4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 13:50:56 -0400
Message-ID: <40C89F4D.4070500@pobox.com>
Date: Thu, 10 Jun 2004 13:50:05 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
       Jens Axboe <axboe@suse.de>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Ed Tomlinson <edt@aei.ca>, Andrew Morton <akpm@osdl.org>
Subject: flush cache range proposal (was Re: ide errors in 7-rc1-mm1 and later)
References: <1085689455.7831.8.camel@localhost> <20040605092447.GB13641@suse.de> <20040606161827.GC28576@bounceswoosh.org> <200406100238.11857.bzolnier@elka.pw.edu.pl> <20040610061141.GD13836@suse.de> <20040610164135.GA2230@bounceswoosh.org>
In-Reply-To: <20040610164135.GA2230@bounceswoosh.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric D. Mudama wrote:
> On Thu, Jun 10 at  8:11, Jens Axboe wrote:
> 
>> On Thu, Jun 10 2004, Bartlomiej Zolnierkiewicz wrote:
>>
>>>
>>> /me just thinks loudly
>>>
>>> 'linear range' FLUSH CACHE seems so easy to implement that I always 
>>> wondered
>>> why FLUSH CACHE command doesn't make any use of LBA address and number
>>> of sectors.
>>
>>
>> Indeed, that would be very helpful as well.
> 
> 
> Neat idea... so you send us a LBA and a block count, and we return
> good status if that region is flushed.
> 
> Each command can specify a 32MiB region, assuming a device with
> 512-byte LBAs.
> 
> Propose an exact implementation and an opcode...


Ok, I'll give it a shot:

1) IDENTIFY DEVICE, Word 206, Command set/feature supported

bit 15:		shall be cleared to zero
bit 14:		shall be set to one
bits 13:1:	reserved
bits 0:		1 == flush cache (range) supported

Word 206:

If bit 0 is set to one, the mandatory FLUSH CACHE and FLUSH CACHE EXT 
commands (if implemented) support the RANGE bit, and user-supplied LBA 
and sector count specifying the limits of the cache flush.  This bit 
merely identifies the presence of this feature.  Use word 207, bit 0, to 
determine if the feature is enabled.


2) IDENTIFY DEVICE, Word 207, Command set/feature enabled

bit 15:		shall be cleared to zero
bit 14:		shall be set to one
bits 13:1:	reserved
bits 0:		1 == flush cache (range) enabled

Word 206:

If bit 0 is set to one, the mandatory FLUSH CACHE and FLUSH CACHE EXT 
commands (if implemented) support the RANGE bit, and user-supplied LBA 
and sector count specifying the limits of the cache flush.



3) Modify FLUSH CACHE (E7h) as follows:

Inputs:
-------

Features:	bit 0 (RANGE)
Sector Count:	sector count
LBA Low:	LBA(7:0)
LBA Mid:	LBA(15:8)
LBA High:	LBA(23:16)

Features -
If the RANGE bit is set, the cache flush operation shall be considered 
to be limited to the region specified in Sector Count / LBA registers. 
If the RANGE bit is not set, or the implementation does not support the 
RANGE bit, then the FLUSH CACHE operation shall flush the entire cache.

Sector Count -
Maximum number of sectors to be flushed from the cache.  A value of 00h 
specified that 256 sectors are to be flushed.

LBA Low / Mid / High -
An LBA starting address for the flush.  Register contents as specified 
in READ DMA command, and other commands.


Normal outputs:
---------------
Unchanged.


Error outputs:
--------------
Error register -

RANGE (bit 0) shall be set to one, if RANGE bit was specified in 
Features register when the command was submitted, indicating this was a 
range-based flush cache.


Description
-----------
If RANGE bit is set to one, the flush cache operation at a minimum shall 
flush the specified range of sectors specified by LBA / Sector Count. 
An implementation may choose to flush more than the specified range, up 
to an entire cache flush in a compatible or "no op" implementation.

If no data within the specified LBA range exists in cache to be flushed, 
that shall not be considered an error.


4) Modify FLUSH CACHE EXT (EAh) as follows:

Inputs:
-------

Features:
	curr	bit 0 (RANGE)
	prev	na
Sector Count:
	curr	sector count(7:0)
	prev	sector count(15:8)
LBA Low:
	curr	LBA(7:0)
	prev	LBA(31:24)
LBA Mid:
	curr	LBA(15:8)
	prev	LBA(39:32)
LBA High:
	curr	LBA(23:16)
	prev	LBA(47:40)

Features -
If the RANGE bit is set, the cache flush operation shall be considered 
to be limited to the region specified in Sector Count / LBA registers. 
If the RANGE bit is not set, or the implementation does not support the 
RANGE bit, then the FLUSH CACHE operation shall flush the entire cache.

Sector Count -
Maximum number of sectors to be flushed from the cache.  A value of 
0000h specified that 65,536 sectors are to be flushed.

LBA Low / Mid / High -
An LBA starting address for the flush.  Register contents as specified 
in READ DMA command, and other commands.


Normal outputs:
---------------
Unchanged.


Error outputs:
--------------
Error register -

RANGE (bit 0) shall be set to one, if RANGE bit was specified in 
Features register when the command was submitted, indicating this was a 
range-based flush cache.


Description
-----------
If RANGE bit is set to one, the flush cache operation at a minimum shall 
flush the specified range of sectors specified by LBA / Sector Count. 
An implementation may choose to flush more than the specified range, up 
to an entire cache flush in a compatible or "no op" implementation.

If no data within the specified LBA range exists in cache to be flushed, 
that shall not be considered an error.


</proposal>


Comments requested.

We need to KISS, if this proposal has any hope getting accepted.

People interested in filesystem journalling, barriers and such please 
review.

Once people on lkml are happy, I'll write this up in a PDF in T13 form, 
and propose it on the T13 list (making sure everyone involved is 
properly credited, of course).

	Jeff


