Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbTJ2Ee2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 23:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbTJ2Ee2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 23:34:28 -0500
Received: from web13004.mail.yahoo.com ([216.136.174.14]:58739 "HELO
	web13004.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261775AbTJ2Ee0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 23:34:26 -0500
Message-ID: <20031029043423.41171.qmail@web13004.mail.yahoo.com>
Date: Tue, 28 Oct 2003 20:34:23 -0800 (PST)
From: Amit Patel <patelamitv@yahoo.com>
Subject: Re: as_arq scheduler alloc with 2.6.0-test8-mm1
To: Nick Piggin <piggin@cyberone.com.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <3F9F2928.7030704@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Nick Piggin <piggin@cyberone.com.au> wrote:
> 
> No, you're on the right track. Actually, in the
> block device
> you will allocate the queue, and the queue will then
> allocate
> the elevator. First see if the queue is being
> properly allocated
> and freed. If it is not, then the problem is in the
> SCSI layer.
> 
> 

Hi Nick,

During scsi_scan.c:scsi_probe_and_add_lun it allocates
scsi device and request_queue to send the
scsi_request. If during this scan it finds no device
attached to target it will deallocate request__queue.
But since there was no disk found it never called
add_disk and so it never go through blk_register_queue
function to register elevator queue. So during clean
up it just calles blk_cleanup_queue which does _not_
clean up elevator_data. 

This is just what I think is happening by looking at
the code. I might be missing something. But in this
case either blk_cleanup_queue should clean elevator
also as part of cleanup instead of it getting cleaned
up through blk_unregister_queue or scsi  layer needs
to make some changes during scan. I do not know what
implication it might have if cleanup is done as part
of blk_cleanup_queue on other kind of block devices. I
will try to put this cleanup as part of
blk_cleanup_queue to see if it works. 

Thanks
Amit
> 
> Amit Patel wrote:
> 
> >Hi 
> >
> >After doing some printk debugging looks like for
> each
> >block device we allocate elevator structure. But
> >during cleanup the elevator->elevator_data is never
> >freed. In printk I put printk in
> as-iosched.c:as_alloc
> >where I see elevator_data is allocated from as_arq
> >pool and it should have been freed as a part of
> block
> >device cleanup through elevator_release function. I
> >never see it coming to elevatore_release function. 
> >
> >I will try to walk through code some more and see
> if I
> >can figure out who was supposed to call
> >elevator_release as part of cleanup. Let me know if
> I
> >am going on wrong track here.
> >
> >Thanks
> >Amit
> >
> 


__________________________________
Do you Yahoo!?
Exclusive Video Premiere - Britney Spears
http://launch.yahoo.com/promos/britneyspears/
