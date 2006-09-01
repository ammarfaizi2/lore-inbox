Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWIAS3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWIAS3k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 14:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWIAS3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 14:29:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45221 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750732AbWIAS3j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 14:29:39 -0400
Date: Fri, 1 Sep 2006 11:28:54 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Andreas Hobein <ah2@delair.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Roland McGrath <roland@redhat.com>, Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: Trouble with ptrace self-attach rule since kernel > 2.6.14
In-Reply-To: <20060901004920.7643a40e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0609011117440.27779@g5.osdl.org>
References: <200608312305.47515.ah2@delair.de> <200609010936.39015.ah2@delair.de>
 <20060901004920.7643a40e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 1 Sep 2006, Andrew Morton wrote:
> On Fri, 1 Sep 2006 09:36:38 +0200
> Andreas Hobein <ah2@delair.de> wrote:
>
> > There is also a reply from Roland McGrath (see 
> > http://lkml.org/lkml/2005/11/9/460) who mentioned that there may occur some 
> > problems in "some real programs out there". May be I'm the first one who is 
> > affected by this new behaviour.
> 
> When you have names, please cc them..

Andreas isn't the first, but in the almost-a-year that the patch has been 
part of the kernel, he's the second.

And for the first one I found a reasonable way to avoid the problem: the 
debugging thread can do a "vfork()" (or, if vfork() does something bad in 
libc, do the direct "clone(CLONE_VFORK|CLONE_MM)" thing) to have a new 
thread that is in a _different_ thread group, but is able to ptrace and 
also is "synchronized" with the VM, simply because it shares it with all 
the other threads it might want to debug.

That "new" (last November) check isn't likely going away. It solved _so_ 
many problems (both security and stability), and considering that

 (a) in a year, only two people have ever even _noticed_
 (b) there's a work-around as per above that isn't horribly invasive

I have to say that in order to actually go back to the old behaviour, we'd 
have to have somebody who cares _deeply_, go back and check every single 
special case, deadlock, and race. 

Not allowing ptracing to send signals and be part of the same thread group 
really got rid of a _lot_ of complexity (and bugs - I don't mind 
complexity per se, but complexity that was known broken and nobody could 
really see a good solution for, and had both security and stability 
implications is a bad bad thing).

But if somebody does feel that "deep caring feeling", I'll try to help 
them. Maybe Roland and Oleg Nesterov might lend a hand too (Oleg in 
particular by now probably knows all the races in that area, including 
pthread parents sending signals to its own thread and de-parenting etc).

Hint, hint, Andreas. But I think it's a rats' nest, and you'd be better 
off trying the CLONE_MM|CLONE_VFORK approach.

Oleg (now added to the Cc) in particular may answer authoritatively 
whether maybe his fixes since last year have fixed some of the problems, 
or whether they do indeed depend even more on the fact that the ptrace 
"fake parent" cannot be in the same thread group.

(Even if we could make it work, I personally much prefer the fact that a 
ptrace parent is forced to behave more like a "real parent" - who also 
cannot be in the same thread group).

		Linus
