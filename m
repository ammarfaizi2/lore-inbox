Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263040AbUK0CEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbUK0CEg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 21:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbUK0Bps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 20:45:48 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263041AbUKZTif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:38:35 -0500
Date: Thu, 25 Nov 2004 16:54:33 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, hch@infradead.org, matthew@wil.cx, dwmw2@infradead.org,
       aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
References: <19865.1101395592@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19865.1101395592@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2004 at 03:13:12PM +0000, David Howells wrote:
> We've been discussing splitting the kernel headers into userspace API headers
> and kernel internal headers and deprecating the __KERNEL__ macro. This will
> permit a cleaner interface between the kernel and userspace; and one that's
> easier to keep up to date.

I am fully in support of both this idea and the current implementation
you have described below.

> What we've come up with is this:
> 
>  (1) Create new directories in the linux sources to shadow existing include
>      directories:
> 
> 	NEW DIRECTORY		DIRECTORY SHADOWED
> 	=============		==================
> 	include/user/		include/linux/
> 	include/user-*/		include/asm-*/
> 
>      Note that this doesn't take account of the other directories under
>      include/, but I don't think they're relevant.

I think they may be.  If they are, they can be accommodated.  For example:

	include/user-scsi/	include/scsi/
	include/user-net/	include/net/
	include/user-rxrpc/	include/rxrpc/

etcetera.  This only creates a conflict if someone creates a directory
foo that also clashes with asm-foo.  And if someone does propose that,
we just kill them.  Easy.

>      (d) stdint types should be used where possible.
> 
> 		[include/user-i386/termios.h]
> 		struct winsize {
> 			uint16_t ws_row;
> 			uint16_t ws_col;
> 			uint16_t ws_xpixel;
> 			uint16_t ws_ypixel;
> 		};

I really hate stdint.  Can't we use __u16 instead?

>      (e) These header files should be bounded with __USER_XXXXX_H conditionals:
> 
> 		[include/user-i386/termios.h]
> 		#ifndef __USER_I386_TERMIOS_H
> 		#define __USER_I386_TERMIOS_H
> 		...
> 		#endif /*  __USER_I386_TERMIOS_H */
> 
>  (3) Remove all #if(n)def __KERNEL__ clauses.
> 
>  (4) Remove the -D__KERNEL__ from the master kernel Makefile.
> 
>  (5) For userspace use (such as for glibc), the appropriate include/user*/
>      directories should be selected and installed in /usr/include/ or wherever,
>      and symlinks made. For example, on i386 arch boxes, you might find:
> 
> 	SOURCE			INSTALLED AS
> 	======================	============
> 	include/user/		/usr/include/user/
> 	include/user-i386/	/usr/include/user-i386/
> 				/usr/include/linux -> user
> 				/usr/include/asm -> user-i386

This proposal doesn't address the asm-generic problem directly.  Can I
presume that you intend to also create linux/include/user-generic, install
it as /usr/include/user-generic and create an asm-generic symlink that
points to user-generic?  A good problem file to be dealt with would
be asm/errno.h

>  (6) On multi-arch archs (such as ppc64 which can also support ppc), you might
>      find:
> 
> 	SOURCE			INSTALLED AS
> 	======================	============
> 	include/user/		/usr/include/user/
> 	include/user-ppc/	/usr/include/user-ppc/
> 	include/user-ppc64/	/usr/include/user-ppc64/
> 				/usr/include/linux -> user
> 				/usr/include/asm-ppc -> user-ppc
> 				/usr/include/asm-ppc64 -> user-ppc64
> 
>      And then /usr/include/asm/ might contain files that do arch-size dependent
>      switching between user-ppc and user-ppc64.

ppc might want to consider following the lead of parisc, s390 and mips
and unify at least their header files, if not their arch directory.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
