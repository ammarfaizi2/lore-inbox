Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316009AbSENTel>; Tue, 14 May 2002 15:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316010AbSENTek>; Tue, 14 May 2002 15:34:40 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:20271 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S316009AbSENTei>; Tue, 14 May 2002 15:34:38 -0400
Message-Id: <5.1.0.14.2.20020514202811.01fcc1d0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 14 May 2002 20:34:16 +0100
To: Martin Dalecki <dalecki@evision-ventures.com>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH] 2.5.15 IDE 61
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Conway <nconway.list@ukaea.org.uk>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <3CE11F90.5070701@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 15:30 14/05/02, Martin Dalecki wrote:
>Uz.ytkownik Alan Cox napisa?:
>>I think you are way off base. If you have a single queue for both hda and
>>hdb then requests will get dumped into that in a way that processing that
>>queue implicitly does the ordering you require.
>> From an abstract hardware point of view each ide controller is a queue not
>>each device. Not following that is I think the cause of much of the existing
>>pain and suffering.
>
>Yes thinking about it longer and longer I tend to the same conclusion,
>that we just shouldn't have per device queue but per channel queues instead.
>The only problem here is the fact that some device properties
>are attached to the queue right now. Like for example sector size and friends.
>
>I didn't have a too deep look in to the generic blk layer. But I would
>rather expect that since the lower layers are allowed to pass
>an spin lock up to the queue intialization, sharing a spin lock
>between two request queues should just serialize them with respect to
>each other. And this is precisely what 63 does.

Hi Martin,

instead of having per channel queue, you could have per device queue, but 
use the same lock for both, i.e. don't make the lock part of "struct queue" 
(or whatever it is called) but instead make the address of the lock be 
attached to "struct queue".

That allows you on "good" controllers to use individual locks for 
individual drives and also allows you to share the same lock (multiple 
"struct queue" point to same lock) among _any_ number of devices on same 
channel.

Further if a controller is truly broken and you need to synchronize 
multiple channels you could share the lock among those.

I know that means allocating a lock, etc, but heck you can make a slab 
cache for spinlocks or semaphores or whatever locking primite you use if 
you consider that important.

I don't know much about the IDE or block layers but it strikes me as the 
simplest approach to control the level of "lock sharing".

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

