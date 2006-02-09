Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422732AbWBIAjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422732AbWBIAjK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 19:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422733AbWBIAjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 19:39:10 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42658 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1422732AbWBIAjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 19:39:09 -0500
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: Kirill Korotaev <dev@sw.ru>, Kirill Korotaev <dev@openvz.org>,
       serue@us.ibm.com, arjan@infradead.org, frankeh@watson.ibm.com,
       clg@fr.ibm.com, haveblue@us.ibm.com, mrmacman_g4@mac.com,
       alan@lxorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org
Subject: Re: [RFC][PATCH 2/7] VPIDs: pid/vpid conversions
References: <43E22B2D.1040607@openvz.org> <43E23179.5010009@sw.ru>
	<m1irrpsifp.fsf@ebiederm.dsl.xmission.com>
	<20060208235348.GC26035@ms2.inr.ac.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 08 Feb 2006 17:37:31 -0700
In-Reply-To: <20060208235348.GC26035@ms2.inr.ac.ru> (Alexey Kuznetsov's
 message of "Thu, 9 Feb 2006 02:53:48 +0300")
Message-ID: <m11wyd5pv8.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Kuznetsov <kuznet@ms2.inr.ac.ru> writes:

> Hello!
>
>> Do you know how incomplete this patch is?
>
> The question is for me. It handles all the subsystems which are allowed
> to be used inside openvz containers. And _nothing_ more, it would be pure S&M.

I agree and this is why I don't like VPIDS I don't see a way for them
to be anything but pure S&M.

>> Is there a plan to catch all of the in-kernel use of pids
>
> grep for ->pid,->tgid,->pgid,->session and look. What could be better? :-)

Ouch.  I know there are cases that the above test fails for.  Which
is why I prefer an interface that takes a global reference and gives
you a compile error if you don't.  You are much more likely to catch
all of the users that way.

>> You missed cap_set_all.
>
> No doubts, something is missing. Please, could you show how to fix it
> or to point directly at the place. Thank you.

In capability.c it does for_each_thread or something like that.  It is
very similar to cap_set_pg.  But in a virtual context all != all :)

The current OpenVZ patch appears to at least catch cap_set_all.

> Actually, you cycled on this pid problem. If you think private pid spaces
> are really necessary, it is prefectly OK. openvz (and, maybe, all VPS-oriented
> solutions) do _not_ need this (well, look, virtuozzo is a mature product
> for 5 years already, and vpids were added very recently for one specific
> purpose), but can live within private spaces or just in peace with them.
> We can even apply vpids on top on pid spaces to preserve global process tree.
> Provided you leave a chance not to enforce use of private pid spaces
> inside containers, of course.

I think for people doing migration a private pid space in some form is
necessary, I agree it is generally overkill for the VPS case but if it
is efficient it should be usable.  And certainly having facilities
like this be optional seems very important.

My problem with the vpid case and it's translate at the kernel
boundary is that boundary is huge, and there is no compile time
checking to help you find the problem users.  So I don't think vpids
make a solution that can be maintained, and thus merging them looks
like a very bad idea.

Eric
