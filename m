Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269363AbUIYRLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269363AbUIYRLs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 13:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269365AbUIYRLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 13:11:48 -0400
Received: from dp.samba.org ([66.70.73.150]:42216 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S269363AbUIYRLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 13:11:45 -0400
Date: Sat, 25 Sep 2004 10:11:04 -0700
From: Jeremy Allison <jra@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
       Jeremy Allison <jra@samba.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6] smbfs & "du" illness
Message-ID: <20040925171104.GN580@jeremy1>
Reply-To: Jeremy Allison <jra@samba.org>
References: <20040917205422.GD2685@bouh.is-a-geek.org> <Pine.LNX.4.58.0409250929030.2317@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409250929030.2317@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 09:41:59AM -0700, Linus Torvalds wrote:
> 
> I hate to say so, but Jeremy is a git in this case.

Thanks, I prefer POSIX fascist myself :-).

> And yes, that's a _fixed_ blocksize. When you use "stat()", and you look 
> at "st_blocks", it's ALWAYS in 512-byte entities. It doesn't matter that 
> "st_blksize" might be something else - when UNIX counts blocks, it counts 
> them in 512-byte chunks.

st_blocks and st_blksize are not in the POSIX spec
(I have one on my desk, and stroke it occasionally :-)
Besides which, on HPUX (which these extensions were
first created for) it returns st_blocks in 8192 byte
units, not 512, so your claim is incorrect.

That's why I got so pissed with the extensions spec
as it didn't specify a unit size. Rather an assume
"all the world is 512" which is plainly wrong, I
decided to make it a unit of bytes on the wire.
The client can then return in the correct blocksize
for it's own system.

> I'm claiming that samba is broken, and we should not try to fix it on the
> client side.  We should ask the samba people to get their act together.  
> They've apparently been able to put _two_ bugs in one single integer:  
> both messing up the block size _and_ then using a totally illogical
> minimum value for the thing.

Well the minimum value is for Windows clients. They go a *lot*
faster with the minimum value as it tweaks some of their internal
buffers when they allocate. You can parameterize it (admittedly at
compile time, not runtime). I can make it runtime parameterized
in a later smbd if you want.

The CIFS client needs to divide the value returned by 512, or
whatever blocksize is being used on the UNIX clients. When
we have a 64-bit space it makes sense to return the absolute
bytes and let the client return it to userspace in whatever blocksize
it wants.

> I bet the minimum value comes from the fact that all files end up using 
> "n" bytes for things like inodes etc. Let's make up some numbers, and 
> assume that somebody thought that the minimum disk-space used was 2kB. 
> Instead of dividing that by 512, and coming up with the value "4", they 
> multiplied it by the block size and came up with the value 1Mb.

Nope. We have strange reasons for things, but they're usually
not *that* strange.

> Whatever the reason, the minimum size is clearly a samba bug, even if you 
> were to (incorrectly, Jeremy) claim that there is no standard blocksize.

It's a Samba *feature* :-). But I agree for UNIX/Linux clients
it doesn't make much sense.

Jeremy.
