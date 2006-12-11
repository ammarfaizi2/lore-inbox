Return-Path: <linux-kernel-owner+w=401wt.eu-S1763136AbWLKWAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763136AbWLKWAs (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 17:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763138AbWLKWAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 17:00:48 -0500
Received: from smtp.osdl.org ([65.172.181.25]:41063 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763130AbWLKWAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 17:00:47 -0500
Date: Mon, 11 Dec 2006 14:00:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] group xtime, xtime_lock, wall_to_monotonic, avenrun,
 calc_load_count fields together in ktimed
Message-Id: <20061211140034.fabb840f.akpm@osdl.org>
In-Reply-To: <457DC332.3090805@cosmosbay.com>
References: <20061206234942.79d6db01.akpm@osdl.org>
	<457849E2.3080909@garzik.org>
	<20061207095715.0cafffb9.akpm@osdl.org>
	<200612081752.09749.dada1@cosmosbay.com>
	<20061208214625.90e010ae.akpm@osdl.org>
	<457DC332.3090805@cosmosbay.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2006 21:44:34 +0100
Eric Dumazet <dada1@cosmosbay.com> wrote:

> Andrew Morton a __crit :
> > 
> > hm, the patch seems to transform a mess into a mess.  I guess it's a messy
> > problem.
> > 
> > I agree that aggregating all the time-related things into a struct like
> > this makes some sense.  As does aggregating them all into a similar-looking
> > namespace, but that'd probably be too intrusive - too late for that.
> 
> 
> Hi Andrew, thanks for your comments.
> 
> I sent two patches for the __attribute__((weak)) xtime_lock thing, and 
> calc_load() optimization, which dont depend on ktimed.

yup, thanks.

> Should I now send patches for aggregating things or is it considered too 
> intrusive ?

The previous version didn't look too intrusive.  But it would be nice to
have a plan to get rid of the macros:

#define xtime_lock	ktimed.xtime_lock

and just open-code this everywhere.

> (Sorry if I didnt understand your last sentence)

What I meant was: if we're not going to to aggregate all these globals like
this:

	ktimed.xtime_lock
	ktimed.wall_to_monotonic

then it would be nice if they were at least aggregated by naming convention:

	time_management_time_lock
	time_management_wall_to_monotonic
	etc

so the reader can see that these things are all part of the same subsystem.

But the proposed ktimed.xtime_lock achieves that, and has runtime benefits
too.

Can we please not call it ktimed?  That sounds like a kernel thread to me. 
time_data would be better.

> If yes, should I send separate patches to :
> 
> 1) define an empty ktimed (or with a placeholder for jiffies64, not yet used)
> 2) move xtime into ktimed
> 3) move xtime_lock into ktimed
> 4) move wall_to_monotonic into ktimed
> 5) move calc_load.count into ktimed
> 6) move avenrun into ktimed.

A single patch there would suffice, I suspect.

> 7) patches to use ktimed.jiffies64 on various arches (with the problem of 
> aliasing jiffies)

That might be a sprinkle of per-arch patches, but I'm not sure what is
entailed here.

