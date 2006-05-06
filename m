Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbWEFQ6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbWEFQ6G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 12:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbWEFQ6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 12:58:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2230 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750966AbWEFQ6E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 12:58:04 -0400
Date: Sat, 6 May 2006 09:57:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Michael Halcrow <lkml@halcrow.us>, penberg@cs.helsinki.fi,
       shaggy@austin.ibm.com, dhowells@redhat.com,
       phillip@hellewell.homeip.net, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, jmorris@namei.org, sct@redhat.com, ezk@cs.sunysb.edu
Subject: Re: [PATCH 10/13: eCryptfs] Mmap operations
In-Reply-To: <20060506094228.25fcda1b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0605060948150.16343@g5.osdl.org>
References: <84144f020605040813q29fcddcr1c846d27cf156432@mail.gmail.com>
 <20060504031755.GA28257@hellewell.homeip.net> <20060504034127.GI28613@hellewell.homeip.net>
 <23514.1146779003@warthog.cambridge.redhat.com> <1146842548.10109.27.camel@kleikamp.austin.ibm.com>
 <1146843528.11271.1.camel@localhost> <20060505192148.e2c968b7.akpm@osdl.org>
 <20060506160044.GA8209@halcrow.us> <20060506094228.25fcda1b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 6 May 2006, Andrew Morton wrote:
> 
> Note that the pagefault handlers do still do a second readpage().  The
> comment implies that this is an open-coded attempt to recover from an I/O
> error.  I do recall that a year or so ago we discussed taking out that
> second readpage attempt, but Linus had good-sounding reasons for keeping
> it.  But I forget what they were.  Perhaps he can remind me?

All the non-readahead read paths - not just page faults, but certainly 
things like the generic file read routines - will do (at least they 
_should_ do) a "readpage()" if they find a page that is not up-to-date 
after they've gotten the lock.

That's basically just what the PG_uptodate flag means. If that flag isn't 
set, you need to ->readpage() the contents, whether you allocated the page 
yourself or not.

But nobody should ever do two readpages on their OWN. If readpage() fails, 
you should return -EIO (or whatever), and the page will be left 
not-up-to-date. But you do need to be able to accept the fact that a 
_previous_ read-page failed.

And yes, it happens in practice. Networked filesystems, for example. The 
previous person to try to read might have gotten a permission error. The 
same is true of any kind of security scheme where the "read()" checks may 
not match the "open()" security.

It's also true of read errors. You don't want to have the kernel re-try 
them forever, but on the other hand, you do NOT want to keep the page as 
an "error" forever without trying again. The read error could have been 
because the user had removed the media (or not closed the door properly), 
or anything else that the user could actually fix manually, and re-do the 
operation, and it would work.

Not all read errors are final. So we shouldn't consider them final.

		Linus
