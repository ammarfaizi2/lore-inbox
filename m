Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVDRWb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVDRWb0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 18:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVDRWb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 18:31:26 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:29809 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261196AbVDRWbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 18:31:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Mh1mCe8RlGvh7fdeL1p9GT53QWQYgSJUADer1a3JrgrPg1d/dXqf3yRPs2zqjM7loIYdIsHokuWum99j8Bnms1hmnnhIjE7LGuMJTiwekd83YJRxxj+d04UW/3DygLTVTQ+rT5MhBhAGEDUQvPnPddhwfXYDy/4DiLU18nI1SFQ=
Date: Tue, 19 Apr 2005 07:31:14 +0900
From: Tejun Heo <htejun@gmail.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jens Axboe <axboe@suse.de>, Christoph Hellwig <hch@infradead.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH scsi-misc-2.6 02/07] scsi: make scsi_send_eh_cmnd use its own timer instead of scmd->eh_timeout
Message-ID: <20050418223114.GA32478@htj.dyndns.org>
References: <20050410184214.4AAD0992@htj.dyndns.org> <20050410184214.B68C4CBA@htj.dyndns.org> <1113838401.4998.27.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113838401.4998.27.camel@mulgrave>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, James.

On Mon, Apr 18, 2005 at 10:33:21AM -0500, James Bottomley wrote:
> On Mon, 2005-04-11 at 03:45 +0900, Tejun Heo wrote:
> > 	scmd->eh_timeout is used to resolve the race between command
> > 	completion and timeout.  However, during error handling,
> > 	scsi_send_eh_cmnd uses scmd->eh_timeout.  This creates a race
> > 	condition between eh and normal completion for a request which
> > 	has timed out and in the process of error handling.  If the
> > 	request completes while scmd->eh_timeout is being used by eh,
> > 	eh timeout is lost and the command will be handled by both eh
> > 	and completion path.  This patch fixes the race by making
> > 	scsi_send_eh_cmnd() use its own timer.
> > 
> > Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> The logic is wrong in there.
> 
> The problem is you cannot rely on the timer being pending as a signal
> that the command completed normally.  The kernel doesn't define the
> elapsed time between the eh_action semaphore going up and the process
> waiting for it being scheduled.  If the timer fires within that
> undefined interval, you'll think the command timed out when it, in fact,
> completed normally.

 The original code also uses timer pending status as a signal that
command completed normally in scsi_eh_done() function, and the same
race also exists in the original code, no matter what we do, unless we
make timer expiration and removal of the command atomic, there will be
a window in which command completes normally but considered to have
timed out as long as we use timer pending status as tie breaker.

 The patch moves the test out of scsi_eh_done() into
scsi_send_eh_cmnd() and this does widen the window by delaying removal
of timer until after the original thread gets scheduled, but usually
not by much and that's how timers are done in many cases (through out
the kernel, timer removals are done with intervening scheduling and no
one considers those incorrect).  So...

 * If you're worried about the race itself, it was there before,
   it shouldn't cause any problem, and we really can't help it.
 * If you're worried about the widening of the window, practically,
   it wouldn't cause problem, and it's how timers are done in many
   other places.

 But if you still don't like it, I can rework it (maybe I'll need to
add a field to Scsi_Host or scsi_cmnd).  So, please let me know.

 Thanks a lot.

-- 
tejun

