Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264073AbUEDAT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264073AbUEDAT4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 20:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264088AbUEDAT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 20:19:56 -0400
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:21930 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264073AbUEDATy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 20:19:54 -0400
Message-ID: <4096E1A6.2010506@yahoo.com.au>
Date: Tue, 04 May 2004 10:19:50 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: peter@mysql.com, linuxram@us.ibm.com, alexeyk@mysql.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Random file I/O regressions in 2.6
References: <200405022357.59415.alexeyk@mysql.com>	<409629A5.8070201@yahoo.com.au>	<20040503110854.5abcdc7e.akpm@osdl.org>	<1083615727.7949.40.camel@localhost.localdomain>	<20040503135719.423ded06.akpm@osdl.org>	<1083620245.23042.107.camel@abyss.local>	<20040503145922.5a7dee73.akpm@osdl.org>	<4096DC89.5020300@yahoo.com.au> <20040503171005.1e63a745.akpm@osdl.org>
In-Reply-To: <20040503171005.1e63a745.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>>That's one of its usage patterns.  It's also supposed to detect the
>>>fixed-sized-reads-seeking-all-over-the-place situation.  In which case it's
>>>supposed to submit correctly-sized multi-page BIOs.  But it's not working
>>>right for this workload.
>>>
>>>A naive solution would be to add special-case code which always does the
>>>fixed-size readahead after a seek.  Basically that's
>>>
>>>	if (ra->next_size == -1UL)
>>>		force_page_cache_readahead(...)
>>>
>>
>>I think a better solution to this case would be to ensure the
>>readahead window is always min(size of read, some large number);
>>
> 
> 
> That would cause the kernel to perform lots of pointless pagecache lookups
> when the file is already 100% cached.
> 


That's pretty sad. You need a "preread" or something which
sends the pages back... or uses the actor itself. readahead
would then have to be reworked to only run off the end of
the read window, but that is what it should be doing anyway.
