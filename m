Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263026AbUCLXZe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 18:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263034AbUCLXZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 18:25:34 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:8389 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263026AbUCLXZZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 18:25:25 -0500
Message-ID: <4052465F.4010201@cyberone.com.au>
Date: Sat, 13 Mar 2004 10:23:11 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: smurf@smurf.noris.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.4-rc2-mm1: vm-split-active-lists
References: <404FACF4.3030601@cyberone.com.au>	<200403111825.22674@WOLK>	<40517E47.3010909@cyberone.com.au>	<20040312012703.69f2bb9b.akpm@osdl.org>	<pan.2004.03.12.11.08.02.700169@smurf.noris.de>	<4051B0C6.2070302@cyberone.com.au>	<4051C5F1.2050605@cyberone.com.au> <20040312111228.3425780b.akpm@osdl.org>
In-Reply-To: <20040312111228.3425780b.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Nick Piggin <piggin@cyberone.com.au> wrote:
>
>>Just had a try of doing things like updatedb and dd if=/dev/zero of=./blah
>>It is pretty swappy I guess.
>>
>
>You'll need to bring the scanning priority back into the picture: don't
>move mapped pages down onto the inactive list at low scanning priorities. 
>And that eans retaining the remember-the-priority-from-last-time logic.
>
>Otherwise it's inevitable that even a `cat monster_file > /dev/null' will
>eventually swap out everything it can.
>
>

Hmm I dunno. At mapped_page_cost 8, I don't think it is swappy enough
that your desktop users will be running into problems. I need to write
4GB of file to push out 70MB of swap here (256MB RAM). And not much of
that swap has come back in, by the way...

>>By the way, I would be interested to know the rationale behind
>>mark_page_accessed as it is without this patch, also what is it doing in
>>rmap.c (I know hardly anything actually uses page_test_and_clear_young, but
>>still). It seems to me like it only serves to make VM behaviour harder to
>>understand, but I'm probably missing something. Andrew?
>>
>
>hm, that's left-over code which is pretty pointless now.
>
>
>	if (page_test_and_clear_young(page))
>		mark_page_accessed(page);
>
>	if (TestClearPageReferenced(page))
>		referenced++;
>
>The pages in here are never on the LRU, so all the mark_page_accessed()
>will do is to set PG_Referenced.  And we immediately clear it again.  So
>the mark_page_accessed() can be replaced with referenced++.
>
>
>

Yep, see the patch I'd attached before.

