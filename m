Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261771AbUK2UFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbUK2UFO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 15:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbUK2UD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 15:03:58 -0500
Received: from hera.kernel.org ([63.209.29.2]:50905 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261776AbUK2UBy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 15:01:54 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Date: Mon, 29 Nov 2004 20:01:39 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <cofv73$us3$1@terminus.zytor.com>
References: <19865.1101395592@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1101758499 31620 127.0.0.1 (29 Nov 2004 20:01:39 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 29 Nov 2004 20:01:39 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <19865.1101395592@redhat.com>
By author:    David Howells <dhowells@redhat.com>
In newsgroup: linux.dev.kernel
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
> 

I'm not sure if user is a good choice, and user-* is even worse.  Most
people seem to have suggested include/linux-abi for this; I would
personally prefer include/linux-abi/arch for the second.

>  (2) Take each file from the shadowed directory. If it has any userspace
>      relevant stuff, then:
> 
>      (a) Transfer this stuff into a file of the same name in the new
> 	 directory. So, for example, the syscall number list from
> 	 include/asm-i386/unistd.h will be transferred to
> 	 include/user-i386/unistd.h.

I'm not sure you can do such a 1:1 mapping.  In fact, there are cases
where you definitely don't want to, because the current structure
doesn't make much sense.

> 
>      (b) Make kernel file #include the user file. So:
> 
> 		[include/asm-i386/unistd.h]
> 		...
> 		#include <user-i386/unistd.h>
> 		...

Good...

>      (c) Where a user header file requires something from another header file
> 	 (such as a type), that file should include a suitable user header file
> 	 directly:
> 
> 		[include/user-i386/termio.h]
> 		...
> 		#include <user/types.h>
> 		...

Good...

>      (d) stdint types should be used where possible.
> 
> 		[include/user-i386/termios.h]
> 		struct winsize {
> 			uint16_t ws_row;
> 			uint16_t ws_col;
> 			uint16_t ws_xpixel;
> 			uint16_t ws_ypixel;
> 		};

Good, except your "struct winsize" is bad; you're stepping on
namespace which belongs to userspace.  Since we can't use typedefs on
struct tags, I suggest:

struct __kstruct_winsize {
       /* ... */
};

.. and userspace can do:

#define __kstruct_winsize winsize

>      (e) These header files should be bounded with __USER_XXXXX_H conditionals:
> 
> 		[include/user-i386/termios.h]
> 		#ifndef __USER_I386_TERMIOS_H
> 		#define __USER_I386_TERMIOS_H
> 		...
> 		#endif /*  __USER_I386_TERMIOS_H */

Good...

>  (3) Remove all #if(n)def __KERNEL__ clauses.
> 
>  (4) Remove the -D__KERNEL__ from the master kernel Makefile.

Bad!  There is code in the kernel which can compile in userspace for
testing.  This is highly valuable and should be kept.

	-hpa
