Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbTFFLz2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 07:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbTFFLz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 07:55:28 -0400
Received: from gw.aurema.com ([203.31.96.1]:46720 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S261265AbTFFLzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 07:55:25 -0400
Date: Fri, 6 Jun 2003 22:08:55 +1000
From: Kingsley Cheung <kingsley@aurema.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [Bug 764] New: btime in /proc/stat wobbles (even over 30 seconds)
Message-ID: <20030606220855.A2888@aurema.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030606122653.B29095@aurema.com> <E19OCdo-0006HB-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E19OCdo-0006HB-00@gondolin.me.apana.org.au>; from herbert@gondor.apana.org.au on Fri, Jun 06, 2003 at 06:32:04PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 06, 2003 at 06:32:04PM +1000, Herbert Xu wrote:
> Kingsley Cheung <kingsley@aurema.com> wrote:
> > 
> > Attached is a trivial patch to fix the problem against 2.5.70.  I've
> > also attached the trivial 2.4.20 patch I sent to Rusty back for
> > completeness.
> 
> What happens when the system time is changed later on?

Well, without the patch the boottime would change as you change the
system time.  So if you set the system time forward an hour, your
boottime would go forward as well, and so forth.

With the patch, the boottime would remain the same regardless of
changes to the system time.  IMHO, this is probably for the better,
since now as it stands we have issues with the boottime changing under
us due to the way xtime and jiffies are updated.  To me, having an
unchanging boottime is more profitable than one that changes.
Applications could use the value as a reliable absolute time
reference.  For example, to find out the absolute time a process
started, you can add the boottime and the starttime of the process,
the latter being in jiffies after the system booted, and not expect
this value to change.

The tradeoff, though, is that it is possible to have the boottime
greater than the current time if you set the system time back enough.
I think setting it forward is a non-issue.  I could be wrong but so
far I believe that is worth putting up this with tradeoff given the
benefits of an unchanging boottime time.  There is no affect obtaining
the system uptime - people shouldn't go calculating system time minus
boottime, since uptime itself is provided.  Moreover, a similar
problem is what to do with file modification times in the future - we
do nothing.

What do you or others think?  If people wanted to keep the old
semantics of a boottime that changed with the system time then we'll
need another way to avoid the wobble.

--
		Kingsley
