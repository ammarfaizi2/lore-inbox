Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751492AbVJLSRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbVJLSRq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 14:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbVJLSRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 14:17:45 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:1184 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751489AbVJLSRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 14:17:44 -0400
Message-ID: <434D533C.6030901@us.ibm.com>
Date: Wed, 12 Oct 2005 14:17:32 -0400
From: Janak Desai <janak@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: chrisw@osdl.org, viro@ZenIV.linux.org.uk, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] New System call unshare (try 2)
References: <Pine.WNT.4.63.0510121201540.1316@IBM-AIP3070F3AM> <20051012171914.GA8622@mail.shareable.org>
In-Reply-To: <20051012171914.GA8622@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> Janak Desai wrote:
> 
>>	Don't allow namespace unsharing, if sharing fs (CLONE_FS)
> 
> 
> Makes sense.  clone() has the same test at the start.  (I think
> namespace should be a property of fs, not task, anyway.  Or completely
> eliminated because it's implied by the task's root dentry+vfsmnt).
> 
> 
>>	Don't allow sighand unsharing if not unsharing vm
> 
> 
> Why not?  It's permitted to clone with unshared sighand and shared vm,
> and it's useful too.
> 
> It's the combination shared sighand + unshared vm which is not
> allowed by clone - so I think that's what you should refuse.
> 

Yes, thanks. I had that backwards. I am checking for the illegal
combination of "shared sighand + unshared vm" later but I will
allow (and test) unsharing of sighand while keeping shared vm.

> 
>>	Don't allow vm unsharing if task cloned with CLONE_THREAD
> 
> 
> It would be better to do what clone does, and say "don't allow sighand
> unsharing if task cloned with CLONE_THREAD".  This is because
> CLONE_THREAD tasks must have shared signals.
> 
> In combination with the rule above for sighand (my rule, not yours),
> that implies "don't allow vm unsharing.." as a consequence.
> 

Ok. Basically, with my current logic you are forced to unshare
both vm and sighand. I will update so you can unshare just sighand
and tie the CLONE_THREAD restriction to sighand.

> 
>>	Don't allow vm unsharing if the task is performing async io
> 
> 
> Why not?
> 
> Async ios are tied to an mm (see lookup_ioctx in fs/aio.c), which may
> be shared among tasks.  I see no reason why the async ios can't
> continue and be waited in on in other tasks that may be using the old mm.
> 
> The new mm, if vm is unshared, would simply not see the outstanding
> aios - in the same way as if a vm was unshared by fork().
> 

Yes, I did see that async ios are tied to an mm and that aio context is
cleared when a new mm is created by clone/exec. It just appeared odd to
me that a task that setup aio is unable to continue performing aio
after unsharing mm, but the task that it was sharing mm with, can. I
don't have any problem making this change. It's just that I wasn't sure
about aio usage and thought it was better to not allow an mm unshare if
aio is being performed.

-Janak

