Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262908AbUKRTXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262908AbUKRTXI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 14:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262929AbUKRTVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 14:21:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:9947 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262911AbUKRTQn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 14:16:43 -0500
Date: Thu, 18 Nov 2004 11:16:31 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
cc: hbryan@us.ibm.com, akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
In-Reply-To: <E1CUrS0-0004Hi-00@dorka.pomaz.szeredi.hu>
Message-ID: <Pine.LNX.4.58.0411181108140.2222@ppc970.osdl.org>
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com>
 <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org>
 <E1CUquZ-0004Az-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411181027070.2222@ppc970.osdl.org>
 <E1CUrS0-0004Hi-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Nov 2004, Miklos Szeredi wrote:
> 
> Will the clients be allowed to fill up the _whole_ memory with dirty
> pages?

Sure. It's not a situation that is easy to get into, but it's a nasty 
case.

> Page writeback will start sooner than that, and then the
> client will not be able to dirty more pages until some are freed.

Ehh - the _CPU_ handles dirtying pages all on its own. The OS never even 
knows that a page got dirtied, so "starting writeout early" is not much of 
an option.

We actually had (for a short while) code that tracked the dirty bit in 
software (ie make it unwritable by default, and take the write fault), but 
people showed that that was actually a real performance problem on some 
loads.

> BTW, I've never myself seen a deadlock, and I've not had any report of
> it.

Almost nobody uses shared writable mappings. Certainly not on "odd" 
things. They are historically used by things like innd for the active 
file, by some odd applications that want to do their own memory 
management, and by databases. That's pretty much it.

So it's entirely possible that you have never even _seen_ a shared 
writable mapping even if you stressed the filesystem very hard. They 
really are that rare.

There's a few VM testers out there that do nasty things with writable 
shared mappings. You could try them just for fun, but personally, if we 
are seriously talking about merging FUSE, I'd actually prefer for writable 
mappings to not be supported at all.

It wouldn't be the only filesystem that doesn't support the thing. I think 
even NFS didn't support them until I did the pagecache rewrite. Nobody 
really complained (well, _very_ few did).

IOW, from a merging standpoint, simple really _is_ better. Even if you
really really want to use exotic features like "direct IO" and writable
mappings some day, let's just put it this way: it's a lot easier to merge
something that has no questions about strange cases, and then _later_ add
in the strange cases, than it is to merge it all on day #1.

I'm a sucker. Ask anybody. I'll accept the exact same patch that I
rejected earlier if you just do it the right way. I'm convinced that some
people actually do it on purpose just for the amusement value ("Look, he
did it _again_. What a doofus!")

		Linus
