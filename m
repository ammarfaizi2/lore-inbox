Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318352AbSGYGZv>; Thu, 25 Jul 2002 02:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318353AbSGYGZv>; Thu, 25 Jul 2002 02:25:51 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:519 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318352AbSGYGZu>; Thu, 25 Jul 2002 02:25:50 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Header files and the kernel ABI
Date: 24 Jul 2002 23:28:37 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <aho5ql$9ja$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK... I have had a thought grinding in my head for a while, and wanted
to throw it out for everyone to think about...

In the libc4/libc5 days, we attempted to use kernel headers in user
space.  This was a total mess, not the least because the kernel
headers tended to pull in a lot of other kernel headers, and the
datatypes were unsuitable to have spead all across userspace.

In glibc, the official rule is "don't use kernel headers."  This
causes problems, because certain aspects of the kernel ABI is only
available through the include files, and reproducing them by hand is
tedious and error-prone.

I'm in the process of writing a very tiny libc for initramfs, and will
likely have to deal with how to use the kernel ABI as well.

It seems to me that a reasonable solution for how to do this is not
for user space to use kernel headers, but for user space and the
kernel to share a set of common ABI description files[1].  These files
should be highly stylized, and only describe things visible to user
space.  Furthermore, if they introduce types, they should use the
already-established __kernel_ namespace, and of course __s* and __u*
could be used for specific types.

This means that we would be able to get rid of #if(n)def __KERNEL__ in
the main kernel header files, because there would be a separation by
file location -- something in the main kernel include files could
include the ABI description files, but the opposite should never be
true.

I would like to propose that these files be set up in the #include
namespace as <linux/abi/*>, with <linux/abi/arch/*> for any
architecture-specific support files (I do believe, however, that those
files should only be included by files in the linux/abi/ root.  This
probably would be a symlink to ../asm/abi in the kernel sources,
unless we change the kernel include layout.)  The linux/ namespace is
universally reserved for the kernel, and unlike <abi/*> I don't know
of any potential conflicts.  I was considered <kabi/*>, but it seems
cleaner to use existing namespace.

If people think this is an idea, I will try to set up the
infrastructure as part of my work on klibc, although I'm definitely
not going to be able to migrate every portion of every include file
that needs to be migrated all by myself.

Thoughts?

	-hpa



[1] I'm assuming here they are C include files, just because it's a
common language to everyone; however, it would be possible to create
an "ABI description language" which would compile to C headers as well
as perhaps other formats (assembly language support files?), ...)
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
