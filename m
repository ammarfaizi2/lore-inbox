Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264246AbUJLOXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUJLOXh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 10:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUJLOXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 10:23:36 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:35010 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S264246AbUJLOX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 10:23:27 -0400
Date: Tue, 12 Oct 2004 16:24:17 +0200
From: Andrea Arcangeli <andrea@cpushare.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: secure computing for 2.6.7
Message-ID: <20041012142417.GD17372@dualathlon.random>
References: <20040704173903.GE7281@dualathlon.random> <20040704143526.62d00790.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040704143526.62d00790.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 04, 2004 at 02:35:26PM -0700, Andrew Morton wrote:
> Of course, yes, the patch is sufficiently safe and simple for it to be
> mergeable in 2.6, if this is the way we want to do secure computing.  I'd
> wonder whether the API should be syscall-based rather than /proc-based, and
> whether there should be a config option for it.

here a new patch, possibly candidate for merging in 2.6.10pre?

	http://www.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.9-rc4/seccomp

I added the config option, mostly to be sure archs will show the seccomp
file only if they really support the feature interally.

For my purpose seccomp is the most robust and secure API I could desire.
Adding genericity isn't the object, the object is to keep it simple and
obviously safe and as hard as possible to break.  I plan to eventually
go a bit more complex (and in turn a bit less secure from the point of
view of the seller) with xen-like trusted computing later once there
will be enough hardware in the market to make it worthwhile. As for the
syscall vs /proc, it's not performance critical, and I find this more
usable (plus currently I'm firing it on with python and excuting a new
syscalls with python isn't as quick as a file('/proc/' + pid +
'/seccomp', 'w').write('1').

Also note, I don't mind if the seccomp file could be removed from /proc
eventually, as far as I have the guarantee that when it's in there it
implements the feature. Ideally the seccomp.c file should be pretty much
fixed in stone and not subject to any further kernel development.

To receive the data asynchronously SIGIO can be set by the
seccomp-loader, or it can simply retry some read syscall from the socket
once every couple of seconds if the buffer isn't already full (socket
can be set in nonblocking mode).  That's all userspace stuff that
belongs to the seccomp loader. On the kernel side I will make it with
only read/write/exit/sigreturn.  Even once trusted computing will be
enabled I will only allow those few operations to communicate with the
untrusted world. So the model is going to stay and this also means
ideally no bytecode would require modification to run in trusted
computing mode by just creating a proper trusted-seccomp-loader (we'll
see if this is really true, I think it's at least theoretically
feasible, but it's not a short term matter).

It's a pain to program inside the seccomp mode for the programmer, but
the power he/she will get if he does I believe could make it worthwhile
and the whole thing worth a quick try.

Another reason for merging this is that projects like BOINC should start
using seccomp too. They write in their webpage "Accidental abuse of
participant hosts by projects: BOINC does nothing to prevent this. The
chances of it happening can be minimized by pre-released application
testing. Projects should test their applications thoroughly on all
platforms and with all input data scenarios before promoting them to
production status.".  seccomp will fix it completely, which means the
userbase could increase significantly too, beacuse the seller will not
have to trust the buyer not to have bugs.

Relaying on seccomp not to break (like I'm doing) is no different from
relaying on the netfilter code not to break and it's no different from
relaying on the openssh code not to break, and again no different from
relaying on the IPSEC code not to break. Except this is an order of
magnitude simpler to guarantee as obviously safe since much less kernel
code is involved in these secure paths. Plus this is a lot more secure
too since if something breaks I will force an upgrade immediatly on
every single client connected and I'll notify via email as well anybody
who could have been affeected, something not enforceable on firewall
kernel code for example on a random computer on the internet.
