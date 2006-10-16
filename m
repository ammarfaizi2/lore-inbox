Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWJPPYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWJPPYK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 11:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWJPPYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 11:24:10 -0400
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:40320 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932148AbWJPPYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 11:24:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=qKAbiYDI7tA5JvC+gd7qTh/jm7aLlybYfkGhZuIziFi9K1miuyLILsG8VrZwJw7KRdok9z95SWS0kTckxRYoqDK4jFTqTZGV5aqbCunNa6obJoWhAA1cL5BYQekoKSEEm2g5rQl/HBVPkFO3KWwYziQBuidXeSU4qa8kFJrO0kM=  ;
Message-ID: <4533A411.2020207@yahoo.com.au>
Date: Tue, 17 Oct 2006 01:24:01 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: pagefault_disable (was Re: [patch 6/6] mm: fix pagecache write deadlocks)
References: <20061013143516.15438.8802.sendpatchset@linux.site>	 <20061013143616.15438.77140.sendpatchset@linux.site>	 <1160912230.5230.23.camel@lappy> <20061015115656.GA25243@wotan.suse.de>	 <1160920269.5230.29.camel@lappy> <20061015141953.GC25243@wotan.suse.de>	 <1160927224.5230.36.camel@lappy>  <20061015155727.GA539@wotan.suse.de> <1160928835.5230.41.camel@lappy>
In-Reply-To: <1160928835.5230.41.camel@lappy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(trimming cc list)

Peter Zijlstra wrote:
> On Sun, 2006-10-15 at 17:57 +0200, Nick Piggin wrote:

>>Hmm, but you may not be doing a copy*user within the kmap. And you may
>>want an atomic copy*user not within a kmap (maybe).
>>
>>I think it really would be more logical to do it in a wrapper function
>>pagefault_disable() pagefault_enable()? ;)
> 
> 
> I did that one first, but then noticed that most non trivial kmap_atomic
> implementations already did the inc_preempt_count()/dec_preempt_count()
> thing (except frv which did preempt_disable()/preempt_enable() ?)
> 
> Anyway, here goes:
> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

I think this is a good approach. The missed preempt checks could easily
have been causing scheduling delays because the usercopy can take up a
lot of kernel time.

I don't know that the function should go in filemap.h... uaccess.h seems
more appropriate, and had thought the pagefault_disable() be calle
directly from within the copy_*_user_inatomic functions themselves, not
the filemap helper.

Also, the rest of the kernel tree (mainly uaccess and futexes) should be
converted ;)

> Index: linux-2.6/mm/filemap.h
> ===================================================================
> --- linux-2.6.orig/mm/filemap.h	2006-10-14 20:20:20.000000000 +0200
> +++ linux-2.6/mm/filemap.h	2006-10-15 17:17:45.000000000 +0200
> @@ -21,6 +21,22 @@ __filemap_copy_from_user_iovec_inatomic(
>  					size_t bytes);
>  
>  /*
> + * By increasing the preempt_count we make sure the arch preempt
> + * handler bails out early, before taking any locks, so that the copy
> + * operation gets terminated early.
> + */
> +pagefault_static inline void disable(void)
> +{
> +	inc_preempt_count();
> +}
> +
> +pagefault_static inline void enable(void)
> +{
> +	dec_preempt_count();
> +	preempt_check_resched();
> +}

Interesting prototype ;)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
