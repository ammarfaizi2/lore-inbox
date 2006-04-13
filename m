Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbWDMPB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbWDMPB3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 11:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWDMPB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 11:01:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61900 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750845AbWDMPB2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 11:01:28 -0400
Date: Thu, 13 Apr 2006 08:01:25 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andrew Morton <akpm@osdl.org>, Dan Bonachea <bonachead@comcast.net>,
       linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: pthread-safety bug in write(2) on Linux 2.6.x
In-Reply-To: <443DE2BD.1080103@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0604130750240.14565@g5.osdl.org>
References: <6.2.5.6.2.20060412173852.033dbb90@cs.berkeley.edu>
 <20060412214613.404cf49f.akpm@osdl.org> <443DE2BD.1080103@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Apr 2006, Nick Piggin wrote:
> 
> Didn't Linus explicitly made the decision not to add synchronisation for
> writes with the same file?

I would be _very_ nervous to do it, yes. In particular, I do not consider 
it at all unlikely to have something database-like that does concurrent 
writes to the same file at different offsets, and serializing them on the 
VFS layer seems pretty broken. 

Also, doing it unconditionally in the VFS layer is actually pretty 
seriously broken: the VFS layer doesn't even know what kind of file it is, 
and locking on writes can be literally the wrong thing for some file 
descriptors (think pipes or sockets: if we have one blocking write holding 
the lock, that should _not_ imply that other - possibly nonblocking - 
writes shouldn't be able to call in to the low-level write handler).

That said, I wouldn't be 100% against it, especially under certain 
circumstances. However, the circumstances when I think it might be 
acceptable are fairly specific:

 - when we use f_pos (ie we'd synchronize write against write, but only 
   per "struct file", not on an inode basis)
 - only for files that are marked seekable with FMODE_LSEEK (thus avoiding 
   the stream-like objects like pipes and sockets)

Under those two circumstances, I'd certainly be ok with it, and I think we 
could argue that it is a "good thing". It would be a "f_pos" lock (so we 
migt do it for reads too), not a "data lock".

Comments?

		Linus
