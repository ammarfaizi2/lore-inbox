Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261866AbVFQAH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbVFQAH0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 20:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbVFQAH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 20:07:26 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:10887 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261866AbVFQAGv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 20:06:51 -0400
Subject: Re: 2.6.12-rc6-mm1 & 2K lun testing
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <20050616133730.1924fca3.akpm@osdl.org>
References: <1118856977.4301.406.camel@dyn9047017072.beaverton.ibm.com>
	 <20050616002451.01f7e9ed.akpm@osdl.org>
	 <1118951458.4301.478.camel@dyn9047017072.beaverton.ibm.com>
	 <20050616133730.1924fca3.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1118965381.4301.488.camel@dyn9047017072.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Jun 2005 16:43:02 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-16 at 13:37, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > > 
> > > We seem to be always ooming when allocating scsi command structures. 
> > > Perhaps the block-level request structures are being allocated with
> > > __GFP_WAIT, but it's a bit odd.  Which I/O scheduler?  If cfq, does
> > > reducing /sys/block/*/queue/nr_requests help?
> > 
> > Yes. I am using CFQ scheduler. I changed nr_requests to 4 for all
> > my devices. I also changed "min_free_kbytes" to 64M.
> 
> Yeah, that monster cfq queue depth continues to hurt in corner cases.
> 
> > Response time is still bad. Here is the vmstat, meminfo, slabinfo
> > and profle output. I am not sure why profile output shows 
> > default_idle(), when vmstat shows 100% CPU sys.
> 
> (please inline text rather then using attachments)
> 
> > MemTotal:      7209056 kB
> > ...
> > Dirty:         5896240 kB
> 
> That's not going to help - we're way over 40% there, so the VM is getting
> into some trouble.
> 
> Try reducing the dirty limits in /proc/sys/vm by a lot to confirm that it
> helps.
> 
> There are various bits of slop and hysteresis and deliberate overshoot in
> page-writeback.c which are there to enhance IO batching and to reduce CPU
> consumption.  A few megs here and there adds up when you multiply it by
> 2000...
> 
> Try this:
> 
> diff -puN mm/page-writeback.c~a mm/page-writeback.c
> --- 25/mm/page-writeback.c~a	Thu Jun 16 13:36:29 2005
> +++ 25-akpm/mm/page-writeback.c	Thu Jun 16 13:36:54 2005
> @@ -501,6 +501,8 @@ void laptop_sync_completion(void)
>  
>  static void set_ratelimit(void)
>  {
> +	ratelimit_pages = 32;
> +	return;
>  	ratelimit_pages = total_pages / (num_online_cpus() * 32);
>  	if (ratelimit_pages < 16)
>  		ratelimit_pages = 16;
> _
> 

Wow !! Reducing the dirty ratios and the above patch did the trick.
Instead of 100% sys CPU, now I have only 50% in sys.

Of course, my IO rate is not so great, but machine responds really
really well. :) 

Thanks,
Badari

procs -----------memory---------- ---swap-- -----io---- --system--
----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy
id wa
 4 3667      8  76068 285016 4777976    0    0    51 22883  419  1900  0
49  0 51
20 3667      8  76068 285744 4779312    0    0    50 23108  433  1908  0
53  0 47
10 3680      8  76080 286492 4772888    0    0    58 26266  419  1805  0
56  0 44
 6 3661      8  76024 287116 4768136    0    0    50 27894  426  1765  0
59  0 41
 7 3679      8  76156 288052 4764620    0    0   270 24391  442  1852  0
53  0 47
 3 3691      8  77604 288732 4759296    0    0    44 24312  425  1809  0
57  0 43
 3 3697      8  75896 288868 4747808    0    0    82 29504  868  3605  2
64  0 34


