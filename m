Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269161AbTGQTqL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 15:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269219AbTGQTqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 15:46:11 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:44252 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S269161AbTGQTqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 15:46:03 -0400
Date: Thu, 17 Jul 2003 22:00:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Peter Osterlund <petero2@telia.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Software suspend testing in 2.6.0-test1
Message-ID: <20030717200039.GA227@elf.ucw.cz>
References: <m2wueh2axz.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2wueh2axz.fsf@telia.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have done some testing of the software suspend function in
> 2.6.0-test1. It works mostly very well, but I have found two problems.
> 
> The first problem is that software suspend fails if a process is
> stopped before you invoke suspend. (For example, by starting cat from
> the shell and pressing ctrl-z.) When the processes are woken up again,
> the cat process is stuck in the schedule loop in refrigerator(),
> sucking up all available cpu time.

Thanks for a report. If it came with a patch it would be better
;-). I'll take a look.

> The second problem is that freeing memory seems to be much slower than
> it has to be. It appears to be caused by the call to
> blk_congestion_wait() in balance_pgdat(). The patch below makes page
> freeing much faster, although I'm quite sure the patch is not correct.
> 
> How can we fix this properly? The disk is mostly idle during page
> freeing, but it looks like blk_congestion_wait still doesn't return
> until the timeout expires. I tried HZ/2 and that made the page freeing
> extremely slow.
> 
> --- linux/mm/vmscan.c.old	Thu Jul 17 21:30:09 2003
> +++ linux/mm/vmscan.c	Thu Jul 17 21:29:58 2003
> @@ -930,7 +930,7 @@
>  		}
>  		if (all_zones_ok)
>  			break;
> -		blk_congestion_wait(WRITE, HZ/10);
> +		blk_congestion_wait(WRITE, HZ/50);
>  	}
>  	return nr_pages - to_free;
>  }

This is certainly not okay. Andrew, you know more about vm
internals... What does this ugly constant mean? Would it be possible
to somehow make it variable and set it to zero during software suspend
memory freeing?
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
