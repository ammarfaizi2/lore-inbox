Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261945AbSJ2QFu>; Tue, 29 Oct 2002 11:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261972AbSJ2QFu>; Tue, 29 Oct 2002 11:05:50 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:13453 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261945AbSJ2QFt>; Tue, 29 Oct 2002 11:05:49 -0500
To: Andreas Gruenbacher <agruen@suse.de>
Cc: <chris@scary.beasts.org>, <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH][RFC] 2.5.44 (1/2): Filesystem capabilities kernel patch
References: <Pine.LNX.4.33.0210282327520.8990-100000@sphinx.mythic-beasts.com>
	<200210290323.09565.agruen@suse.de> <87n0oxmrhn.fsf@goat.bogus.local>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Tue, 29 Oct 2002 15:38:56 +0100
Message-ID: <87lm4hl37j.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de> writes:

> Andreas Gruenbacher <agruen@suse.de> writes:
>
>> On Tuesday 29 October 2002 00:36, chris@scary.beasts.org wrote:
>>> I'm not sure what the current glibc security check is, but it used to be
>>> simple *uid() vs. *euid() checks. This would not catch an executable with
>>> filesystem capabilities.
>>> Have a look at
>>> http://security-archive.merton.ox.ac.uk/security-audit-199907/0192.html
> [...]
>>> I think the eventual plan was that we pass the kernel's current->dumpable
>>> as an ELF note. Not sure if it got done. Alternatively glibc could use
>>> prctl(PR_GET_DUMPABLE).
>>
>> Sorry, I don't know exactly what was your plan here. Could you please explain?
>
> Judging from the mail archive above: instead of checking uid vs. euid
> and gid vs. egid, ask the kernel and grant or deny LD_PRELOAD
> according to the dumpable flag (see prctl(2)). This flag is set to
> false, if uid != euid, etc. So, this flag could be used/cleared by
> capabilities as well.

This is already done in cap_bprm_compute_creds(), it seems. Here is an
untested patch to trick glibc into thinking this is a SGID binary and
thus ignoring LD_PRELOAD. This may break some programs, though.

Comments?

Regards, Olaf.

--- a/security/capability.c	Thu Oct 24 00:11:51 2002
+++ b/security/capability.c	Tue Oct 29 15:13:42 2002
@@ -187,6 +187,8 @@
 			}
 		}
 		do_unlock = 1;
+		if (current->euid == current->uid && current->egid == current->gid)
+			current->gid = -1;
 	}
 
 	/* For init, we want to retain the capabilities set
