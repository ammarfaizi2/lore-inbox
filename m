Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271686AbTGRCSQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 22:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271689AbTGRCSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 22:18:16 -0400
Received: from 12-229-144-126.client.attbi.com ([12.229.144.126]:32391 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S271686AbTGRCSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 22:18:06 -0400
Message-ID: <3F175C5C.3030708@comcast.net>
Date: Thu, 17 Jul 2003 19:33:00 -0700
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030704
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, arjanv@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       davzaffiro@tasking.nl
Subject: Re: [PATCH] pdcraid and weird IDE geometry
References: <3F160965.7060403@comcast.net> <1058431742.5775.0.camel@laptop.fenrus.com> <3F16B49E.8070901@comcast.net> <1058453918.9055.12.camel@dhcp22.swansea.linux.org.uk> <20030717173413.A2393@pclin040.win.tue.nl>
In-Reply-To: <20030717173413.A2393@pclin040.win.tue.nl>
X-Enigmail-Version: 0.76.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> On Thu, Jul 17, 2003 at 03:58:38PM +0100, Alan Cox wrote:
> 
>>On Iau, 2003-07-17 at 15:37, Walt H wrote:
>>
>>
>>>On the second drive, it's like this:
>>>capacity = 80418240, head=255, sect = 63
>>>lba = capacity / (head * sect) = 5005 int or 5005.80 float
>>>lba = lba * (head * sect) = 80405325 int or 80418240.01 float
>>>lba = lba - sect = 80405262 int or 80418177 float
>>
>>Would fixed point solve this. Start from capacity <<= 16 and then
>>do the maths. That would put lba in 65536ths of a sector which
>>should have the same result as your float maths
> 
> 
> Ach Alan - I have not seen these earlier posts, but float or
> fixed point here is just nonsense.
> 
> The purpose of
> 	A = B/C;
> 	A *= C;
> can only be to round B down to the largest multiple of C below it.
> Using infinite precision just turns this into
> 	A = B;
> 
> He needs the first sector of the last cylinder, in a setup where
> cylinders have size 16*63 or so, but the surrounding software
> thinks that it is 255*63, a mistake.
> 
> I don't know anything about these RAIDs, but possibly it would
> help to give boot parameters for this disk.
> 
> Maybe he is victim of the completely ridiculous
> 	drive->head = 255;
> in ide-disk.c.
> (We have drive->head, the number of physical heads, and
> drive->bios_head, the translation presently used by the BIOS -
> or at least that is the intention. It is a bug if the former
> is larger than 16. The latter may well be 255.)
> 
> Andries
> 
> 
OK. Just got home from work. I've tried booting and specifying geometry
via hdg=79780,16,63 hdg=noprobe etc... The geometry is accepted,
however, drive access fails when trying to read the disk. This geometry
is the geometry reported by hde (my old drive without screwy geometry).
 The code in calc_pdcblock_offset to calculate the offset is unchanged
in my patch (except the date type conversion to float) and calls
get_info_ptr for geometry. From what I can tell, this call returns the
physical geometry of the disk so using fdisk to fool it doesn't work.
I've also tried using unsigned long to store the calcs, multiplying the
capacity by 100 to start, doing the maths and dividing the final lba by
100. This doesn't work cause it overflows the data type. Won't I have
similar problems using fixed point? At this point, my very limited
knowledge of C keeps me from getting much further.

-Walt


