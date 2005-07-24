Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbVGXVEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbVGXVEF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 17:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVGXVEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 17:04:04 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:59556 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261305AbVGXVED convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 17:04:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EQeBprf2VSRzEEtoHCZUZRJzuCfx5jmzvEuTPISHu0YCjLBhzoXQ7mMoONkz/rola/nvHrjQghPVOFqsedvzK4735Y/gxqrvL6ETxu6YFjfQZiKYXa2+LFRO3BTEDLtuyX9gc4YNNZRGCWlyhVjXRjFGVB+gWV8iyMDUvLmSYGg=
Message-ID: <f89941150507241403234949be@mail.gmail.com>
Date: Sun, 24 Jul 2005 17:03:59 -0400
From: Florin Malita <fmalita@gmail.com>
Reply-To: Florin Malita <fmalita@gmail.com>
To: Ciprian <cipicip@yahoo.com>
Subject: Re: kernel 2.6 speed
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050724191211.48495.qmail@web53608.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050724191211.48495.qmail@web53608.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/05, Ciprian <cipicip@yahoo.com> wrote:
> test /= 10;
> test *= 10;
> test += 10;
> test -= 10;

You're not trying to benchmark the kernel with those arithmetic
operations are you?! That's completely bogus, the kernel is not
involved in any of that.

As it has been already pointed out, the only OS-dependent and (by far)
the most expensive operation in your loop is the time() function call
- so that's the only thing you're really benchmarking there (besides
compiler optimizations).

> In windows were performed about 300 millions cycles,
> while in Linux about 10 millions. This test was run on
> Fedora 4 and Suse 9.2 as Linux machines, and Windows
> XP Pro with VS .Net 2003 on the MS side. My CPU is a
> P4 @3GHz HT 800MHz bus.

I can only speculate as of why the windoze time() call seems so much
faster: maybe it is implemented in userspace and doesn't involve a
system call. Somebody with more knowledge in the area might
confirm/infirm this.

Even in Linux your results will vary a lot depending on whether the
kernel and glibc support vsyscalls. The FC kernels disable vsyscall
because it's incompatible with NX, not sure about the Suse kernels.
Here's what I get on a P4 1.7 with a vsyscall enabled kernel
(2.6.11.12):

No. of cycles: 65688977

Check this thread for a FC4 kernel performance discussion:
http://www.redhat.com/archives/fedora-devel-list/2005-June/msg01126.html


> Now, can anyone explain this and suggest what other
> optimizations I should use? The 2.4 version was a lot
> faster. 

Your bogus test aside, a certain userland performance degradation when
moving from 2.4 to 2.6 is expected as the x86 timer interrupt
frequency has increased from 100Hz to 1KHz (it's about to be lowered
to 250Hz) - so your apps are interrupted more often. But I wouldn't
expect that degradation to be substantial. If you want to dig in and
measure it you should use asm/rdtsc instead of time().
