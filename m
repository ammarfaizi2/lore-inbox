Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290284AbSBORSb>; Fri, 15 Feb 2002 12:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290289AbSBORST>; Fri, 15 Feb 2002 12:18:19 -0500
Received: from 216-42-72-167.ppp.netsville.net ([216.42.72.167]:62895 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S290259AbSBORSJ>; Fri, 15 Feb 2002 12:18:09 -0500
Date: Fri, 15 Feb 2002 12:17:49 -0500
From: Chris Mason <mason@suse.com>
To: James Bottomley <James.Bottomley@steeleye.com>
cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] queue barrier support 
Message-ID: <4044420000.1013793468@tiny>
In-Reply-To: <200202151651.g1FGpjs02083@localhost.localdomain>
In-Reply-To: <200202151651.g1FGpjs02083@localhost.localdomain>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, February 15, 2002 11:51:45 AM -0500 James Bottomley <James.Bottomley@steeleye.com> wrote:

> mason@suse.com said:
>> While I've got linux-scsi cc'd, I'll reask a question from yesterday.
>> Do the targets with write back caches usually ignore the order tag,
>> doing the write in the most efficient way possible instead? 
> 
> I'll try to answer, although I'm not quite sure of the basis of the question.
> 
> No ordinary SCSI drive that's not on a battery backed circuit should *ever* 
> use writeback caching.  They should all come by default as write through.  In 
> this case, the tag is acknowleged as completed only when the write has made it 
> to the medium.

Right, friends don't let friends use non-battery back write back caches ;-)

> 
> If you alter the drive parameter page to turn on write back caching, it's 
> caveat emptor.  Since you're now telling the drive that you consider hitting 
> the cache to be equivalent to hitting the medium (because you know better 
> about power failures and the like) it is undefined by the standards how the 
> drives write from the cache to the medium---and you shouldn't care about this 
> if you have arranged your system to do write back caching.  They will 
> acknowlege the tag as completed as soon as it hits the cache, and the ordered 
> tag will be order it commits to the cache.

Ok, this is what I was expecting.  The performance improvement from
using the ordered tags on single drives doesn't seem to be very big, and
given the problems with failed requests, I'm thinking about dropping the
scsi parts of the 2.4 barrier patch, and just worrying about making ide 
drives flush things correctly.  The hard stuff on error recovery can
be tackled in 2.5 and (maybe) ported back later.

But, if high end controllers with write back caching see improvements
because they can combine the log writes better with the patch, it might
be worth keeping, but modified in reiserfs so it flushes IDE caches
by default, but only sends ordered tags when the admin mounts 
with -o barrier_ordered or something.

thanks for the info
-chris

