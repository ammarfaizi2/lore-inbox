Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290070AbSBOQ3V>; Fri, 15 Feb 2002 11:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290012AbSBOQ3E>; Fri, 15 Feb 2002 11:29:04 -0500
Received: from 216-42-72-167.ppp.netsville.net ([216.42.72.167]:40879 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S290056AbSBOQ26>; Fri, 15 Feb 2002 11:28:58 -0500
Date: Fri, 15 Feb 2002 11:28:35 -0500
From: Chris Mason <mason@suse.com>
To: James Bottomley <James.Bottomley@steeleye.com>, Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] queue barrier support 
Message-ID: <3998280000.1013790514@tiny>
In-Reply-To: <200202151515.g1FFFw801733@localhost.localdomain>
In-Reply-To: <200202151515.g1FFFw801733@localhost.localdomain>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Friday, February 15, 2002 10:15:58 AM -0500 James Bottomley <James.Bottomley@steeleye.com> wrote:

> mason@suse.com said:
>> I was wondering about this, we would need to change the error handler
>> to  fail all the requests after the barrier.  I was hoping the driver
>> did this for us ;-) 
> 
> Unfortunately, this is going to involve deep hackery inside the error handler. 
>  The current initial premise is that it can simply retry the failing command 
> by issuing an ABORT to the tag and resending it (which can cause a tag to move 
> past your barrier).  In an error situation, it really wouldn't be wise to try 
> to abort lots of potentially running tags to preserve the barrier ordering 
> (because of the overload placed on a known failing component), so I think the 
> error handler has to abandon the concept of aborting commands and move 
> straight to device reset.  We then carefully resend the commands in FIFO order.
> 

Ok, I'll try to narrow the barrier usage a bit, I'm waiting on the
barrier write once it is sent, so I'm not worried about anything done
after the ordered tag.

write X log blocks   (simple tag)
write 1 commit block (ordered tag)
wait on all of them.

All I care about is knowing that all of the log blocks hit the disk
before the commit.  So, if one of the log blocks aborts, I want it
to abort the commit too.  Is this a little easier to implement?

> Additionally, you must handle the case that a device is reset by something 
> else (in error handler terms, the cc_ua [check condition/unit attention]).  
> Here also, the tags would have to be sent back down in FIFO order as soon as 
> the condition is detected.
> 
> mason@suse.com said:
>> Yes, this could get sticky.  Does anyone know if other OSes have
>> already done this? 
> 
> Other OSs (well the ones I've heard about: Solaris and HP-UX) try to avoid 
> ordered tags, mainly because of the performance impact they have---the drive 
> tag service algorithms become inefficient in the presence of ordered tags 
> since they're usually optimised for all simple tags.

I do see that on my drives ;-)  The main reason I think its worth trying
is because the commit block is directly adjacent to the last log block,
so I'm hoping the drive can optimize the commit (even though it is ordered)
better when the OS sends it directly after the last log block.

While I've got linux-scsi cc'd, I'll reask a question from yesterday.
Do the targets with write back caches usually ignore the order tag, 
doing the write in the most efficient way possible instead?

-chris



