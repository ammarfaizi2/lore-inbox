Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131548AbRAAISB>; Mon, 1 Jan 2001 03:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131662AbRAAIRw>; Mon, 1 Jan 2001 03:17:52 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:41383 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S131548AbRAAIRh>; Mon, 1 Jan 2001 03:17:37 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 31 Dec 2000 23:47:11 -0800
Message-Id: <200101010747.XAA02612@adam.yggdrasil.com>
To: kaos@ocs.com.au, linux-kernel@vger.kernel.org
Subject: Re: Patch(?): linux-2.4.0-prerelease/drivers/char/drm/Makefile libdrm symbol versioning fix
Cc: faith@valinux.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> = Adam Richter
>  = Keith Owens

>>	There is a thread in linux-kernel about how somewhere in
>>linux-2.4.0-test13-preX, the Makefile for drivers/char/drm started
>>building libdrm.a and not versioning the symbols.  I believe the
>>following patch fixes the problem, but I have not tried it for the
>>nonmodular case.
>>
>>	The change is that libdrm.o is built instead of libdrm.a.  This
>>object is linked into the kernel if at least one driver that needs it
>>is also linked into the kernel.  Otherwise, it is built as a helper
>>module which is automatically loaded by modprobe when a module that
>>needs it is loaded.

>Having drmlib.o as a helper module will defeat the requirements listed
>in drivers/char/drm/Makefile (below).  You end up with one copy of the
>library being used by all modules.  See my patch earlier today on l-k
>that builds two versions of drmlib.a, for kernel and module.  That
>patch preserves the drm requirements.

># libs-objs are included in every module so that radical changes to the
># architecture of the DRM support library can be made at a later time.
>#
># The downside is that each module is larger, and a system that uses
># more than one module (i.e., a dual-head system) will use more memory
># (but a system that uses exactly one module will use the same amount of
># memory).
>#
># The upside is that if the DRM support library ever becomes insufficient
># for new families of cards, a new library can be implemented for those new
># cards without impacting the drivers for the old cards.  This is significant,
># because testing architectural changes to old cards may be impossible, and
># may delay the implementation of a better architecture.  We've traded slight
># memory waste (in the dual-head case) for greatly improved long-term
># maintainability.

>BTW, I disagree with this approach but I guess it is up to the drm
>maintainers.

	Like you, I disagree with this approach, but, if I have not missed
some important information, then I hope the drm maintainers with see
the light or, failing that, the Linus will just delete those comments
from linux/drivers/char/drm/Makefile anyhow and integrate a patch like
the one I posted.

	Kernel interfaces change radically all the time, and we make better
tradeoffs to deal with the same issues of maintaining support for old
hardware which might not be tested right away all the time.  For example,
we currently maintain two styles of PCI device drivers.  The drm
maintainers could just write a libdrm2 library if the need arose and
depmod/modprobe would automatically load it when necessary if they designed
it the normal way.  Imagine how huge the kernel modules would be if every
facility in the kernel duplicated itself as an object file in every module.
Why should drm be treated differently?

	It an especially bad tradeoff to take on the maintenance costs
of a weird kernel build (that drm users are already complaining about on
linux-kernel) for a facility like drm, which is a graphics optimization
for applications that are willing to go to some trouble to use it.  Users
of these applications will be disproprionately quick to upgrade or (for
example, in embedded applications) some organization will care enough and
have resources enough to at least report bugs and test fixes.  This is
like recoding i386 floating point emulation into assembly.  The
performance/maintence tradeoff is not worth it, because 386's have
already obscelesced from those applications, and still would have, even
with FP emulation in assembly.

	It's not my call to make, and I think we will follow the stock
kernels' drivers/char/drm even if it continues this weirdness, but I
certainly hope this duplication of libdrm in every module will be dropped.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
