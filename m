Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbUK0VDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbUK0VDp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 16:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbUK0VDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 16:03:45 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:11392 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261329AbUK0VCV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 16:02:21 -0500
Date: Sat, 27 Nov 2004 22:03:31 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, hch@infradead.org, matthew@wil.cx, dwmw2@infradead.org,
       aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041127210331.GB7857@mars.ravnborg.org>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
	torvalds@osdl.org, hch@infradead.org, matthew@wil.cx,
	dwmw2@infradead.org, aoliva@redhat.com, linux-kernel@vger.kernel.org,
	libc-hacker@sources.redhat.com
References: <19865.1101395592@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19865.1101395592@redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2004 at 03:13:12PM +0000, David Howells wrote:
> 
> We've been discussing splitting the kernel headers into userspace API headers
> and kernel internal headers and deprecating the __KERNEL__ macro. This will
> permit a cleaner interface between the kernel and userspace; and one that's
> easier to keep up to date.
> 
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

If we go for some resturcturing of include/ then we should get rid of
the annoying asm symlink. Following layout deals with that:

include/<arch>/asm		<= Files from include/asm-<arch>
include/<arch>/mach*		<= Files from include/mach-*

This layout solve the symlink issue in an elegant way.
We need to do trivial changes to compiler options to make it work. Changing
compiler options is much more relaible than using symlinks.

Then the userspace part would then be located in:
include/<arch>/user-asm

Userspace shall not be 'allowed' to include files from asm-generic direct,
but asm-generic shall be part of the userspace api.


>  (2) Take each file from the shadowed directory. If it has any userspace
>      relevant stuff, then:
> 
>      (b) Make kernel file #include the user file. So:
> 
> 		[include/asm-i386/unistd.h]
> 		...
> 		#include <user-i386/unistd.h>
In example above it would become:
 		#include <user-asm/unistd.h>

With repsect to consistency of the userspace header files then we could define
a few simple rules:
1) Files in include/user must be able to compile standalone - so they include
   all files they need.
2) They are not allowed to use any files outside the kernel
3) Must not use __KERNEL__ in any place

Writing a small script / Makefile that does these checks should be trivial.
Jörn wrote something similar for include/linux at one point in time.
If it is fast then we just let it be part of the standard compile so it is
checked often.

	Sam
