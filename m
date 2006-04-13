Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWDMXDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWDMXDT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWDMXDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:03:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6044 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751176AbWDMXDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:03:18 -0400
Date: Thu, 13 Apr 2006 16:03:06 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dan Bonachea <bonachead@comcast.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: pthread-safety bug in write(2) on Linux 2.6.x
In-Reply-To: <6.2.5.6.2.20060413145913.03436f38@comcast.net>
Message-ID: <Pine.LNX.4.64.0604131553430.3701@g5.osdl.org>
References: <6.2.5.6.2.20060412173852.033dbb90@cs.berkeley.edu>
 <20060412214613.404cf49f.akpm@osdl.org> <443DE2BD.1080103@yahoo.com.au>
 <Pine.LNX.4.64.0604130750240.14565@g5.osdl.org> <1144965022.12387.23.camel@localhost.localdomain>
 <6.2.5.6.2.20060413145913.03436f38@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Apr 2006, Dan Bonachea wrote:
>
> 2.9.7 Thread Interactions with Regular File Operations
> All of the functions chmod( ), close( ), fchmod( ), fcntl( ), fstat( ),
> ftruncate( ), lseek( ), open( ), read( ), readlink( ), stat( ), symlink( ),
> and write( ) shall be atomic with respect to each other in the effects
> specified in IEEE Std 1003.1-2001 when they operate on regular files. If two
> threads each call one of these functions, each call shall either see all of
> the specified effects of the other call, or none of them.
> 
> Unless I'm missing something, that doesn't leave much ambiguity regarding
> what's required for POSIX compliance on this issue (although I'm not sure
> POSIX compliance is the right metric).

Interesting. That's certainly not something we've guaranteed. My suggested 
patch makes read/write on the same file descriptor atomic wrt each other, 
but does not serialize them wrt different file descriptors (even if it's 
the same file). So you could see "half a write" from another read, for 
example, or fstat() could easily return the half-way file size for a write 
that hasn't completed.

Quite frankly, being totally atomic wrt each other seems unreasonable. 
Having fstat take the inode lock between threads is insane. It's 
definitely not even something you'd _want_ between processes (ie if 
somebody is doing a 2GB write, you want to be able to do an "ls" to see 
the file grow!), doing it between threads would just be insane.

Or maybe the "effects specified in IEEE Std 1003.1-2001" is really about 
the _other_ effects (ie things like write clearing SUID bits, atime/mtime 
etc).

So it smells like POSIX is broken here, in that it expects bad behaviour 
that isn't sane. But a subset of it would potentially be sane (ie exactly 
that write/write or write/read atomicity on the same file _descriptor_, 
exactly because they share f_pos).

		Linus
