Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263996AbUAMLrr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 06:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264104AbUAMLrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 06:47:47 -0500
Received: from gprs214-71.eurotel.cz ([160.218.214.71]:3200 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263996AbUAMLrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 06:47:45 -0500
Date: Tue, 13 Jan 2004 12:49:13 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@users.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Is this too ugly to merge?
Message-ID: <20040113114913.GB269@elf.ucw.cz>
References: <1073609923.2003.10.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073609923.2003.10.camel@laptop-linux>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm wanting to the opinion, if I may, of more experienced people
> regarding changes I have implemented in my version of Software Suspend,
> which I want to merge with Patrick and Pavel. Since I'm don't expect
> that you're all familiar with how my version works, I'll give a fair bit
> of background before I come to the question.
> 
> One of the problems I ran into in developing the code was the issue of
> getting activity stopped so that (1) locks which are required in writing
> the image aren't still held, (2) we can ensure that dirty buffers are
> synced to disk and (3) freezing doesn't fail because of races between
> processes entering the freezer. Point three is especially important.
> With the implementation in the kernel at the moment, deadlocks can
> easily happen under load. (I could provide examples but I'm sure you can
> imagine).
> 
> To get around these problems, I tried a number of different approaches.
> In the end, the one that has worked best has been to add hooks to the
> entrance and exit for critical paths in the kernel, and maintain a count
> of the number processes in those sections. There are also hooks to
> temporarily decrement the counter at points where a thread can block in
> kernel code, in cases where it can safely sit there until resume time. 
> 
> These hooks also provide a means whereby processes that want to begin
> work on a critical path can be held until post-resume.
> 
> Finally, processes can be marked as needed for syncing ('syncthreads'),
> and allowed to continue through these hooks where 'normal' threads would
> be held.
> 
> When we want to freeze activity, then, it is simply a matter of toggling
> a flag and waiting for the number of active processes to reduce to zero.
> During this time, user space threads that want to start new activity are
> frozen (via the hook at the start of the critical path they try to
> enter) until post suspend. Threads already in critical sections run
> until they exit the critical path or pause at one of the 'safe points',
> and syncthreads such as kjournald run normally.

Okay, I can now remember (and agree to) that we need to suspend
userspace first, and only then suspend kernelspace. Bug I don't see
why we can't suspend userspace using old, SIGSTOP-like, method.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
