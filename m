Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWA2GuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWA2GuD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 01:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWA2GuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 01:50:03 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44510 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750853AbWA2GuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 01:50:01 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386: Add a temporary to make put_user more type safe.
References: <m1r76rft2t.fsf@ebiederm.dsl.xmission.com>
	<20060128223917.4e5c3dd9.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 28 Jan 2006 23:49:32 -0700
In-Reply-To: <20060128223917.4e5c3dd9.akpm@osdl.org> (Andrew Morton's
 message of "Sat, 28 Jan 2006 22:39:17 -0800")
Message-ID: <m17j8jfs03.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> ebiederm@xmission.com (Eric W. Biederman) wrote:
>>
>> 
>> In some code I am developing I had occasion to change the type of a
>> variable.  This made the value put_user was putting to user space
>> wrong.  But the code continued to build cleanly without errors.
>
> What do you mean by "wrong"?  What combinations of types do you think
> should be disallowed here?  put_user(char, int*), for example, or what?
>
> We had one instance recently where code was doing put_user() of an
> eight-byte struct and that sailed through x86 testing but made the sparc64
> compiler ICE.  Certainly we should stamp out tricks like that at compile
> time, but how far should we go?
>
> There's probably a good case for ensuring that typeof(x)==typeof(*ptr), but
> I suspect that'd create a lot of noise.

All I do is ensure that typeof(x) is assignment compatible with typeof(*ptr).
That is what the assignment to the temporary does.  We actually do
this already on x86 if you compile for an i386 which people very rarely
do anymore.

I have performed sever kernel compiles with it applied against the stable
tree and saw no errors other than when I tried to assign a pointer to an
integer using put_user.

So your eight-byte struct case would probably be caught but the character
case would get type promoted and be fine.

>> Introducing a temporary fixes this problem and at least with gcc-3.3.5
>> does not cause gcc any problems with optimizing out the temporary.
>> gcc-4.x using SSA internally ought to be even better at optimizing out
>> temporaries, so I don't expect a temporary to become a problem.
>> Especially because in all correct cases the types on both sides of the
>> assignment to the temporary are the same.
>> 
>
> Sounds sane.  We could make it warn if typeof(x)!=typeof(*ptr) by adding
> another temporary for the pointer, give it type typeof(x)*, but I haven't
> tried it.

I guess we could do that.  However if we don't use the value we will probably
get an unused variable warning.  

Mostly I am just after the normal C assignment warnings/errors.  Although if
we can do better that would be great.

Eric
