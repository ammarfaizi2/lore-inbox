Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752129AbWCOQ1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129AbWCOQ1h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 11:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752136AbWCOQ1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 11:27:37 -0500
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:64573 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1752129AbWCOQ1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 11:27:36 -0500
Message-ID: <44184075.6080000@watson.ibm.com>
Date: Wed, 15 Mar 2006 11:27:33 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Greg KH <greg@kroah.com>
Subject: Re: [Patch 3/9] Block I/O accounting initialization
References: <1142296834.5858.3.camel@elinux04.optonline.net>	 <1142297222.5858.13.camel@elinux04.optonline.net> <1142418436.3021.13.camel@laptopd505.fenrus.org>
In-Reply-To: <1142418436.3021.13.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>> 
>>+static inline void delayacct_blkio_start(void)
>>+{
>>+	if (unlikely(delayacct_on))
>>+		__delayacct_blkio_start();
>>+}
>>    
>>
>
>
>I still think the unlikely() makes no sense here; at runtime it's either
>going to be always on or off (in the sense that switching it will be
>RARE). The cpus branch predictor will get that right; while if you force
>it unlikely you can even run the risk of getting a 100% miss on some
>architectures (not x86/x86-64) when you enable the accounting
>
>  
>
I don't understand why the fact that delayacct_on is not going to vary
dynamically once a kernel has been booted should prevent the usage of 
"unlikely/likely"
Perhaps you can help me understand. Here's the logic I was using:

There are two kinds of users

1. Those who will not turn delay accounting on at boot time for a number of
reasons (don't care about the functionality, don't want to incur any 
overhead
however small).

2. The ones who do turn it on at boot time are willing to pay some overhead
for the benefits such functionality brings. What that overhead exactly 
is will be known
when we finish running some tests but we can safely assume it'll be 
non-zero.

A distro will need to keep delay accounting configured to accomodate 
both kinds
of users but because 1 is the common case,  the default boot time option 
will be off and
there is a strong incentive to reduce overhead for non-users.

Using unlikely reduces the overhead for the common case 1 and increases 
overhead for
case 2 (because of what you pointed out of 100% wrong decisions by the 
branch predictor).

I don't know how much of overhead reduction is achieved by using 
unlikely (I'm assuming its
non-trivial) or how much penalty is imposed by a 100% wrong prediction 
(I'm assuming its not
very high).

But under these assumptions, its better to use unlikely, make type 2 
users pay extra overhead
and save type 1 users from any.

Is this reasoning accurate ? If not, we could easily switch the unlikely 
off.

Regards,
Shailabh

(cc'ing Greg since he'd brought up the overhead for real benchmarks etc.)
