Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWGLQhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWGLQhN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 12:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWGLQhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 12:37:13 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55276 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751143AbWGLQhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 12:37:11 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Allow /proc/sys without sys_sysctl
References: <m1u05pkruk.fsf@ebiederm.dsl.xmission.com>
	<200607121652.21920.ak@suse.de>
	<m1lkqyc00d.fsf@ebiederm.dsl.xmission.com>
	<200607121808.26555.ak@suse.de>
Date: Wed, 12 Jul 2006 10:36:32 -0600
In-Reply-To: <200607121808.26555.ak@suse.de> (Andi Kleen's message of "Wed, 12
	Jul 2006 18:08:26 +0200")
Message-ID: <m1ac7ebx0v.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Wednesday 12 July 2006 17:32, Eric W. Biederman wrote:
>> Andi Kleen <ak@suse.de> writes:
>> 
>> >> So it will correctly handle that sysctl being compiled out, and
>> >> the fallback to using /proc.  The code seems to have been
>> >> doing that since it was added to glibc in 2000.
>> >
>> > Using /proc is extremly slow for this.
>> 
>> How so it is the same code in the kernel.  Is open much slower than
>> sys_sysctl?
>
> Yes, the VFS adds quite a lot of overhead with its zillions of
> locks and other complicated things.
>
> I have also people complaining about /proc/cpuinfo overhead.

Yes. I just confirmed that /proc/sys access is about an order
of magnitude slower.  I goofed and forgot to add you to the
cc list but I just sent a patch to Ulrich to switch glibc to using
uname for this case.  uname is even faster than sysctl.

I am very curious to understand where the overhead is coming
from.  It may just be the VFS or it may be stupidities in
the /proc implementation.  If things are really as bad as
they appear it puts a serious damper on the plan9 style everything
is a filesystem approach.

>> > You added significant cost to each program startup.
>> 
>> Not each program only the ones that use pthreads.
>
> In modern glibc it's basically everything

It shouldn't be.   You can support be thread safe without pulling
in glibc.  But yes it is common.

>> > I still think it's a good idea to simulate that sysctl and printk
>> > the others.
>> 
>> To reduce the noise something like that makes sense.  I'm going to
>> see if I can get glibc to use uname which should have the same effect.
>
> And still printk for all old binaries?  Not a good idea.
>
> You have to check for  this case in the printk stub anyways and 
> if you check for it you can as well emulate it
> (with a big fat comment that this won't be done for any other sysctl)

I will see how it goes.

Eric
