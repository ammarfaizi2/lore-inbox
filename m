Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262505AbVA0Gi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262505AbVA0Gi4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 01:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbVA0Gi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 01:38:56 -0500
Received: from egg.hpc2n.umu.se ([130.239.45.244]:30710 "EHLO egg.hpc2n.umu.se")
	by vger.kernel.org with ESMTP id S262505AbVA0Gix (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 01:38:53 -0500
Date: Thu, 27 Jan 2005 07:38:49 +0100
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Ake <Ake.Sandgren@hpc2n.umu.se>, linux-kernel@vger.kernel.org
Subject: Re: Bug in 2.4.26 in mm/filemap.c when using RLIMIT_RSS
Message-ID: <20050127063849.GA11119@hpc2n.umu.se>
References: <20050126110750.GE7349@hpc2n.umu.se> <20050126144904.GE26308@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050126144904.GE26308@logos.cnet>
User-Agent: Mutt/1.5.6+20040907i
From: Ake.Sandgren@hpc2n.umu.se (Ake)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 12:49:04PM -0200, Marcelo Tosatti wrote:
> > There is also a misinformative comment in fs/proc/array.c
> > in proc_pid_stat where it says
> > mm ? mm->rss : 0, /* you might want to shift this left 3 */
> > the number 3 should probably be PAGE_SHIFT-10.

Don't forget the comment (it's still there in 2.6) :-)

> Amazing that this has never been noticed before - I bet not many people use RSS 
> limits with madvise().

Neither do we. :-)

I just found it when trying to figure out if the kernel actually used
any of the rlimits and if so how.
(Trying to make PBS work correctly)

> This transform the rlimit in pages before the comparison, can you please test
> it.
> 
> --- a/mm/filemap.c.orig	2004-11-17 09:54:22.000000000 -0200
> +++ b/mm/filemap.c	2005-01-26 15:21:10.614842296 -0200
> @@ -2609,6 +2609,9 @@
>  	error = -EIO;
>  	rlim_rss = current->rlim ?  current->rlim[RLIMIT_RSS].rlim_cur :
>  				LONG_MAX; /* default: see resource.h */
> +
> +	rlim_rss = (rlim_rss & PAGE_MASK) >> PAGE_SHIFT;
> +
>  	if ((vma->vm_mm->rss + (end - start)) > rlim_rss)
>  		return error;

Since we don't use it i can't really test it, but a visual inspection is
good enough in this simple case. And since this is the only place in 2.4
that RLIMIT_RSS is used, the problem is solved.

BTW do you know if there is any plans for 2.6++ to actually use
RLIMIT_RSS? I saw a hint in that direction in mm/thrash.c
grab_swap_token but it is commented out and only skeleton code...

I'm asking since the above code piece has been removed.

-- 
Ake Sandgren, HPC2N, Umea University, S-90187 Umea, Sweden
Internet: ake@hpc2n.umu.se	Phone: +46 90 7866134 Fax: +46 90 7866126
Mobile: +46 70 7716134 WWW: http://www.hpc2n.umu.se
