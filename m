Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264585AbUHJMbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264585AbUHJMbx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 08:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264665AbUHJMbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 08:31:53 -0400
Received: from smtp.rol.ru ([194.67.21.9]:29867 "EHLO smtp.rol.ru")
	by vger.kernel.org with ESMTP id S264585AbUHJMZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 08:25:27 -0400
Message-ID: <4118BF51.8030303@vlnb.net>
Date: Tue, 10 Aug 2004 16:28:01 +0400
From: Vladislav Bolkhovitin <vst@vlnb.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: ru, en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86 bitops.h commentary on instruction reordering
References: <20040805200622.GA17324@logos.cnet> <411392E0.6080507@vlnb.net>	 <20040806143359.GC20911@logos.cnet> <4113A579.5060702@vlnb.net>	 <20040806155328.GA21546@logos.cnet> <4113B752.7050808@vlnb.net>	 <20040806170931.GA21683@logos.cnet> <411794E8.6000806@vlnb.net>	 <20040809155009.GB6361@logos.cnet> <4117B5DB.7060602@vlnb.net>	 <20040809183437.GD6361@logos.cnet>  <4117DAA0.1020601@vlnb.net> <1092086514.14770.7.camel@localhost.localdomain>
In-Reply-To: <1092086514.14770.7.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> On Llu, 2004-08-09 at 21:12, Vladislav Bolkhovitin wrote:
> 
>>Well, Marcelo, sorry if I'm getting too annoying, but we had a race with 
>>cache coherency during SCST (SCSI target mid-level) development. We 
>>discovered that on P4 Xeon after atomic_set() there is very small 
>>window, when atomic_read() on another CPUs returns the old value. We had 
>>to rewrite the code without using atomic_set(). Isn't it cache coherency 
>>issue?
> 
> atomic_set/atomic_read are _atomic_ operations. Nothing is said about
> ordering. You get old or new but not half and half. Two atomic_inc's
> will both occur and so on.
> 
> If you want ordering you need locks otherwise there is nothing defining
> the time order of both processors.
> 
> How can you even measure such a window without locking to know what the
> state of the processors is ?

We didn't measure it, we just had lockup. In our code in the commands 
serialization we have two paths: the regular (fast) one, where the 
atomic value is equal to current value and there are no locks used, 
because only one command can be on the fast path, and the slow one, 
where the atomic and the current values are different, so lock used to 
perform all necessary job. After the fast path the atomic value gets 
incremented together with some checks on it. We used to use atomic_set() 
here and sometimes had lockup.

>>And, BTW, returning to the original topic, would it be better to make 
>>set_bit() and friends guarantee not to be reordered on all 
>>architectures, instead of just add the comment. Otherwise, what is the 
> 
> 
> x86 and some other platforms have certain ordering guarantees. set_bit
> doesn't guarantee them but it happens to unavoidably work for most
> (ab)uses.

So, seems there is no difference between operations with and without 
"__" prefix (like set_bit() and __set_bit()) now? Maybe, it's worth to 
leave only one version of them?

>>right thing? In some places in SCST we heavy rely on non-ordering 
>>guarantees.
> 
> 
> Then you will get burned on most hardware.

Designing that we also be guided by the comments, which turned out to be 
misleading :).

Actually, I feel it would be perfect if someone wrote a document, where 
he described various issues with using atomic variables and bit 
operations on various architectures, like some FAQ. For example, this 
thread has at least several good questions and answers. Also, I can add 
one more question: for an user it could be non-obvious why 
smp_mb__after_atomic_*() and friends needed. This document wouldn't be 
big, so it didn't take too much time to write it, but it would help a 
*lot* for people who wish to write portable code.

Thanks,
Vlad

