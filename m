Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262912AbSJ1KWP>; Mon, 28 Oct 2002 05:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262937AbSJ1KWP>; Mon, 28 Oct 2002 05:22:15 -0500
Received: from [81.29.64.88] ([81.29.64.88]:12197 "EHLO bjl1.asuk.net")
	by vger.kernel.org with ESMTP id <S262912AbSJ1KWO>;
	Mon, 28 Oct 2002 05:22:14 -0500
Date: Mon, 28 Oct 2002 10:28:09 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Paul Eggert <eggert@twinsun.com>
Cc: andrew@pimlott.net, linux-kernel@vger.kernel.org
Subject: Re: nanosecond file timestamp resolution in filesystems, GNU make, etc.
Message-ID: <20021028102809.GA16062@bjl1.asuk.net>
References: <20021027153651.GB26297@pimlott.net> <200210280947.g9S9l9H01162@sic.twinsun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210280947.g9S9l9H01162@sic.twinsun.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Eggert wrote:
> My personal experience is that it's hard to read and write code that
> futzes with timestamps of various resolutions, and there is a real
> advantage to sticking with a simple rule that always takes the floor
> when going to a lower-precision timestamp, even if that rule has
> suboptimal results in some cases.

I have to disagree.  The whole point of accurate timestamps is that a
program can reliably ask "are my assumptions about the contents of
this file still valid?", "do I have to read the file to revalidate my
assumptions?"

When you don't have accurate timestamps, or resolutions are mixed,
then it's not possible to answer this question.  The only correct
behaviour for a program, such as a cacheing dynamic web server, a
cacheing JIT compiler or something like Make, is to round the
timestamp _up_.

Which is fine so long as you can write this in the application code:

    if (ts_nanoseconds == 0)
        ts_nanoseconds = 1e9-1;

That's a rare enough occurrence when timestamps have nanosecond
accuracy that the the glitch is not a problem.

Unfortunately that application code breaks when the filesystem may
have timestamps with resolution better than 1 second, but worse than 1
nanosecond.  Then the application just can't do the right thing,
unless it knows what rounding was applied by the kernel/filesystem, so
it can change that rounding in a safe direction.

So for applications which actually _depend_ on accurate timestamps for
reliability, I see only two valid things for the kernel to do:

     1. Round timestamps _up_.

     2. Or, round timestamps down _and_ store the rounding resolution in
        struct stat, in addition to the timestamp.

I'm in favour of 1.

(With Paul's suggestion of just rounding down without telling me when
that happened, AFAICT my _reliable_ cacheing applications must simply
ignore the nanoseconds field, which is a bit unfortunate isn't it?)

-- Jamie
