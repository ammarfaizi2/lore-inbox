Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292947AbSBVSPT>; Fri, 22 Feb 2002 13:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292950AbSBVSPL>; Fri, 22 Feb 2002 13:15:11 -0500
Received: from 216-42-72-168.ppp.netsville.net ([216.42.72.168]:25744 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S292947AbSBVSPB>; Fri, 22 Feb 2002 13:15:01 -0500
Date: Fri, 22 Feb 2002 13:14:21 -0500
From: Chris Mason <mason@suse.com>
To: James Bottomley <James.Bottomley@steeleye.com>,
        "Stephen C. Tweedie" <sct@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3) 
Message-ID: <1064010000.1014401661@tiny>
In-Reply-To: <200202221736.g1MHaMc04473@localhost.localdomain>
In-Reply-To: <200202221736.g1MHaMc04473@localhost.localdomain>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, February 22, 2002 12:36:22 PM -0500 James Bottomley <James.Bottomley@steeleye.com> wrote:

> sct@redhat.com said:
>> There is a get-out for ext3 --- we can submit new journal IOs without
>> waiting for the commit IO to complete, but hold back on writeback IOs.
>> That still has the desired advantage of allowing us to stream to the
>> journal, but only requires that the commit block be ordered with
>> respect to older, not newer, IOs.  That gives us most of the benefits
>> of tagged queuing without any problems in your scenario. 
> 
> Actually, I intended the tagged queueing discussion to be discouraging.  

;-) 

> The 
> amount of work that would have to be done to implement it is huge, touching, 
> as it does, every low level driver's interrupt routine.  For the drivers that 
> require scripting changes to the chip engine, it's even worse: only someone 
> with specialised knowledge can actually make the changes.
> 
> It's feasible, but I think we'd have to demonstrate some quite significant 
> performance or other improvements before changes on this scale would fly.

Very true.  At best, we pick one card we know it could work on, and
one target that we know is smart about tags, and try to demonstrate
the improvement.

> 
> Neither of you commented on the original suggestion.  What I was wondering is 
> if we could benchmark (or preferably improve on) it:
> 
> James.Bottomley@SteelEye.com said:
>> The easy way out of the problem, I think, is to impose the barrier as
>> an  effective queue plug in the SCSI mid-layer, so that after the
>> mid-layer  recevies the barrier, it plugs the device queue from below,
>> drains the drive  tag queue, sends the barrier and unplugs the device
>> queue on barrier I/O  completion. 

The main way the barriers could help performance is by allowing the
drive to write all the transaction and commit blocks at once.  Your
idea increases the chance the drive heads will still be correctly 
positioned to write the commit block, but doesn't let the drive 
stream things better.

The big advantage to using wait_on_buffer() instead is that it doesn't
order against data writes at all (from bdflush, or some other proc
other than a commit), allowing the drive to optimize those
at the same time it is writing the commit.  Using ordered tags has the
same problem, it might just be that wait_on_buffer is the best way to 
go.

-chris

