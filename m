Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315630AbSHAQL6>; Thu, 1 Aug 2002 12:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315708AbSHAQL6>; Thu, 1 Aug 2002 12:11:58 -0400
Received: from ns.suse.de ([213.95.15.193]:1031 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315630AbSHAQL4> convert rfc822-to-8bit;
	Thu, 1 Aug 2002 12:11:56 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: linux-kernel@vger.kernel.org, bug-glibc@gnu.org
Subject: Kernel/Glibc:  EOPNOTSUPP vs. ENOTSUP vs. ENOTSUPP
Date: Thu, 1 Aug 2002 18:15:23 +0200
X-Mailer: KMail [version 1.4]
Cc: Nathan Scott <nathans@sgi.com>, Tim Shimmin <tes@sgi.com>,
       Thorsten Kukuk <kukuk@suse.de>, Andreas Schwab <schwab@suse.de>,
       Andreas Jaeger <aj@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200208011815.23462.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

we have a bit of a mess concerning error definitions: POSIX 1003.1-200
defines the errors EOPNOTSUPP and ENOTSUP as follows:

	[ENOTSUP] Not supported. The implementation does not support this
	feature of the Realtime Option Group.

	[EOPNOTSUPP] Operation not supported on socket. The type of socket
	(address family or protocol) does not support the requested operation.

The standard further says the numbers assigned to ENOTSUP and EOPNOTSUPP shall 
be unique.

Glibc seems to follow, but not quite:

	[ENOTSUP] "Not supported".  A function returns this error when
	certain parameter values are valid, but the functionality they request
	is not available. This can mean that the function does not implement
	a particular command or option value or flag bit at all.  For functions
	that operate on some object given in a parameter, such as a file
	descriptor or a port, it might instead mean that only that specific
	object (file descriptor, port, etc.) is unable to support the other
	parameters given; different file descriptors might support different
	ranges of parameter values.

        If the entire function is not available at all in the implementation,
	it returns ENOSYS instead.

	[EOPNOTSUPP] "Operation not supported". The operation you requested is
	not supported.  Some socket functions don't make sense for all types of
	sockets, and others may not be implemented for all communications
	protocols.  In the GNU system, this error can happen for many calls when
	the object does not support the particular operation; it is a generic
	indication that the server knows nothing to do for that call.

In Glibc's sysdeps/unix/sysv/linux/bits/errno.h it says:
	/* Linux has no ENOTSUP error code. */
	# define ENOTSUP EOPNOTSUPP

In the kernel we define EOPNOTSUPP (architecture specific) and
ENOTSUPP (in include/linux/errno.h). ENOTSUPP doesn't exist inside POSIX.

Is ENOTSUPP supposed to be the same as ENOTSUP? Some applications are
already checking for ENOTSUP; if they are compiled against Glibs they
currently will really check against EOPNOTSUPP. Renaming or aliasig
ENOTSUPP to ENOTSUP will cause trouble, but aliasing ENOTSUP to
EOPNOTSUPP leads to a conflict with POSIX.

What shall be done?

Regards,
Andreas.

------------------------------------------------------------------
 Andreas Gruenbacher                                SuSE Linux AG
 mailto:agruen@suse.de                     Deutschherrnstr. 15-19
 http://www.suse.de/                   D-90429 Nuernberg, Germany

