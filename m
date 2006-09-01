Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbWIAQCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbWIAQCv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 12:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWIAQCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 12:02:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20679 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932327AbWIAQCe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 12:02:34 -0400
Message-ID: <44F859CC.6060404@redhat.com>
Date: Fri, 01 Sep 2006 12:03:24 -0400
From: Chris Snook <csnook@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.4.1 (X11/20060420)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vadim Lobanov <vlobanov@speakeasy.net>
CC: Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.33.2] enforce RLIMIT_NOFILE in poll()
References: <20060901.PbR.07536400@egw.corp.redhat.com> <20060901034834.GB28317@1wt.eu> <200608312125.14564.vlobanov@speakeasy.net>
In-Reply-To: <200608312125.14564.vlobanov@speakeasy.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry about the blank post last night.  Looks like my non-patch-mangling 
webmailer has a UTF-8/ASCII conversion bug that eats messages.  If 
anyone can recommend completely reliable mail clients for posting here, 
they'd be a good addition to the lkml.org FAQ

Comments inline...

Vadim Lobanov wrote:
> On Thursday 31 August 2006 20:48, Willy Tarreau wrote:
> 
>>Hi Chris,
>>
>>On Thu, Aug 31, 2006 at 09:06:55PM -0400, Chris Snook wrote:
>>
>>>From: Chris Snook <csnook@redhat.com>
>>>
>>>POSIX states that poll() shall fail with EINVAL if nfds > OPEN_MAX.  In
>>>this context, POSIX is referring to sysconf(OPEN_MAX), which is the value
>>>of current->rlim[RLIMIT_NOFILE].rlim_cur, not the compile-time constant
>>>which happens to be named OPEN_MAX.  The current code will permit polling
>>>up to 1024 file descriptors even if RLIMIT_NOFILE is less than 1024,
>>>which POSIX forbids. The current code also breaks polling greater than
>>>1024 file descriptors if the process has less than 1024 valid
>>>descriptors, even if RLIMIT_NOFILE > 1024.  While it is silly to poll
>>>duplicate or invalid file descriptors, POSIX permits this, and it worked
>>>circa 2.4.18, and currently works up to 1024. This patch directly checks
>>>the RLIMIT_NOFILE value, and permits exactly what POSIX suggests, no
>>>more, no less.
>>
>>While I understand that it was a bug before, I fear that it could break
>>existing apps. Are you aware of some apps which do not work as expected
>>because of this bug ? If not, I'd prefer to wait for some feedback from
>>2.6 with this fix before applying it (or maybe you're already using it
>>in RHEL with success ?).
> 
> 
> I submitted a similar but different patch for this very same issue against the 
> 2.6 kernel. It's currently residing in the -mm tree. Andrew Morton is 
> somewhat reticent (and understandably so) to push it quickly into the vanilla 
> tree; but, for what it's worth, I've yet to hear -- either directly or 
> indirectly -- of any application breakages caused by this fix.

Willy and Vadim --

	We have received reports of apps which poll a large set of 
not-necessarily-valid file descriptors which worked fine under 2.4.18, 
when the check was only against NR_OPEN, which is 1024*1024, that fail 
under newer kernels.  So there is a real motivation to change the 
current code.  As for the patch breaking existing apps, there are really 
3 scenarios:

1)	RLIMIT_NOFILE is at the default value of 1024

	In this (default) case, the patch changes nothing.  Calls with nfds > 
1024 fail with EINVAL both before and after the patch, and calls with 
nfds <= 1024 pass the check both before and after the patch, since 1024 
is the initial value of max_fdset.

2)	RLIMIT_NOFILE has been raised above the default

	In this case, poll() becomes more permissive, allowing polling up to 
RLIMIT_NOFILE file descriptors even if less than 1024 have been opened. 
  The patch won't introduce new errors here.  If an application somehow 
depends on poll() failing when it polls with duplicate or invalid file 
descriptors, it's already broken, since this is already allowed below 
1024, and will also work above 1024 if enough file descriptors have been 
open at some point to cause max_fdset to have been increased above nfds.

3)	RLIMIT_NOFILE has been lowered below the default

	In this case, the system administrator or the user has gone out of 
their way to protect the system from inefficient (or malicious) 
applications wasting kernel memory.  The current code allows polling up 
to 1024 file descriptors even if RLIMIT_NOFILE is much lower, which is 
not what the user or administrator intended.  Well-written applications 
which only poll valid, unique file descriptors will never notice the 
difference, because they'll hit the limit on open() first.  If an 
application gets broken because of the patch in this case, then it was 
already poorly/maliciously designed, and allowing it to work in the past 
was a violation of POSIX and a DoS risk on low-resource systems.

	-- Chris

>>Thanks,
>>Willy
>>
>>
>>>Signed-off-by: Chris Snook <csnook@redhat.com>
>>>---
>>>
>>>diff -urNp linux-2.4.33.2-orig/fs/select.c
>>>linux-2.4.33.2-patch/fs/select.c ---
>>>linux-2.4.33.2-orig/fs/select.c	2006-08-22 16:13:54.000000000 -0400 +++
>>>linux-2.4.33.2-patch/fs/select.c	2006-08-31 13:43:39.000000000 -0400 @@
>>>-417,7 +417,7 @@ asmlinkage long sys_poll(struct pollfd *
>>> 	int nchunks, nleft;
>>>
>>> 	/* Do a sanity check on nfds ... */
>>>-	if (nfds > current->files->max_fdset && nfds > OPEN_MAX)
>>>+	if (nfds > current->rlim[RLIMIT_NOFILE].rlim_cur)
>>> 		return -EINVAL;
>>>
>>> 	if (timeout) {
>>
> 
> -- Vadim Lobanov

