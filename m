Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbUECX6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbUECX6J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 19:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264010AbUECX6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 19:58:09 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:5012 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261913AbUECX6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 19:58:05 -0400
Message-ID: <4096DC89.5020300@yahoo.com.au>
Date: Tue, 04 May 2004 09:58:01 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Peter Zaitsev <peter@mysql.com>, linuxram@us.ibm.com, alexeyk@mysql.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Random file I/O regressions in 2.6
References: <200405022357.59415.alexeyk@mysql.com>	<409629A5.8070201@yahoo.com.au>	<20040503110854.5abcdc7e.akpm@osdl.org>	<1083615727.7949.40.camel@localhost.localdomain>	<20040503135719.423ded06.akpm@osdl.org>	<1083620245.23042.107.camel@abyss.local> <20040503145922.5a7dee73.akpm@osdl.org>
In-Reply-To: <20040503145922.5a7dee73.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Peter Zaitsev <peter@mysql.com> wrote:
> 
>>On Mon, 2004-05-03 at 13:57, Andrew Morton wrote:
>>
>>>Ram Pai <linuxram@us.ibm.com> wrote:
>>>
>>>>>The place which needs attention is handle_ra_miss().  But first I'd like to
>>>>>reacquaint myself with the intent behind the lazy-readahead patch.  Was
>>>>>never happy with the complexity and special-cases which that introduced.
>>>>
>>>>lazy-readahead has no role to play here.
>>>
>>Andrew,
>>
>>Could you please clarify how this things become to be dependent on
>>read-ahead at all.
> 
> 
> readahead is currently the only means by which we build up nice large
> multi-page BIOs.
> 
> 
>>At my understanding read-ahead it to catch sequential (or other) access
>>pattern and do some advance reading, so instead of 16K request we do
>>128K request, or something similar.
> 
> 
> That's one of its usage patterns.  It's also supposed to detect the
> fixed-sized-reads-seeking-all-over-the-place situation.  In which case it's
> supposed to submit correctly-sized multi-page BIOs.  But it's not working
> right for this workload.
> 
> A naive solution would be to add special-case code which always does the
> fixed-size readahead after a seek.  Basically that's
> 
> 	if (ra->next_size == -1UL)
> 		force_page_cache_readahead(...)
> 

I think a better solution to this case would be to ensure the
readahead window is always min(size of read, some large number);

The size of the read is basically a free and accurate "hint" to
the minimum size of the required readahead.

Either that or do a simple "preread" while you're still in the
read request window, and run readahead when that completes.
