Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265300AbSKFBay>; Tue, 5 Nov 2002 20:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265302AbSKFBay>; Tue, 5 Nov 2002 20:30:54 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:27598 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S265300AbSKFBax>;
	Tue, 5 Nov 2002 20:30:53 -0500
Date: Tue, 5 Nov 2002 20:37:10 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Werner Almesberger <wa@almesberger.net>
cc: Andy Pfiffer <andyp@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: [lkcd-devel] Re: What's left over.
In-Reply-To: <20021105221050.A10679@almesberger.net>
Message-ID: <Pine.GSO.4.21.0211052017320.6521-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Nov 2002, Werner Almesberger wrote:

> Now, if we assume that it's okay for kexec to use a system call,
> the next question is whether kexec should indeed use it, i.e.
> whether a system call makes sense for what it is trying to do.
> Since there are no device files or network elements naturally
> involved here (i.e. other major kernel function interfaces),
> the answer seems to be "yes".

That's not obvious.  By the same logics, we would need syscalls for
turning off overcommit, etc., etc.

FWIW, I suspect that
	open("/proc/image", O_EXCL|O_WRONLY);
	bunch of lseek()/write()
	close()
would be more natural - definitely easier to understand than arguments of
your sys_kexec().  It's easy to switch from your code to that - you
put initialization into ->open(), pulling segments from userland into
->write(), use default ->lseek() and do actual work on ->close() if
no errors had happened.  file->private_data will point to intermediate
state you need.

After all, that's what happens - you form an image, writing to it user-supplied
data from given buffers at given offsets and when you are done with that you
commit the changes.  IMO special syscall is less natural match for that
than sequence above - commit-on-close is not something unusual, so it matches
the semantics of all syscalls involved...



