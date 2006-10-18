Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422659AbWJRQcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422659AbWJRQcW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422649AbWJRQcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:32:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12479 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422643AbWJRQcT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:32:19 -0400
Date: Wed, 18 Oct 2006 09:32:08 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: dealing with excessive includes
In-Reply-To: <20061018160609.GO29920@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0610180926380.3962@g5.osdl.org>
References: <20061017005025.GF29920@ftp.linux.org.uk>
 <Pine.LNX.4.64.0610161847210.3962@g5.osdl.org> <20061017043726.GG29920@ftp.linux.org.uk>
 <Pine.LNX.4.64.0610170821580.3962@g5.osdl.org> <20061018044054.GH29920@ftp.linux.org.uk>
 <20061018091944.GA5343@martell.zuzino.mipt.ru> <20061018093126.GM29920@ftp.linux.org.uk>
 <Pine.LNX.4.64.0610180759070.3962@g5.osdl.org> <20061018160609.GO29920@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Oct 2006, Al Viro wrote:
> 
> Actually, after reading that code I suspect that get_fs_excl() in there
> is the wrong thing to do.  Why?  Because the logics is all wrong.
> 
> Look what we do under lock_super().  There are two things: ->remount_fs()
> and ->write_super().  Plus whatever low-level filesystems are using
> lock_super() for.

I think this all boils down to the fact that "lock_super()" really is a 
very old and broken interface. It pretty much harks back to the original 
filesystem code, and yes, every "lock_super()" _should_ probably be 
replaced by a lower-level lock.

I think ext2 was already fixed to use its own spinlocks for bitmap 
accesses, although it looks like somebody re-introduced "lock_super()" 
there for xattr handling.

[ Which in turn is probably just a bug, since nothing else uses it, so 
  having a single lock_user() in all of ext2 is almost certainly totally 
  pointless - there is nothing that it actually _protects_ against. I 
  guess it protects against "sync()", but that's pretty much it. ]

That said, I'd rather do any lock_super() cleanup totally _independently_ 
of a include file cleanup. 

So since it's clearly not performance-critical, how about just making it 
be out-of-line in fs/super.c, and turn the header file into just a 
declaration?

			Linus
