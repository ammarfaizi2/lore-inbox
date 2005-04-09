Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVDIG2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVDIG2c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 02:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVDIG2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 02:28:31 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:22413 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261297AbVDIG2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 02:28:22 -0400
Message-ID: <42577602.8090507@yahoo.com.au>
Date: Sat, 09 Apr 2005 16:28:18 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
Subject: Re: [patch] sched: unlocked context-switches
References: <B8E391BBE9FE384DAA4C5C003888BE6F033DB07E@scsmsx401.amr.corp.intel.com> <20050409043848.GA2677@elte.hu>
In-Reply-To: <20050409043848.GA2677@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Luck, Tony <tony.luck@intel.com> wrote:
> 
> 
>>>tested on x86, and all other arches should work as well, but if an 
>>>architecture has irqs-off assumptions in its switch_to() logic 
>>>it might break. (I havent found any but there may such assumptions.)
>>
>>The ia64_switch_to() code includes a section that can change a pinned
>>MMU mapping (when the stack for the new process is in a different
>>granule from the stack for the old process).  [...]
> 
> 
> thanks - updated patch below. Any other architectures that switch the 
> kernel stack in a nonatomic way? x86/x64 switches it atomically.
> 

Well that does look like a pretty good cleanup. It certainly is
the final step in freeing complex architecture switching code
from entanglement with scheduler internal locking, and unifies
the locking scheme.

I did propose doing unconditionally unlocked switches a while
back when my patch first popped up - you were against it then,
but I guess you've had second thoughts?

It does add an extra couple of stores to on_cpu, and a wmb()
for architectures that didn't previously need the unlocked
switches. And ia64 needs the extra interrupt disable / enable.
Probably worth it?

Minor style request: I like that you're accessing ->on_cpu
through functions so the !SMP case doesn't clutter the code
with ifdefs... but can you do set_task_on_cpu(p) and
clear_task_on_cpu(p) ?

Thanks.

-- 
SUSE Labs, Novell Inc.

