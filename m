Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262444AbSJ1Muf>; Mon, 28 Oct 2002 07:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262447AbSJ1Muf>; Mon, 28 Oct 2002 07:50:35 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:32677 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S262444AbSJ1Mue>;
	Mon, 28 Oct 2002 07:50:34 -0500
Date: Mon, 28 Oct 2002 12:56:52 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Andi Kleen <ak@suse.de>
Cc: eggert@twinsun.com, linux-kernel@vger.kernel.org
Subject: Re: nanosecond file timestamp resolution in filesystems, GNU make, etc.
Message-ID: <20021028125652.GA16329@bjl1.asuk.net>
References: <20021027153651.GB26297@pimlott.net.suse.lists.linux.kernel> <200210280947.g9S9l9H01162@sic.twinsun.com.suse.lists.linux.kernel> <20021028102809.GA16062@bjl1.asuk.net.suse.lists.linux.kernel> <p73r8eastwo.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73r8eastwo.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> > Unfortunately that application code breaks when the filesystem may
> > have timestamps with resolution better than 1 second, but worse than 1
> > nanosecond. 
> 
> The current resolution is jiffies, which tends to be 1ms
> 
>  Then the application just can't do the right thing,
> > unless it knows what rounding was applied by the kernel/filesystem, so
> > it can change that rounding in a safe direction.
> 
> The rounding is always truncation. So the application can just assume
> that.

This is fine when you are comparing two files with the same timestamp
resolution, but when the resolutions are different you need to know
what they are.

Come to think of it, rounding up is no better than rounding down when
comparing two files.  The application needs to round one of them up
and one of them down, in order to make reliable tests of the form "is
this file definitely newer than this other file".

For those kinds of tests, the application needs to know a lower bound
of the resolution.  Note that a jiffie is not suitable as the lower
bound, because that part of the timestamp is dropped when the inode is
dropped from memory.

The other kind of test is a comparison of one file against against its
own modification time when something derived from the file was last
cached.  (This is appropriate for server requests and JIT compiler
launching, for example).

This time there is only one resolution.  Nevertheless, to make a
reliable test of the form "have the contents of the file definitely
not been modified since mtime T", neither form of rounding on the
kernel side is sufficient: the application needs to know the
resolution.

I think that in all cases, for the application to make useful
decisions it needs to know the resolution of the timestamps in any
particular struct stat.  If those resolutions change when an inode is
flushed from memory: that should change the resolution returned by
struct stat.

So I propose: add a field to struct stat indicating the resolution of
the timestamps in it.  It can go on the end.

-- Jamie

