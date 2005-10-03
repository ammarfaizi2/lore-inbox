Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbVJCFFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbVJCFFg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 01:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbVJCFFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 01:05:36 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:59458 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750702AbVJCFFf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 01:05:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JD2tHLhmYr3NwO68LT3MRbepqw0aCAqD8uXvJ3bFdmfyf3Py/TmAUePHrqHnf51AahSeYx5+fHxvGLet9h4feeutVoYwKx2i3E7qo8jqPEWE7BtIcZX0ZkJXRjfZ61hxqP0XuTPhdMGetrQHLJ2hGKSxxBSca3QupsTuC7u5mA8=
Message-ID: <aec7e5c30510022205o770b6335o96d9a9d9cc5d7397@mail.gmail.com>
Date: Mon, 3 Oct 2005 14:05:34 +0900
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH 00/07][RFC] i386: NUMA emulation
Cc: Dave Hansen <haveblue@us.ibm.com>, magnus@valinux.co.jp,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20051002202157.7b54253d.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050930073232.10631.63786.sendpatchset@cherry.local>
	 <1128093825.6145.26.camel@localhost>
	 <20051002202157.7b54253d.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/05, Paul Jackson <pj@sgi.com> wrote:
> Dave wrote:
> > Also, I worry that simply #ifdef'ing things out like CPUsets' update
> > means that CPUsets lacks some kind of abstraction that it should have
> > been using in the first place.
>
> In the abstract, cpusets should just assume that the system has one or
> more CPUs, and one or more Memory Nodes.  Ideally, it should not
> require either SMP nor NUMA.  Indeed, if you (Magnus) can get it
> to compile with just one or the other of those two:
>
>      config CPUSETS
>             bool "Cpuset support"
>     -       depends on SMP
>     +       depends on SMP || NUMA
>
> then I would hope that it would compile with neither.  The cpuset
> hierarchy on such a system would be rather boring, with all cpusets
> having the same one CPU and one Memory Node, but it should work ... in
> theory of course.

I just tested this on top of my patches:
@@ -245,7 +245,6 @@ config IKCONFIG_PROC

 config CPUSETS
        bool "Cpuset support"
-       depends on SMP || NUMA
        help

and it seems to work ok in practice too. On a regular !SMP !NUMA PC
anyway. As you note, the hierarchy is not that exciting. =) Anyway,
both SMP || NUMA or nothing seems to work as dependencies. After
partition_sched_domain() gets fixed that is.

> In practice of course, there may be details on the edges that depend on
> the current SMP/NUMA limitations, such as:
>
> Magnus wrote:
> > Regarding the #ifdef, it
> > was added because partition_sched_domain() is only implemented for
> > SMP. That symbol has no prototype or implementation when CONFIG_SMP is
> > not set. Maybe it is better to add an empty inline function in
> > linux/sched.h for !SMP?
>
> An empty inline partition_sched_domain() would be better than ifdef's
> in cpuset.c, yes.  Or at least, that's usually the case.  Probably here
> too.

I agree.

> In theory at least, I applaud Magnus's work here.  The assymetry of the
> SMP/NUMA define structure has always annoyed me slightly, and only been
> explainable in my view as a consequence of the historical order of
> development.  I had a PC with a second memory board in an ISA slot,
> which would qualify as a one CPU, two Memory Node system.
>
> Or what byte us in the future (that PC was a long time ago), the kinks
> in the current setup might be a hitch in our side as we extend to
> increasingly interesting architectures.

Nice to hear that you like the idea.

Maybe I should have broken down my patches into three smaller sets:

1) i386: NUMA without SMP
2) CPUSETS: NUMA || SMP
3) i386: NUMA emulation

If people like 1) then it's probably a good idea to convert other
architectures too. Both 2) and 3) above are separate but related
issues. And now seems like a good time to solve 2).

So, Paul, please let me know if you prefer SMP || NUMA or no
depencencies in the Kconfig. When I know that I will create a new
patch that hopefully can get into -mm later on.

> Aside - for those reading this thread on lkml, it originated
> on linux-mm.  It looks like Dave added lkml to the cc list.

Huh? I sent my patches both to lkml and linux-mm...

Thank you for the feedback!

/ magnus
