Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbWCMPHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWCMPHQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 10:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWCMPHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 10:07:16 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:41146 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751400AbWCMPHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 10:07:14 -0500
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, garloff@suse.de,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] KERN_SETUID_DUMPABLE in /proc/sys/fs/
References: <20060310155738.GL5766@tpkurt.garloff.de>
	<20060310145605.08bf2a67.akpm@osdl.org>
	<1142061816.3055.6.camel@laptopd505.fenrus.org>
	<20060310234155.685456cd.akpm@osdl.org>
	<1142063254.3055.9.camel@laptopd505.fenrus.org>
	<20060310235103.4e9c9457.akpm@osdl.org>
	<1142064294.3055.13.camel@laptopd505.fenrus.org>
	<m1r757xqoc.fsf@ebiederm.dsl.xmission.com>
	<1142236842.3023.2.camel@laptopd505.fenrus.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 13 Mar 2006 08:06:09 -0700
In-Reply-To: <1142236842.3023.2.camel@laptopd505.fenrus.org> (Arjan van de
 Ven's message of "Mon, 13 Mar 2006 09:00:42 +0100")
Message-ID: <m1mzfupeou.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:

>> This must be number 69 here.  Or else we break the sys_sysctl ABI.
>
> numeric sysctl abi is since 2.6.0 no longer an ABI though; anything
> after that.. not an ABI :)

The system call still exists, in the system call table and
is still implemented.  The system call still takes a binary path.  I
don't see any big fat deprecated warnings in Documentation.  So if the
status has changed it has not been well communicated.

Looking a little closer I can find this note in sysctl.h:

 ****************************************************************
 **
 **  The values in this file are exported to user space via 
 **  the sysctl() binary interface.  However this interface
 **  is unstable and deprecated and will be removed in the future. 
 **  For a stable interface use /proc/sys.
 **
 ****************************************************************
Which used to be:

 ****************************************************************
 ****************************************************************
 **
 **  WARNING:  
 **  The values in this file are exported to user space via 
 **  the sysctl() binary interface.  Do *NOT* change the 
 **  numbering of any existing values here, and do not change
 **  any numbers within any one set of values.  If you have
 **  to redefine an existing interface, use a new number for it.
 **  The kernel will then return ENOTDIR to any application using
 **  the old binary interface.
 **
 **  --sct
 **
 ****************************************************************

However except for new values and old values that are now reserved
because that variable is no longer supported I do not see any
changes in sysctl values from 2.4 to 2.6.

Looking in the git history of 2.6.0 at sysctl.h I can only
see one clear instance of a value being reused for a
different purpose, and that was somewhere under SCTP.

If we are going to kill the binary ABI I'm fine with that but
it should be in Documentation/feature-removal-schedule.txt
The system call should generate a rate-limited warning in
the logs, or be removed entirely from the syscall table.

None of that was done.  Given the current state of things I am
strongly tempted to just to revert the comment, at the
top of sysctl.h, as that would be easier than going through
the proper steps to remove the system call.

However on the practical side it looks like /sbin/sysctl
only uses the /proc interface.  So it looks like the number
of users of the binary interface are probably quite slim.
So now would not be a bad time to deprecate the binary system call
entirely, and in six months or whatever submit the patch to
remove it.

But until we do that we should maintain the ABI, since we
have been.  It's not like setting enum to number 69 is an onerous
task.

Eric

