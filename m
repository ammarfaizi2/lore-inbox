Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263585AbUDUSNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263585AbUDUSNm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 14:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263586AbUDUSNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 14:13:42 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:10419 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S263585AbUDUSNk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 14:13:40 -0400
Subject: Re: compute_creds fixup in -mm
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4086AEFC.5010002@myrealbox.com>
References: <20040421010621.L22989@build.pdx.osdl.net>
	 <4086AEFC.5010002@myrealbox.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1082571199.9213.61.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 21 Apr 2004 14:13:19 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-21 at 13:27, Andy Lutomirski wrote:
> This doesn't fix selinux, though -- its apply_creds hook just blindly calls
> commoncap's.  In fact, this breaks all attempts to get nested capability modules
> right.  The problem is that, AFAICS, not only does ptrace_detach not take
> task_lock, _exit() doesn't either.  So you get an equivalent race for the shared
> state check.  I see two ways to fix that:

I didn't see Chris' patch.  I assume that the worst case is unexpected
program failure due to lack of capability, right?  The SELinux security
transitions aren't tied to the uid/capability evolution anyway, and
SELinux provides its own separation among differing security domains,
including the kernel access controls and enabling glibc secure mode.

Side bar:  Why does the uid/capability logic proceed under the old
uid/capability set rather than aborting the exec?  SELinux leaves the
task SID unchanged and forces a SIGKILL, as we don't really want the
program proceeding under the wrong permission set anyway.

> 1. something checks for shared state _once_ and saves it either in the binprm or
> passes it as a parameter to apply_creds.  apply_creds needs to be changed so
> that the task_lock is taken by the caller.

Likely a good idea.

> This one also (hopefully) fixes selinux.
> 
> Patch against 2.6.5-mm5.

Didn't apply for me.  Also would help to rebase to 2.6.6-rc2-mm1.

> --- linux-2.6.5-mm5/security/selinux/hooks.c.ptlock	2004-04-21 08:57:16.947281304 -0700
> +++ linux-2.6.5-mm5/security/selinux/hooks.c	2004-04-21 09:22:15.227508088 -0700
> @@ -1782,14 +1780,13 @@
>   		/* Check for ptracing, and update the task SID if ok.
>   		   Otherwise, leave SID unchanged and kill. */
>   		task_lock(current);

Above line needs to be deleted, right?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

