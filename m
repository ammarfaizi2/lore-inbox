Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965181AbWBHCll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965181AbWBHCll (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 21:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965185AbWBHCll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 21:41:41 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35476 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965181AbWBHClk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 21:41:40 -0500
To: Ulrich Drepper <drepper@gmail.com>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: pid_t range question
References: <Pine.LNX.4.61.0602071122520.327@chaos.analogic.com>
	<m1pslystkz.fsf@ebiederm.dsl.xmission.com>
	<a36005b50602071619w379980a2se9d78131a8e2b7bd@mail.gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 07 Feb 2006 19:39:11 -0700
In-Reply-To: <a36005b50602071619w379980a2se9d78131a8e2b7bd@mail.gmail.com> (Ulrich
 Drepper's message of "Tue, 7 Feb 2006 16:19:56 -0800")
Message-ID: <m1pslybmls.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper <drepper@gmail.com> writes:

> On 2/7/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
>> I know for certain that proc assumes it can fit pid in
>> the upper bits of an ino_t taking the low 16bits for itself
>> so that may the entire reason for the limit.
>
> Is this still the case?  For the 100,000 threads tests Ingo and I were
> running Ingo certainly came up with some patches to make /proc behave
> better.  This was before we had subdirs for thread groups.

It isn't too hard to change but it is still the case.  Truth is proc
really doesn't use inodes internally it is just a reporting thing.
So /proc will work but user space might get terribly confused.

> Anyway, I think we should put a reasonable top on the number of bits
> for the PIDs.  One reason is that the current (and fastest) design for
> more complex mutexes needs to encode more information than the PID in
> an 'int'.  See the latest robust mutex patches for an example.  If the
> limit could be, say, 28 bits that would still enable using more
> processes and threads then anybody wants so far.  Who know, when we
> hit this limit, maybe we have separate namespaces.  If not, we can
> still fix the existing limits but this would come at a cost which is
> why I think it's not worth doing now.

>From threads.h:
> /*
>  * This controls the default maximum pid allocated to a process
>  */
> #define PID_MAX_DEFAULT (CONFIG_BASE_SMALL ? 0x1000 : 0x8000)
> 
> /*
>  * A maximum of 4 million PIDs should be enough for a while:
>  */
> #define PID_MAX_LIMIT (CONFIG_BASE_SMALL ? PAGE_SIZE * 8 : \
> 	(sizeof(long) > 4 ? 4 * 1024 * 1024 : PID_MAX_DEFAULT))
> 

So I think as long as this is a kernel implementation things should work ok.
I hate to have user space make assumptions about how many bits are in a pid
though.

Eric
