Return-Path: <linux-kernel-owner+w=401wt.eu-S1751551AbXAUNMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbXAUNMH (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 08:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbXAUNMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 08:12:06 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4582 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751538AbXAUNMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 08:12:02 -0500
Date: Fri, 19 Jan 2007 09:29:37 +0000
From: Pavel Machek <pavel@ucw.cz>
To: "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>
Cc: inux-pm@lists.osdl.org, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Power S3 Resume Optimization Patch. Request for Comment
Message-ID: <20070119092936.GA5590@ucw.cz>
References: <5B3EF00AF56209498A59172917BFE8130165151B@bgsmsx412.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B3EF00AF56209498A59172917BFE8130165151B@bgsmsx412.gar.corp.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> [RFC][PATCH] Power S3 Resume optimisation 
> 	Here is a simple patch for optimising the S3 resume. With this
> patch the resume time is 0.85. Given the fact that device initialisation
> on the resume takes almost 70% of time, By executing the whole
> "device_resume()" function on a seperate kernel thread, the resume gets
> completed( ie. the user can precieve) by ~0.85 sec.

Yep, but you also break it completely...

> 	To avoid any possible race condition while processing the IO
> request and to make sure all the io request are queued till the device
> resume thread exits, the IO schedulars (patched cfq and as) checks a for
> system_resume flag, which is set when the device resume thread starts,
> if the flag is set, it doesnt put the request in the dispatch queue.
> Once the flag is cleared i.e when the device resume thread is complete,
> the IO-schedular behave as in normal situation.

And you noticed that, so you fixed obvious problems on block devices.
Ignoring char and net devices completely.


> @@ -1088,6 +1088,19 @@
>         if (list_empty(&ad->fifo_list[adir]))
>                 return 0;
> 
> +       /*
> +        * Check here for the System resume flag to be cleared, if flag
> is
> +       *  still set the resume thread hasnt completed yet, and hence
> dont
> +       *  takeout any new request from the FIFO
> +       */
> +       extern int system_resuming;
> +       if (system_resuming != 0)
> +       {

Locking. CodingStyle.

> -static void suspend_finish(suspend_state_t state)
> +static int dev_resume_proc(void * data)
> {
> +       /* Set the global resume flag, this will be checked by the
> IO_schedular

Broken mail client.

> +       * before dispatching the IO request
> +       */
> +       system_resuming =1;

Add mdelay(1 hour) here. Then try to use your wifi card and your tv
grabber.

>         device_resume();
> +       system_resuming = 0;
> +#ifdef DEBUG
> +       printk(" reseting system_resume \n");
> +#endif

							Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
