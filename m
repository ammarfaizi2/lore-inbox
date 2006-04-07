Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbWDGTUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbWDGTUq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 15:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbWDGTUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 15:20:46 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27585 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964904AbWDGTUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 15:20:45 -0400
To: "Joshua Hudson" <joshudson@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: wait4/waitpid/waitid oddness
References: <787b0d920604052038i3a75bdb6ic0818d93805b881b@mail.gmail.com>
	<m1acaxnt1x.fsf@ebiederm.dsl.xmission.com>
	<bda6d13a0604071158x33080de3ya8016dde59c2d97f@mail.gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 07 Apr 2006 13:19:41 -0600
In-Reply-To: <bda6d13a0604071158x33080de3ya8016dde59c2d97f@mail.gmail.com> (Joshua
 Hudson's message of "Fri, 7 Apr 2006 11:58:40 -0700")
Message-ID: <m1fykpmbw2.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Joshua Hudson" <joshudson@gmail.com> writes:

> On 4/7/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
>> "Albert Cahalan" <acahalan@gmail.com> writes:
>>
>> > The kernel prohibits:
>> >
>> > 1. WNOHANG on waitpid/wait4
>>
>> Not 2.6.17-rc1, and not for a lot of earlier kernels.
>> At least not on ingress, and just skimming the code
>> I can't see any deeper checks that would prevent this.
>>
>> > 2. __WALL on waitid
>> >
>> > Why? I need both at once.
>>
>> Which kernel is failing, and how?
>
> LKNL 2.6.16.1 has this check. Haven't checked any others.

So what I see current in wait4 is:
> asmlinkage long sys_wait4(pid_t pid, int __user *stat_addr,
> 			  int options, struct rusage __user *ru)
> {
> 	long ret;
> 
> 	if (options & ~(WNOHANG|WUNTRACED|WCONTINUED|
> 			__WNOTHREAD|__WCLONE|__WALL))
> 		return -EINVAL;

This denies access if you use other flags but it should allow
__WALL and WNOHANG together.  I didn't see anything in do_wait,
that would prohibit this.

> 	ret = do_wait(pid, options | WEXITED, NULL, stat_addr, ru);
> 
> 	/* avoid REGPARM breakage on x86: */
> 	prevent_tail_call(ret);
> 	return ret;
> }

So where are you seeing the check in 2.6.16.1?

Eric


