Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269696AbTGJXRW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 19:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269697AbTGJXRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 19:17:21 -0400
Received: from news.cistron.nl ([62.216.30.38]:55823 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S269696AbTGJXRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 19:17:09 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: 2.5.74-mm3 OOM killer fubared ?
Date: Thu, 10 Jul 2003 23:31:50 +0000 (UTC)
Organization: Cistron Group
Message-ID: <bekt16$f7e$1@news.cistron.nl>
References: <bejhrj$dgg$1@news.cistron.nl> <20030710103810.1276def5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1057879910 15598 62.216.29.200 (10 Jul 2003 23:31:50 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030710103810.1276def5.akpm@osdl.org>,
Andrew Morton  <akpm@osdl.org> wrote:
>"Miquel van Smoorenburg" <miquels@cistron.nl> wrote:
>>
>> I was running 2.5.74 on our newsfeeder box for a day without
>> problems (and 2.5.72-mm2 for weeks before that).
>
>And how was 2.5.72-mm2 performing, generally?

Quite allright, but it had (known) ext3 problems so I went to
2.5.74. Linus fixed the issue with siimage yesterday, so that
was stable. No fun in that so I went to -mm3 ;)

The VM appears to run better with 2.5 than with 2.4, but I do not
experience a real difference between 2.5.74-vanilla and -mm3.

Difference between 2.4.21 and 2.5.7x is that interactive response
under load is much better, and that the VM is better. With 2.4.21,
the nightly expire process (rebuilds the history database) was
running for 3 days without making progress if the news server (INN)
was running at the same time, because its working set kept getting
evicted to swap. 2.5 behaves better - expire finished in a few hours.
Ofcourse now I stop the INN process before expire and restart it
afterwards and the expire process runs in 5 minutes ... which simply
means I need more memory.

>> Now with 2.5.74-mm3 (booted 11 hours ago) it keeps killing processes
>> for no apparent reason:
>> ...
>> I notice that in -mm3 this was deleted relative to -vanilla:
>> 
>> -
>> -       /*
>> -        * Enough swap space left?  Not OOM.
>> -        */
>> -       if (nr_swap_pages > 0)
>> -               return;
>>   
>> .. is that what causes this?
>
>Yes.  That was a "hmm, I wonder what happens if I do this" patch.  It's
>interesting that we're going down that code path.

Yes, and it's really not happening all that often. For example:

Jul 10 12:25:48 quantum kernel: Fixed up OOM kill of mm-less task
Jul 10 12:45:41 quantum kernel: Out of Memory: Killed process 11894 (innfeed).
Jul 10 12:47:14 quantum kernel: Out of Memory: Killed process 13128 (innfeed).
Jul 10 12:53:09 quantum kernel: Out of Memory: Killed process 13221 (innfeed).
Jul 10 12:55:12 quantum kernel: Out of Memory: Killed process 13649 (innfeed).
Jul 10 15:18:24 quantum kernel: Out of Memory: Killed process 13754 (innfeed).
Jul 10 15:35:54 quantum kernel: Out of Memory: Killed process 22667 (innfeed).
Jul 10 16:38:05 quantum kernel: Out of Memory: Killed process 23781 (innfeed).
Jul 10 17:04:32 quantum kernel: Out of Memory: Killed process 27640 (innfeed).
Jul 10 20:26:12 quantum kernel: Out of Memory: Killed process 29298 (innfeed).
Jul 10 22:05:43 quantum kernel: Out of Memory: Killed process 9333 (innfeed).
Jul 10 22:24:00 quantum kernel: Out of Memory: Killed process 15476 (innfeed).
Jul 10 22:24:00 quantum kernel: Fixed up OOM kill of mm-less task
Jul 10 22:44:47 quantum kernel: Out of Memory: Killed process 16616 (innfeed).
Jul 11 01:23:32 quantum kernel: Out of Memory: Killed process 17896 (innfeed).
Jul 11 01:24:50 quantum kernel: Out of Memory: Killed process 28108 (innfeed).

Sometimes it happens every 5 minutes though.

>Is your INND configured to use the strange mmap(MAP_SHARED) of a blockdev
>thing?   That could explain the scanning hysteria.

Yes. In fact, INND itself just mmaps small parts of the blockdev
(just a few 100K of bitmap at the beginning), but the outgoing processes
called "innfeed" actually mmaps whole articles from the blockdevs,
which could be several megs. Not hundeds of megs, though. Maybe 20.

>> Related mm question - this box is a news server, which does a lot
>> of streaming I/O, and also keeps a history database open. I have the
>> idea that the streaming I/O evicts the history database hash and
>> index file caches from memory, which I do not want. Any chance of
>> a control on a filedescriptor that tells it how persistant to be
>> in caching file data ? E.g. a sort of "nice" for the cache, so that
>> I could say that streaming data may be flushed from buffers/cache
>> earlier than other data (where the other data would be the
>> database files) ?
>
>Makes sense.  We can use posix_fadvise(POSIX_FADV_NOREUSE) as a hint to
>tell the VM/VFS to throw away old pages.  I'll take a look at that.

Well, throw away earlier than other pages. If nothing else needs
those pages, I'd like to keep them around anyway. What comes in
streaming, goes out streaming - but usually within seconds.

Mike.

