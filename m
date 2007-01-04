Return-Path: <linux-kernel-owner+w=401wt.eu-S932282AbXADGER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbXADGER (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 01:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbXADGER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 01:04:17 -0500
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:45106 "HELO
	smtp104.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932282AbXADGER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 01:04:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Vc7oAQg/M9AWKQILk5uSylXHYnoJExepdmLElN1/Go7J6/HfKCZf3QKixdHCtVZYKVj0qL4p8Mu17BKTc6JA9Vm4N4lR2rA0a8OXXP2aCyEuAM/088jFbzsH06AjpZ1c9v4i5dUkKp+jEQ7M9kcepUbM1gQVDGV8RlATx02eoSo=  ;
X-YMail-OSG: oFPQ0c0VM1lXsQVuBNPOyX0K3vWRA27MovkzEKvubyP5a7RJ4q_DjKfB8HKhRr8r50CUoBCtlyd3tI3FAc8v4LQr58L0JlUy7g8WdrbjFVFmYk03SuBaTbgSofPfpbjMM.yYLQrvUe1PxPw-
Message-ID: <459C98BF.5080409@yahoo.com.au>
Date: Thu, 04 Jan 2007 17:03:43 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linus Torvalds <torvalds@osdl.org>, Andrea Gelmini <gelma@gelma.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VM: Fix nasty and subtle race in shared mmap'ed page writeback
References: <200612291859.kBTIx2kq031961@hera.kernel.org>	<20061229224309.GA23445@gelma.net>	<459734CE.1090001@yahoo.com.au>	<20061231135031.GC23445@gelma.net>	<459C7B24.8080008@yahoo.com.au>	<Pine.LNX.4.64.0701032031400.3661@woody.osdl.org> <20070103214121.997be3e6.akpm@osdl.org>
In-Reply-To: <20070103214121.997be3e6.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 3 Jan 2007 20:44:36 -0800 (PST)
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
> 
>>Actually, I think 2.6.18 may have a subtle variation on it. 
>>
>>In particular, I look back at the try_to_free_buffers() thing that I hated 
>>so much, and it makes me wonder.. It used to do:
>>
>>	spin_lock(&mapping->private_lock);
>>	ret = drop_buffers(page, &buffers_to_free);
>>	spin_unlock(&mapping->private_lock);
>>	if (ret) {
>>		.. crappy comment ..
>>		if (test_clear_page_dirty(page))
>>			task_io_account_cancelled_write(PAGE_CACHE_SIZE);
>>	}
>>
>>and I think that at least on SMP, we had a race with another CPU doing the 
>>"mark page dirty if it was dirty in the PTE" at the same time. Because the 
>>marking dirty would come in, find no buffers (they just got dropped), and 
>>then mark the page dirty (ignoring the lack of any buffers), but then the 
>>above would do the "test_clear_page_dirty()" thing on it.
>>
> 
> 
> That bug was introduced in 2.6.19, with the dirty page tracking patches.
> 
> 2.6.18 and earlier used ->private_lock coverage in try_to_free_buffers() to
> prevent it.

Ohh, right you are, I was looking at 2.6.19 sources. The comments above
ttfb match that as well. Curious that the dirty page patches were allowed
to mess with this...

Anyway that leaves us with the question of why Andrea's database is getting
corrupted. Hopefully he can give us a minimal test-case.

>>Ie the race, I think, existed where that crappy comment was.
> 
> 
> The comment was complete, accurate and needed.

Indeed ;)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
