Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261300AbSJ1PLb>; Mon, 28 Oct 2002 10:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261302AbSJ1PLa>; Mon, 28 Oct 2002 10:11:30 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:63141 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S261300AbSJ1PL3>;
	Mon, 28 Oct 2002 10:11:29 -0500
Date: Mon, 28 Oct 2002 15:17:47 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Andi Kleen <ak@suse.de>
Cc: eggert@twinsun.com, linux-kernel@vger.kernel.org
Subject: Re: nanosecond file timestamp resolution in filesystems, GNU make, etc.
Message-ID: <20021028151747.GC16546@bjl1.asuk.net>
References: <20021027153651.GB26297@pimlott.net.suse.lists.linux.kernel> <200210280947.g9S9l9H01162@sic.twinsun.com.suse.lists.linux.kernel> <20021028102809.GA16062@bjl1.asuk.net.suse.lists.linux.kernel> <p73r8eastwo.fsf@oldwotan.suse.de> <20021028125652.GA16329@bjl1.asuk.net> <20021028151533.D18441@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021028151533.D18441@wotan.suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> > So I propose: add a field to struct stat indicating the resolution of
> > the timestamps in it.  It can go on the end.
> It's impossible. There is no space left in struct stat64
> And adding a new syscall just for that would be severe overkill.

There's the 4 bytes following dev_t in Glibc's definition (call __pad1
in Glibc) which isn't used by Glibc or anything else.  That's still
free even when the kernel changes to 64-bit dev_t.

And if you don't like that to do that, i.e you want to guarantee that
the unused word continues to be zero for older programs (though I
can't think of any reason why it would matter), that's what the
(currently unused) flags argument to stat64() is for.

> But what you could do if you really wanted that: implement kernel
> POSIX pathconf()/fpathconf() and implement it as a parameter to
> that.

Ugh.

> I personally have no plans to implement it [pathconf], however,
> because it looks like kernel bloat to me :-)

Given the choice of using fpathconf, I'd rather accept that the
nanoseconds field is not reliable, hence I must ignore it.  It does
seem a waste though - sometimes you are returning good information I
can use, other times you're not, and I can't tell the difference :-(

I'd much rather do this right.  What do you think of storing the
resolution in the unused word called __pad1 in Glibc?

(Btw, it wouldn't bloat the in-core kernel inode, because only a
couple of flag bits are needed there to distinguish known resolution
values).

-- Jamie
