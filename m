Return-Path: <linux-kernel-owner+w=401wt.eu-S1751949AbWLVSv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbWLVSv1 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 13:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751952AbWLVSv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 13:51:27 -0500
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:58753 "EHLO
	mail-in-08.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751949AbWLVSv0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 13:51:26 -0500
In-Reply-To: <20061222011706.GA27396@localhost.localdomain>
References: <20061221222303.GA6418@localhost.localdomain> <E5477CAE-3FE8-4441-9225-570DD0679765@kernel.crashing.org> <20061222011706.GA27396@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <EE6A12AA-3BE6-43DE-AEB2-7477CDAD21DC@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, libhugetlbfs-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, William Lee Irwin <wli@holomorphy.com>,
       linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [powerpc] Fix bogus BUG_ON() in in hugetlb_get_unmapped_area()
Date: Fri, 22 Dec 2006 19:51:09 +0100
To: David Gibson <david@gibson.dropbear.id.au>
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> +	if (len > TASK_SIZE)
>>> +		return -ENOMEM;
>>
>> Shouldn't that be addr+len instead?  The check looks incomplete
>> otherwise.  And you meant ">=" I guess?
>
> No.  Have a look at the other hugetlb_get_unmapped_area()
> implementations.  Because this is in the get_unmapped_area() path,
> 'addr' is just a hint,

Ah I missed this vital piece of information, thanks for the
explanation.  Care putting in a code comment pointing this out?

> so checking addr+len would give bogus
> failures.  This test is, I believe, essentially an optimization - if
> it fails, we're never going to find a suitable addr, so we might as
> well give up now.

Yes, it all makes sense now.

>>> -		/* Paranoia, caller should have dealt with this */
>>> -		BUG_ON((addr + len) > 0x100000000UL);
>>> -
>>
>> Any real reason to remove the paranoia check?  If it's trivially
>> always satisfied, the compiler will get rid of it for you :-)
>
> Yes - this is the very bug on which was causing crashes - the "caller
> should have dealt with this" comment is wrong.  The test has been
> moved into htlb_check_hinted_area() and now simply fails (and so falls
> back to searching for a suitable address), rather than BUG()ing.

Yep.

Cheers,


Segher

