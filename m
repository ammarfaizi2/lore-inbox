Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290192AbSBOQwL>; Fri, 15 Feb 2002 11:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290081AbSBOQwE>; Fri, 15 Feb 2002 11:52:04 -0500
Received: from host194.steeleye.com ([216.33.1.194]:31241 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S290185AbSBOQvx>; Fri, 15 Feb 2002 11:51:53 -0500
Message-Id: <200202151651.g1FGpjs02083@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Chris Mason <mason@suse.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>, Jens Axboe <axboe@suse.de>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] queue barrier support 
In-Reply-To: Message from Chris Mason <mason@suse.com> 
   of "Fri, 15 Feb 2002 11:28:35 EST." <3998280000.1013790514@tiny> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 15 Feb 2002 11:51:45 -0500
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mason@suse.com said:
> While I've got linux-scsi cc'd, I'll reask a question from yesterday.
> Do the targets with write back caches usually ignore the order tag,
> doing the write in the most efficient way possible instead? 

I'll try to answer, although I'm not quite sure of the basis of the question.

No ordinary SCSI drive that's not on a battery backed circuit should *ever* 
use writeback caching.  They should all come by default as write through.  In 
this case, the tag is acknowleged as completed only when the write has made it 
to the medium.

If you alter the drive parameter page to turn on write back caching, it's 
caveat emptor.  Since you're now telling the drive that you consider hitting 
the cache to be equivalent to hitting the medium (because you know better 
about power failures and the like) it is undefined by the standards how the 
drives write from the cache to the medium---and you shouldn't care about this 
if you have arranged your system to do write back caching.  They will 
acknowlege the tag as completed as soon as it hits the cache, and the ordered 
tag will be order it commits to the cache.

Note, for high end disk arrays, the reverse is usually true since they often 
have internal battery backups for their caches and drives.

If you lose power to the drive that does write back caching before the cache 
flushes, all the indications you've given the journalling fs about write 
commits are voided and the fs is probably inconsistent and not recoverable by 
a journal replay.

Note also that on system shutdown, most devices that use write back caching 
are also expecting a cache flush instruction from the node, which Linux 
doesn't send.

James


