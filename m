Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316377AbSEOMFe>; Wed, 15 May 2002 08:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316378AbSEOMFd>; Wed, 15 May 2002 08:05:33 -0400
Received: from [195.63.194.11] ([195.63.194.11]:26888 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316377AbSEOMFc>; Wed, 15 May 2002 08:05:32 -0400
Message-ID: <3CE24040.4050001@evision-ventures.com>
Date: Wed, 15 May 2002 13:02:24 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Neil Conway <nconway.list@ukaea.org.uk>
CC: Anton Altaparmakov <aia21@cantab.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 IDE 61
In-Reply-To: <E177dYp-00083c-00@the-village.bc.nu> <5.1.0.14.2.20020514202811.01fcc1d0@pop.cus.cam.ac.uk> <3CE22B2B.5080506@evision-ventures.com> <3CE24A34.CEA0CAE0@ukaea.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Neil Conway napisa?:
> Martin Dalecki wrote:
> 
>>The only problem is that having a shared lock between two queues apparently
>>doesn't imply that the queues are behaving atomic on the request level
>>among each others.
> 
> 
> Correct - both queues can be active with I/O in flight at the same
> time.  But think about it: if this weren't the case, then the older
> kernels (using global io_request_lock) would have had to serialize ALL
> I/O, one request-queue active at a time, for every single
> block-device...
> 
> 
>>Apparenty the "sublimation" of the hwgroup and overall cleanup of
>>data structures, just made many people awake and be aware of problems which
>>where there already for a very very long time...
> 
> 
> I'm not quite sure which problems you mean.  The busy flag prevents any
> clash. (But sure, if you change to per-device queues AND you ditch the
> busy flag you're screwed.) Where is the problem?

The problem is that with the busy flag on we are wasting quite
a significant amount of CPU time spinning around it for no good...

Right now I'm quite confident about the idea of just having
two queues ata_queue and atapi_queue on the channel possible
shared among two channels. This will make the CPU cycle waste
occur only in the case of channels where ATA and ATAPI devices
are mixed as master and slave. This will work becouse the
only really crucial queue property which has to be device type
specific is the hardsect size.
Quite the same design as in, well, FreeBSD.
As a second step we could do just the following - block one
of the queues if the second one is active right now... This should
be simpler than doing it on the per device level by the busy flag and
wasting CPU time around it.

