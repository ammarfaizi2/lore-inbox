Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271460AbTGQOWm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 10:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271459AbTGQOWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 10:22:41 -0400
Received: from 12-229-144-126.client.attbi.com ([12.229.144.126]:34178 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S271460AbTGQOW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 10:22:26 -0400
Message-ID: <3F16B49E.8070901@comcast.net>
Date: Thu, 17 Jul 2003 07:37:18 -0700
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030704
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: arjanv@redhat.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>, davzaffiro@tasking.nl
Subject: Re: [PATCH] pdcraid and weird IDE geometry
References: <3F160965.7060403@comcast.net> <1058431742.5775.0.camel@laptop.fenrus.com>
In-Reply-To: <1058431742.5775.0.camel@laptop.fenrus.com>
X-Enigmail-Version: 0.76.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Thu, 2003-07-17 at 04:26, Walt H wrote:
> 
>>compatible with the binary FastTrak.o module. I'm not much of a coder,
>>so if this could be done more efficiently than my attached patch, please
>>let me know. Please CC any replies. Thanks,
> 
> 
> (un)fortionatly it's not valid to use floating point in the kernel.
> Could you try the same thing by using u64 as type instead please ?

I've tried it using unsigned long, and it will fail to find the second
drive. The problem is that the FastTrak bios writes the superblock to
the second drive in the same place as if it had the geometry of the
first drive. How it does it, I do not know. What I know is that the
offset for the superblock on both drives lies at:  80418177


On the first drive, you get there like this:

capacity = 80418240, head = 16, sect = 63
lba = capacity / (head * sect) = 79780
lba = lba * (head * sect) = 80418240
lba = lba - sect = 80418177
This one's correct.

On the second drive, it's like this:
capacity = 80418240, head=255, sect = 63
lba = capacity / (head * sect) = 5005 int or 5005.80 float
lba = lba * (head * sect) = 80405325 int or 80418240.01 float
lba = lba - sect = 80405262 int or 80418177 float

If integer results are used, the second drive's offset is returned as
80405262, which is not the offset for the superblock. It lies at the
same location as the first drive.

Insmodding the module compiled with ints as calculations results in this:
Jul 17 07:15:16 waltsathlon kernel:  ataraid/disc0/disc: p1 p2 < >
Jul 17 07:15:16 waltsathlon kernel: Drive 0 is 39266 Mb (33 / 0)
Jul 17 07:15:16 waltsathlon kernel: Raid0 array consists of 1 drives.
Jul 17 07:15:16 waltsathlon kernel: Promise Fasttrak(tm) Softwareraid
driver for linux version 0.03beta

While the one with floating calcs finds both drives.
My only guess at this point, is that the FastTrak bios is using
different geometry than what's reported to us. I'm not sure how this
would work, but I've thought about storing the offset of the working
drive to use in the event that the offset calculation fails and the
capacity is identical on additional drives. Seems kinda hacky to me, but
then what do I know :) I'm up for trying things, any other ideas?

-Walt Holman

