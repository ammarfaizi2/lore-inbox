Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbWHTQUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWHTQUG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 12:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbWHTQUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 12:20:05 -0400
Received: from mother.openwall.net ([195.42.179.200]:8129 "HELO
	mother.openwall.net") by vger.kernel.org with SMTP id S1750862AbWHTQUD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 12:20:03 -0400
Date: Sun, 20 Aug 2006 20:16:02 +0400
From: Solar Designer <solar@openwall.com>
To: Andi Kleen <ak@suse.de>
Cc: Willy Tarreau <wtarreau@hera.kernel.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH] getsockopt() early argument sanity checking
Message-ID: <20060820161602.GA20163@openwall.com>
References: <20060819230532.GA16442@openwall.com> <200608201034.43588.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608201034.43588.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 10:34:43AM +0200, Andi Kleen wrote:
> In general I don't think it makes sense to submit stuff for 2.4 
> that isn't in 2.6.

In general I agree, however right now I had the choice between
submitting these changes for 2.4 first and not submitting them at all
(at least for some months more).  I chose the former.

> > The patch makes getsockopt(2) sanity-check the value pointed to by
> > the optlen argument early on.  This is a security hardening measure
> > intended to prevent exploitation of certain potential vulnerabilities in
> > socket type specific getsockopt() code on UP systems.
> 
> It's not only insufficient on SMP, but even on UP where a thread
> can sleep in get_user and another one can run in this time.

Good point.  However, what about this special case? -

We're on UP.  sys_getsockopt() does get_user() (due to the patch) and
makes sure that the passed *optlen is sane.  Even if this get_user()
sleeps, the value it returns in "len" is what's currently in memory at
the time of the get_user() return (correct?)  Then an underlying
*getsockopt() function does another get_user() on optlen (same address),
without doing any other user-space data accesses or anything else that
could sleep first.  Is it possible that this second get_user()
invocation would sleep?  I think not since it's the same address that
we've just read a value from, we did not leave kernel space, and we're
on UP (so no other processor could have changed the mapping).  So the
patch appears to be sufficient for this special case (which is not
unlikely).

Of course, it is possible that I am wrong about some of the above;
please correct me if so.

> If there is really a length checking bug somewhere it needs to be
> fixed in a race-free way.

Indeed, all known bugs need to be fixed properly.

Thanks,

Alexander
