Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbUCJCr0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 21:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbUCJCqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 21:46:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:57318 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261454AbUCJCqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 21:46:44 -0500
Date: Tue, 9 Mar 2004 18:53:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adam Sampson <azz@us-lot.org>
cc: urban@teststation.com, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: smbfs Oops with Linux 2.6.3
In-Reply-To: <20040310013933.GA19137@cartman.at.fivegeeks.net>
Message-ID: <Pine.LNX.4.58.0403091836410.1092@ppc970.osdl.org>
References: <20040310013933.GA19137@cartman.at.fivegeeks.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Mar 2004, Adam Sampson wrote:
> 
> I use smbfs on my x86 Linux 2.6.3 machine to mount filesystems from a
> (Debian) Samba 3.0.0beta2 server. This has worked fine with both this
> kernel and previous ones for the last few months, but I've just had an
> Oops message while trying to open a directory with ROX-Filer. The
> filesystem in question is automounted (using autofs4), and this would
> have been the first operation upon it after being mounted.

Hmm.. Looks like an indirect call that jumped through a NULL pointer.

There's a few different indirect calls in "smb_readdir()", so it's a bit 
hard to guess which one. It's at the end of the function, but gcc 
re-orders code so much (and usually wrong, I have to say), that it's hard 
to guess which one it would be.

Three out of four calls are to "readdir()", which is an argument to the 
function and should not really reasonably be NULL unless there is a 
compiler bug or some _major_ stack corruption going on. So I consider 
those to be the less likely causes.

The last one is to "server->ops->readdir()", and it's entirely possible 
that that might be NULL. That's reinforced by the data on the stack 
which would be the arguments to that function:

	c5107840 cf84bfa0 c0165560 cf84bf2c

which makes some amount of sense (arg 2 and 4 are both pointing to the
call-stack, which I think is correct for those arguments if it is that
"->readdir()" call). In contrast, the above would _not_ make sense as the
four first arguments to "filldir" (the third one should be a name length).

So I think you had a NULL pointer for "server->ops->readdir".

As to how something like that could happen, I have absolutely no clue. The 
"smb_install_null_ops()" would seem to cause that, but that's all I can 
say.

Maybe the "smp_ops_null" thing should be filled in with stuff that always
returns EINVAL or something? Rather than actual NULL pointers that will
oops if they are ever used?

(That structure is actually from Andrew's patch from Zwane Mwaikambo 
as a workaround for smb_proc_getattr oops from last summer)

Urban? Andrew? Zwane? I can decode the oopses, but when it comes to smbfs 
I'm a retard.

		Linus
