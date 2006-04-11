Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWDKEV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWDKEV4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 00:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWDKEV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 00:21:56 -0400
Received: from ishtar.tlinx.org ([64.81.245.74]:64900 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S1751122AbWDKEVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 00:21:55 -0400
Message-ID: <443B2EE2.1030107@tlinx.org>
Date: Mon, 10 Apr 2006 21:21:54 -0700
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Herbert Rosmanith <kernel@wildsau.enemy.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Q on audit, audit-syscall: insecure?
References: <200604051127.k35BR3Qe009718@wildsau.enemy.org>
In-Reply-To: <200604051127.k35BR3Qe009718@wildsau.enemy.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Herbert Rosmanith wrote:
>  * The method for actual interception of syscall entry and exit (not in
>  * this file -- see entry.S) is based on a GPL'd patch written by
>  * okir@suse.de and Copyright 2003 SuSE Linux AG.
>   
===
    How does this audit method overcome the well known security
problem or race condition where one object is decoded and stored at
audit time, and a second, different object is used when the kernel
decodes the same arguments a second time, between which, user memory
has changed?

    I.e. -
    From this description, audit could store the filename used in an
"open" call by decoding the open arguments and recording
(copying from user-space into kernel space audit-buffer), then
return to the beginning of the code of the actual system call.
    Then a process on another CPU or an interrupting process on
the same CPU runs and changes the contents of the user-buffer.
    Then execution resumes in "audited" process and the "open" system
call decodes the arguments and copies the *different* filename from
the user space buffer into the kernel space buffer which the kernel
then uses for the call. 

    Usually, double-decoding of arguments is not just inefficient, but also
insecure because of this problem.  It's not practical to mask off interrupts
or halt all other CPU's to prevent them from accessing the user-memory
buffer. 

    The only safe way, that I'm aware of, is for "audit" to record
the arguments after the kernel has decoded and transferred them from
user space to kernel space.

    Is Linux's audit implementation secure or is it expected that it will
be vulnerable to these insecure race conditions?

    If it is vulnerable, the integrity of the audit records is known to
be suspect.  Such a system would not pass an open CAPP security evaluation.
However, if evaluators are properly misled, known-flawed
systems have been known to achieve CAPP and LSPP certification.  To my
understanding, it's not illegal to construct a certification plan such
that the certifier is led around such bugs.  It's also possible that
certifier doesn't know enough about the system to suspect such a problem.

The ethical preference would be to eliminate the race condition, but when
someone less ethical is in charge, it may not be your decision.  And if
a corporation, interested in the bottom line is running the priorities,
which would be cheaper?  On one hand you have the easy, two points of
insertion for auditing before and after the common system call vector,
    versus
spending the extra cycles (and $$$) to add calls for audit-recording in
every security relevant call, both at entry and exit points, then
testing the resulting code?

The second method is considerably more efficient because the security is
built into the kernel, instead of tacked on as an afterthought, but
$$$ often speak louder than ethics in a corporate/capitalist environment.

Linda
