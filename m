Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964947AbWHQNaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbWHQNaB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbWHQN34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:29:56 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:3439 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964943AbWHQN31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:29:27 -0400
Message-ID: <44E46FC4.2050002@sw.ru>
Date: Thu, 17 Aug 2006 17:31:48 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
Subject: Re: [RFC][PATCH 5/7] UBC: kernel memory accounting (core)
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru> <1155754029.9274.21.camel@localhost.localdomain>
In-Reply-To: <1155754029.9274.21.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> On Wed, 2006-08-16 at 19:40 +0400, Kirill Korotaev wrote:
> 
>>--- ./include/linux/mm.h.kmemcore       2006-08-16 19:10:38.000000000
>>+0400
>>+++ ./include/linux/mm.h        2006-08-16 19:10:51.000000000 +0400
>>@@ -274,8 +274,14 @@ struct page {
>>        unsigned int gfp_mask;
>>        unsigned long trace[8];
>> #endif
>>+#ifdef CONFIG_USER_RESOURCE
>>+       union {
>>+               struct user_beancounter *page_ub;
>>+       } bc;
>>+#endif
>> };
> 
> 
> Is everybody OK with adding this accounting to the 'struct page'?  Is
> there any kind of noticeable performance penalty for this?  I thought
> that we had this aligned pretty well on cacheline boundaries.
When I discussed this with Hugh Dickins on summit we agreed
that +4 bytes on page struct for kernel using accounting
are ok and almost unavoidable.

it can be stored not on the struct page, but in this
case you need to introduce some kind of hash to lookup ub
quickly from page, which is slower for accounting-enabled kernels.

> How many things actually use this?  Can we have the slab ubcs without
> the struct page pointer?
slab doesn't use this pointer on the page.
It is used for pages allocated by buddy
alocator implicitly (e.g. LDT pages, page tables, ...).

Kirill

