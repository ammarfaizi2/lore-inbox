Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311898AbSDJF26>; Wed, 10 Apr 2002 01:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312449AbSDJF25>; Wed, 10 Apr 2002 01:28:57 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:30096 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S311898AbSDJF25>; Wed, 10 Apr 2002 01:28:57 -0400
Date: Tue, 09 Apr 2002 22:28:57 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        Tony.P.Lee@nokia.com, kessler@us.ibm.com, alan@lxorguk.ukuu.org.uk,
        Dave Jones <davej@suse.de>
Subject: Re: Event logging vs enhancing printk
Message-ID: <2032894297.1018391336@[10.10.2.3]>
In-Reply-To: <20020410032328.C6875@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Right - what I'm proposing would be a generic equivalent of the
>> local staging buffer and sprintf - basically just a little wrapper
>> that does this for you, keeping a per task buffer somewhere.
> 
> That still doesn't solve the race with the interrupt handlers, you'd
> need a buffer for each irq handler and one the softirq too to make
> printk buffered and coeherent coherent across newlines (doable but even
> more tricky and in turn less robust and less self contained).

I was envisaging a larger buffer where the current location pointer 
simply taken by the interrupt handler, and the remaining section of
that buffer was used for the "inner printk". Which is really just 
like a stack, so it makes more sense to just allocate this off the
stack really .... I think this would work? We might need to flush
on a certain size limit (128 chars, maybe?) to stop any risk of
stack overflow.

> Some other code may omit it by mistake, leading to the other cpus
> blackholed and data lost after the buffer on the other cpus overflowed
> so at least we should put a timer that spawns an huge warning if a cpu
> doesn't flush the buffer in a rasonable amount of time so we can catch
> those places.

It seems that 99.9% of these cases are just assembling a line of output 
a few characters at a time. There might be a few odd miscreants around,
but not enough to worry about - I think it's overkill to do the runtime
timer check, but we could always run like this to test it, or try to
work some sort of automated code inspection (though that sounds hard to
do 100% reliably).

M.

