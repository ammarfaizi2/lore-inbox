Return-Path: <linux-kernel-owner+w=401wt.eu-S1751606AbWLOAUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606AbWLOAUj (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 19:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751867AbWLOAUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 19:20:38 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:58393 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606AbWLOAUi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 19:20:38 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: "Eric Dumazet" <dada1@cosmosbay.com>, "Andrew Morton" <akpm@osdl.org>,
       "Greg KH" <gregkh@suse.de>, "Arjan" <arjan@linux.intel.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: kref refcnt and false positives
References: <EB12A50964762B4D8111D55B764A8454010572C1@scsmsx413.amr.corp.intel.com>
Date: Thu, 14 Dec 2006 17:19:55 -0700
In-Reply-To: <EB12A50964762B4D8111D55B764A8454010572C1@scsmsx413.amr.corp.intel.com>
	(Venkatesh Pallipadi's message of "Thu, 14 Dec 2006 15:51:38 -0800")
Message-ID: <m13b7ivwlw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com> writes:

>>But I believe Venkatesh problem comes from its release() 
>>function : It is 
>>supposed to free the object.
>>If not, it should properly setup it so that further uses are OK.
>>
>>ie doing in release(kref)
>>atomic_set(&kref->count, 0);
>>
>
> Agreed that setting kref refcnt to 0 in release will solve the probloem.
> But, once the optimization code is removed, we don't need to set it to
> zero as release will only be called after the count reaches zero anyway.

The primary point of the optimization is to not write allocate a cache line
unnecessarily.   I don't know it's value, but it can have one especially
on big way SMP machines.

If the optimization is not performed setting the value to 0 immediately
there after has not real cost as your cpu has the dirty cache line
already.  If the optimization is performed you still have to dirty
the cache line but at least you don't have to allocate it.

How that compares to the branch mispredict in cost I don't know, except
that cache line misses are the only operation that is generally
more expensive than branch misses.

So I see no virtue in avoiding the atomic_set(&kref->count, 0) if
you are about to immediately reuse the data structure.

Eric
