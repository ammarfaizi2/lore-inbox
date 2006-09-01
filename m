Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751487AbWIAT5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbWIAT5K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 15:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751581AbWIAT5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 15:57:10 -0400
Received: from 1wt.eu ([62.212.114.60]:56337 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751487AbWIAT5J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 15:57:09 -0400
Date: Fri, 1 Sep 2006 21:31:35 +0200
From: Willy Tarreau <w@1wt.eu>
To: Chris Snook <csnook@redhat.com>
Cc: Vadim Lobanov <vlobanov@speakeasy.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.33.2] enforce RLIMIT_NOFILE in poll()
Message-ID: <20060901193135.GA28388@1wt.eu>
References: <20060901.PbR.07536400@egw.corp.redhat.com> <20060901034834.GB28317@1wt.eu> <200608312125.14564.vlobanov@speakeasy.net> <44F859CC.6060404@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F859CC.6060404@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2006 at 12:03:24PM -0400, Chris Snook wrote:
> Sorry about the blank post last night.  Looks like my non-patch-mangling 
> webmailer has a UTF-8/ASCII conversion bug that eats messages.

pfff... this stupid utf8 again... and it's not going to disappear
unfortunately :-(  The day we will vote for the worst invention of
the last 20 years, it might get lots of voices !

> If 
> anyone can recommend completely reliable mail clients for posting here, 
> they'd be a good addition to the lkml.org FAQ

[OT]
I use mutt (and get laughed at at work), many others use pine (and
probably hear the same hilarious ignorants). Simple, fast, stupid
enough for me. Not well suited to classify lists in folders, but
still fast, considering that I achieve to manually and accurately
delete 2800 spams in the middle of ham in less than 30 minutes.
[/OT]

> Comments inline...
> 
> Vadim Lobanov wrote:
> >On Thursday 31 August 2006 20:48, Willy Tarreau wrote:
> >
> >>Hi Chris,
> >>
> >>On Thu, Aug 31, 2006 at 09:06:55PM -0400, Chris Snook wrote:
> >>
> >>>From: Chris Snook <csnook@redhat.com>
> >>>
> >>>POSIX states that poll() shall fail with EINVAL if nfds > OPEN_MAX.  In
> >>>this context, POSIX is referring to sysconf(OPEN_MAX), which is the value
> >>>of current->rlim[RLIMIT_NOFILE].rlim_cur, not the compile-time constant
> >>>which happens to be named OPEN_MAX.  The current code will permit polling
> >>>up to 1024 file descriptors even if RLIMIT_NOFILE is less than 1024,
> >>>which POSIX forbids. The current code also breaks polling greater than
> >>>1024 file descriptors if the process has less than 1024 valid
> >>>descriptors, even if RLIMIT_NOFILE > 1024.  While it is silly to poll
> >>>duplicate or invalid file descriptors, POSIX permits this, and it worked
> >>>circa 2.4.18, and currently works up to 1024. This patch directly checks
> >>>the RLIMIT_NOFILE value, and permits exactly what POSIX suggests, no
> >>>more, no less.
> >>
> >>While I understand that it was a bug before, I fear that it could break
> >>existing apps. Are you aware of some apps which do not work as expected
> >>because of this bug ? If not, I'd prefer to wait for some feedback from
> >>2.6 with this fix before applying it (or maybe you're already using it
> >>in RHEL with success ?).
> >
> >
> >I submitted a similar but different patch for this very same issue against 
> >the 2.6 kernel. It's currently residing in the -mm tree. Andrew Morton is 
> >somewhat reticent (and understandably so) to push it quickly into the 
> >vanilla tree; but, for what it's worth, I've yet to hear -- either 
> >directly or indirectly -- of any application breakages caused by this fix.
> 
> Willy and Vadim --
> 
> 	We have received reports of apps which poll a large set of 
> not-necessarily-valid file descriptors which worked fine under 2.4.18, 
> when the check was only against NR_OPEN, which is 1024*1024, that fail 
> under newer kernels.  So there is a real motivation to change the 
> current code.  As for the patch breaking existing apps, there are really 
> 3 scenarios:
> 
> 1)	RLIMIT_NOFILE is at the default value of 1024
> 
> 	In this (default) case, the patch changes nothing.  Calls with nfds 
> 	> 1024 fail with EINVAL both before and after the patch, and calls with 
> nfds <= 1024 pass the check both before and after the patch, since 1024 
> is the initial value of max_fdset.
> 
> 2)	RLIMIT_NOFILE has been raised above the default
> 
> 	In this case, poll() becomes more permissive, allowing polling up to 
> RLIMIT_NOFILE file descriptors even if less than 1024 have been opened. 
>  The patch won't introduce new errors here.  If an application somehow 
> depends on poll() failing when it polls with duplicate or invalid file 
> descriptors, it's already broken, since this is already allowed below 
> 1024, and will also work above 1024 if enough file descriptors have been 
> open at some point to cause max_fdset to have been increased above nfds.
> 
> 3)	RLIMIT_NOFILE has been lowered below the default
> 
> 	In this case, the system administrator or the user has gone out of 
> their way to protect the system from inefficient (or malicious) 
> applications wasting kernel memory.  The current code allows polling up 
> to 1024 file descriptors even if RLIMIT_NOFILE is much lower, which is 
> not what the user or administrator intended.  Well-written applications 
> which only poll valid, unique file descriptors will never notice the 
> difference, because they'll hit the limit on open() first.  If an 
> application gets broken because of the patch in this case, then it was 
> already poorly/maliciously designed, and allowing it to work in the past 
> was a violation of POSIX and a DoS risk on low-resource systems.

OK, thanks very much for the details. Now, call me an idiot, but why
don't you consider broken the apps which are currently failing on
newer kernels ? I'm starting to suspect that we have to sets of apps :

  - those which rely on poll() failing for invalid fds (do they really
    exist ?)
  - those which rely on poll() not failing for invalid fds.

The poll(2) man page suggests what you're saying. Man pages from other
OSes found on the net suggest various behaviours. I guess it's better
to stick to what has been documented (ie: your fix) but with *infinite
care*. Apps which need more than 1024 fds are not end-user mp3 players.
Breaking them in a stable branch can have a huge impact. I'd like this
patch to be tested in 2.6 long before 2.4, and also it would be good
if we could find some feedback from affected people which could confirm
that your patch really fixes their problems. If you have some customers
reporting the problem in RHEL who confirm the fix, it would be nice if
they accepted to inform us about the application(s) which need this fix. 

> 	-- Chris

Thanks,
Willy

