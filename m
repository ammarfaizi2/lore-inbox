Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbWGJL5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWGJL5P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 07:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbWGJL5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 07:57:15 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:33215 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964863AbWGJL5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 07:57:14 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: devel@openvz.org
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Trond Myklebust <Trond.Myklebust@netapp.com>
Subject: Re: [PATCH] struct file leakage
References: <44B2185F.1060402@sw.ru>
Date: Mon, 10 Jul 2006 05:56:07 -0600
In-Reply-To: <44B2185F.1060402@sw.ru> (Kirill Korotaev's message of "Mon, 10
	Jul 2006 13:05:35 +0400")
Message-ID: <m1odvxptbb.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:

> Hello!
>
> Andrew, this is a patch from Alexey Kuznetsov for 2.6.16.
> I believe 2.6.17 still has this leak.
>
> -------------------------------------------------------------
>
> 2.6.16 leaks like hell. While testing, I found massive leakage
> (reproduced in openvz) in:
>
> *filp
> *size-4096
>
> And 1 object leaks in
> *size-32
> *size-64
> *size-128
>
>
> It is the fix for the first one. filp leaks in the bowels
> of namei.c.
>
> Seems, size-4096 is file table leaking in expand_fdtables.
>
> I have no idea what are the rest and why they show only
> accompaniing another leaks. Some debugging structs?

Or something the intent or the filp holds a reference to?

Looks like this has been broken since 834f2a4a1554dc5b2598038b3fe8703defcbe467
about 9 months ago.

The patch looks sane.

Trond did you just miss this case?


> Signed-Off-By: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
> CC: Kirill Korotaev <dev@openvz.org>
>
> --- linux-2.6.16-w/fs/namei.c	2006-07-10 11:43:11.000000000 +0400
> +++ linux-2.6.16/fs/namei.c	2006-07-10 11:53:36.000000000 +0400
> @@ -1774,8 +1774,15 @@ do_link:
>  	if (error)
>  		goto exit_dput;
>  	error = __do_follow_link(&path, nd);
> -	if (error)
> +	if (error) {
> +		/* Does someone understand code flow here? Or it is only
> +		 * me so stupid? Anathema to whoever designed this non-sense
> +		 * with "intent.open".
> +		 */
> +		if (!IS_ERR(nd->intent.open.file))
> +			release_open_intent(nd);
>  		return error;
> +	}
>  	nd->flags &= ~LOOKUP_PARENT;
>  	if (nd->last_type == LAST_BIND)
>  		goto ok;

Eric
