Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbVLOV3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbVLOV3K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 16:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVLOV3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 16:29:10 -0500
Received: from mail.shareable.org ([81.29.64.88]:30694 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S1751114AbVLOV3J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 16:29:09 -0500
Date: Thu, 15 Dec 2005 21:28:45 +0000
From: Jamie Lokier <jamie@shareable.org>
To: JANAK DESAI <janak@us.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, viro@ftp.linux.org.uk,
       chrisw@osdl.org, dwmw2@infradead.org, serue@us.ibm.com, mingo@elte.hu,
       linuxram@us.ibm.com, jmorris@namei.org, sds@tycho.nsa.gov,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 1/9] unshare system call: system call handler function
Message-ID: <20051215212845.GA6990@mail.shareable.org>
References: <1134513959.11972.167.camel@hobbs.atlanta.ibm.com> <m1k6e687e2.fsf@ebiederm.dsl.xmission.com> <43A1D435.5060602@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A1D435.5060602@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

JANAK DESAI wrote:
> clone checks to
> makes sure that CLONE_NEWNS and CLONE_FS are not specified together, while
> unshare will force CLONE_FS if CLONE_NEWNS is spefcified.
[ ... ]
> since clone and unshare are doing opposite things, sharing code
> between them that checks constraints on the flags can get
> convoluted.

clone() and unshare() are not doing opposite things.  They do the same
thing, which is to unshare some properties while keeping others
shared, and the only differences are that clone() first creates a new
task, and the defaults for flags that aren't specified.

It is the polarity of _some_ flags which is opposite in your unshare()
API: In your API, CLONE_FS means "unshare fs", while with clone() it
means "share fs".  Same for other flags - except for CLONE_NEWNS,
where unshare() and clone() both take it to mean "unshare ns".

That's a bit of a confusing mixture of polarities, in my opinion.

I think it would be better if this:

	pid = clone(flags);

Could be always equivalent to this:

	pid = clone(CLONE_FLAGS_TO_SHARE_EVERYTHING)
	if (pid == 0)
		unshare(flags);

Or, if you don't like that, then this:

	pid = clone(CLONE_FLAGS_TO_SHARE_EVERYTHING)
	if (pid == 0)
		unshare(~flags);

However, if the API you've chosen for unshare() must be kept, then you
can still have the same checks in clone() and unshare().  Just XOR the
flags word with bits for polarities that are different between the two
calls, before doing the checks, and XOR again afterwards to include
any flags that were forced by the checks.

-- Jamie
