Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292896AbSBVP1j>; Fri, 22 Feb 2002 10:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292902AbSBVP1d>; Fri, 22 Feb 2002 10:27:33 -0500
Received: from 216-42-72-168.ppp.netsville.net ([216.42.72.168]:26252 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S292896AbSBVP1T>; Fri, 22 Feb 2002 10:27:19 -0500
Date: Fri, 22 Feb 2002 10:26:38 -0500
From: Chris Mason <mason@suse.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Message-ID: <919450000.1014391598@tiny>
In-Reply-To: <20020222141915.F2424@redhat.com>
In-Reply-To: <799880000.1014334220@tiny> <20020222141915.F2424@redhat.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, February 22, 2002 02:19:15 PM +0000 "Stephen C. Tweedie" <sct@redhat.com> wrote:

>> There might be additional spots in ext3 where ordering needs to be 
>> enforced, I've included the ext3 code below in hopes of getting 
>> some comments.
> 
> No.  However, there is another optimisation which we can make.
> 
> Most ext3 commits, in practice, are lazy, asynchronous commits, and we
> only nedd BH_Ordered_Tag for that, not *_Flush.  It would be easy
> enough to track whether a given transaction has any synchronous
> waiters, and if not, to use the async *_Tag request for the commit
> block instead of forcing a flush.

Just a note, the scsi code doesn't implement flush at all, flush
either gets ignored or failed (if BH_Ordered_Hard is set), the
assumption being that scsi devices don't write back by default, so
wait_on_buffer() is enough.

The reiserfs code tries to be smart with _Tag, in pratice I haven't
found a device that gains from it, so I didn't want to make the larger
changes to ext3 until I was sure it was worthwhile ;-)

It seems the scsi drives don't do tag ordering as nicely as we'd 
hoped, I'm hoping someone with a big raid controller can help 
benchmark the ordered tag mode on scsi.  Also, check the barrier
threads from last week on how write errors might break the 
ordering with the current scsi code.

-chris

