Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbULFN2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbULFN2m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 08:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbULFN2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 08:28:42 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:65487 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261152AbULFN2T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 08:28:19 -0500
Date: Mon, 6 Dec 2004 14:27:50 +0100
From: Jens Axboe <axboe@suse.de>
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       helge.hafting@hist.no
Subject: [PATCH] Time sliced CFQ #3
Message-ID: <20041206132749.GX10498@suse.de>
References: <20041204104921.GC10449@suse.de> <41B426D4.6080506@gmx.de> <20041206093517.GJ10498@suse.de> <41B45134.4040005@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B45134.4040005@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06 2004, Prakash K. Cheemplavam wrote:
> Jens Axboe schrieb:
> >On Mon, Dec 06 2004, Prakash K. Cheemplavam wrote:
> >
> >>Hi,
> >>
> >>this one crapped out on me, while having heavy disk activity. (updating 
> >>gentoo portage tree - rebuilding metadata of it). Unfortunately I 
> >>couldn't save the oops, as I had no hd access anymore and X would freeze 
> >>a little later...(and I don't want to risk my data a second time...)
> >
> >
> >Did you save anything at all? Just the function of the EIP would be
> >better than nothing.
> 
> Nope, sorry. I hoped it would be in the logs, but it seems as new cfq 
> went havoc, hd access went dead. And I was a bit too nervous about my 
> data so that I didn't write it down by hand...

It is really rare for the io scheduler to cause serious data screwups,
thankfully. Often what will happen is that it will crash, but with
everything written fine up to that point. So it's similar to a power
loss, but the drive should get it's cache out on its own.

> >Well hard to say anything qualified without an oops :/
> >
> >I'll try with PREEMPT here.
> 
> If you are not able to reproduce, I will try it again on a spare 
> partition... Should access to zip drive stil be possible if hd's 
> io-scheduler is dead?

Depends on where it died, really. But the chances are probably slim.

If you feel like giving it another go, I've uploaded a new patch here:

http://www.kernel.org/pub/linux/kernel/people/axboe/patches/v2.6/2.6.10-rc3/cfq-time-slices-6.gz

Changes:

- Increase async_rq slice significantly (from 8 to 128)

- Fix accounting bug that prevented non-fs requests from working
  correctly. Things like cdrecord and cdda rippers would hang.

- Add logic to check whether a given process is potentially runnable or
  not. We don't arm the slice idle timer if the process has exited or is
  not either running or about to be running.

- TCQ fix: don't idle drive until last request comes in.

- Fix a stall with exiting task holding the active queue. This should
  fix Helges problems, I hope.

- Restore ->nr_requests on io scheduler switch

- Kill ->pid from io_context, this seems to have been added with 'as'
  but never used by anyone.


-- 
Jens Axboe

