Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262161AbVANU5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbVANU5O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 15:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbVANU5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 15:57:05 -0500
Received: from waste.org ([216.27.176.166]:15803 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262138AbVANU4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 15:56:18 -0500
Date: Fri, 14 Jan 2005 12:55:12 -0800
From: Matt Mackall <mpm@selenic.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Paul Davis <paul@linuxaudiosystems.com>,
       nickpiggin@yahoo.com.au, lkml@s2y4n2c.de, rlrevell@joe-job.com,
       arjanv@redhat.com, joq@io.com, hch@infradead.org, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       kernel@kolivas.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050114205512.GD3823@waste.org>
References: <1105669451.5402.38.camel@npiggin-nld.site> <200501140240.j0E2esKG026962@localhost.localdomain> <20050113191237.25b3962a.akpm@osdl.org> <20050114065701.GG2940@waste.org> <20050114121021.O24171@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050114121021.O24171@build.pdx.osdl.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 12:10:21PM -0800, Chris Wright wrote:
> * Matt Mackall (mpm@selenic.com) wrote:
> > The closest thing to concensus I've seen yet was a new rlimit for
> > scheduling with code from Chris Wright. The version I last saw had
> > some rough edges on the API (exposing the internal scheduler priority
> > levels) but wasn't too bad in principle. We really ought not get in
> > the habit of adding new rlimits though.
> > 
> > Perhaps he can post whatever he has again, I'm not sure what the
> > current state is.
> 
> This is the latest version, with the idea from Utz to break nice and
> rtprio apart.
> 
> The basic issue on the rlimit value is how to sanely encode nice values,
> realtime prioroties and scheduler policies into a number.  The first
> incarnation was the clumsiest, and tried to pack it all into a number
> in range of [0,139].  This, as many agree, too closely reflects kernel
> internal values.  This one gives 0-39 (nice values 19,-20) to RLIMIT_NICE,
> and 0-99 (rt priorities) to RLIMIT_RTPRIO.  There's no distinction in rt
> policy, and the traditional override (CAP_SYS_NICE) is still in place.
> The defaults for both rlimits are 0, and behaviour should be backwards
> compatible.  I tested this one a bit, and it worked as expected.  I've
> got a patch to pam_limits as well, although it's untested.

This is looking pretty good.

> +#define NICE_TO_RLIMIT_NICE(nice)	(19 - nice)
...
> +unsigned long nice_to_rlimit_nice(const int nice)
> +{
> +	return NICE_TO_RLIMIT_NICE(nice);
> +}

This is a bit silly.

> -	if (niceval < task_nice(p) && !capable(CAP_SYS_NICE)) {
> +	if (niceval < task_nice(p) &&
> +		nice_to_rlimit_nice(niceval) >
> +		p->signal->rlim[RLIMIT_NICE].rlim_cur &&
> +		!capable(CAP_SYS_NICE)) {

Perhaps we want another helper function to do the rlim and
CAP_SYS_NICE check together.

-- 
Mathematics is the supreme nostalgia of our time.
