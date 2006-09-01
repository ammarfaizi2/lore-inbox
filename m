Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWIAENJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWIAENJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 00:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWIAENJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 00:13:09 -0400
Received: from 1wt.eu ([62.212.114.60]:52241 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S932079AbWIAENH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 00:13:07 -0400
Date: Fri, 1 Sep 2006 05:48:34 +0200
From: Willy Tarreau <w@1wt.eu>
To: Chris Snook <csnook@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.33.2] enforce RLIMIT_NOFILE in poll()
Message-ID: <20060901034834.GB28317@1wt.eu>
References: <20060901.PbR.07536400@egw.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060901.PbR.07536400@egw.corp.redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Thu, Aug 31, 2006 at 09:06:55PM -0400, Chris Snook wrote:
> From: Chris Snook <csnook@redhat.com>
> 
> POSIX states that poll() shall fail with EINVAL if nfds > OPEN_MAX.  In this
> context, POSIX is referring to sysconf(OPEN_MAX), which is the value of
> current->rlim[RLIMIT_NOFILE].rlim_cur, not the compile-time constant which
> happens to be named OPEN_MAX.  The current code will permit polling up to 1024
> file descriptors even if RLIMIT_NOFILE is less than 1024, which POSIX forbids.
>  The current code also breaks polling greater than 1024 file descriptors if
> the process has less than 1024 valid descriptors, even if RLIMIT_NOFILE >
> 1024.  While it is silly to poll duplicate or invalid file descriptors, POSIX
> permits this, and it worked circa 2.4.18, and currently works up to 1024.
> This patch directly checks the RLIMIT_NOFILE value, and permits exactly what
> POSIX suggests, no more, no less.

While I understand that it was a bug before, I fear that it could break
existing apps. Are you aware of some apps which do not work as expected
because of this bug ? If not, I'd prefer to wait for some feedback from
2.6 with this fix before applying it (or maybe you're already using it
in RHEL with success ?).

Thanks,
Willy

> Signed-off-by: Chris Snook <csnook@redhat.com>
> ---
> 
> diff -urNp linux-2.4.33.2-orig/fs/select.c linux-2.4.33.2-patch/fs/select.c
> --- linux-2.4.33.2-orig/fs/select.c	2006-08-22 16:13:54.000000000 -0400
> +++ linux-2.4.33.2-patch/fs/select.c	2006-08-31 13:43:39.000000000 -0400
> @@ -417,7 +417,7 @@ asmlinkage long sys_poll(struct pollfd *
>  	int nchunks, nleft;
> 
>  	/* Do a sanity check on nfds ... */
> -	if (nfds > current->files->max_fdset && nfds > OPEN_MAX)
> +	if (nfds > current->rlim[RLIMIT_NOFILE].rlim_cur)
>  		return -EINVAL;
> 
>  	if (timeout) {
