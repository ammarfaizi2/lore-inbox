Return-Path: <linux-kernel-owner+w=401wt.eu-S932500AbXARQsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbXARQsj (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 11:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbXARQsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 11:48:39 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:44360 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932460AbXARQsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 11:48:38 -0500
Message-ID: <45AFA4D5.7060405@pobox.com>
Date: Thu, 18 Jan 2007 11:48:21 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Chris Lalancette <clalance@redhat.com>
CC: Francois Romieu <romieu@fr.zoreil.com>, netdev@vger.kernel.org,
       Herbert Xu <herbert@gondor.apana.org.au>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc3]: 8139cp: Don't blindly enable interrupts
References: <45ABAE69.4070105@redhat.com> <20070115195635.GA14205@electric-eye.fr.zoreil.com> <45ACE4B6.3040809@redhat.com> <20070116202217.GA9369@electric-eye.fr.zoreil.com> <45AD4698.7050908@redhat.com>
In-Reply-To: <45AD4698.7050908@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Lalancette wrote:
> Francois Romieu wrote:
> 
>> Chris Lalancette <clalance@redhat.com> :
>> [...]
>>  
>>
>>>     Thanks for the comments.  While the patch you sent will help, there are
>>> still other places that will have problems.  For example, in netpoll_send_skb,
>>> we call local_irq_save(flags), then call dev->hard_start_xmit(), and then call
>>> local_irq_restore(flags).  This is a similar situation to what I described
>>> above; we will re-enable interrupts in cp_start_xmit(), when netpoll_send_skb
>>> doesn't expect that, and will probably run into issues.
>>>     Is there a problem with changing cp_start_xmit to use the
>>> spin_lock_irqsave(), besides the extra instructions it needs?
>>>    
>>>
>> No. Given the history of locking in netpoll and the content of
>> Documentation/networking/netdevices.txt, asking Herbert which rule(s)
>> the code is supposed to follow seemed safer to me.
>>
>> You can forget my patch.
>>
>> Please resend your patch inlined to Jeff as described in
>> http://linux.yyz.us/patch-format.html.
>>
>>  
>>
> Francois,
>      Great.  Resending mail, shortening subject to < 65 characters and
> inlining the patch.
> 
> Thanks,
> Chris Lalancette
> 
> Similar to this commit:
> 
> http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=d15e9c4d9a75702b30e00cdf95c71c88e3f3f51e
> 
> It's not safe in cp_start_xmit to blindly call spin_lock_irq and then
> spin_unlock_irq, since it may very well be the case that cp_start_xmit
> was called with interrupts already disabled (I came across this bug in
> the context of netdump in RedHat kernels, but the same issue holds, for
> example, in netconsole). Therefore, replace all instances of
> spin_lock_irq and spin_unlock_irq with spin_lock_irqsave and
> spin_unlock_irqrestore, respectively, in cp_start_xmit(). I tested this
> against a fully-virtualized Xen guest using netdump, which happens to
> use the 8139cp driver to talk to the emulated hardware. I don't have a
> real piece of 8139cp hardware to test on, so someone else will have to
> do that.
> 
> Signed-off-by: Chris Lalancette <clalance@redhat.com>

applied.

In the future, please remove the quoted emails stuff, and anything else 
that does not belong in the kernel changelog.  It must be hand-edited 
out, before using git-am to merge your patch into the kernel tree.

	Jeff



