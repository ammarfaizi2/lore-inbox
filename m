Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWF1SMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWF1SMr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 14:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWF1SMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 14:12:47 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14255 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750728AbWF1SMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 14:12:45 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrey Savochkin <saw@swsoft.com>
Cc: dlezcano@fr.ibm.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       serue@us.ibm.com, haveblue@us.ibm.com, clg@fr.ibm.com,
       Andrew Morton <akpm@osdl.org>, dev@sw.ru, herbert@13thfloor.at,
       devel@openvz.org, sam@vilain.net, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: Network namespaces a path to mergable code.
References: <20060626134945.A28942@castle.nmd.msu.ru>
	<m14py6ldlj.fsf@ebiederm.dsl.xmission.com>
	<20060627215859.A20679@castle.nmd.msu.ru>
	<m1ejx9kj1r.fsf@ebiederm.dsl.xmission.com>
	<20060628150605.A29274@castle.nmd.msu.ru>
	<m1sllpfckx.fsf@ebiederm.dsl.xmission.com>
	<20060628212240.A1833@castle.nmd.msu.ru>
Date: Wed, 28 Jun 2006 12:11:24 -0600
In-Reply-To: <20060628212240.A1833@castle.nmd.msu.ru> (Andrey Savochkin's
	message of "Wed, 28 Jun 2006 21:22:40 +0400")
Message-ID: <m1r719dub7.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Savochkin <saw@swsoft.com> writes:

>> In a slightly different vein your second patch introduced a lot
>> of #ifdef CONFIG_NET_NS in C files.  That is something we need to look closely
>> at.
>> 
>> So I think the abstraction that we use to access per network namespace
>> variables needs some work if we are going to allow the ability to compile
>> out all of the namespace code.  The explicit versus implicit lookup is just
>> one dimension of that problem.
>
> This is a good comment.
>
> Those ifdef's mostly correspond to places where we walk over lists
> and need to filter-out entities not belonging to a specific namespace.
> Those places about the same in your and my implementation.
> We can think what we can do with them.
> One trick that I used on several occasions is net_ns_same macro
> which doesn't evalute its arguments if CONFIG_NET_NS not defined,
> and thus can be used without ifdef's.
>
> Returning to implicit vs explicit function arguments, I belive that implicit
> arguments are more promising in having zero impact on the code when
> CONFIG_NET_NS is disabled.
> Functions like inet_addr_type will translate into exactly the same code as
> they did without net namespace patches.

Which brings us to a basic question.  Does it make sense to have
a define that completely disables namespace support.

I know all of the simple namespaces have been implemented like that,
and it was relatively easy there.  I'm not at all certain in the long
term we want a configuration option.  Especially if simply enabling
the code doesn't have an impact on performance.  Which I think is
a merge requirement anyway.

As for inet_addr_type and friends I do agree that implicit arguments
make for an easier implementation of CONFIG_NET_NS.  My gut feel
is though that the code with explicit arguments is probably more
comprehensible in the long term.  Especially as we find more weird
exceptions where the process we are running in does not have the correct
network namespace.

In general unnecessary CONFIG options are a problem because they make
the entire testing process much harder and make the code harder to
write (so that both cases work and work cleanly).

So my feeling is that we actually want to kill all of those CONFIG_XXX_NS
options.

Which simply leaves us with the problem of implementing the code cleanly.

Eric
