Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbTKBAFz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 19:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbTKBAFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 19:05:54 -0500
Received: from SteeleMR-loadb-NAT-49.caltech.edu ([131.215.49.69]:28096 "EHLO
	water-ox.its.caltech.edu") by vger.kernel.org with ESMTP
	id S261271AbTKBAFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 19:05:53 -0500
Date: Sat, 1 Nov 2003 16:05:50 -0800 (PST)
From: "Noah J. Misch" <noah@caltech.edu>
X-X-Sender: noah@sue
To: Scott Porter <scott@javascript-games.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Type conflicts in in.h header files.
Message-ID: <Pine.GSO.4.58.0311011520230.5827@sue>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     I'm not much of a C programmer, but I'm attempting to build an old
> daemon called "mrouted" to allow me to set up a multicast router using
> linux (there doesn't seem to be ANY current documentation about this, so
> I'm assuming I still need to use this daemon?!). The kernel was compiled
> with all routing options enabled. Here's a partial error log during the
> build:

I don't know anything about multicast routing on Linux, so I can't provide any
additional guidance there.

> gcc -D__BSD_SOURCE  -Ibsd -O -Iinclude-linux  -DRSRR       -c -o igmp.o
> igmp.c
> In file included from /usr/include/linux/mroute.h:5,
>                  from defs.h:34,
>                  from igmp.c:14:
> /usr/include/linux/in.h:25: conflicting types for `IPPROTO_IP'
> /usr/include/netinet/in.h:32: previous declaration of `IPPROTO_IP'
> /usr/include/linux/in.h:26: conflicting types for `IPPROTO_ICMP'
> /usr/include/netinet/in.h:36: previous declaration of `IPPROTO_ICMP'
> /usr/include/linux/in.h:27: conflicting types for `IPPROTO_IGMP'
> /usr/include/netinet/in.h:38: previous declaration of `IPPROTO_IGMP'
> /usr/include/linux/in.h:28: conflicting types for `IPPROTO_IPIP'
> /usr/include/netinet/in.h:40: previous declaration of `IPPROTO_IPIP'

Each of those headers defines those symbols in an enum, with the enum in the
core glibc header (netinet/in.h) a superset of that in the glibc kernel header.
GCC doesn't let two enums define the same thing (nor do HP-UX or Sun CC).

>     I did "fix" this problem by symlinking linux/in.h -> netinet/in.h,
> however, this may have caused other problems during the build, but
> that's my problem I guess!

That's not a good idea.  C library includes are supposed to provide a consistent
interface atop the potentially volatile kernel interfaces provided in kernel
header files.  This makes userspace applications more portable across different
kernels (for glibc 1.x) and across different versions of the same kernel.

However, the fact that this worked indicates to me that the simplest correct and
effective solution to your problem is removing #include <netinet/in.h> from the
mrouted sources (I would guess all instances thereof).  Sending a patch to the
maintainer of that program would also be appropriate.  Though userspace programs
should avoid including kernel-specific headers, if they must, there's no need to
include generic headers as well.

A better solution would be to see if you could instead remove the include of
linux/mroute.h and other kernel headers, but that may not be possible, because
this program may be too tightly bound to the kernel to use standard glibc
interfaces.  I can't say without studying the program.

