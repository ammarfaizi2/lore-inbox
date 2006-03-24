Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932596AbWCXSwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932596AbWCXSwR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbWCXSwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:52:17 -0500
Received: from smtpout.mac.com ([17.250.248.97]:39136 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932596AbWCXSwQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:52:16 -0500
In-Reply-To: <200603231811.26546.mmazur@kernel.pl>
References: <200603141619.36609.mmazur@kernel.pl> <200603231811.26546.mmazur@kernel.pl>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com>
Cc: llh-announce@lists.pld-linux.org,
       LKML Kernel <linux-kernel@vger.kernel.org>, dank@kegel.com,
       nkukard@lbsd.net, vmiklos@frugalware.org, rseretny@paypc.com,
       lkml@dervishd.net, Rob Landley <rob@landley.net>, jbailey@ubuntu.com,
       llh-discuss@lists.pld-linux.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: State of userland headers
Date: Fri, 24 Mar 2006 13:51:58 -0500
To: Mariusz Mazur <mmazur@kernel.pl>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 23, 2006, at 12:11:26, Mariusz Mazur wrote:
> There was a thread on lkml on this topic about a year ago. IIRC  
> I've suggested, that the best option would be to get a new set of  
> dirs somewhere inside the kernel, and gradually export the userland  
> usable stuff from the kernel headers, so to (a) achieve full  
> separation and (b) avoid duplication of definitions (meaning that  
> kernel headers would simply include the userland ones where  
> required). Linus said, that it would break stuff and so is  
> unacceptable.

I seem to remember Linus saying that "breaking things is  
unacceptable", not that the project was guaranteed to break things  
(we would just need to be much more careful about it than most kernel  
patches).  What that seems to indicate to me is that an in-kernel  
version would need to do the following for userspace-accessible  
header files for a large number of kernel releases:

#ifndef _LINUX_HEADER_H
#define _LINUX_HEADER_H
#include <kabi/header.h>
   /* Define or typedef a bunch of __kabi_ prefixes to the old  
prefixes they used to have in the kernel header */
#ifndef __KERNEL__
# warning "The header file <linux/header.h> is deprecated for"
# warning "userspace, please use <kabi/header.h> instead."
#else
   /* Kernel-only declarations/definitions */
#endif

If this were done carefully, all programs that compile against kernel  
headers could be _fixed_ in the short term (they'd go from throwing  
errors to giving a couple deprecation warnings).  In the long term,  
the extra ifdeffery could be removed and the <linux/*.h> headers for  
which a <kabi/*.h> replacement had existed for a couple versions  
could be removed.  New ABIs (including IOCTLs, new syscalls, etc)  
could be required to use <kabi/*.h> in the first place.

> Unfortunately I must agree with him -- I don't think it is possible  
> to completely avoid duplication of definitions and all tries would  
> lead to breakage of some obscure configurations -- kernel headers  
> sometimes require various magic that should be avoided inside the  
> userland headers at all cost. This means that initially the llh-ng  
> project would need to start as a completely separate entity that  
> would not require the original kernel headers for anything, and  
> only later, after achieving some level of maturity and getting  
> merged into the kernel, would come the time for removing some  
> duplication.

I think that requiring any kind of duplication of effort on that  
large a scale is virtually guaranteed not to work.  It will break  
down and be really painful for a long time.

> And here's where the first problem arises -- llh were so great  
> initially, because they removed a lot of conflicts with glibc, by  
> simply removing 'offending' linux headers and including the glibc  
> counterparts (eg. linux/socket.h would do nothing else, than  
> include sys/socket.h).  Glibc's known for having lots of stuff  
> simply 'hardcoded' into it's own set of headers, and more often  
> than not, people do need to include headers from both places.

1: Ewww, bad glibc!
2: The symbols in kabi/*.h should probably all start with __kabi_

The kernel _internally_ would "#include <kabi/foo.h>" and then  
promptly redefine or typedef all of those objects.  If the kernel or  
GLIBC want a struct renamed, they should #define  
__kabi_name_of_struct name_of_struct just before including the header  
file. We should also kind of frown upon non-libc userspace including  
many <kabi/*.h> files, since if they get included before libc can  
redefine the names to what it wants.

> I don't know about uclibc, but klibc afaik expects a lot more of  
> the linux headers to be present, than glibc does.

Perhaps we should use klibc as our test-case for functional headers,  
then, instead of glibc.

> Hell, if llh-ng is supposed to be a full set of apis, we can't  
> expect any of the headers to come from other places, so if any  
> other app (libcs included) has duplicates, that's too bad for the  
> app, since it's in need of some patching.

The solution to that is to make sure that the new exported kernel  
ABIs always have the __kabi_ prefix, so that we don't smash the  
namespace of various programs.

Cheers,
Kyle Moffett
