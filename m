Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbVIKCQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbVIKCQY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 22:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbVIKCQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 22:16:23 -0400
Received: from omta03sl.mx.bigpond.com ([144.140.92.155]:35572 "EHLO
	omta03sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932257AbVIKCQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 22:16:23 -0400
Message-ID: <43239374.8010604@eyal.emu.id.au>
Date: Sun, 11 Sep 2005 12:16:20 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Debian Thunderbird 1.0.2 (X11/20050817)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nuno Silva <nuno.silva@vgertech.com>
CC: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: RAID resync speed
References: <432240E9.9010400@eyal.emu.id.au> <43224ABB.3030002@vgertech.com> <4322506A.1010303@eyal.emu.id.au> <43226701.1000606@vgertech.com>
In-Reply-To: <43226701.1000606@vgertech.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nuno Silva wrote:
> Eyal Lebedinsky wrote:
> 
>> Nuno Silva wrote:
>>
>>> Hi,
>>> Eyal Lebedinsky wrote:
>>>
>>>> I noticed that my 3-disk RAID was syncing at about 40MB/s, now that I
>>>> added a fourth disk it goes at only 20+MB/s. This is on an idle
>>>> machine.
>>>
>>> 3*40=120
>>> 4*20=80
>>
>> What does this mean? The raid is syncing at 20MB/s, not each disk, so
>> I do
>> not see what the multiplication is about.
> 
> Yes, you're correct :-)

Actually, I took another look at this matter and I now think that you
had the correct approach.

The rebuild speed is the speed at which the new disk is being built, not
the total rebuild i/o. This means that it does not contain the read
operations. So the PCI limit is a limiting factor. On a 32-bit 33MHz PCI
controller (132MB/s theoretical bandwidth) a 2->3 rebuild cannot be
faster 44MB/s and a 3->4 is limited to 33MB/s.

I think this is true.

The same limit will also apply to any raid i/o as we read/write to all
the disks for any data.

To use 5 60MB/s disks I will need 300MB/s bandwidth which a 64-bit 66MHz
PCI can deliver. A 32-bit/66MHz will come close - what can PCIe do?.
A proper RAID card will alleviate the PCI limitation as it will have
dedicated channels for each disk (well, a good controller should) with
full bandwidth and the PCI will only need to go at the one-disk speed
(for raid-5).

On-board SATA controllers will have better bandwidth if they sit on a
better than PCI bus (or on more than one PCI bus).

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	attach .zip as .dat
