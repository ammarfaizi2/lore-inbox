Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264762AbSJ3R72>; Wed, 30 Oct 2002 12:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264757AbSJ3R72>; Wed, 30 Oct 2002 12:59:28 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:58833 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264760AbSJ3R70>;
	Wed, 30 Oct 2002 12:59:26 -0500
Date: Wed, 30 Oct 2002 10:05:34 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.5 current bk fix setting scsi queue depths
Message-ID: <20021030100534.A12400@eng2.beaverton.ibm.com>
Mail-Followup-To: James Bottomley <James.Bottomley@steeleye.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <patmans@us.ibm.com> <200210301717.g9UHHs902706@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200210301717.g9UHHs902706@localhost.localdomain>; from James.Bottomley@steeleye.com on Wed, Oct 30, 2002 at 11:17:52AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2002 at 11:17:52AM -0600, James Bottomley wrote:
> patmans@us.ibm.com said:
> > This patch fixes a problem with the current linus bk tree setting scsi
> > queue depths to 1. Please apply. 
> 
> This patch causes the depth specification to be retained when we release 
> commandblocks.  Since releasing command blocks is supposed only to be done 
> when we give up the device (and therefore, is supposed to clear everything), 
> your fix looks like it's merely masking a problem, not fixing it.
> 
> Is the real problem that this controller is getting a release command blocks 
> and then a reallocate of them after slave_attach is called?  If so, that's 
> probably what needs to be fixed.
> 
> James

Yes, the problem is that in scsi_register_host() if there are no upper
level drivers - the standard case if building no modules - we call
scsi_release_commandblocks even though we are NOT getting rid of
the scsi_device. So, with current code, new_queue_depth and
current_queue_depth are zero.

When we register upper level drivers in scsi_register_device(), we
call scsi_build_commandblocks (again), and get a queue depth of 1,
since we've cleared new_queue_depth.

(In many cases, for one device we call build command blocks twice, call
release command blocks, and then build command blocks again. Yuck)

Removing the scsi_release_commandblocks() in scsi_register_host()
would also fix the problem, and in most cases, would not waste any
space. In the worst case AFAICT it would waste one scsi_cmnd (about 300
or so bytes?).

I see no good reason to zero new_queue_depth in scsi_release_commandblocks,
as new_queue_depth is the desired queue depth, and should remain so until
scsi_adjust_queue_depth is called. Setting new_queue_depth to zero means
we have to call slave_attach again to set it right, and depending on what
else an adapter slave_attach does could be very wrong.

-- Patrick Mansfield
