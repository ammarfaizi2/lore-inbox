Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269361AbUIYQmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269361AbUIYQmM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 12:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269362AbUIYQmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 12:42:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:32441 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269361AbUIYQmF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 12:42:05 -0400
Date: Sat, 25 Sep 2004 09:41:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
       Jeremy Allison <jra@samba.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6] smbfs & "du" illness
In-Reply-To: <20040917205422.GD2685@bouh.is-a-geek.org>
Message-ID: <Pine.LNX.4.58.0409250929030.2317@ppc970.osdl.org>
References: <20040917205422.GD2685@bouh.is-a-geek.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 17 Sep 2004, Samuel Thibault wrote:
> 
> But I discussed about it with samba people (see
> http://lists.samba.org/archive/samba-technical/2004-September/thread.html
> "Unix Extension & "du"" subject), and they told that they modified
> it into bytes because there was no block size specified.

I hate to say so, but Jeremy is a git in this case.

There's definitely a very standard UNIX blocksize, and it's 512.

And yes, that's a _fixed_ blocksize. When you use "stat()", and you look 
at "st_blocks", it's ALWAYS in 512-byte entities. It doesn't matter that 
"st_blksize" might be something else - when UNIX counts blocks, it counts 
them in 512-byte chunks.

So complaining that you don't have a blocksize is just silly.

This is a fairly common thinko, btw. Many people see "st_blocks" and
"st_blksize" in the UNIX stat info, and they think that they are defined
in terms of each other, and that disk usage is "st_blocks*st_blksize"  
bytes. Not so. Disk usage is "st_blocks*512" bytes, and "st_blksize" is
something totally different - it's the _preferred_ IO blocking factor.

So let's all repeat after me: UNIX file "blocksize" is 512. It's not a
question of whether that value makes sense these days or not, it's just a
matter of simple _fact_.

> Some conservative way of correcting it is the following:

Since that won't fix "du" _anyway_, I think it's pointless. As you point 
out:

> Now another trouble is that samba people also use a minimum of 1Mo
> (hence the number in the above fstat result). I'm not sure what to do
> with this: should we then use file size which we divide into sectors
> ourselves ? Or should we keep 1Mo, getting some strange results to some
> extent ?

I'm claiming that samba is broken, and we should not try to fix it on the
client side.  We should ask the samba people to get their act together.  
They've apparently been able to put _two_ bugs in one single integer:  
both messing up the block size _and_ then using a totally illogical
minimum value for the thing.

I bet the minimum value comes from the fact that all files end up using 
"n" bytes for things like inodes etc. Let's make up some numbers, and 
assume that somebody thought that the minimum disk-space used was 2kB. 
Instead of dividing that by 512, and coming up with the value "4", they 
multiplied it by the block size and came up with the value 1Mb.

Whatever the reason, the minimum size is clearly a samba bug, even if you 
were to (incorrectly, Jeremy) claim that there is no standard blocksize.

			Linus
