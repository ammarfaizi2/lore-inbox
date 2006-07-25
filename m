Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbWGYSr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbWGYSr0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 14:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWGYSr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 14:47:26 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:40863 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751482AbWGYSrZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 14:47:25 -0400
Date: Tue, 25 Jul 2006 13:47:19 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Frank v Waveren <fvw@var.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux capabilities oddity
Message-ID: <20060725184719.GA8076@sergelap.austin.ibm.com>
References: <20060723143646.GA2840@var.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060723143646.GA2840@var.cx>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Frank v Waveren (fvw@var.cx):
> I sent this to linux-privs-discuss, but that list appears to be dead.
> Perhaps someone here can help me?
> 
> 
> While debugging an odd problem where /proc/sys/kernel/cap-bound wasn't
> working, I came across the following code at
> linux-2.6.x/security/commoncap.c:140:
> 
>    void cap_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
>    {
>            /* Derived from fs/exec.c:compute_creds. */
>            kernel_cap_t new_permitted, working;
> 
>            new_permitted = cap_intersect (bprm->cap_permitted, cap_bset);
>            working = cap_intersect (bprm->cap_inheritable,
>                                     current->cap_inheritable);
>            new_permitted = cap_combine (new_permitted, working);
>            ...
> 
> Here the new permitted set gets limited to the bits in cap_bset, which
> is as it should be, but then the intersection of the of the current
> and exec inheritable masks get added to that set, whereas as I
> understand it, cap_bset should always be the bounding set.
>            
> This triggered a problem where the /sbin/init on a gentoo install disk
> (which I was using as an quick&dirty UML root disk for testing) for
> some reason did something to set its inheritable mask to ~0, which
> then propagated to all the processes that ran as root, which meant
> that the cap bound didn't apply to them.
> 
> I took out the cap_combine and didn't notice any ill effects on some
> quick tests, though I don't know POSIX capabilities well enough to say
> all the behaviour was per the standard. If someone could tell me what
> those lines are for, and if its foiling of cap-bound limits is on
> purpose, I'd be most grateful.

Actually going by the faq
(http://ftp.kernel.org/pub/linux/libs/security/linux-privs/kernel-2.4/capfaq-0.2.txt)
it seems like the cap_intersect with current->cap_inheritable is *too*
limiting.  I haven't checked what the posix draft actually says, but the
bprm->cap_inheritable is called the 'forced' set, and is supposed to be
like setuid.

I suspect the reason why removing the cap_combine worked for you is
because when the file is setuid 0, the bprm->cap_permitted is also set
full on.  For people actually using one of the patches implementing
filesystem capabilities, I think you might in fact change behavior.

-serge
