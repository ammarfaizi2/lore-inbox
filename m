Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129348AbQLOSnK>; Fri, 15 Dec 2000 13:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129429AbQLOSnA>; Fri, 15 Dec 2000 13:43:00 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:25214 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S129423AbQLOSmq>;
	Fri, 15 Dec 2000 13:42:46 -0500
From: "LA Walsh" <law@sgi.com>
To: "Werner Almesberger" <Werner.Almesberger@epfl.ch>,
        "Alexander Viro" <viro@math.psu.edu>
Cc: "lkml" <linux-kernel@vger.kernel.org>
Subject: RE: Linus's include file strategy redux
Date: Fri, 15 Dec 2000 10:10:39 -0800
Message-ID: <NBBBJGOOMDFADJDGDCPHAENMCJAA.law@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20001215152137.K599@almesberger.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Werner Almesberger [mailto:Werner.Almesberger@epfl.ch]
>
> I think there are three possible directions wrt visibility of kernel
> headers:
>
>  - non at all - anything that needs kernel headers needs to provide them
>    itself
>  - kernel-specific extentions only; libc is self-contained, but user
>    space can get items from .../include/linux (the current glibc
>    approach)
>  - share as much as possible; libc relies on kernel for "standard"
>    definitions (the libc5 approach, and also reasonably feasible
>    today)
>
> So we get at least the following levels of visibility:
>
>  0) kernel-internal interfaces; should only be visible to "base" kernel
>  1) public kernel interfaces; should be visible to modules (exposing
>     type 0 interfaces to modules may create ways to undermine the GPL)
>  2) interfaces to kernel-specific user space tools (modutils, mount,
>     etc.); should be visible to user space that really wants them
>  3) interface to common non-POSIX extensions (BSD system calls, etc.);
>     should be visible to user space on request, or on an opt-out basis
>  4) interfaces to POSIX elements (e.g. struct stat, mode_t); should be
>     visible unconditionally (**)
---
	The problem came in a case where I had a kernel module that included
standard memory allocation <linux/malloc.h>.  That file, in turn, included
<linux/slab.h>, then that included <linux/mm.h> and <linux/cache.h>.  From
there more and more files were included until it got down to files in
a kernel/kernel-module only directory "<include/kernel>".  It was at that
point, the externally compiled module "barfed", because like many modules,
it expected, like many externally compiled modules, that it could simply
access all of it's needed files through /usr/include/linux which it gets
by putting /usr/include in it's path.  I've seen commercial modules like
vmware's kernel modules use a similar system where they expect
/usr/include/linux to contain or point to headers for the currently running
kernel.

	So I'm doing my compile in a 'chrooted' environment where the headers
for the new kernel are installed.  However, now, with the new include/kernel
dir in the linux kernel, modules compiled separately out of the kernel
tree have no way of finding hidden kernel include files -- even though
those files may be needed for modules.  Precisely -- in this case, "memory
allocation" for the kernel (not userland) was needed.  Arguably, this
belongs(ed)
in a kernel-only directory.  If that directory is not /usr/include/linux or
*under* /usr/include/linux, then modules need a separate way to find it --
namely a new link in /usr/include(<kernel>) to point to the new location,
or we move the internal kernel interfaces to something under the current
<include/linux> so while the intent of "kernel-only" is made clear, they
are still accessible in the way they already are, thus not requiring
rewrites
of all the existing makefiles.


	I think in my specific case, perhaps, linux/malloc.h *is* a public
interface that is to be included by module writers and belongs in the
'public interface dir -- and that's great.  But it includes files like
'slab.h' which are kernel mm-specific that may change in the future.  Those
files should be in the private interface dir.  But that dir may still need
to be included by public interface (malloc) file.

	So the user should/needs to be blind to how that is handled.  They
shouldn't have to change their makefiles or add new links just because
how 'malloc' implements its functionality changes.  This would impy that
kernel only interfaces need to be include-able within the current
model -- just moved out of the existing "public-for-module" interface
directory (/usr/include/linux).  For that to happen transparently, that
directory needs to exist under the current hierarchy (under
/usr/include/linux),
not parallel.

	So at that point it becomes what we should name it under
/usr/include/linux.  Should it be:

1) "/usr/include/linux/sys" (my preference)
2) "/usr/include/linux/kernel"
3) "/usr/include/linux/private"
4) "/usr/include/linux/kernel-only"
5) <other>

???

	Any other solution, as I see it, would break existing module code.

Comments??  Any preferences from /dev/linus?

	Any flaws in my logic chain?

tnx,
-linda

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
