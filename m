Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbVF0HeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbVF0HeQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 03:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVF0HeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 03:34:08 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:41556 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261888AbVF0Hdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 03:33:47 -0400
Message-ID: <42BFABD7.5000006@yahoo.com.au>
Date: Mon, 27 Jun 2005 17:33:43 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: VFS scalability
References: <42BF9CD1.2030102@yahoo.com.au> <42BFA014.9090604@yahoo.com.au> <p733br4w9uw.fsf@verdi.suse.de>
In-Reply-To: <p733br4w9uw.fsf@verdi.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> writes:
> 
> 
>>This is with the filesystem mounted as noatime, so I can't work
>>out why update_atime is so high on the list. I suspect maybe a
>>false sharing issue with some other fields.
> 
> 
> Did all the 64CPUs write to the same file?
> 

Yes.

> Then update_atime was just the messenger - it is the first function
> to read the inode so it eats the cache miss overhead.
> 

I agree.

> Maybe adding a prefetch for it at the beginning of sys_read() 
> might help, but then with 64CPUs writing to parts of the inode
> it will always thrash no matter how many prefetches.
> 

True. I'm just not sure what is causing the bouncing - I guess
->f_count due to get_file()?

rw_verify_area is another that is taking a lot of hits - probably
due to the same cacheline(s) as update_atime.

Unless I'm mistaken, the big difference between the read fault and
the read(2) cases is that mmap holds a reference on the file, while
open(2) doesn't?

I guess if anyone really cares about that, they could hack up a flag
to tell the file to remain pinned.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
