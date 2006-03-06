Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752387AbWCFSZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387AbWCFSZn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 13:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752347AbWCFSZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 13:25:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27090 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752298AbWCFSZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 13:25:42 -0500
Date: Mon, 6 Mar 2006 10:25:26 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, markhe@nextd.demon.co.uk,
       Andrea Arcangeli <andrea@suse.de>, Mike Christie <michaelc@cs.wisc.edu>,
       James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
In-Reply-To: <200603060117.16484.jesper.juhl@gmail.com>
Message-ID: <Pine.LNX.4.64.0603060956570.13139@g5.osdl.org>
References: <200603060117.16484.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 6 Mar 2006, Jesper Juhl wrote:
> 
> Slab corruption: start=f72948a0, len=64
> Redzone: 0x5a2cf071/0x5a2cf071.
> Last user: [<c02934eb>](sr_do_ioctl+0x11b/0x270)
> 000: 70 00 05 00 00 00 00 0a 00 00 00 00 24 00 00 00
> 010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> Prev obj: start=f7294854, len=64
> Redzone: 0x170fc2a5/0x170fc2a5.
> Last user: [<c0173923>](real_lookup+0x93/0xe0)
> 000: 6c 69 62 6b 64 65 69 6e 69 74 5f 6b 69 6f 5f 68
> 010: 74 74 70 5f 63 61 63 68 65 5f 63 6c 65 61 6e 65
> Next obj: start=f72948ec, len=64
> Redzone: 0x170fc2a5/0x170fc2a5.
> Last user: [<c01c7c80>](ext3_init_block_alloc_info+0x20/0x70)
> 000: 10 cf ce f7 00 00 00 00 00 00 00 00 00 00 00 00
> 010: 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Ok, this is interesting because the previous and the next objects look 
fine, which implies that it's not something else that overwrote it.

Perhaps more importantly, the actual corrupted object _should_ contain the 
POISON_FREE bytes, but doesn't. In fact, what it _does_ contain is 
apparently perfectly valid SCSI sense request data (if I read it right, 
it's ASC/ASCQ of 24/00 means "Invalid field in cdb").

So that "last user: sr_do_ioctl" thing actually matches what the contents 
are.

Your other smal corruption:

> Slab corruption: start=f70aeab4, len=64
> Redzone: 0x5a2cf071/0x5a2cf071.
> Last user: [<c02934eb>](sr_do_ioctl+0x11b/0x270)
> 000: 70 00 02 00 00 00 00 0a 00 00 00 00 3a 01 00 00
> 010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> Prev obj: start=f70aea68, len=64
> Redzone: 0x170fc2a5/0x170fc2a5.
> Last user: [<c023d6df>](init_dev+0x5cf/0x630)
> 000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> Next obj: start=f70aeb00, len=64
> Redzone: 0x170fc2a5/0x170fc2a5.
> Last user: [<c0173923>](real_lookup+0x93/0xe0)
> 000: 6c 69 62 62 6f 6f 73 74 5f 70 72 67 5f 65 78 65
> 010: 63 5f 6d 6f 6e 69 74 6f 72 2d 67 63 63 2d 31 5f

is exactly the same thing. The objects around it look ok. The object that 
should be poisoned again looks like it contains normal request-sense data 
(this time 3a/01: "Medium not present - tray closed", if I read it right).

So it really looks like in this case, the sr_do_ioctl() function free'd 
the sense key object, but that the sense data was actually written _after_ 
the object was free'd.

That in turn would imply that scsi_execute() returned before the SCSI 
command had actually completed. Now, scsi_execute() just calls to the 
generic block device layer, which in turn just submits it, and then waits 
for its completion, so if it returns too early, that means that it got 
_completed_ too early by the driver.

Alternatively, it got re-tried. The reason I mention that is that we have 
commit 17e01f216b611fc46956dcd9063aec4de75991e3, which changes 
scsi_execute() to add retries.

I wonder if something does a "complete(rq->waiting)" while the thing is 
still retrying? In general, I do not believe that we should retry special 
commands that have been initiated by a user, we should return the error. 
But I haven't thought this through.

Anyway, Jesper, I see two potential reasons for this bug:

 - total and utter slab confusion (the slab layer returned the same slab 
   allocation twice to two different callers). I consider this pretty 
   unlikely, because it's such a _major_ failure of the slab code, and the 
   slab code hasn't changed that much, but I mention it just in case. 

 - SCSI layer breakage. It might well be the low-level driver completing a 
   request too early, or it migth be the re-trying. If it's the re-trying, 
   you could try just reverting that commit I pointed to (ie if you're a 
   git user, just do "git revert 17e01f21", otherwise you'd need to look 
   it up from gitweb and un-apply the patch)

Regardless, Jesper, it would be great to hear _what_ strange CDROM device 
you have that would implied in sr_ioctl.c - is it USB, SATA or something 
else?

James, Mike, can you double-check the retries? In particular, it's _wrong_ 
to retry after you've already marked a command completed with 
"complete(rq->waiting)", so if that happens somewhere, things are really 
broken.

			Linus
