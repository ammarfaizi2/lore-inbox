Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310529AbSCEHtY>; Tue, 5 Mar 2002 02:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310528AbSCEHtP>; Tue, 5 Mar 2002 02:49:15 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:29709 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S310525AbSCEHtD>;
	Tue, 5 Mar 2002 02:49:03 -0500
Date: Tue, 5 Mar 2002 08:48:53 +0100
From: Jens Axboe <axboe@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Chris Mason <mason@suse.com>,
        James Bottomley <James.Bottomley@steeleye.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Message-ID: <20020305074853.GD716@suse.de>
In-Reply-To: <phillips@bonn-fries.net> <1201480000.1015262195@tiny> <20020304180537.F1444@redhat.com> <E16hyRG-0000fO-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16hyRG-0000fO-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04 2002, Daniel Phillips wrote:
> But the bio layer can manage it, by sending a write barrier down all relevant 
> queues.  We can send a zero length write barrier command, yes?

Actually, yes that was indeed one of the things I wanted to achieve with
the block layer rewrite -- the ability to send down other commands than
read/write down the queue. So not exactly bio, but more of a new block
feature.

See, now fs requests have REQ_CMD set in the request flag bits. This
means that it's a "regular" request, which has a string of bios attached
to it. Doing something ala

	struct request *rq = get_request();

	init_request(rq);
	rq->rq_dev = target_dev;
	rq->cmd[0] = GPCMD_FLUSH_CACHE;
	rq->flags = REQ_PC;
	/* additional info... */
	queue_request(rq);

would indeed be possible. The attentive reader will now know where
ide-scsi is headed and why :-)

This would work for any SCSI and psueo-SCSI device, basically all the
stuff out there. For IDE, the request pre-handler would transform this
into an IDE command (or taskfile).

-- 
Jens Axboe

