Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbVHRPvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbVHRPvg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 11:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbVHRPvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 11:51:36 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:15538 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S932267AbVHRPvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 11:51:35 -0400
Subject: Re: [PATCH 2.6.13-rc6 2/2] New Syscall: set rlimits of any process
	(update)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: e8607062@student.tuwien.ac.at
Cc: Chris Wright <chrisw@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Elliot Lee <sopwith@redhat.com>
In-Reply-To: <1124326935.8359.6.camel@w2>
References: <1124326652.8359.3.camel@w2>  <1124326935.8359.6.camel@w2>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 18 Aug 2005 11:48:51 -0400
Message-Id: <1124380131.25854.81.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-18 at 03:02 +0200, Wieland Gmeiner wrote:
> diff -uprN -X linux-2.6.13-rc6-vanilla/Documentation/dontdiff linux-2.6.13-rc6-getprlimit/security/selinux/hooks.c linux-2.6.13-rc6-setprlimit/security/selinux/hooks.c
> --- linux-2.6.13-rc6-getprlimit/security/selinux/hooks.c	2005-08-17 03:11:33.000000000 +0200
> +++ linux-2.6.13-rc6-setprlimit/security/selinux/hooks.c	2005-08-18 01:28:11.000000000 +0200
> @@ -2717,11 +2721,22 @@ static int selinux_task_setrlimit(unsign
>  	   later be used as a safe reset point for the soft limit
>  	   upon context transitions. See selinux_bprm_apply_creds. */
>  	if (old_rlim->rlim_max != new_rlim->rlim_max)
> -		return task_has_perm(current, current, PROCESS__SETRLIMIT);
> +		return task_has_perm(current, task, PROCESS__SETRLIMIT);
>  
>  	return 0;
>  }

This isn't sufficient for mandatory access control over setprlimit.  As
long as the setrlimit operation could only be performed by the process
on itself, we were only concerned with controlling attempts to modify
the hard limit (not the soft limit), as that is being used as a safe
reset point for the soft limit upon security context transitions.  But
for the case of setprlimit where the target process may differ, we need
to be able to control setting of any limit, soft or hard, in order to
control the ability of a process in one security context to modify the
state of a process in a different security context.  Further, we would
need a parallel check on the getprlimit side, to control the ability of
a process in one security context to observe the state of a process in a
different security context.

-- 
Stephen Smalley
National Security Agency

