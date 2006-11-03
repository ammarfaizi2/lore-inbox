Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751803AbWKCNGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbWKCNGL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 08:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752849AbWKCNGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 08:06:11 -0500
Received: from mexforward.lss.emc.com ([128.222.32.20]:39261 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S1751803AbWKCNGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 08:06:09 -0500
Message-ID: <454B3EB2.3010600@emc.com>
Date: Fri, 03 Nov 2006 08:05:54 -0500
From: Ric Wheeler <ric@emc.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
CC: Grzegorz Kulewski <kangur@polcom.net>, linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz> <Pine.LNX.4.63.0611022346450.14187@alpha.polcom.net> <Pine.LNX.4.64.0611030015150.3266@artax.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0611030015150.3266@artax.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.4.0.264935, Antispam-Data: 2006.11.3.43433
X-PerlMx-Spam: Gauge=, SPAM=0%, Reasons='EMC_BODY_1+ -3, EMC_BODY_PROD_1+ -3, EMC_BODY_PROD_2+ -3, EMC_FROM_0+ -2, __C230066_P1_5 0, __CP_URI_IN_BODY 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mikulas Patocka wrote:

>> Hi,
>>
>> On Thu, 2 Nov 2006, Mikulas Patocka wrote:
>>
>>> As my PhD thesis, I am designing and writing a filesystem, and it's 
>>> now in a state that it can be released. You can download it from 
>>> http://artax.karlin.mff.cuni.cz/~mikulas/spadfs/
>>
>>
>> "Disk that can atomically write one sector (512 bytes) so that the 
>> sector
>> contains either old or new content in case of crash."
>>
>> Well, maybe I am completly wrong but as far as I understand no disk 
>> currently will provide such requirement. Disks can have (after halted 
>> write):
>> - old data,
>> - new data,
>> - nothing (unreadable sector - result of not full write and disk 
>> internal checksum failute for that sector, happens especially often 
>> if you have frequent power outages).
>>
>> And possibly some broken drives may also return you something that 
>> they think is good data but really is not (shouldn't happen since 
>> both disks and cables should be protected by checksums, but hey... 
>> you can never be absolutely sure especially on very big storages).
>>
>> So... isn't this making your filesystem a little flawed in design?
>
>
> There was discussion about it here some times ago, and I think the 
> result was that the IDE bus is reset prior to capacitors discharge and 
> total loss of power and disk has enough time to finish a sector --- 
> but if you have crap power supply (doesn't signal power loss), crap 
> motherboard (doesn't reset bus) or crap disk (doesn't respond to 
> reset), it can fail.

These are two examples of very different classes of storage devices - if 
you use a high end array (like EMC Clariion/Symm, IBM Shark, Hitachi, 
NetApp Block, etc) once the target device acknowledges the write 
transaction, you have a hard promise that the data is going to persist 
after a power outage, etc.

If you are using a a commodity disk, then you really have to worry about 
how the drive's write cache will handle your IO.  These disks will ack 
the write once they have stored the write request in their volatile 
memory which can be lost on power outages.

That is a reasonable setting for most end users (high performance, few 
power outages and some risk of data loss), but when data integrity is a 
hard requirement, people typically run with the write cache disabled.

The "write barrier" support that is in reiserfs, ext3 and xfs all 
provide something that is somewhere in the middle - good performance and 
cache flushes injected on transaction commits or application level 
fsync() commands.

I would not depend on the IDE bus reset or draining capacitors to safely 
destage data - in fact, I know that it will routinely fail when we test 
the write barrier on/off over power outages.

Modern S-ATA/ATA drives have 16MB or more of data in write cache and 
there is a lot of data to destage in those last few ms ;-)

>
> BTW. reiserfs and xfs depend on this feature too. ext3 is the only one 
> that doesn't.
>
> Mikulas
>
