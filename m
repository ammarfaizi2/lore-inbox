Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263810AbUE2Umh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263810AbUE2Umh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 16:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUE2Ume
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 16:42:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40920 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263810AbUE2Umc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 16:42:32 -0400
Date: Sat, 29 May 2004 21:42:30 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Netdev <netdev@oss.sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@redhat.com>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [PATCH] remove net driver ugliness that sparse complains about
Message-ID: <20040529204230.GG12308@parcelfarce.linux.theplanet.co.uk>
References: <40B8D2F8.6090905@pobox.com> <Pine.LNX.4.58.0405291117511.1648@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405291117511.1648@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2004 at 11:23:56AM -0700, Linus Torvalds wrote:
> Since the whole point of sparse is to have _static_ typechecking, such
> code will never be sparse-clean, and either we have to ignore it, or we
> should split up the use into two different kinds of structures (with the
> same members apart from the address space) and explicitly convert between
> the two.  I'd obviously prefer that approach, but it might be a fair
> amount of work (most of it should be really trivial, though, and I suspect
> it would clarify pointer usage a lot to know when a "struct msghdr" points
> to user space, and when it points to kernel space. Or whatever - maybe 
> that was a bad example).

Right now there is only one serious false positive I know about.
	put_user(0, dirent->d_name)
and its equivanlents in some places.  That's __typeof__() handling bug.

The rest is easy to spot - ## handling is broken in minimally tricky
cases, [arg] is not recognized in asm arguments, some __attribute__()
are not recognized and string constant length limits sometimes bite
in asm bodies.

The rest of patchset (~360Kb right now, and it will grow more) does include
several splittings of structs, BTW.  It removes pretty much all noise on
my alpha / amd64 / x86 builds; the rest is real issues.

Probably the worst annoyance is iovec - there is almost no intersection
between the code that expects kernel pointers in it with code that expects
userland ones (majority).  I hadn't split that one, but that's worth
considering.

sync kiocb is a disaster waiting to happen.

->write() of tty_driver will take some research - we might want to try and
keep copying from userland in generic code instead of just splitting the
method, but that will require figuring out the locking issues.

A bunch of set_fs() users in compat code is simply broken and should be
using compat_alloc_user_space() instead.  They end up with a mix of kernel
and userland pointers, and set_fs(KERNEL_DS) is not enough to handle that.

console code has some moderately minor annoyances; compared to the ugliness
of the entire code in that area they are not too interesting.

One thing I would _really_ hate to see is use of typecasts just to shut
sparse up - the point is to find the potentially problematic places, not
to hide them.  We probably need a flag for sparse that would warn about
explicit typecasts changing noderef and address_space inside the pointers;
it obviously won't help the casts to unsigned long and back, but those
are presumably used when people really mean it.
