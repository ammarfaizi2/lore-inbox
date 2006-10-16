Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422710AbWJPQMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422710AbWJPQMg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 12:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422711AbWJPQMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 12:12:36 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:39284 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422710AbWJPQMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 12:12:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=edd2g/4JKFU5dfqXF+HVbjpne6psOHpTdeOTwrSikTSNXDSYowZZI0uW2215LiV0umwzBiswJRZoohP80QixejUvIx2ijFs3+BMpAVy9epfgboTWiZ065MlzcXMtiSZHDrRxonT9n1/YC6DM7OS7bCTOeM9oiarf0N7epOVVp7E=  ;
Message-ID: <4533AF6C.6020207@yahoo.com.au>
Date: Tue, 17 Oct 2006 02:12:28 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: pagefault_disable (was Re: [patch 6/6] mm: fix pagecache write
 deadlocks)
References: <20061013143516.15438.8802.sendpatchset@linux.site>	 <20061013143616.15438.77140.sendpatchset@linux.site>	 <1160912230.5230.23.camel@lappy> <20061015115656.GA25243@wotan.suse.de>	 <1160920269.5230.29.camel@lappy> <20061015141953.GC25243@wotan.suse.de>	 <1160927224.5230.36.camel@lappy>  <20061015155727.GA539@wotan.suse.de>	 <1160928835.5230.41.camel@lappy>  <4533A411.2020207@yahoo.com.au> <1161014732.2096.9.camel@taijtu>
In-Reply-To: <1161014732.2096.9.camel@taijtu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> On Tue, 2006-10-17 at 01:24 +1000, Nick Piggin wrote:

>>Also, the rest of the kernel tree (mainly uaccess and futexes) should be
>>converted ;)
> 
> 
> Yeah, lotsa places to touch.
> 
> 
>>>Index: linux-2.6/mm/filemap.h
>>>===================================================================
>>>--- linux-2.6.orig/mm/filemap.h	2006-10-14 20:20:20.000000000 +0200
>>>+++ linux-2.6/mm/filemap.h	2006-10-15 17:17:45.000000000 +0200
>>>@@ -21,6 +21,22 @@ __filemap_copy_from_user_iovec_inatomic(
>>> 					size_t bytes);
>>> 
>>> /*
>>>+ * By increasing the preempt_count we make sure the arch preempt
>>>+ * handler bails out early, before taking any locks, so that the copy
>>>+ * operation gets terminated early.
>>>+ */
>>>+pagefault_static inline void disable(void)
>>>+{
>>>+	inc_preempt_count();
> 
> 
> I think we also need a barrier(); here. We need to make sure the preempt
> count is written to memory before we hit the fault handler.

It will come from this thread, but I guess the fault is not an event the
compiler can forsee, so indeed it might optimise this into the wrong place.
Perhaps not with any copy*user implementation we have, but at least in
theory...

>>>+pagefault_static inline void enable(void)
>>>+{
>>>+	dec_preempt_count();
>>>+	preempt_check_resched();
>>>+}

You'll want barriers before and after the dec_preempt_count, for similar
reasons.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
