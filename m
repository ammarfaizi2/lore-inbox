Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423146AbWJQGen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423146AbWJQGen (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 02:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423148AbWJQGen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 02:34:43 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:1884 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1423146AbWJQGem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 02:34:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=bAj0KeNVv+h+IBvq8x+eIX045MqlsInLGdR6MTj1Wc7pegaYA/+NrXUsbdYNn+1vbq1OA4kv+UuXnWqxvdcRvsRtf9x2/JYF1W4qWNWJPAcdm80X4PE60UFzyaUvme02OxhrZ/3lHRTilZ3EIHsXmGxGjQ/Ojg9yCxTDXlAw3ZQ=  ;
Message-ID: <45347951.3050907@yahoo.com.au>
Date: Tue, 17 Oct 2006 16:33:53 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060216 Debian/1.7.12-1.1ubuntu2
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Bligh <mbligh@google.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH] Use min of two prio settings in calculating distress
 for reclaim
References: <4534323F.5010103@google.com>
In-Reply-To: <4534323F.5010103@google.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh wrote:

> Another bug is that if try_to_free_pages / balance_pgdat are called
> with a gfp_mask specifying GFP_IO and/or GFP_FS, they may reclaim
> the requisite number of pages, and reset prev_priority to DEF_PRIORITY.
>
> However, another reclaimer without those gfp_mask flags set may still
> be struggling to reclaim pages. The easy fix for this is to key the
> distress calculation not off zone->prev_priority, but also take into
> account the local caller's priority by using:
> min(zone->prev_priority, sc->priority)


Does it really matter who is doing the actual reclaiming? IMO, if the
non-crippled (GFP_IO|GFP_FS) reclaimer is making progress, the other
guy doesn't need to start swapping, and should soon notice that some
pages are getting freed up.

Workloads where non GFP_IO or GFP_FS reclaimers are having a lot of
trouble indicates that either it is very swappy or page writeback has
broken down and lots of dirty pages are being reclaimed off the LRU.
In either case, they are likely to continue to have problems, even if
they are now able to unmap the odd page.

What are the empirical effects of this patch? What's the numbers? And
what have you done to akpm? ;)
--

Send instant messages to your online friends http://au.messenger.yahoo.com 
