Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWGLSMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWGLSMX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 14:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWGLSMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 14:12:23 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27049 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932279AbWGLSMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 14:12:22 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Kirill Korotaev <dev@sw.ru>
Cc: Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrey Savochkin <saw@sw.ru>, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 5/7] add user namespace
References: <20060711075051.382004000@localhost.localdomain>
	<20060711075420.937831000@localhost.localdomain>
	<44B3D435.8090706@sw.ru> <m1k66jebut.fsf@ebiederm.dsl.xmission.com>
	<44B4D970.90007@sw.ru>
Date: Wed, 12 Jul 2006 12:10:37 -0600
In-Reply-To: <44B4D970.90007@sw.ru> (Kirill Korotaev's message of "Wed, 12 Jul
	2006 15:13:52 +0400")
Message-ID: <m164i2ae3m.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:

>>>Another example of not so evident coupling here:
>>>user structure maintains number of processes/opened
> files/sigpending/locked_shm
>>>etc.
>>>if a single user can belong to different proccess/ipc/... namespaces
>>>all these becomes unusable.
>> Why do the count of the number of objects a user has become
>> unusable if they can count objects in multiple namespaces?
>> Namespaces are about how names are looked up and how names are
>> created.  Namespaces are not about the objects those names refer to.
>
> One example below, which I believe is a bug due to coupling.
> Will be glad to hear your opinion on this.
>
> Let user u to unshare its process namespace and run e.g. httpd inside newly
> created 2nd process namespace.
> Now imagine that user u hits his process rlimit.
> He can't kill his httpd's because they are in another process namespace. He can
> kill visible to his bash processes from
> 1st process namespace, but httpd can spawn childs more after that. So we end up
> with the situation
> when user u can't control his processes, nor run any other processes in his
> bash.

Yes, this can happen.   But as described this really is a usage problem.  I would
expect if your uid is in use in multiple places you will have accesses to all of
those places.  Part of this won't be clear until we sort out the process id
namespace though.

> I'm fine with such situations, since we need containers mostly, but what makes
> me
> really afraid is that it introduces hard to find/fix/maintain issues. I have no
> any other concerns.

Hard to find and maintain problems I agree should be avoided.  There are only two
ways I can see coping with the weird interactions that might occur.
1) Assert weird interactions will never happen, don't worry about it,
   and stomp on any place where they can occur.  (A fully isolated container approach).

2) Assume weird interactions happen and write the code so that it simply
   works if those interactions happen, because for each namespace you have
   made certain the code works regardless of which namespace the objects are
   in.

The second case is slightly harder.  But as far as I can tell it is more robust
and allows for much better incremental development.

Eric
