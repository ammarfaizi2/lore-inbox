Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262801AbUK0DKC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262801AbUK0DKC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 22:10:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262781AbUK0DI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:08:59 -0500
Received: from smtpout.mac.com ([17.250.248.46]:36293 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262835AbUK0DIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 22:08:06 -0500
In-Reply-To: <19865.1101395592@redhat.com>
References: <19865.1101395592@redhat.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7258BF93-4021-11D9-8DB8-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: aoliva@redhat.com, linux-kernel@vger.kernel.org, matthew@wil.cx,
       dwmw2@infradead.org, torvalds@osdl.org, libc-hacker@sources.redhat.com,
       hch@infradead.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Date: Fri, 26 Nov 2004 22:07:18 -0500
To: David Howells <dhowells@redhat.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 25, 2004, at 10:13, David Howells wrote:
> We've been discussing splitting the kernel headers into userspace API 
> headers
> and kernel internal headers and deprecating the __KERNEL__ macro. This 
> will
> permit a cleaner interface between the kernel and userspace; and one 
> that's
> easier to keep up to date.

Yay!!! Finally!!!

> 	NEW DIRECTORY		DIRECTORY SHADOWED
> 	=============		==================
> 	include/user/		include/linux/
> 	include/user-*/		include/asm-*/

How about include/abi for the platform-independent headers and 
include/arch-*
for the platform-specific headers?  Then include/arch would be 
symlinked to the
correct arch-* directory.

>      Note that this doesn't take account of the other directories under
>      include/, but I don't think they're relevant.

Perhaps such directories should either be broken out into 
abi/foo<->linux/foo
pieces, or put into their own top-level directories.

>  (2) Take each file from the shadowed directory. If it has any 
> userspace
>      relevant stuff, then:
[...snip...]

Something like this would warn about incorrect uses of the linux/ 
headers, yet
still allow for a period of backwards compatibility.  Once such period 
has passed,
then linux/* would not even be installed, only abi/* and arch/*

include/linux/foo.h:
#ifndef _LINUX_FOO_H
#define _LINUX_FOO_H 1

#ifndef __KERNEL__
# warning "Directly including <kernel/foo.h> is deprecated!!!"
# warning "Please change your program to include <abi/foo.h> instead!!!"
#endif

#include <abi/foo.h>

#ifdef __KERNEL__
/* Old __KERNEL__ contents of include/linux/foo.h */
#endif

#endif /* not _LINUX_FOO_H */


include/abi/foo.h:
#ifndef _ABI_FOO_H
#define_ABI_FOO_H 1

#include <abi/bar.h>
#include <arch/baz.h>

/* Old non-__KERNEL__ contents of include/linux/foo.h */

#endif /* not _ABI_FOO_H */

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


