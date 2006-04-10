Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWDJFoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWDJFoQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 01:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWDJFoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 01:44:16 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8162 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750853AbWDJFoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 01:44:15 -0400
To: Petr Baudis <pasky@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dumpable tasks and ownership of /proc/*/fd
References: <20060408120815.GB16588@pasky.or.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 09 Apr 2006 23:43:03 -0600
In-Reply-To: <20060408120815.GB16588@pasky.or.cz> (Petr Baudis's message of
 "Sat, 8 Apr 2006 14:08:16 +0200")
Message-ID: <m17j5yhtp4.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

>   Hello,
>
>   I would like to ask why is /proc/*/fd owned by root when the task is
> not dumpable - what security concern does it address? It would seem more
> reasonable to me if the /proc/*/fd owner would be simply always the real
> uid of the process.
>
>   The issue is that now all tasks calling setuid() from root to non-root
> during their lifetime will not be able to access their /proc/self/fd.
> This is troublesome because the fstatat() and other *at() routines are
> emulated by accessing /proc/self/fd/*/path and that will break with
> setuid()ing programs, leading to various weird consequences (e.g. with
> the latest glibc, nftw() does not work with setuid()ing programs and
> furthermore causes the LSB testsuite to fail because of this, etc.).

Looking at it the current check is indeed incorrect.
Primarily because it is a check on open and not a check
on access.  We can open the directory anytime so if
this is a serious permission we need to check on access.

Further when it is ourselves we always have access to that
information directly, and /proc is just a convenience.  So
we should not be denying ourselves.

Other processes we do need to deny if we aren't dumpable because
they don't have another way to get that information.

Speaking of things why does the *at() emulation need to touch
/proc/self/fd/*?  I may be completely dense but if the practical
justification for allowing access to /proc/self/fd/ is that we
already have access then we shouldn't need /proc/self/fd.

I suspect this a matter of convenience where you are prepending
/proc/self/fd/xxx/ to the path before you open it instead of calling
fchdir openat() and the doing fchdir back.  Have I properly guessed
how the *at() emulation works?

Eric
