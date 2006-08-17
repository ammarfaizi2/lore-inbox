Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964956AbWHQNdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbWHQNdj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964964AbWHQNdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:33:38 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:39341 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964956AbWHQNd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:33:29 -0400
Message-ID: <44E470B5.4020706@sw.ru>
Date: Thu, 17 Aug 2006 17:35:49 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: rohitseth@google.com
CC: Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
Subject: Re: [RFC][PATCH 5/7] UBC: kernel memory accounting (core)
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>	 <1155754029.9274.21.camel@localhost.localdomain> <1155755729.22595.101.camel@galaxy.corp.google.com>
In-Reply-To: <1155755729.22595.101.camel@galaxy.corp.google.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 2006-08-16 at 11:47 -0700, Dave Hansen wrote:
> 
>>On Wed, 2006-08-16 at 19:40 +0400, Kirill Korotaev wrote:
>>
>>>--- ./include/linux/mm.h.kmemcore       2006-08-16 19:10:38.000000000
>>>+0400
>>>+++ ./include/linux/mm.h        2006-08-16 19:10:51.000000000 +0400
>>>@@ -274,8 +274,14 @@ struct page {
>>>        unsigned int gfp_mask;
>>>        unsigned long trace[8];
>>> #endif
>>>+#ifdef CONFIG_USER_RESOURCE
>>>+       union {
>>>+               struct user_beancounter *page_ub;
>>>+       } bc;
>>>+#endif
>>> };
>>
>>Is everybody OK with adding this accounting to the 'struct page'?  
> 
> 
> My preference would be to have container (I keep on saying container,
> but resource beancounter) pointer embeded in task, mm(not sure),
> address_space and anon_vma structures.  This should allow us to track
> user land pages optimally.  But for tracking kernel usage on behalf of
> user, we will have to use an additional field (unless we can re-use
> mapping).  Please correct me if I'm wrong, though all the kernel
> resources will be allocated/freed in context of a user process.  And at
> that time we know if a allocation should succeed or not.  So we may
> actually not need to track kernel pages that closely.  We are not going
> to run reclaim on any of them anyways.  
objects are really allocated in process context
(except for TCP/IP and other softirqs which are done in arbitrary
process context!)
And objects are not always freed in correct context (!).

Note, page_ub is not for _user_ pages. user pages accounting will be added
in next patch set. page_ub is added to track kernel allocations.

Kirill

