Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264830AbTB0M07>; Thu, 27 Feb 2003 07:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264844AbTB0M07>; Thu, 27 Feb 2003 07:26:59 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:26000 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264830AbTB0M0z>; Thu, 27 Feb 2003 07:26:55 -0500
Date: Thu, 27 Feb 2003 18:12:20 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Linus Torvalds <torvalds@transmeta.com>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Software Suspend Functionality in 2.5
Message-ID: <20030227181220.A3082@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1046238339.1699.65.camel@laptop-linux.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1046238339.1699.65.camel@laptop-linux.cunninghams>; from ncunningham@clear.net.nz on Wed, Feb 26, 2003 at 07:46:47AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel,

When I noticed some of your discussions on swsusp mailing
list earlier, a question that crossed my mind was whether
you'd thought about the possibility of compression of data 
at the time of copy. 

Would that have been another way to helped achieve the 
objective you have in mind ? Do any issues come to mind ?

Regards
Suparna

On Wed, Feb 26, 2003 at 07:46:47AM +0000, Nigel Cunningham wrote:
> Hi Linus.
> 
> Pavel and I have been discussing what functionality should be in
> software suspend, and I wanted to ask your opinion since you're the
> final decision maker anyway.
> 
> Under 2.4, I've added a lot functionality which has recently been merged
> by Florent (swsusp beta 18). This functionality brings us as close as I
> can get to the point where what you have in memory when you initiate the
> suspend is very close to what you have when you finish resuming.
> Settings on the proc interface and the amount of swap available do mean 
> the degree to which this is true varies - you can set a soft limit on
> the image size, for example - but that's the gist of the changes. I
> implemented all the changes because as a user, I wanted the system to be
> as responsive as possible upon resume - I didn't want a ton of thrashing
> and an unresponsive system while processes tried to get back whatever
> had been discarded or forced to swap. Performance with the changes does
> not seem to be degraded, even though pages are currently write
> synchronously (batching of requests is in the pipeline).
> 
> Where the rubber hits the road, I guess, is that the process is a bit
> more complicated than the one in the kernel at the moment:
> - Rather than freeing memory until no more can be freed, memory is freed
> until the image fits in available swap, will be able to be saved and
> reloaded and meets the user's size limit. (The limit can be disabled by
> setting it to zero. If we can't reduce the image size to the requested
> amount (eg the user requests a 1MB image), we continue anyway - hence
> the description of 'soft limit' above.
> - Pages to be saved are put into two categories - those we definitely
> won't need during suspend and those that might/will be needed (simple
> algorithm). The two sets of pages are saved separately - those not
> needed are saved directly to disk, those needed are later copied and
> then the copy is saved (as per current algorithm).
> - Since we're saving more pages, we need more pages for the pagedir
> (index). Unlike now, we probably won't be able to allocate (say) a
> hundred contiguous set of pages, so we need to be able to have a
> scattered (discontiguous) pagedir.
> - We also need to be careful to free buffers & swap cache generated
> during the save/resume process, so as to not corrupt the image.
> 
> Naturally there are other changes, but perhaps the simplest comparison
> is to say that the 2.5.62 suspend.c is 34549 bytes (suspend.o 25132),
> whereas beta18 is 77945 bytes (suspend.o 53756 with all the debugging
> code turned off).
> 
> So can we please get your thoughts? Would you be willing to accept these
> additions when they're ready?
> 
> Regards,
> 
> Nigel
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

