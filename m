Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbWDFAXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbWDFAXr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 20:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWDFAXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 20:23:47 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:42624 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750911AbWDFAXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 20:23:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=pRM9OMAT/h8Xt4JLkvbuleV1Ngo4a2E2Y/BGPdjykB9ApTndrwiUYWy3EEOH+F00IVEgtnHuuzVhgJ55YcDboe/f/SG/VV4kCfJHlLMKVw4MYPGOvbRxLrQ4uLjKNnl2W0ELdX5B2tJPzs7ADHniaRewHu3KUytTBE0sVwb/EFE=  ;
Message-ID: <44330EF8.1040800@yahoo.com.au>
Date: Wed, 05 Apr 2006 10:27:36 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [patch 2/3] mm: speculative get_page
References: <20060219020140.9923.43378.sendpatchset@linux.site> <20060219020159.9923.94877.sendpatchset@linux.site> <Pine.LNX.4.64.0604040820540.26807@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0604040820540.26807@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Tue, 4 Apr 2006, Nick Piggin wrote:
> 
> 
>>+	/*
>>+	 * PageNoNewRefs is set in order to prevent new references to the
>>+	 * page (eg. before it gets removed from pagecache). Wait until it
>>+	 * becomes clear (and checks below will ensure we still have the
>>+	 * correct one).
>>+	 */
>>+	while (unlikely(PageNoNewRefs(page)))
>>+		cpu_relax();
> 
> 
> That part looks suspiciously like we need some sort of lock here.
> 

It's very light-weight now. A lock of course would only be page local,
so it wouldn't really harm scalability, however it would slow down the
single threaded case. At the moment, single threaded performance of
find_get_page is anywhere from about 15-100% faster than before the
lockless patches.

I don't see why you think there needs to be a lock? Before the write
side clears PageNoNewRefs, they will have moved 'page' out of pagecache,
so when this loop breaks, the subsequent test will fail and this
function will be repeated.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
