Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264305AbUEJRJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbUEJRJk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 13:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbUEJRJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 13:09:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:12441 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264305AbUEJRJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 13:09:37 -0400
Date: Mon, 10 May 2004 19:09:36 +0200
From: Pavel Machek <pavel@suse.cz>
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Cc: Gabor Kuti <seasons@fornax.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.6 swsusp.c: allow device aliasing
Message-ID: <20040510170936.GG27008@atrey.karlin.mff.cuni.cz>
References: <xb73c68s14g.fsf@savona.informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xb73c68s14g.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm  using  devfs.   (I'm   using  /dev/hda7  for  swsusp.)   So,  cat
> /proc/swaps shows my swap device as:
> 
>     Filename                                Type      Size  Used Priority
>     /dev/ide/host0/bus0/target0/lun0/part7  partition 498920  0   -1
> 
> whereas  I  specify  "resume=/dev/hda7"  as a  boot  parameter.   Upon
> suspend, swsusp can't find a swap device exactly named "/dev/hda7" and
> hence thinks there is no swapspace.
> 
> 
> The problem is that:
> 
> 1) Upon suspend, kernel/power/swsusp.c compares the devices names
>    "/dev/hda7" and "/dev/ide/.../part7" and they don't match.  So
>    swsusp refuses to suspend to the swap partition.  Changing the
>    boot parameter to "resume=/dev/ide/host0/bus0/target0/lun0/part7"
>    solves this problem, BUT:
> 
> 2) Upon resume, kernel/power/swsusp.c doesn't understand what a device
>    "/dev/ide/host0/bus0/target0/lun0/part7" is.  It only knows what
>    "/dev/hda7".  So, I have to set "resume=/dev/hda7" for resume to
>    work.  But this would create problem (1).
> 
> So, I can't get both suspend and resume to work!  :(
> 
> Why did it  work in pre-2.6.6?  Because that check  in swsusp.c in pre
> 2.6.6 didn't really check if  the device is correct upon suspend.  The
> suspend code  only writes  the suspend/resume data  to the  FIRST swap
> device.  2.6.6 has corrected this bug, but can't equate "/dev/hda7" to
> "/dev/ide/host0/bus0/target0/lun0/part7",  although the  two  refer to
> the same device.
> 
> 
> The following patch (against 2.6.6)  fixes this problem in the suspend
> code.  It  will check whether both  the swap device  and the "resume="
> parameter refer to a block  device with the same (major,minor) number.
> If so, the swap device is taken  to be the one specified for swsusp to
> use.   So, aliasing  of devices  is support.   This means  I  must say
> "resume=/dev/hda7"                       and                       not
> "resume=/dev/ide/host0/bus0/target0/lun0/part7".    If,  however,  the
> specified swap devices are (swap)  files rather block devices, it only
> does a filename comparison.  (Does  swsusp support swap files?  If so,
> should we also support file aliasing?  How?)

No, swsusp only supports swap devices. That means that you probably
should kill d_path and name handling; that will slean the code up as
well.

Oh and please 

> 
> --- linux-2.6.6-official/kernel/power/swsusp.c	2004/05/10 14:11:17	1.1
> +++ linux-2.6.6-swsusp-dev-aliasing/kernel/power/swsusp.c	2004/05/10 16:11:41	1.3
> @@ -215,47 +215,67 @@
>  		else if ((!memcmp("SWAPSPACE2",cur->swh.magic.magic,10)))
>  			memcpy(cur->swh.magic.magic,"S2SUSP....",10);
>  		else panic("\nSwapspace is not swapspace (%.10s)\n", cur->swh.magic.magic);
>  		cur->link.next = prev; /* prev is the first/last swap page of the resume area */
>  		/* link.next lies *no more* in last 4/8 bytes of magic */
>  	}
>  	rw_swap_page_sync(WRITE, entry, page);
>  	__free_page(page);
>  }
>  
> +static int is_resume_file(const struct swap_info_struct *swap_info) {

Newline needed before {.

Otherwise it looks good. Can you submit fixed patch? Thanks,
									Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
