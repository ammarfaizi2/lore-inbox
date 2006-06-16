Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWFPG21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWFPG21 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 02:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbWFPG21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 02:28:27 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5823 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751080AbWFPG21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 02:28:27 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Akiyama, Nobuyuki" <akiyama.nobuyuk@jp.fujitsu.com>
Cc: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [PATCH] kdump: add a missing notifier before crashing
References: <20060615201621.6e67d149.akiyama.nobuyuk@jp.fujitsu.com>
Date: Fri, 16 Jun 2006 00:28:08 -0600
In-Reply-To: <20060615201621.6e67d149.akiyama.nobuyuk@jp.fujitsu.com>
	(Nobuyuki Akiyama's message of "Thu, 15 Jun 2006 20:16:21 +0900")
Message-ID: <m1d5d9pqbr.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Akiyama, Nobuyuki" <akiyama.nobuyuk@jp.fujitsu.com> writes:

> Hi all,
>
> The attached patch adds a missing notifier before crashing.
> This patch is remade to follow the former discussions.
> The change is that a notifier calling becomes optional.
> Please refer to the following thread for details:
>
> http://lists.osdl.org/pipermail/fastboot/2006-May/003018.html
>
> Description:
> We don't have a simple and light weight way to know the kernel dies.
> The panic notifier does not be called if kdump is activated
> because crash_kexec() does not return, and there is no mechanism to
> notify of a crash before crashing by SysRq-c.
> Although notify_die() exists, the function depends on architecture.
> If notify_die() is added in panic and SysRq respectively like
> existing implementation, the code will be ugly.
> I think that adding a generic hook in crash_kexec() is better to
> simplify the code.
>
> This new notifier is useful, especially for a clustering system.
> On a mission critical system, failover need to start within a few
> milli-second. The notifier could be called on 2nd kernel, but it is
> no use because it takes the time of second order to boot up.
>
> The attached patch is against 2.6.17-rc6-git5.
> I tested on i386-box.

Please give a concrete example of a failure mode where this allows
you to meet your timing constraint.

I have yet to be convinced that this actually solves a real world
problem.

What is the cost of the notifier you wish to implement?
What is your guarantee that the system won't have wasted seconds
detecting it can't allocate memory or other cases?

If we go this route the notifier should not be exported to modules.
Only the most scrutinized of code paths should ever set this,
and code like that should never be a module.

The patchset that adds the notifier call needs to include the notifier
so people can look and see how sane this is.

So far what I have seen are hand waving arguments that failures
that can never happen must be detected and reported within
milliseconds to another machine in an unspecified manner.  Your kernel
startup times are asserted to be to large to do this from the next
kernel, but the code to do so is sufficiently complicated you can't do
this in the kexec code stub that runs before it starts your next
kernel.

I am sympathetic but this interface seems to set expectations that
we can the impossible, and it still appears unnecessary to me.

Eric
