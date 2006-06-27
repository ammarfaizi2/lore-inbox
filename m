Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161198AbWF0Qss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161198AbWF0Qss (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161194AbWF0Qss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:48:48 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32235 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161183AbWF0Qsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:48:46 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Daniel Lezcano <dlezcano@fr.ibm.com>, Andrey Savochkin <saw@swsoft.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>,
       dev@sw.ru, devel@openvz.org, sam@vilain.net, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
References: <20060609210625.144158000@localhost.localdomain>
	<20060626134711.A28729@castle.nmd.msu.ru>
	<449FF5A0.2000403@fr.ibm.com> <20060626192751.A989@castle.nmd.msu.ru>
	<44A00215.2040608@fr.ibm.com>
	<20060627131136.B13959@castle.nmd.msu.ru>
	<44A0FBAC.7020107@fr.ibm.com>
	<20060627133849.E13959@castle.nmd.msu.ru>
	<44A1149E.6060802@fr.ibm.com>
	<m1sllqn7cb.fsf@ebiederm.dsl.xmission.com>
	<20060627160241.GB28984@MAIL.13thfloor.at>
Date: Tue, 27 Jun 2006 10:47:29 -0600
In-Reply-To: <20060627160241.GB28984@MAIL.13thfloor.at> (Herbert Poetzl's
	message of "Tue, 27 Jun 2006 18:02:42 +0200")
Message-ID: <m1psgulf4u.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> writes:

> On Tue, Jun 27, 2006 at 05:52:52AM -0600, Eric W. Biederman wrote:
>> 
>> Inside the containers I want all network devices named eth0!
>
> huh? even if there are two of them? also tun?
>
> I think you meant, you want to be able to have eth0 in
> _more_ than one guest where eth0 in a guest can also
> be/use/relate to eth1 on the host, right?

Right I want to have an eth0 in each guest where eth0 is
it's own network device and need have no relationship to
eth0 on the host.

>> We need a clean abstraction that optimizes well.
>> 
>> However local communication between containers is not what we
>> should benchmark. That can always be improved later. So long as
>> the performance is reasonable. What needs to be benchmarked is the
>> overhead of namespaces when connected to physical networking devices
>> and on their own local loopback, and comparing that to a kernel
>> without namespace support.
>
> well, for me (obviously advocating the lightweight case)
> it seems improtant that the following conditions are met:
>
>  - loopback traffic inside a guest is insignificantly
>    slower than on a normal system
>
>  - loopback traffic on the host is insignificantly
>    slower than on a normal system
>
>  - inter guest traffic is faster than on-wire traffic,
>    and should be withing a small tolerance of the
>    loopback case (as it really isn't different)
>
>  - network (on-wire) traffic should be as fast as without
>    the namespace (i.e. within 1% or so, better not really
>    measurable)
>
>  - all this should be true in a setup with a significant
>    number of guests, when only one guest is active, but
>    all other guests are ready/configured
>
>  - all this should scale well with a few hundred guests

Ultimately I agree. However.  Only host performance should be
a merge blocker.  Allowing us to go back and reclaim the few
percentage points we lost later.

>> If we don't hurt that core case we have an implementation we can
>> merge.  There are a lot of optimization opportunities for local
>> communications and we can do that after we have a correct and accepted
>> implementation.  Anything else is optimizing too soon, and will
>> just be muddying the waters.
>
> what I fear is that once something is in, the kernel will
> just become slower (as it already did in some areas) and
> nobody will care/be-able to fix that later on ...

If nobody cares it doesn't matter.

If no one can fix it that is a problem.  Which is why we need
high standards and clean code, not early optimizations.

But on that front each step of the way must be justified on
it's own merits.  Not because it will give us some holy grail.

The way to keep the inter guest performance from degrading is
to measure it an complain.  But the linux network stack is too
big to get in one pass.

Eric
