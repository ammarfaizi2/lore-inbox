Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbVILPGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbVILPGP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 11:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbVILPGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 11:06:00 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:54962 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751371AbVILPFt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 11:05:49 -0400
Date: Mon, 12 Sep 2005 08:05:41 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Peter Staubach <staubach@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, dwmw2@infradead.org, bunk@stusta.de,
       johnstul@us.ibm.com, drepper@redhat.com, Franz.Fischer@goyellow.de,
       linux-kernel@vger.kernel.org
Subject: Re: [UPDATE PATCH][Bug 5132] fix sys_poll() large timeout handling
Message-ID: <20050912150541.GA25471@us.ibm.com>
References: <20050831200109.GB3017@us.ibm.com> <20050906212514.GB3038@us.ibm.com> <20050910003525.GC24225@us.ibm.com> <20050909181658.221eb6f9.akpm@osdl.org> <20050910022330.GD24225@us.ibm.com> <20050909193621.5d578583.akpm@osdl.org> <20050910025534.GE24225@us.ibm.com> <4325910E.8080707@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4325910E.8080707@redhat.com>
X-Operating-System: Linux 2.6.13 (i686)
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.09.2005 [10:30:38 -0400], Peter Staubach wrote:
> Nishanth Aravamudan wrote:
> 
> >On 09.09.2005 [19:36:21 -0700], Andrew Morton wrote:
> > 
> >
> >>Nishanth Aravamudan <nacc@us.ibm.com> wrote:
> >>   
> >>
> >>>+	/*
> >>>+	 * We compare HZ with 1000 to work out which side of the
> >>>+	 * expression needs conversion.  Because we want to avoid
> >>>+	 * converting any value to a numerically higher value, which
> >>>+	 * could overflow.
> >>>+	 */
> >>>+#if HZ > 1000
> >>>+	overflow = timeout_msecs >= jiffies_to_msecs(MAX_SCHEDULE_TIMEOUT);
> >>>+#else
> >>>+	overflow = msecs_to_jiffies(timeout_msecs) >= MAX_SCHEDULE_TIMEOUT;
> >>>+#endif
> >>>+
> >>>+	/*
> >>>+	 * If we would overflow in the conversion or a negative timeout
> >>>+	 * is requested, sleep indefinitely.
> >>>+	 */
> >>>+	if (overflow || timeout_msecs < 0)
> >>>+		timeout_jiffies = MAX_SCHEDULE_TIMEOUT;
> >>>     
> >>>
> >>Do we need to test (timeout_msecs < 0) here?  If we make timeout_msecs
> >>unsigned long then I think `overflow' will always be correct.
> >>   
> >>
> >
> >Even though poll is explicitly allowed to take negative values, as per
> >my man-page:
> >
> >"#include <sys/poll.h>
> >
> >int poll(struct pollfd *ufds, unsigned int nfds, int timeout);
> >
> >...
> >
> >A negative value means infinite timeout."
> >
> >Would we have a local variable to store timeout_msecs as well? Or do we
> >want to make a userspace-visible change like this? I don't have a
> >preference, I just want to make sure I understand.
> >
> 
> Actually, given this, isn't the interface for sys_poll() incorrectly 
> defined?
> Shouldn't the timeout argument be an int, instead of a long?
> 
> And, if we make it an int, then can't we do the math correctly for all
> possible values of the timeout?  The patch could look like:
> 
> Signed-off-by: Peter Staubach <staubach@redhat.com>
> 

> --- linux-2.6.13/fs/select.c.org	2005-08-28 19:41:01.000000000 -0400
> +++ linux-2.6.13/fs/select.c	2005-09-12 10:19:30.000000000 -0400
> @@ -457,25 +457,34 @@ static int do_poll(unsigned int nfds,  s
>  	return count;
>  }
>  
> -asmlinkage long sys_poll(struct pollfd __user * ufds, unsigned int nfds, long timeout)
> +asmlinkage long sys_poll(struct pollfd __user * ufds, unsigned int nfds, int timeout_msecs)
>  {
>  	struct poll_wqueues table;
>   	int fdcount, err;
>   	unsigned int i;
>  	struct poll_list *head;
>   	struct poll_list *walk;
> +	long timeout;
> +	int64_t lltimeout;
>  
>  	/* Do a sanity check on nfds ... */
>  	if (nfds > current->files->max_fdset && nfds > OPEN_MAX)
>  		return -EINVAL;
>  
> -	if (timeout) {
> -		/* Careful about overflow in the intermediate values */
> -		if ((unsigned long) timeout < MAX_SCHEDULE_TIMEOUT / HZ)
> -			timeout = (unsigned long)(timeout*HZ+999)/1000+1;
> -		else /* Negative or overflow */
> +	if (timeout_msecs) {
> +		if (timeout_msecs < 0)
>  			timeout = MAX_SCHEDULE_TIMEOUT;
> -	}
> +		else {
> +			lltimeout = (int64_t)timeout_msecs * HZ + 999;
> +			do_div(lltimeout, 1000);

I don't think the embedded folks are going to be ok with adding a 64-bit
div in the poll() common-path... But otherwise the patch looks pretty
sane, except I think you want s64, not int64_t? I can't ever remember
myself :)

I agree the interface mght be mis-defined. And changing timeout_msecs()
to an integer is consistent with the size of millisecond-unit variables
used elsewhere in the kernel.

Thanks,
Nish
