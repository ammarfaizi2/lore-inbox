Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <157299-215>; Tue, 9 Mar 1999 20:09:33 -0500
Received: by vger.rutgers.edu id <157130-215>; Tue, 9 Mar 1999 20:09:19 -0500
Received: from alcor.twinsun.com ([198.147.65.9]:4727 "EHLO alcor.twinsun.com" ident: "TIMEDOUT") by vger.rutgers.edu with ESMTP id <157075-212>; Tue, 9 Mar 1999 20:06:51 -0500
X-Bogus-CC: o.r.c@p.e.l.l.p.o.r.t.l.a.n.d.o.r.u.s (david parsons)
To: linux-kernel@vger.rutgers.edu
Subject: Re: Recursion level of symlinks limitted to five?
References: <36E3A065.9F07184B@imb-jena.de> <19990308213403.B9844@kali.munich.netsurf.de> <19990309115204.A19052@caffeine.ix.net.nz> <linux.kernel.7v4snva2bj.fsf@shine.twinsun.com> <7c4446$tk2@pell.pell.portland.or.us>
From: Junio Hamano <junio@twinsun.com>
Date: 09 Mar 1999 17:00:53 -0800
In-Reply-To: o.r.c@p.e.l.l.p.o.r.t.l.a.n.d.o.r.u.s's message of "9 Mar 1999 13:33:58 -0800"
Message-ID: <7v7lsqw43e.fsf@shine.twinsun.com>
X-Mailer: Gnus v5.5/Emacs 20.3
Sender: owner-linux-kernel@vger.rutgers.edu

>>>>> "david" == david parsons <o.r.c@p.e.l.l.p.o.r.t.l.a.n.d.o.r.u.s> writes:

david> In article <linux.kernel.7v4snva2bj.fsf@shine.twinsun.com>,
david> Junio Hamano  <junio@twinsun.com> wrote:
>> Just out of curiosity, couldn't the resolving of symlinks all be
>> done in the userland? 

david>    A libc solution requires that everyone use a libc that's been
david>    hacked to do this, umm, method, and not everyone will hack their
david>    version of libc to do that.

Agreed, and that's part of my idea.  If non-insignificant number
of people feel that 5 levels of symlinks are too few for
real-world applications, either (1) they rewrite their
application so that it catches ELOOP whenever they call system
calls and resolve symlink as needed, or (2) fold such a
check-and-recover scheme into the standard C library so that
application programmers do not have to worry about this
limitation over and over again.  The key idea here is to fold
this into the standard C library, not to replace the C library
with your hacked one.

When (2) happens, but until everybody updates to the new C
library, applications running on a configuration where they do
not see more than 5 levels of symlink indirection work fine with
both the old and new C library, and in addition, applications
running with the new C library would not even see 5-level
restriction imposed by the kernel.  Of course, userland C
library would still have its own limits, depending on the way
the memory needed to recursively resolve symlinks are allocated.
Over time, everybody would update their C library if the above
makes into the standard C library.

When that happens, there is no reason for the kernel to even
support 5 levels of indirection.  The kernel could even return
ELOOP when it sees just one symbolic link and let the C library
resolve the symlink.  Of course, on the other hand, we may want
to have the kernel resolve some levels of indirection itself
for, say, performance reasons.  But an important point of the
idea outlined above is that it makes how many symlink
indirections a typical application expects to be supported by
the kernel irrelevant when the kernel implementor decides how
many levels of symlinks are supported by the kernel.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
