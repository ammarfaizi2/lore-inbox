Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315042AbSDWDbH>; Mon, 22 Apr 2002 23:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315043AbSDWDbC>; Mon, 22 Apr 2002 23:31:02 -0400
Received: from zok.SGI.COM ([204.94.215.101]:38607 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S315042AbSDWDbB>;
	Mon, 22 Apr 2002 23:31:01 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] race in request_module() 
In-Reply-To: Your message of "Mon, 22 Apr 2002 20:49:40 -0400."
             <Pine.GSO.4.21.0204222027360.5686-100000@weyl.math.psu.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 23 Apr 2002 13:30:49 +1000
Message-ID: <10621.1019532649@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Apr 2002 20:49:40 -0400 (EDT), 
Alexander Viro <viro@math.psu.edu> wrote:
>	Looks like request_module() has quite a few problems:
>
>* there is no way to distinguish between failing modprobe and successful
>  one followed by rmmod -a (e.g. called by cron).  For one thing, we
>  don't pass exit value of modprobe to caller of request_module().

There is no such thing as a failing modprobe.  It either works and the
module is loaded or modprobe does not work and the module is not
loaded.  This excludes the case where a module oops during init, but
that is not what you are worried about.

When a module is loaded, it is marked !MOD_USED_ONCE.  An explicit
rmmod will get rid of the module but rmmod -a will not.  rmmod -a will
not remove a module unless __MOD_INC_USE_COUNT has been issued on the
module at least once, or the module is loaded to satisfy unresolved
symbols from another module.

Rusty and I have a completely new design for module loading and
unloading in 2.5, we believe it is race free.  I do not have time to
work on the new design until I have got kbuild 2.5 into the kernel.

