Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWHMUIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWHMUIX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 16:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWHMUIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 16:08:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:52914 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751399AbWHMUIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 16:08:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RxlaImDpFqfbjgYAEn2ly0D1cJ2a9ED2NRAGjvWJkLH+aTVtwithbqH3ZuYGZeYVkv2VGfF1RYTnzAk8rsoB62AkurLzOHxzH4AJ9x0hGh7ZTyn3ptok2Hli2ti3Jh/q4/d3a+KDSuZE5vxd0xb5mvGK/406M2uOc7Lb5lJ7GhM=
Message-ID: <787b0d920608131308se2376f3ua2a775533d99f58e@mail.gmail.com>
Date: Sun, 13 Aug 2006 16:08:20 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC] ps command race fix
Cc: "KAMEZAWA Hiroyuki" <kamezawa.hiroyu@jp.fujitsu.com>, akpm@osdl.org,
       pj@sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <m1mza8wqdc.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060714203939.ddbc4918.kamezawa.hiroyu@jp.fujitsu.com>
	 <20060724182000.2ab0364a.akpm@osdl.org>
	 <20060724184847.3ff6be7d.pj@sgi.com>
	 <20060725110835.59c13576.kamezawa.hiroyu@jp.fujitsu.com>
	 <20060724193318.d57983c1.akpm@osdl.org>
	 <20060725115004.a6c668ca.kamezawa.hiroyu@jp.fujitsu.com>
	 <20060725121640.246a3720.kamezawa.hiroyu@jp.fujitsu.com>
	 <m1mza8wqdc.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> writes:

> > /*
> >  * A maximum of 4 million PIDs should be enough for a while.
> >  * [NOTE: PID/TIDs are limited to 2^29 ~= 500+ million, see futex.h.]
> >  */
> > #define PID_MAX_LIMIT (CONFIG_BASE_SMALL ? PAGE_SIZE * 8 : \
> >         (sizeof(long) > 4 ? 4 * 1024 * 1024 : PID_MAX_DEFAULT))
> >
> > ...we have to manage 4 millions tids.

BTW, it looks like powerpc runs out of MMU contexts if
there are more than 32768 processes. Badness happens.

> The basic posix/susv guarantee is that in readdir if a directory
> entry is neither deleted nor added between opendir and closedir of the
> directory you should see the directory entry.   I could not
> quite tell what the rules were with regards seekdir.

Never minding the bare minimum, I think the user-visible
offset should be the PID plus some constant for all PIDs.
(sadly, the constant can't be 0 because of ".." and init)

> There are also other reasons to changing to a pid base traversal
> of /proc.  It allows us to display information on process groups,
> and sessions whose original leader has died.

Huh?

> If namespaces get
> assigned a pid traversal by pid looks like a good way to display
> namespaces that are not used by any process but are still alive.
> Albert does that sound like a sane extension?

You mean /proc/42 could be non-process data?
That will surely break lots and lots of things.

In general, process namespaces are useful for:

1. silly marketing (see Sun and FreeBSD)

2. the very obscure case of "root" account providers
   who are too clueless to use SE Linux or Xen

I don't think either case justifies the complexity.
I am not looking forward to the demands that I
support this mess in procps. I suspect I am not
alone; soon people will be asking for support in
pstools, gdb, fuser, killall... until every app which
interacts with other processes will need hacks.

If the cost were only an #ifdef in the kernel, there
would be no problem. Unfortunately, this is quite
a hack in the kernel and it has far-reaching
consequenses in user space.
