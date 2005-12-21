Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbVLUPhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbVLUPhQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 10:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbVLUPhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 10:37:15 -0500
Received: from smtpout.mac.com ([17.250.248.97]:13051 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932439AbVLUPhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 10:37:14 -0500
In-Reply-To: <dobr1u$19t$1@sea.gmane.org>
References: <20051218231401.6ded8de2@werewolf.auna.net> <43A77205.2040306@rtr.ca> <20051220133729.GC6789@stusta.de> <170fa0d20512200637l169654c9vbe38c9931c23dfb1@mail.gmail.com> <BAYC1-PASMTP01F075F44E45AA32F0DF85AE3E0@CEZ.ICE> <dobr1u$19t$1@sea.gmane.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2C2D8A91-7BD7-4181-B054-E82A279AF51D@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: About 4k kernel stack size....
Date: Wed, 21 Dec 2005 10:37:07 -0500
To: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 21, 2005, at 10:07, Giridhar Pemmasani wrote:
> Sean wrote:
>
>> I for one hope those silly bastards using ndiswrapper fix up that  
>> code to
>                        ^^^^^^^^^^^^^^
> It is despicable that some of the proponents of this 4k-only stack  
> size have resorted to such epithets.


> As I see, although people that rely on ndiswrapper (since there is  
> no other way they could use the hardware that they have) will not  
> be able to use their wireless cards when this patch gets merged  
> without having to patch the kernel, only a few comments have been  
> raised about it.

Not true.  This is (IIRC) the _third_ flamewar during which a large  
proportion of the comments were either directly or indirectly one of  
the following: "You are intentionally breaking ndiswrapper", "What's  
wrong with having an 8k option?", and "This makes things more-fragile  
or isn't well tested".

> There are other people that have raised concern not related to  
> ndiswrapper. Branding everyone that is raising a concern about this  
> patch into one group and calling them names is pathetic and  
> despondent.

To date, all of the above concerns have been addressed:

"You are intentionally breaking ndiswrapper":
    Yes, we know, and we don't care, because it's a bad solution and  
already broken. (12k windows stacks, preempt, etc).  If it matters to  
you, go fix it permanently (which I gather you are already trying to  
do, good work).

"What's wrong with having an 8k option?":
    It complicates the code, it means that bugs do not get reported  
because disabling 4k (or enabling 8k) fixes it, and this is the only  
excuse for the askers of the third question.  It also makes things  
more fragile because it means we need per-process order-1 allocations  
instead of order-0 allocations.  This option also makes crashes much  
harder to reproduce depending on interrupt load and a wide variety of  
other factors.  This means that _users_ may see no problem with an 8k  
option, but to the developers it's not such a great idea.

"This makes things more-fragile or isn't well tested.":
    Not true!  With the current situation in -mm, there are _0_  
unresolved 4k-stacks bugs.  If you have a problem, please report it  
so we can get it fixed.  However, since this does have technical  
advantages (see above), we want to _force_ this option _in_-mm_,  
*precisely* so we can get it better tested and work out the few  
remaining bugs.  Furthermore, this does *not* change the overall  
amount of stack!  8k == 4k + 4k!!!  It only makes stack overflows  
guaranteed and easy to debug in the specific call scenarios (instead  
of making them probabilistic and hard to reproduce).

> And supporting private stacks, as some people have suggested, may  
> be possible in theory, but it is _very hard_, considering that  
> Windows uses different calling conventions (fastcall, stdcall,  
> cdecl) and a driver can use more than one thread.

Windows drivers like that using more than one thread are basically  
inherently racy under current Linux, and probably would not handle  
preemption at all.  If some mess like that breaks due to any in- 
kernel change, you get to keep all 42 pieces.

> It is futile on this thread to suggest to someone to come up with a  
> patch to implement private stacks in such an environment. And let  
> me also repeat that I have been working on implementing NDIS in  
> user space, although there are few issues with that too.

Great, you will probably make a lot of people happy with that.

Cheers,
Kyle Moffett

--
Simple things should be simple and complex things should be possible
   -- Alan Kay



