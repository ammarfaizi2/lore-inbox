Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbVDMFal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbVDMFal (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 01:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262199AbVDMFah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 01:30:37 -0400
Received: from mail27.sea5.speakeasy.net ([69.17.117.29]:30090 "EHLO
	mail27.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S262079AbVDMFaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 01:30:24 -0400
Date: Tue, 12 Apr 2005 22:30:22 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Tomko <tomko@haha.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Why system call need to copy the date from the userspace before
 using it
In-Reply-To: <425C9E55.6010607@haha.com>
Message-ID: <Pine.LNX.4.58.0504122207280.30548@shell2.speakeasy.net>
References: <425C9E55.6010607@haha.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2005, Tomko wrote:

> Hi all,
>
> I am new to linux , hope someone can help me.
> While i am reading the source code of the linux system call , i find
> that the system call need to call copy_from_user() to copy the data from
> user space to kernel space before using it . Why not use it directly as
> the system call has got the address ?  Furthermore , how to distinguish
> between user space and kernel space ?
>
> Thx a lot,
>
> TOM
> -

The quick and simple answer to this question is: data integrity.

The main thing to understand is that, from the perspective of the
kernel, any user input provided in the form of system calls must have
immutable data. Only if the data is immutable can the kernel code parse
it and decide what to do, without getting into really hairy race
conditions. And, for that matter, it's much simpler and less error-prone
to program code where you don't have to worry about the inputs changing
around you all the time.

So, you might say, what's wrong with the user code giving the kernel a
pointer to a userland buffer? After all, the calling task will be
blocked while the system call is being executed on its behalf. The
biggest problem is that the buffer can still be modified, while the
system call is executing, by another userland thread running in the same
virtual memory context. Or, for that matter, by another process that has
this chunk of memory shared with the original task. There are
innumerable ways for the data to potentially change in the middle of the
system call, and the simplest solution ends up being to copy the data to
kernelspace before working with it. That way, no userland tasks can
change it on you.

I'm sure there are other reasons for doing the copy, that someone will
be able to chime in with. Other input is always welcome. :-)

-Vadim Lobanov
